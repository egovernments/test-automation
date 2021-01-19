Feature: Business Services - Collection service tests

 Background:
     * def jsUtils = read('classpath:jsUtils.js')
     * configure headers = read('classpath:websCommonHeaders.js')
     * call read('../preTests/collectionServicesPretest.feature@assessment')
     * call read('../preTests/collectionServicesPretest.feature@fetchBill')
     * def collectionServiceData = read('../constants/collectionServices.yaml')
     * def tenantId = tenantId
     * def businessService = collectionServiceData.parameters.businessService
     * def propertyId = collectionServiceData.parameters.propertyId
     * def paymentMode = collectionServiceData.parameters.paymentMode
     * def paidBy = collectionServiceData.parameters.paidBy
     * def mobileNumber = collectionServiceData.parameters.mobileNumber
     * def payerName = collectionServiceData.parameters.payerName
     * def invalidBillId = collectionServiceData.parameters.billId
     * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
     * def paidBillIdError = collectionServiceData.errorMessages.paidBillId
     * def invalidBillIdError = collectionServiceData.errorMessages.invalidBillId
    
@validBillId @positive
    Scenario: Make payment with valid Bill id 
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match response.ResponseInfo.status == 'successful'

@paidBillId @negative
    Scenario: Make payment with paid Bill id 
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

@invalidBillId @negative
    Scenario: Make payment with invalid Bill id 
    # Set the `billId` value with invalid bill id
    * set createPaymentRequest.Payment.paymentDetails[0].billId = invalidBillId
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * match response.Errors[0].message == invalidBillIdError
    