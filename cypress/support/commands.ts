import { ISignIn,IRegister,IVerifyOtp,IApproveAccount,ICreateOrder } from './models';

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

const register = (data:IRegister) => {
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
    Cypress.Commands.add('register',register);


const verifyOTP = (data:IVerifyOtp) => {
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

const approveAccount = (data:IApproveAccount) => {
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

const createOrder = (data:ICreateOrder) => {
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

// Cypress.Commands.add(
//     "Post_Clients",
//     (csvPath, fileType, authToken, purpose, orderType) => {
//       cy.fixture(csvPath, "binary").then(csvBin => {
//         Cypress.Blob.binaryStringToBlob(csvBin, fileType).then(blob => {
//           const xhr = new XMLHttpRequest();
//           xhr.withCredentials = true;
//           const data = new FormData();
//           data.set("authToken", authToken);
//             data.set("orderType", orderType);
//             data.set("purpose", purpose);
//             data.set("file", blob);
//           xhr.open("POST", "/ecurfew/createOrder");
//           xhr.setRequestHeader("content-type", "multipart/form-data");

//           xhr.onload = function() {
//             done(xhr);
//           };
//           xhr.onerror = function() {
//             done(xhr);
//           };
//           xhr.send(data);
//         });
//       });
//     }
// );

