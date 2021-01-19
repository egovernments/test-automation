Feature: Business services - collection service calls

  Background:
    * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../preTests/authenticationToken.feature')
    * def collectionServiceData = read('../constants/collectionServices.yaml')
    * def collectionServiceCommonData = read('../constants/commonConstants.yaml')
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
    * def invalidBillId = collectionServiceData.parameters.billId
    * def invalidBusinessId = collectionServiceData.parameters.invalidBusinessService
    * def invalidPaymentMode = collectionServiceData.parameters.invalidPaymentMode
    * def invalidTenantId = collectionServiceCommonData.invalidParameters.invalidTenantId
    * def negativeTotalAmount = collectionServiceData.parameters.negativeTotalAmount
    
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def collectionServicesConstants = read('../constants/collection-services.yaml')
  * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
  * def workflowRequest = read('../requestPayload/collection-services/workflow.json')
  * configure headers = read('classpath:websCommonHeaders.js')

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
  Then status 200
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response
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
    Then status 200

@invalidBillId
Scenario: Steps to process a bill with Invalid billId

@success_workflow
Scenario: Collection Service success workflow call
  * print workflowRequest
  Given url collectionServiceWorkflowUrl
  And request workflowRequest
  When method post
  Then status 200
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@error_workflow
Scenario: Collection Service error workflow call
  * print workflowRequest
  Given url collectionServiceWorkflowUrl
  And request workflowRequest
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@error_workflow_removeField
Scenario: Collection Service error workflow call
  * eval karate.remove('workflowRequest', removeFieldPath)
  * print workflowRequest
  Given url collectionServiceWorkflowUrl
  And request workflowRequest
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@error_auth_workflow
Scenario: Collection Service error authorisation workflow call
  * print workflowRequest
  Given url collectionServiceWorkflowUrl
  And request workflowRequest
  When method post
  Then status 403
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response
  @errorBillId
   Scenario: Steps to create a payment with Invalid billId
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Set the `billId` value with invalid bill id
     * set createPaymentRequest.Payment.paymentDetails[0].billId = invalidBillId
     Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 400

  @errorBusinessService
   Scenario: Steps to create a payment with invalid Business Service
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Set the `businessService` value with invalid businessService id
     * set createPaymentRequest.Payment.paymentDetails[0].businessService = invalidBusinessId
     Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 200

  @totalAmountPaidNull
   Scenario: Steps to create a payment where total paid amount is null
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     # Set the `totalAmountPaid` value with as `null`
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = null
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount

    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 400

  @errorPaymentMode
   Scenario: Steps to create a payment with an Invalid payment mode
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Set the `paymentMode` value with as `invalid`
     * set createPaymentRequest.Payment.paymentMode = invalidPaymentMode

    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 400

  @errorTenantId
   Scenario: Steps to create a payment with an Invalid Tenant Id
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Set the `tenantId` value with as `invalid`
     * set createPaymentRequest.Payment.tenantId = invalidTenantId

    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 403

  @nullTenantId
   Scenario: Steps to create a payment where tenant id is null
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Set the `tenantId` value with as `null`
     * set createPaymentRequest.Payment.tenantId = null

    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 400

  @negativeTotalAmount
   Scenario: Steps to create a payment with negative total amount paid value
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = negativeTotalAmount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount

    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 400
     * print response

  @cardPaymentMethod
   Scenario: Steps to create a payment with Card type payment method
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     * set createPaymentRequest.Payment.paymentMode = "Card"

    Given url payment
    And request createPaymentRequest
     * print createPaymentRequest
    When method post
    Then status 200
     * print response