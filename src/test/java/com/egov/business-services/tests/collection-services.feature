Feature: Business Services - Collection service tests

 Background:
     * def jsUtils = read('classpath:jsUtils.js')
     * configure headers = read('classpath:websCommonHeaders.js')
    
     * def collectionServiceData = read('../constants/collectionServices.yaml')
     * def collectionServiceCommonError = read('../constants/commonConstants.yaml')
     * def tenantId = tenantId
     * def businessService = collectionServiceData.parameters.businessService
     * def propertyId = collectionServiceData.parameters.propertyId
     * def paymentMode = collectionServiceData.parameters.paymentMode
     * def paidBy = collectionServiceData.parameters.paidBy
     * def mobileNumber = collectionServiceData.parameters.mobileNumber
     * def payerName = collectionServiceData.parameters.payerName
     * def transactionNumber = collectionServiceData.parameters.transactionNumber
     * def instrumentNumber = collectionServiceData.parameters.instrumentNumber
     * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
     * def paidBillIdError = collectionServiceData.errorMessages.paidBillId
     * def invalidBillIdError = collectionServiceData.errorMessages.invalidBillId
     * def totalAmountPaidError = collectionServiceData.errorMessages.totalAmountPaidNull
     * def invalidPaymentModeError = collectionServiceData.errorMessages.invalidPaymentMode
     * def invalidTenantIdError = collectionServiceCommonError.errorMessages.invalidTenantIdError
     * def nullTenantIdError = collectionServiceCommonError.errorMessages.nullParameterError
    
@validBillId @positive @collectionService
    Scenario: Make payment with valid Bill id 
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match response.ResponseInfo.status == '200 OK'

@paidBillId @negative @collectionService
    Scenario: Make payment with paid Bill id 
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with valid Bill id first
    * call read('../tests/collection-services.feature@validBillId')
    # Set the `billId` value with paid bill id
    * set createPaymentRequest.Payment.paymentDetails[0].billId = billId
    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 400
    And match response.Errors[0].message == paidBillIdError

@invalidBillId @negative @collectionService
    Scenario: Make payment with invalid Bill id
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill') 
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBillId')
    * match response.Errors[0].message == invalidBillIdError

@invalidBusinessId @positive @collectionService
    Scenario: Make payment with invalid Business ID
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBusinessService')
    * match response.ResponseInfo.status == '200 OK'

@invalidTotalAmountPaid @negative @collectionService
    Scenario: Make payment with invalid Business ID
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@totalAmountPaidNull')
    * match response.Errors[0].message == totalAmountPaidError

@invalidPaymentMode @negative @collectionService
    Scenario: Make payment with invalid Payment mode
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with invalid Payment Mode
    * call read('../preTests/collectionServicesPretest.feature@errorPaymentMode')
    * match response.Errors[0].message == invalidPaymentModeError

@tenantIdNotValid @negative @collectionService
    Scenario: Make payment with invalid Tenant Id
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@errorTenantId')
    * match response.Errors[0].message == invalidTenantIdError

@tenantIdNull @negative @collectionService
    Scenario: Make payment with null Tenant Id
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@nullTenantId')
    * match response.Errors[0].message == nullTenantIdError

@totalAmountNegative @negative @collectionService
    Scenario: Make payment with negative total amount paid
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with negative total amount paid value
    * call read('../preTests/collectionServicesPretest.feature@negativeTotalAmount')
    * def billId = fetchBillResponse.Bill[0].id
    * def negativeAmountError = "The amount paid for the paymentDetail with bill number: " + billId
        * print negativeAmountError
    * match response.Errors[0].message == negativeAmountError

@cardPayment @positive @collectionService
    Scenario: Make payment with Card payment mode
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
    # Make payment with Card type payment mode
    * call read('../preTests/collectionServicesPretest.feature@cardPaymentMethod')
    * match response.ResponseInfo.status == '200 OK'
    