/// <reference types="cypress" />

import * as loginData from '../../fixtures/auth/loginData.json';
import * as createResponse from '../../fixtures/auth/createOrderRes.json';
import * as downloadData from '../../fixtures/auth/downloadData.json';
import * as login from '../../fixtures/auth/login.json'


var authToken: string;


context('Download Pass mandatory fields missing', () => {

    Object.keys(downloadData.downloadQRCode).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let download = Object.assign({}, downloadData.downloadQRCode, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.donwloadQRCode(download)
                .then((response) => {
                    expect(response.status).equal(500)
                    // expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('Download Pass Test Cases', () => {
    it('Download pass and validate the zip file', () => {
        let download = downloadData.downloadQRCode
        download.authToken = login.authToken
        download.orderID=createResponse.id
        cy.donwloadQRCode(download)
            .then((response) => {
                expect(response.status).equal(200)
                cy.request('GET', response.body.processedS3URL).then((response) => {
                    expect(response.status).equal(200)
                })
            })

    })


})
