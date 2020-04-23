/// <reference types="cypress" />

import * as loginData from '../../fixtures/testData/loginData.json';
import * as allOrdersData from '../../fixtures/testData/allOrdersData.json';

var authToken: string;
context('Get All Organisations', () => {
    beforeEach(() => {
        let user=loginData.approver
        cy.signin(user)
            .then((response) => {
                authToken=response.body.authToken
            })
      })

    it('Get All Organisations', () => {
        let org = allOrdersData.valid
        org.authToken=authToken
        cy.getAllOrganisations(org)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body).to.be.not.null
                expect(response.body).to.have.all.keys("organizations")

            });

    })
})

