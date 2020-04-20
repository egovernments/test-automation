// in cypress/support/index.d.ts
// load type definitions that come with Cypress module
/// <reference types="cypress" />

export interface ISignIn {
    email: String;
    password: String;
    accountType: String;
    stateName: String;
}

export interface IAuthRequired {
    authToken: String
}
export interface IRegister {
    name: String;
    email: String;
    password: String;
    orgID: String;
    orgName: String;
    stateName: String;
}

export interface IVerifyOtp {
    identifier: String;
    accountIdentifierType: Number;
    otp: String;
    stateName: String;
}

export interface IGetPendingAccount extends IAuthRequired {

}
export interface IApproveAccount {
    identifier: String;
    accountIdentifierType: String;
    otp: String;
    stateName: String;
}

export interface ICreateOrder extends IAuthRequired {
    file: String;
    orderType: String
    purpose: String;
}

export interface IDownloadQRCode extends IAuthRequired {
    orderID: String
}

export interface IGetAllOrders extends IAuthRequired {
    accountID: String
}
