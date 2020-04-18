/// <reference types="cypress" />

import * as loginData from '../../fixtures/auth/loginData.json';
import * as createOrder from '../../fixtures/auth/createOrder.json';


var authToken: string;
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
    it('Create bulk pass', () => {
        let order = createOrder.validfile_2User
        order.authToken = authToken
        order.file=cy.readFile('../../fixtures/csv_files/epass_valid_2user.csv')
        cy.createOrder(order)
            .then((response) => {
                expect(response.status).equal(200)
                // expect(response.body).to.have.string("approved")
            })

    })


    // it.only("API POSTing TEST", () => {
    //     let order = createOrder.validfile_2User
    //     cy.Post_Clients(
    //       "csv_files/epass_valid_2user",
    //       "text/csv",
    //         authToken,
    //       order.purpose,
    //       order.orderType).then((response) => {
    //         expect(response.status).equal(200)
    //         expect(response.body.accountName).to.have.string('superuser')
    //         authToken = response.body.authToken
    //     })
    //   });
})
