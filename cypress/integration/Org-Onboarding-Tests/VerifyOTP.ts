/// <reference types="cypress" />

import * as registerBody from '../../fixtures/testData/registerData.json';
import * as verifyOTP from '../../fixtures/testData/verifyOTP.json';
import * as commonActions from '../../utils/commonActions';

context('VerifyOTP mandatory fields missing', () => {

    Object.keys(verifyOTP.validData).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let user = Object.assign({}, verifyOTP.validData, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.verifyOTP(user)
                .then((response) => {
                    expect(response.status).equal(400)
                    expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('ePass OTP verification Test cases', () => {
    let email = commonActions.randomEmail()
    it('Register as Organisation with valid email', () => {
        let user = registerBody.validData
        user.email = email

        cy.register(user)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body.message).equal('Account Created')
            })
    })


    it('Verify email by Invalid OTP', () => {
        let otp = verifyOTP.InvalidData
        otp.identifier = email
        cy.verifyOTP(otp)
            .then((response) => {
                expect(response).to.have.property('status', 400);
                expect(response.body.message).equal('Invalid OTP')
            })
    })

    it('Verify email by OTP', () => {
        let otp = verifyOTP.validData
        otp.identifier = email
        cy.verifyOTP(otp)
            .then((response) => {
                expect(response).to.have.property('status', 200);
                expect(response.body).to.have.all.keys("authToken", "publicKey")
            })
    })



})
