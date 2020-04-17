const registerBody = require('../../fixtures/auth/registerBody.json')
const signinBody = require('../../fixtures/auth/loginBody.json')
const loginData = require('../../fixtures/auth/loginData.json')
context('ePass OTP verification Test cases',()=>{
    let email='dharmalingam.k+'+Math.floor(Math.random() * 1000)+'@egovernments.org'
    it('Register as Organisation with valid email',()=>{
        registerBody.email=email
        cy.register(registerBody).then((response)=>{
            expect(response.status).equal(200)
            expect(response.body.message).equal('Account Created')
        })
    })

    it('Verify email by OTP',()=>{
        cy.verifyOTP('dharmalingam.k+93@egovernments.org','email','732786','DELHI')

        .then((response)=>{
            expect(response).to.have.property('status', 200);
            expect(response.body).to.have.all.keys("authToken","publicKey")
        })
    })

    it('Verify email by Invalid OTP',()=>{
        cy.verifyOTP(email,'email','332211','DELHI')

        .then((response)=>{
            expect(response).to.have.property('status', 500);
            expect(response.body.message).equal('OTP has expired')
        })
    })


})
