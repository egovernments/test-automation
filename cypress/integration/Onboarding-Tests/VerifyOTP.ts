/// <reference types="cypress" />

import * as registerBody from '../../fixtures/auth/registerData.json';
import * as verifyOTP from '../../fixtures/auth/verifyOTP.json';

context('Registration mandatory fields missing', () => {

    Object.keys(verifyOTP.validData).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let user = Object.assign({}, verifyOTP.validData, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.verifyOTP(user.identifier, user.accountIdentifierType, user.otp, user.stateName)
                .then((response) => {
                    expect(response.status).equal(400)
                    expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('ePass OTP verification Test cases', () => {
    let email = 'dharmalingam.k+' + Math.floor(Math.random() * 1000) + '@egovernments.org'
    it('Register as Organisation with valid email', () => {
        let user = registerBody.validData

        cy.register(user.name, email, user.password, user.orgID, user.orgName, user.stateName).then((response) => {
            expect(response.status).equal(200)
            expect(response.body.message).equal('Account Created')
        })
    })


    it('Verify email by Invalid OTP', () => {
        let otp = verifyOTP.validData
        cy.verifyOTP(email, otp.accountIdentifierType, '232323', otp.stateName)
            .then((response) => {
                expect(response).to.have.property('status', 500);
                expect(response.body.message).equal('Invalid OTP')
            })
    })

    it('Verify email by OTP', () => {
        let otp = verifyOTP.validData
        cy.verifyOTP(email, otp.accountIdentifierType, otp.otp, otp.stateName)
            .then((response) => {
                expect(response).to.have.property('status', 200);
                expect(response.body).to.have.all.keys("authToken", "publicKey")
            })
    })



})
