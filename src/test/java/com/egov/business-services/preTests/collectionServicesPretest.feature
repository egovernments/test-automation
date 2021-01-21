Feature: Business services - collection service calls

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