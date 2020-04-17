// in cypress/support/index.d.ts
// load type definitions that come with Cypress module
/// <reference types="cypress" />

export interface ISignIn {
    email: String;
    password: String;
    accountType: String;
    stateName: String;
}
