describe('Cypress TS', () => {
  it.skip('should go to Google', () => {
    cy.google()
  })

  it('should test header', () => {
    cy.visit('http://localhost:3000')

    cy.findByText('Header')
  })
})
