// load type definations from Cypress module
/// <reference types="cypress" />

declare namespace Cypress {
  interface Chainable {
    /**
     * Custom command to visit google page
     */
    google(): Chainable<Window>
  }
}
