Feature: Business services - collection service calls

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def collectionServicesConstants = read('../constants/collection-services.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def tenantId = tenantId
  * def businessService = fetchBillResponse.Bill[0].businessService
  * def paymentMode = collectionServicesConstants.parameters.paymentMode
  * def paidBy = fetchBillResponse.Bill[0].payerName
  * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
  * def payerName = fetchBillResponse.Bill[0].payerName
  * def totalDue = 0
  * def totalAmountPaid = fetchBillResponse.Bill[0].totalAmount
  * def transactionNumber = collectionServicesConstants.parameters.transactionNumber
  * def instrumentNumber = collectionServicesConstants.parameters.instrumentNumber
  * def invalidBillId = generateUUID()
  * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
  * def workflowRequest = read('../requestPayload/collection-services/workflow.json')
  * def searchPaymentRequest = read('../requestPayload/collection-services/search.json')
  * configure headers = read('classpath:websCommonHeaders.js')
   * def invalidBillId = 'invalid_'+randomNumber(4)
   * def invalidBusinessId = 'PT'+randomNumber(4)
   * def invalidPaymentMode = randomString(4)
   * def invalidTenantId = randomString(5)
   * def negativeTotalAmount = '-'+randomNumber(4)
   

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
  Then assert responseStatus == 200 ||  responseStatus == 400
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

  @success_workflow
  Scenario: Collection Service success workflow call
  Given url collectionServiceWorkflowUrl 
  And request workflowRequest
  When method post
  Then status 200
  And def collectionServicesResponseHeader = responseHeaders
  And def collectionServicesResponseBody = response

# Search Payment

  @successSearchBillId 
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
    * print receiptNumber


  @successSearchConsumerCode
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
      * print searchPaymentRequest
    When method post
    Then status 200
    And def searchResponseHeader = responseHeaders
    And def searchResponseBody = response


  @successSearchMobileNumber
  Scenario: test to search a payment with MobileNumber & ReceiptNumber
    Given url searchPayment
    And params parameters
    * print parameters
    And request searchPaymentRequest
    When method post
    Then status 200
    And def searchResponseHeader = responseHeaders
    And def searchResponseBody = response


  # @successSearchInvalid
  # Scenario: test to search a payment with Invalid tenantId

  #   Given url searchPayment
  #   And param tenantId = invalidTenantId
  #   And request searchPaymentRequest
  #   When method post
  #   Then status 200
  #   And def searchResponseHeader = responseHeaders
  #   And def searchResponseBody = response


#  @successSearchInvalidMobile
#   Scenario: test to search a payment with Invalid mobileNumber

#     Given url searchPayment
#     And param tenantId = tenantId
#     And param mobileNumber = invalidMobile
#     And request searchPaymentRequest
#     When method post
#     Then status 200
#     And def searchResponseHeader = responseHeaders
#     And def searchResponseBody = response

@error_auth_workflow
Scenario: Collection Service error authorisation workflow call
  * print workflowRequest
  Given url collectionServiceWorkflowUrl 
  And request workflowRequest
  When method post
  Then status 403
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