/// <reference types="cypress" />
// @ts-check
import * as common from '../../utils/UICommon';
import * as RegisterPage from '../../pageObjects/RegisterPage.json';

context('Requester::Register Tests', () => {

    it('Register with all the valid data', () => {
        common.createAccount('test org','DHARMA098765432','909098765432','DELHI','DharmaK','dharmalingam.k+7119@egovernments.org','test1234')
        cy.get('div.verify-otp-form .title').should('have.text', 'Enter OTP')
        common.verifyOtp('123456', '123456')
        cy.get(RegisterPage.successPage.successText).should('have.text', 'Account created successfully')

    })

})
