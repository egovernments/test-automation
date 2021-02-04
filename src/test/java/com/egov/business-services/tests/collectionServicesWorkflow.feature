Feature: Business Services - Collection service tests

Background:
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def invalidPaymentId = 'payment_'+randomNumber(4)
    * def invalidReason = 'reason_'+randomNumber(4)
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../preTests/authenticationToken.feature')
    
@workflow_payment_01 @workflow_payment_CHEQUEBOUNCEreason_08 @positive @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with valid field values
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert collectionServicesResponseBody.Payments[0].id == paymentId
    * assert collectionServicesResponseBody.Payments[0].tenantId == tenantId
    * match collectionServicesResponseBody.Payments[0].transactionNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentMode == "#present"
    * assert collectionServicesResponseBody.Payments[0].instrumentStatus == commonConstants.expectedStatus.instrumentStatusCancelled
    * match collectionServicesResponseBody.Payments[0].paidBy == "#present"
    * match collectionServicesResponseBody.Payments[0].mobileNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].payerName == "#present"
    * match collectionServicesResponseBody.Payments[0].payerId == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentStatus == commonConstants.expectedStatus.instrumentStatusCancelled

@workflow_payment_samePaymentID_02 @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with same paymentId
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_NoPaymentID_03 @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with no paymentId
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].paymentId'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidPaymentID_04 @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with invalid paymentId
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * def paymentId = invalidPaymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_OTHERreason_05 @positive @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with OTHER as reason
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * def reason = collectionServicesConstants.parameters.otherReason
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert collectionServicesResponseBody.Payments[0].id == paymentId
    * assert collectionServicesResponseBody.Payments[0].tenantId == tenantId
    * match collectionServicesResponseBody.Payments[0].transactionNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentMode == "#present"
    * assert collectionServicesResponseBody.Payments[0].instrumentStatus == commonConstants.expectedStatus.instrumentStatusCancelled
    * match collectionServicesResponseBody.Payments[0].paidBy == "#present"
    * match collectionServicesResponseBody.Payments[0].mobileNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].payerName == "#present"
    * match collectionServicesResponseBody.Payments[0].payerId == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentStatus == commonConstants.expectedStatus.instrumentStatusCancelled

@workflow_payment_NoReason_06 @negative @collectionServiceWorkflow @collectionService_bug
Scenario: Test to Cancel a payment in workflow with no reason
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].reason'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField')

@workflow_payment_InValidReason_07 @negative @collectionServiceWorkflow @collectionService_bug
Scenario: Test to Cancel a payment in workflow with invalid reason
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * def reason = invalidReason
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField')

@workflow_payment_NotenantID_09 @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with no tenantId
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].tenantId'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidtenantID_10 @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with invalid tenantId
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * def tenantId = randomString(5)
    * call read('../pretests/collectionServicesPretest.feature@error_auth_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.NotAuthorized