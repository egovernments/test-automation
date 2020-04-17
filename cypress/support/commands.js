// in cypress/support/index.d.ts
// load type definitions that come with Cypress module
/// <reference types="cypress" />

const signin = (email, password, type, state) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/signin',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: {
            "email": email,
            "password": password,
            "accountType": type,
            "stateName": state
        }
    })
}

Cypress.Commands.add('signin', signin);

Cypress.Commands.add('register', (name,email,password,orgid,orgName,state) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/createAccount',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: {
            "name": name,
            "email": email,
            "password": password,
            "orgID": orgid,
            "orgName": orgName,
            "stateName": state
          }
    })
})



Cypress.Commands.add('verifyOTP', (email, accType, otp, state) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/verifyOTP',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: {
            "identifier": email,
            "accountIdentifierType": accType,
            "otp": otp,
            "stateName": state
        }

    })
})

Cypress.Commands.add('approve_reject', (email, accId, action, token) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/approveAccount',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: {
            "email": email,
            "requesterAccountId": accId,
            "accountAction": action,
            "authToken": token
        }

    })
})
