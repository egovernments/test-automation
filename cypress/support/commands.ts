import {ISignIn} from './models';

const signin = (data: ISignIn) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/signin',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: data
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

Cypress.Commands.add('create_pass', (file, orderType, purpose, token) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/createOrder',
        failOnStatusCode: false,
        headers: {
            'content-type': 'multipart/form-data; boundary=----WebKitFormBoundaryD3u3amCb9BMTuDLp'
        },
        body: {
            "file": file,
            "orderType": orderType,
            "purpose": purpose,
            "authToken": token
        }

    })
})

