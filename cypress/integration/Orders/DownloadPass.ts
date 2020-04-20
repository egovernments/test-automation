/// <reference types="cypress" />

import * as loginData from '../../fixtures/testData/loginData.json';
import * as createResponse from '../../fixtures/testData/createOrderRes.json';
import * as downloadData from '../../fixtures/testData/downloadData.json';
import * as login from '../../fixtures/testData/login.json'


var authToken: string;


context('Download Pass mandatory fields missing', () => {

    Object.keys(downloadData.downloadQRCode).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let download = Object.assign({}, downloadData.downloadQRCode, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.donwloadQRCode(download)
                .then((response) => {
                    expect(response.status).equal(400)
                    expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('Download Pass as approver and requester Test Cases', () => {
    beforeEach(() => {
        let user=loginData.approver
        cy.signin(user)
            .then((response) => {
                authToken=response.body.authToken
            })
      })
    it('Download pass as approver and validate the zip file', () => {
        let download = downloadData.downloadQRCode
        download.authToken = authToken
        download.orderID=createResponse.id
        cy.donwloadQRCode(download)
            .then((response) => {
                expect(response.status).equal(200)
                cy.request('GET', response.body.processedS3URL).then((response) => {
                    expect(response.status).equal(200)
                })
            })

    })

    it('Download pass as requester and validate the zip file', () => {
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
