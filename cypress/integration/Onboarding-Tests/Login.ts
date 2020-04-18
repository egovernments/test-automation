/// <reference types="cypress" />
// @ts-check

import * as loginData from '../../fixtures/auth/loginData.json';


context('Login mandatory fields missing', () => {

    Object.keys(loginData.userValidLogin).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let user = Object.assign({}, loginData.userValidLogin, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.signin(user)
                .then((response) => {
                    expect(response.status).equal(500)
                    // expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('ePass Login Test Cases', () => {
    it('Login as requester with Approved email', () => {
        let user = loginData.userValidLogin
        cy.signin(user)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body.organizationName).equal('KDS Limited')
            })
    })

    it('Login as requester with Rejected email', () => {
        let user = loginData.rejectedUser
        cy.signin(user)
            .then((response) => {
                expect(response.status).equal(500)
                expect(response.body.message).to.have.string('Account declined or blocked')
            })
    })

    it('Login as approver ', () => {
        let user = loginData.approver
        cy.signin(user)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body.accountName).to.have.string('superuser')
            })
    })
})
