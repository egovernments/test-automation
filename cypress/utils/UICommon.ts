import * as LoginPage from '../pageObjects/LoginPage.json';
import * as RegisterPage from '../pageObjects/RegisterPage.json';

export function loginAsRequester(type,email,password,state) {
        cy.visit('/'+type+'-dashboard/login')
        cy.get(LoginPage.loginForm.emailInput).type(email)
        cy.get(LoginPage.loginForm.passwordInput).type(password)
        cy.get(LoginPage.loginForm.stateDropDown).select(state)
        cy.get(LoginPage.loginForm.submitButton).click()
        //title
}

export function createAccount(orgName,GST,PEID,state,name,email,password) {
    let register=RegisterPage.registerForm
    cy.visit('requester-dashboard/register')
    cy.get(register.orgNameInput).type(orgName)
    cy.get(register.GSTIDInput).type(GST)
    cy.get(register.PEIDInput).type(PEID)
    cy.get(register.stateInput).select(state)
    cy.get(register.nameInput).type(name)
    cy.get(register.emailInput).type(email)
    cy.get(register.passwordInput).type(password)
    cy.get(register.confirmPwdInput).type(password)
    cy.get(register.registerButton).click()

}

export function verifyOtp(otp,peid) {
    let otpForm=RegisterPage.otpForm
    cy.get(otpForm.otpInput).type(otp)
    cy.get(otpForm.peidInput).type(peid)
    cy.get(otpForm.verifyEmailButton).click()

}

