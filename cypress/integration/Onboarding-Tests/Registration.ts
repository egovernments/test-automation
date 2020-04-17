/// <reference types="cypress" />

import * as registerBody from '../../fixtures/auth/registerData.json';

context('ePass Registration Test cases', () => {

    it('Register as Organisation with valid email', () => {
        let user = registerBody.validData
        let email ='dharmalingam.k+'+Math.floor((Math.random() * 1000) + 1)+'@egovernments.org'
        cy.register(user.name,email,user.password,user.orgID,user.orgName,user.stateName).then((response) => {
          expect(response.status).equal(200)
          expect(response.body.message).equal('Account Created')
      })
  })

  it('Register as Organisation with invalid org ID',()=>{
    let user = registerBody.invalidData
    cy.register(user.name,user.email,user.password,user.orgID,user.orgName,user.stateName).then((response) => {
        expect(response.status).equal(400)
        expect(response.body.message).to.have.string('Validation failed')
    })
  })

  it('Register as Organisation with exist email',()=>{
    let user = registerBody.existData
    cy.register(user.name,user.email,user.password,user.orgID,user.orgName,user.stateName).then((response) => {
        expect(response.status).equal(500)
        expect(response.body.message).to.have.string('Account already exists')
    })
})

})
