Feature: collection-services-Create tests

Background:
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../business-services/preTests/billingServicePretest.feature@fetchBill')
    * def paidBillIdError = collectionServicesConstants.errorMessages.paidBillId
    * def invalidBillIdError = collectionServicesConstants.errorMessages.invalidBillId
    * def totalAmountPaidError = collectionServicesConstants.errorMessages.totalAmountPaidNull
    * def invalidPaymentModeError = collectionServicesConstants.errorMessages.invalidPaymentMode
    * def invalidTenantIdError = commonConstants.errorMessages.invalidTenantIdError
    * def nullTenantIdError = commonConstants.errorMessages.nullParameterError
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action

 @Create_PaymentWithValidBillID_01 @positive @CreatePayment @collectionServices 
    Scenario: Make payment with valid Bill id 
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match response.ResponseInfo.status == '200 OK'
     * def paymentId = collectionServicesResponseBody.Payments[0].id
     * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithPaidBillID_02 @negative @CreatePayment @collectionServices
    Scenario: Make payment with paid Bill id 
     * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
     * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with valid Bill id first
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Set the `billId` value with paid bill id
     * set createPaymentRequest.Payment.paymentDetails[0].billId = billId
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Calling steps to Cancel the Payment along with Payment Id
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match collectionServicesResponseBody.Errors[0].message == paidBillIdError
     * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithInvalidBillID_03 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Bill id
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBillId')
    * match response.Errors[0].message == invalidBillIdError
    * print collectionServicesResponseBody
    
@Create_PaymentWithInvalidBusinessService_04 @positive @CreatePayment @collectionServices
    Scenario: Make payment with invalid Business ID
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBusinessService')
    * match response.ResponseInfo.status == '200 OK'
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Calling steps to Cancel the Payment along with Payment Id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithAmountpaid_Null_05 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Business ID
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@totalAmountPaidNull')
    * match response.Errors[0].message == totalAmountPaidError

@Create_PaymentWith_PaymentModeCard_06 @positive @CreatePayment @collectionServices
    Scenario: Make payment with Card payment mode
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with Card type payment mode
    * call read('../preTests/collectionServicesPretest.feature@cardPaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

@Create_PaymentWith_InvalidPaymentMode_07 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Payment mode
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Payment Mode
    * call read('../preTests/collectionServicesPretest.feature@errorPaymentMode')
    * match response.Errors[0].message == invalidPaymentModeError

@Create_PaymentWith_InvalidtenantID_08 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Tenant Id
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@errorTenantId')
    * match response.Errors[0].message == invalidTenantIdError

@Create_PaymentWith_NotenantID_09 @negative @CreatePayment @collectionServices
    Scenario: Make payment with null Tenant Id
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Tenant Id
    * call read('../preTests/collectionServicesPretest.feature@nullTenantIdPayment')
    * match response.Errors[0].message == nullTenantIdError

@Create_PaymentWith_negativeAmount_10 @negative @CreatePayment @collectionServices
    Scenario: Make payment with negative total amount paid
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with negative total amount paid value
    * call read('../preTests/collectionServicesPretest.feature@negativeTotalAmount')
    * def billId = fetchBillResponse.Bill[0].id
    * def negativeAmountError = "The amount paid for the paymentDetail with bill number: " + billId
    * match response.Errors[0].message == negativeAmountError