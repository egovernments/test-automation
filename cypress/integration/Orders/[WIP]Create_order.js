const signinBody = require('../../fixtures/auth/loginBody.json')
const loginData = require('../../fixtures/auth/loginData.json')
let authToken,accId,email=""
context('ePass Login Test Cases',()=>{

    it('Login as requester with Approved email',()=>{
        let user=loginData.userValidLogin
          cy.signin(user.email,user.password,user.type,user.state).then((response)=>{
              expect(response.status).equal(200)
              expect(response.body.organizationName).equal('KDS Limited')
          })
      })
    it('Get All pending approval organisations',()=>{
        cy.request({
            method: 'POST',
            url: '/ecurfew/getAllAccountsPendingVerification',
            failOnStatusCode: false,
            headers: {
                'content-type': 'application/json;charset=UTF-8'
            },
            body: {
                "authToken": authToken
            }

    }).then((response)=>{
        let accounts=response.body.accounts
        expect(response.status).equal(200)

        if(accounts.length<1){
            console.log('No pending approval organisations and stop execution')
            Cypress.stop()
        }else{
            console.log(response.body)
            accId=response.body.accounts[0].id
            email=response.body.accounts[0].email
        }

    })
})

    it('Approve the Signup request',()=>{
        let user=loginData.approver
        cy.approve_reject(email,accId,'ACCEPT',authToken).then((response)=>{
            expect(response.status).equal(200)
            expect(response.body).to.have.all.keys("authToken","publicKey")


        })

    })
    it('Decline the Signup request',()=>{
        let user=loginData.approver
        cy.approve_reject(email,accId,'DECLINE',authToken).then((response)=>{
            expect(response.status).equal(200)
            expect(response.body).to.have.all.keys("authToken","publicKey")

        })

    })

})
