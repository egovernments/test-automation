/// <reference types="cypress" />

import * as registerBody from '@fixtures/testData/registerData.json';
import * as common from '@src/utils/commonActions'

context('Registration mandatory fields missing', () => {

    Object.keys(registerBody.validData).forEach((key: string) => {
        let updatedValue: any = {}
        updatedValue[key] = null;

        let user = Object.assign({}, registerBody.validData, updatedValue)

        it(`has missing parameter ${key}`, () => {
            cy.register(user)
                .then((response) => {
                    expect(response.status).equal(400)
                    expect(response.body.error).does.not.contain("Internal Server Error")

                });
        })
    });
});

context('ePass Registration Test cases', () => {

    it('Register as Organisation with valid email', () => {
        let user = registerBody.validData
        user.email = common.randomEmail()
        user.orgID=common.randomGSTIN()
        cy.register(user).then((response) => {
            expect(response.status).equal(200)
            expect(response.body.message).equal('Account Created')
        })
    })

    it('Register as Organisation with invalid org ID', () => {
        let user = registerBody.invalidData
        cy.register(user).then((response) => {
            expect(response.status).equal(400)
            expect(response.body.message).to.have.string('Validation failed')
        })
    })

    it('Register as Organisation with exist email', () => {
        let user = registerBody.existData
        cy.register(user).then((response) => {
            expect(response.status).equal(400)
            expect(response.body.message).to.have.string('Account already exists')
        })
    })
})
