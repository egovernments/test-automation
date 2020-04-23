/// <reference types="Cypress" />

import { ISignIn, IRegister, IVerifyOtp, IApproveAccount, ICreateOrder, IDownloadQRCode, IGetAllOrders,IGetPendingAccount,IUpdatePassword, IGetAllOrganisations } from './models';
import axios from 'axios';

function postApi(url: string, data: Cypress.RequestBody){
    let body: Partial<Cypress.RequestOptions> = {
        method: 'POST',
        url: url,
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: data
    }
    return cy.request(body);
}

const signin = (data: Partial<ISignIn>) => {
    return postApi('/ecurfew/signin', data);
}

Cypress.Commands.add('signin', signin);

const register = (data: IRegister) => {
    return postApi( '/ecurfew/createAccount', data);
}

Cypress.Commands.add('register', register);

const verifyOTP = (data: IVerifyOtp) => {
    return postApi('/ecurfew/verifyOTP', data);

}
Cypress.Commands.add('verifyOTP', verifyOTP);

const approveAccount = (data: IApproveAccount) => {
    return postApi('/ecurfew/approveAccount', data);

}
Cypress.Commands.add('approveAccount', approveAccount);

const createOrder = (data: ICreateOrder) => {
    // return postApi('/ecurfew/createOrder', data);
    // let body: Partial<Cypress.RequestOptions> = {
    //     method: 'POST',
    //     url: '/ecurfew/createOrder',
    //     form: true,
    //     failOnStatusCode: false,
    //     headers: {
    //         'content-type': 'multipart/form-data'
    //     },
    //     body: data
    // }
    // return cy.request(body);
    return axios({
        method: 'post',
        url: '/ecurfew/createOrder',
        data: data,
        headers: {'Content-Type': 'multipart/form-data' }
        })
}

Cypress.Commands.add('createOrder', createOrder)

const donwloadQRCode = (data: IDownloadQRCode) => {
    return postApi('/ecurfew/downloadQRCodes', data);

}
Cypress.Commands.add('donwloadQRCode', donwloadQRCode)

const getAllOrders = (data: IGetAllOrders) => {
    return postApi('/ecurfew/getAllOrders', data);
}

Cypress.Commands.add('getAllOrders', getAllOrders)

const getPendingAccount = (data:IGetPendingAccount) => {
    return postApi('/ecurfew/getAllAccountsPendingVerification',data)
}

Cypress.Commands.add('getPendingAccount', getPendingAccount)

const updatePassword = (data: IUpdatePassword) => {
    return postApi('/ecurfew/updatePassword',data)
}

Cypress.Commands.add('updatePassword', updatePassword)

const getState = (data) => {
    return postApi('/ecurfew/fetchStateList',data)
}

Cypress.Commands.add('getState', getState)

const getAllOrganisations = (data:IGetAllOrganisations) => {
    return postApi('/ecurfew/getAllOrganizations',data)
}

Cypress.Commands.add('getAllOrganisations', getAllOrganisations)
