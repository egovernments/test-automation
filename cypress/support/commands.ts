/// <reference types="Cypress" />

import { ISignIn, IRegister, IVerifyOtp, IApproveAccount, ICreateOrder, IDownloadQRCode, IGetAllOrders } from './models';

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
    return postApi('/ecurfew/createOrder', data);

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


