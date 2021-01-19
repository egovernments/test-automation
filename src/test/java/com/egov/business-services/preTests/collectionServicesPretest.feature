Feature: Business services - collection service calls

  Background:
    * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../preTests/authenticationToken.feature')
    * def collectionServiceData = read('../constants/collectionServices.yaml')
    * def propertyId = collectionServiceData.parameters.propertyId
    * def financialYear = collectionServiceData.parameters.financialYear
    * def assessmentDate = getTodayUtcDate()
    * def source = collectionServiceData.parameters.source
    * def channel = collectionServiceData.parameters.channel
    * def businessService = collectionServiceData.parameters.businessService
    * def assessmentRequest = read('../requestPayload/collection-services/assessment.json')
    * def fetchBillRequest = read('../requestPayload/collection-services/fetchBill.json')
    * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
    * configure headers = read('classpath:websCommonHeaders.js')
    

  @assessment
    Scenario: Create assessment
    Given url createAssessment
    And request assessmentRequest
      * print assessmentRequest
    When method post
    Then status 201
    And match response.ResponseInfo.status == 'successful'
  
  @fetchBill
    Scenario: Fetch Bill
    Given url fetchBill
    And param consumerCode = propertyId
    And param tenantId = tenantId
    And param businessService = businessService 
    And request fetchBillRequest
    * print fetchBillRequest
    When method post
    Then status 201
    And def fetchBillResponse = response
    And def totalAmount = response.Bill[0].totalAmount
    And def billId = response.Bill[0].id
     * print billId 
     * print totalAmount

  @successPayment
   Scenario: Common test to create a Payment 
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 201

  @invalidBillId
   Scenario: Steps to process a bill with Invalid billId