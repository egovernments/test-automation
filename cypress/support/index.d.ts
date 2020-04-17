// in cypress/support/index.d.ts
// load type definitions that come with Cypress module
/// <reference types="cypress" />

declare module "*.json"
{
    const value: any;
   export default value;
}

declare namespace Cypress {
    interface Chainable {
        /**
         * Custom command to select DOM element by data-cy attribute.
         * @example cy.dataCy('greeting')
        */
        signin(data: ISignIn): Chainable<Response>
        register(name: string, email: string, password: string, orgid: string, orgName: string, state: string): Chainable<Response>
        verifyOTP(email: string, accType: string, otp: string, state: string): Chainable<Response>
        approve_reject(email: string, accId: string, action: string, token: string): Chainable<Response>
        create_pass(file: File, orderType: string, purpose: string, token: string): Chainable<Response>
    }
}
