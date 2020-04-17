const registerBody = require('../../fixtures/auth/registerBody.json')
context('ePass Registration Test cases',()=>{

  it('Register as Organisation with valid email',()=>{
      registerBody.email='dharmalingam.k+'+Math.floor(Math.random() * 1000)+'@egovernments.org'
      cy.register(registerBody).then((response)=>{
          expect(response.status).equal(200)
          expect(response.body.message).equal('Account Created')
      })
  })

  it('Register as Organisation with exist email',()=>{

    cy.register(registerBody).then((response)=>{
        expect(response.status).equal(500)
        expect(response.body.message).equal('Error Creating account Please verify your email.')
    })
})

})
