/// <reference types="cypress" />
import * as registerBody from '../../fixtures/testData/registerData.json';
import * as verifyOTP from '../../fixtures/testData/verifyOTP.json';
import * as loginData from '../../fixtures/testData/loginData.json';
import * as approveData from '../../fixtures/testData/approveData.json';
import * as allOrdersData from '../../fixtures/testData/allOrdersData.json';
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
                    expect(response.status).equal(400|401)
                    expect(response.body.error).does.not.contain("Internal Server Error")
                });
        })
    });
});

context('ePass ApproveAccount Test Cases', () => {

    before(() => {
        let user = loginData.approver
        cy.signin(user)
            .then((response) => {
                authToken = response.body.authToken
            })
    })

    it('Decline the Signup request', () => {
        let newEmail = commonActions.randomEmail()
        let user = registerBody.validData
        user.name = commonActions.randomName()
        user.email = newEmail
        user.orgID = commonActions.randomGSTIN()
        user.orgName=commonActions.randomCompanyName()
        cy.register(user);
        let otp = verifyOTP.validData
        otp.identifier = newEmail
        cy.verifyOTP(otp)
        let data = allOrdersData.valid
        data.authToken = authToken
        cy.getPendingAccount(data).then((response) => {
            console.log(response.body)
            accId = response.body.accounts[0].id
            email = response.body.accounts[0].email
            let approve = approveData.validRejectAccount
            approve.email = email
            approve.authToken = authToken
            approve.requesterAccountId = accId

            //Reject account
            cy.approveAccount(approve)
                .then((response) => {
                    expect(response.status).equal(200)
                    expect(response.body).to.have.string("approved")
                })
        })



    })

    it('Approve the Signup request', () => {
        let newEmail = commonActions.randomEmail()
        let user = registerBody.validData
        user.name = commonActions.randomName()
        user.email = newEmail
        user.orgID = commonActions.randomGSTIN()
        user.orgName=commonActions.randomCompanyName()
        cy.register(user);
        let otp = verifyOTP.validData
        otp.identifier = newEmail
        cy.verifyOTP(otp)
        let data = allOrdersData.valid
        data.authToken = authToken
        cy.getPendingAccount(data).then((response) => {
            console.log(response.body)
            accId = response.body.accounts[0].id
            email = response.body.accounts[0].email
            let approve = approveData.validAcceptAccount
            approve.email = newEmail
            approve.authToken = authToken
            approve.requesterAccountId = accId

            //Approve Account
            cy.approveAccount(approve)
                .then((response) => {
                    expect(response.status).equal(200)
                    expect(response.body).to.have.string("approved")
                })
        })


    })

})
