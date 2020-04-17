Cypress.Commands.add('register', (body) => {
    cy.request({
        method: 'POST',
        url: '/ecurfew/createAccount',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: body
    })
})

Cypress.Commands.add('signin', (email,password,type,state) => {
    cy.request({
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
})

Cypress.Commands.add('verifyOTP', (email,accType,otp,state) => {
    cy.request({
        method: 'POST',
        url: '/ecurfew/verifyOTP',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: {
            "identifier":email,
            "accountIdentifierType": accType,
            "otp": otp,
            "stateName": state
        }

    })
})

Cypress.Commands.add('approve_reject', (email,accId,action,token) => {
    cy.request({
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

