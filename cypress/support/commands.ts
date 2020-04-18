import { ISignIn, IRegister, IVerifyOtp, IApproveAccount, ICreateOrder, IDownloadQRCode } from './models';

const signin = (data: ISignIn) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/signin',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: data
    })
}

Cypress.Commands.add('signin', signin);

const register = (data: IRegister) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/createAccount',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: data
    })
}
Cypress.Commands.add('register', register);


const verifyOTP = (data: IVerifyOtp) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/verifyOTP',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: data

    })
}
Cypress.Commands.add('verifyOTP', verifyOTP);

const approveAccount = (data: IApproveAccount) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/approveAccount',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json;charset=UTF-8'
        },
        body: data

    })
}
Cypress.Commands.add('approveAccount', approveAccount);

const createOrder = (data: ICreateOrder) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/createOrder',
        failOnStatusCode: false,
        headers: {
            'content-type': 'multipart/form-data; boundary=----WebKitFormBoundaryD3u3amCb9BMTuDLp'
        },
        body: data

    })
}
Cypress.Commands.add('createOrder', createOrder)

const donwloadQRCode = (data: IDownloadQRCode) => {
    return cy.request({
        method: 'POST',
        url: '/ecurfew/downloadQRCodes',
        failOnStatusCode: false,
        headers: {
            'content-type': 'application/json'
        },
        body: data

    })
}
Cypress.Commands.add('donwloadQRCode', donwloadQRCode)


