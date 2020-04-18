/// <reference types="cypress" />

import * as loginData from '../../fixtures/auth/loginData.json';
import * as createResponse from '../../fixtures/auth/createOrderRes.json';
import * as allOrdersData from '../../fixtures/auth/allOrdersData.json';


var authToken: string;


context('Download Pass mandatory fields missing', () => {

    Object.keys(allOrdersData.valid).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let orders = Object.assign({}, allOrdersData.valid, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.getAllOrders(orders)
                .then((response) => {
                    expect(response.status).equal(500)
                    // expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('Get All Orders', () => {
    beforeEach(() => {
        let user=loginData.approver
        cy.signin(user)
            .then((response) => {
                authToken=response.body.authToken
            })
      })

    it('Orders :Get all orders', () => {
        let orders = allOrdersData.valid
        orders.authToken = authToken
        orders.accountID=createResponse.accountId
        cy.getAllOrders(orders)
            .then((response) => {
                expect(response.status).equal(200)
                expect(response.body).to.be.not.null

            });

    })
})

