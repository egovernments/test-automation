/// <reference types="cypress" />
// @ts-check

//const signinBody = require('../../fixtures/auth/loginBody.json')
//const loginData = require('../../fixtures/auth/loginData.json')
import * as loginData from '../../fixtures/auth/loginData.json';

context('ePass Login Test Cases', () => {

    it('Login as requester with Approved email', () => {
        let user = loginData.userValidLogin
        cy.signin(user.email, user.password, user.type, user.state)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body.organizationName).equal('KDS Limited')
            })
    })

    it('Login as requester with Rejected email', () => {
        let user = loginData.rejectedUser
        cy.signin(user.email, user.password, user.type, user.state).then((response) => {
            expect(response.status).equal(500)
            expect(response.body.message).to.have.string('Account declined or blocked')
        })
    })

    it('Login as approver ', () => {
        let user = loginData.approver
        cy.signin(user.email, user.password, user.type, user.state).then((response) => {
            expect(response.status).equal(200)
            expect(response.body.accountName).to.have.string('superuser')
        })
    })

})