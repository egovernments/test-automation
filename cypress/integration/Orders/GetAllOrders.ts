/// <reference types="cypress" />

import * as loginData from '../../fixtures/testData/loginData.json';
import * as createResponse from '../../fixtures/testData/createOrderRes.json';
import * as allOrdersData from '../../fixtures/testData/allOrdersData.json';


var authToken: string;


context('GetAlllOrders mandatory fields missing', () => {

    Object.keys(allOrdersData.valid).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let orders = Object.assign({}, allOrdersData.valid, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.getAllOrders(orders)
                .then((response) => {
                    expect(response.status).equal(400|401)
                    expect(response.body.error).does.not.contain("Internal Server Error")

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

