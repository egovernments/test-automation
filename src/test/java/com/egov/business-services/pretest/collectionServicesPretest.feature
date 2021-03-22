Feature: Business services - collection service calls

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def tenantId = tenantId
  * def businessService = fetchBillResponse.Bill[0].businessService
  * def paymentMode = collectionServicesConstants.parameters.paymentMode
  * def paidBy = 'Payer ' + randomString(10)
  * def mobileNumber = '78' + randomMobileNumGen(8)
  * def payerName = fetchBillResponse.Bill[0].payerName
  * def totalDue = 0
  * def totalAmountPaid = fetchBillResponse.Bill[0].totalAmount
  * def transactionNumber = collectionServicesConstants.parameters.transactionNumber
  * def instrumentNumber = collectionServicesConstants.parameters.instrumentNumber
  * def paymentModeForCard = collectionServicesConstants.parameters.paymentMode2
  * def paymentModeForCheque = collectionServicesConstants.parameters.paymentModeForCheque
  * def transactionNumberForCheque = collectionServicesConstants.parameters.transactionNumberForCheque
  * def instrumentNumberForCheque = collectionServicesConstants.parameters.instrumentNumberForCheque
  * def instrumentDate = getPastEpochDate(1)
  * def ifscCode = collectionServicesConstants.parameters.ifscCode
  * def invalidBillId = generateUUID()
  * def invalidBillId = generateUUID()
  * def createPaymentRequest = read('../../business-services/requestPayload/collection-services/create.json')
  * def workflowRequest = read('../../business-services/requestPayload/collection-services/workflow.json')
  * def searchPaymentRequest = read('../../business-services/requestPayload/collection-services/search.json')
  * def createPaymentRequestForCheque = read('../../business-services/requestPayload/collection-services/createPaymentWithCheque.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def invalidBillId = 'invalid_'+randomNumber(4)
  * def invalidBusinessId = 'PT'+randomNumber(4)
  * def invalidPaymentMode = randomString(4)
  * def invalidTenantId = randomString(5)
  * def negativeTotalAmount = '-'+randomNumber(4)
   

@createPayment
Scenario: Common test to create a Payment 
  Given url payment
  And request createPaymentRequest
  * print createPaymentRequest
  When method post
  Then assert responseStatus == 200
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response
  And def Payments = collectionServicesResponseBody.Payments

@errorInCreatePayment
Scenario: Common negative pre test of creating a Payment 
   * def amount = fetchBillResponse.Bill[0].totalAmount
   * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
   * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
   * set createPaymentRequest.Payment.totalDue = amount
   * set createPaymentRequest.Payment.totalAmountPaid = amount
  Given url payment
  And request createPaymentRequest
  When method post
  Then assert responseStatus == 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response
  And def Payments = collectionServicesResponseBody.Payments

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
    When method post
    Then status 400
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

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
    When method post
    Then status 200
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

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
    When method post
    Then status 400
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

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
    When method post
    Then status 400
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

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
    When method post
    Then status 403
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

  @nullTenantIdPayment
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
    When method post
    Then status 400
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

  @negativeTotalAmount
   Scenario: Steps to create a payment with negative total amount paid value
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = negativeTotalAmount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount

    Given url payment
    And request createPaymentRequest
    When method post
    Then status 400
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response
  
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
    When method post
    Then status 200
    And def collectionServicesResponseHeader = responseHeaders
    And def collectionServicesResponseBody = response

  @processworkflow
  Scenario: Collection Service success workflow call
  Given url collectionServiceWorkflowUrl 
  And request workflowRequest
  When method post
  Then status 200
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

# Search Payment

  @searchPaymentWithBillId 
    Scenario: test to search a payment with BillId

    * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     billIds: '#(billId)'
    }
    """
    Given url searchPayment
    And params parameters
    And request searchPaymentRequest
    When method post
    Then status 200
    And def searchResponseHeader = responseHeaders
    And def searchResponseBody = response
    And def receiptNumber = response.Payments[0].paymentDetails[0].receiptNumber

  @searchPaymentWithConsumerCode
  Scenario: test to search a payment with ConsumerCode

    * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     consumerCodes: '#(consumerCode)'
    }
    """
    Given url searchPayment
    And params parameters
    And request searchPaymentRequest
    When method post
    Then status 200
    And def searchResponseHeader = responseHeaders
    And def searchResponseBody = response


  @searchPaymentWithParams
  Scenario: Test to search a payment with given parameters
    Given url searchPayment
    And params parameters
    And request searchPaymentRequest
    When method post
    Then status 200
    And def searchResponseHeader = responseHeaders
    And def searchResponseBody = response

@errorInauthworkflow
Scenario: Collection Service error authorisation workflow call
  Given url collectionServiceWorkflowUrl 
  And request workflowRequest
  When method post
  Then status 403
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorinworkflow
Scenario: Collection Service error workflow call
  Given url collectionServiceWorkflowUrl 
  And request workflowRequest
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@removeFieldFromWorkFlow
Scenario: Collection Service error workflow call
  * eval karate.remove('workflowRequest', removeFieldPath)
  Given url collectionServiceWorkflowUrl 
  And request workflowRequest
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

# Payment with cheque
@chequePaymentMethod
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCheque
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 200
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorForInstrumentDateWihChequePayment
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCheque
  * set createPaymentRequestForCheque.Payment.instrumentDate = 'null'
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorForPastDaysInstrumentDateWihChequePayment
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCheque
  * set createPaymentRequestForCheque.Payment.instrumentDate = getPastEpochDate(100)
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorForFutureInstrumentDateWihChequePayment
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCheque
  * set createPaymentRequestForCheque.Payment.instrumentDate = getEpochDate(91)
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorForMorethanDueAmountWihChequePayment
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount + 10
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount + 10
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCheque
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorForInstrumentNumberWihChequePayment
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCheque
  * set createPaymentRequestForCheque.Payment.instrumentNumber = ""
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

@errorForTransactionNumberWihChequePayment
Scenario: Steps to create a payment with Cheque payment method
  * def amount = fetchBillResponse.Bill[0].totalAmount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalDue = amount
  * set createPaymentRequestForCheque.Payment.paymentDetails[0].totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.totalDue = amount
  * set createPaymentRequestForCheque.Payment.totalAmountPaid = amount
  * set createPaymentRequestForCheque.Payment.paymentMode = paymentModeForCard
  * set createPaymentRequestForCheque.Payment.transactionNumber = ""
  Given url payment
  And request createPaymentRequestForCheque
  When method post
  Then status 400
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response