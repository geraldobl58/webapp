# Base image
FROM node:18-alpine AS base

# Setup the base working directory
WORKDIR /app

# === Install dependencies only ===
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# === Build the application ===
FROM base AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Gera a build standalone (inclui tudo que precisa em .next/standalone)
RUN npm run build

# === Production-ready image ===
FROM node:18-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Cria um usuário sem root
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copia os arquivos necessários para produção
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/.next/standalone ./

# Usa usuário sem root
USER nextjs

EXPOSE 3000

CMD ["node", "server.js"]
