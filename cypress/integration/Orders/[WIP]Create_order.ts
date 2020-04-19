/// <reference types="cypress" />
// @ts-check

import * as loginData from '../../fixtures/auth/loginData.json';
import * as createOrder from '../../fixtures/auth/createOrder.json';
import axios from 'axios';


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
        cy.readFile('./cypress/fixtures/csv_files/epass_valid_2user.csv', 'base64').then((data) => {
            Cypress.Blob.base64StringToBlob(data).then((blob)=>{
                order.file = data; 
                let formData: FormData = new FormData();
                formData.append("authToken", "")
                formData.append("orderType", "person")
                formData.append("purpose", "Essential services")
                formData.append("file",  new File([blob], "test.csv", { type: 'text/csv' }))
                cy.createOrder(formData)
                .then((response) => {
                    expect(response.status).equal(200)
                    // expect(response.body).to.have.string("approved")
                })    
            })
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
