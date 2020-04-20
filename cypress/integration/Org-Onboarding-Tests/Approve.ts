/// <reference types="cypress" />
import * as registerBody from '../../fixtures/testData/registerData.json';
import * as verifyOTP from '../../fixtures/testData/verifyOTP.json';
import * as loginData from '../../fixtures/testData/loginData.json';
import * as approveData from '../../fixtures/testData/approveData.json';
import * as commonActions from '../../utils/commonActions'
var authToken: string, accId: number, email: string;

context('ApproveAccount mandatory fields missing', () => {

    Object.keys(approveData.validAcceptAccount).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let approve = Object.assign({}, approveData.validAcceptAccount, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.approveAccount(approve)
                .then((response) => {
                    expect(response.status).equal(400)
                    expect(response.body.error).does.not.contain("Internal Server Error")
                });
        })
    });
});

context('ePass Login Test Cases', () => {

    it('Login as approver ', () => {
        let user = loginData.approver
        cy.signin(user)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body.accountName).to.have.string('superuser')
                authToken = response.body.authToken
            })
    })
    it('Get All pending approval organisations', () => {
        cy.request({
            method: 'POST',
            url: '/ecurfew/getAllAccountsPendingVerification',
            failOnStatusCode: false,
            headers: {
                'content-type': 'application/json;charset=UTF-8'
            },
            body: {
                "authToken": authToken
            }

        }).then((response) => {
            let accounts = response.body.accounts
            expect(response.status).equal(200)

            if (accounts.length < 1) {
                console.log('No pending approval organisations and stop execution')
            } else {
                console.log(response.body)
                accId = response.body.accounts[0].id
                email = response.body.accounts[0].email
            }

        })
    })

    it('Approve the Signup request', () => {
        let newEmail=commonActions.randomEmail()
        let approve = approveData.validAcceptAccount
        approve.email = newEmail
        approve.requesterAccountId = accId
        approve.authToken = authToken
        let user = registerBody.validData
        user.email = newEmail
        cy.register(user);
        let otp = verifyOTP.validData
        otp.identifier = newEmail
        cy.verifyOTP(otp)
        cy.approveAccount(approve)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body).to.have.string("approved")
            })

    })
    it('Decline the Signup request', () => {
        let newEmail=commonActions.randomEmail()
        let approve = approveData.validRejectAccount
        approve.email = newEmail
        approve.requesterAccountId = accId
        approve.authToken = authToken
        let user = registerBody.validData
        user.email = newEmail
        cy.register(user);
        let otp = verifyOTP.validData
        otp.identifier = newEmail
        cy.verifyOTP(otp)
        cy.approveAccount(approve)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body).to.have.string("approved")
            })

    })

})
