/// <reference types="cypress" />

import * as loginData from '../../fixtures/auth/loginData.json';


var authToken:string, accId:string, email:string;
context('ePass Login Test Cases',()=>{

    it('Login as approver ',()=>{
        let user=loginData.approver
        cy.signin(user.email,user.password,user.type,user.state).then((response)=>{
            expect(response.status).equal(200)
            expect(response.body.accountName).to.have.string('superuser')
            authToken=response.body.authToken
        })
    })


    it('Create bulk pass', () => {
        let fileName = new File('../../fixtures/csv_files/epass_valid_2user.csv');
        cy.create_pass(fileName,'person','Essential services',authToken).then((response)=>{
            expect(response.status).equal(200)
            // expect(response.body).to.have.string("approved")


        })

    })

})
