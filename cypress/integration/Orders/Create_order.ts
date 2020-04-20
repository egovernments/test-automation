/// <reference types="cypress" />
// @ts-check

import * as loginData from '../../fixtures/testData/loginData.json';
import * as createOrder from '../../fixtures/testData/createOrder.json';
import * as commonActions from '../../utils/commonActions';
import axios from 'axios';


var authToken: string;
context('Create bulk pass test cases', () => {
    beforeEach(() => {
        let user=loginData.userValidLogin
        cy.signin(user)
            .then((response) => {
                authToken=response.body.authToken
            })
      })
    it('Create bulk pass with valid user details', () => {
        cy.readFile('./cypress/fixtures/csv_files/epass_valid_2user.csv', 'base64').then((data) => {
            Cypress.Blob.base64StringToBlob(data).then((blob)=>{
                let formData: FormData = new FormData();
                formData.append("authToken", authToken)
                formData.append("orderType", "person")
                formData.append("purpose", "Essential services")
                formData.append("file", new File([blob], "test.csv", { type: 'text/csv' }))
                cy.createOrder(formData)
                .then((response) => {
                    expect(response.status).equal(200)
                    // expect(response.body.orderStatus).to.have.string("approved")

                })
            })
        })
    })

    it('Create bulk pass with invalid user data', () => {
        cy.readFile('./cypress/fixtures/csv_files/epass_invalid_2user.csv', 'base64').then((data) => {
            Cypress.Blob.base64StringToBlob(data).then((blob)=>{
                let formData: FormData = new FormData();
                formData.append("authToken", authToken)
                formData.append("orderType", "person")
                formData.append("purpose", "Essential services")
                formData.append("file", new File([blob], "test.csv", { type: 'text/csv' }))
                cy.createOrder(formData)
                .then((response) => {
                    expect(response.status).equal(400)
                    // expect(response.body.orderStatus).to.have.string("approved")

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
