import { render, screen } from '@testing-library/react'

import { Header } from '.'

describe('<Main />', () => {
  it('should render the heading', () => {
    const { container } = render(<Header />)

    expect(screen.getByRole('heading', { name: /header/i })).toBeInTheDocument()
    expect(container.firstChild).toMatchSnapshot()
  })
})
