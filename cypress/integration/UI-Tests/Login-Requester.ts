/// <reference types="cypress" />
// @ts-check
import * as common from '../../utils/UICommon';

context('Requester::Login Tests', () => {

    it('Login with valid credentials', () => {
        common.loginAsRequester('requester','dharmalingam.k+1@egovernments.org','test1234','DELHI')
        cy.get('title').should('have.text', 'Applicant Dashboard')

    })

    it('Login with invalid credentials', () => {
        common.loginAsRequester('requester','dharmalingam.k+1@egovernments.org','test123','DELHI')
        cy.get('div.has-text-danger').should('have.text', '  Invalid password ')

    })
    it('Login without email', () => {
        common.loginAsRequester('requester',' ','test123','DELHI')
        cy.get('div.has-text-danger').should('have.text', '  Invalid password ')

    })
})
