/// <reference types="cypress" />

import * as states from '../../fixtures/testData/states.json';


context('Get All Orders', () => {

    it('Orders :Get all orders', () => {

        cy.getState(null)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body).to.be.not.null
                expect(response.body.stateMap).to.be.eql(states.states)

            });

    })
})

