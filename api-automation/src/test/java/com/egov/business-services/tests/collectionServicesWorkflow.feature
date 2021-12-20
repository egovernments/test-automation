Feature: Business Services - Collection service tests

Background:
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def invalidPaymentId = 'payment_'+randomNumber(4)
    * def invalidReason = 'reason_'+randomNumber(4)
    
    # * def authUsername = employeeUserName
    # * def authPassword = employeePassword
    # * def authUserType = employeeType
    
    
@workflow_payment_01 @workflow_payment_CHEQUEBOUNCEreason_08 @businessServices @regression @positive @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with valid field values
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a Payment
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    # Defining paymentId with payment id fetched from collectionServicesResponseBody
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Steps to process workflow
    * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')
    # Validate the response status as 200 OK
    * assert collectionServicesResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    # Validate the payments id
    * assert collectionServicesResponseBody.Payments[0].id == paymentId
    # Validate the tenantId
    * assert collectionServicesResponseBody.Payments[0].tenantId == tenantId
    # Validate the transactionNumber is present in the response body
    * match collectionServicesResponseBody.Payments[0].transactionNumber == "#present"
    # Validate the payment mode is present in the response body
    * match collectionServicesResponseBody.Payments[0].paymentMode == "#present"
    # Validate the instruments status
    * assert collectionServicesResponseBody.Payments[0].instrumentStatus == commonConstants.expectedStatus.instrumentStatusCancelled
    # Validate the paidBy is present in the response body
    * match collectionServicesResponseBody.Payments[0].paidBy == "#present"
    # Validate the mobileNumber is present in the response body
    * match collectionServicesResponseBody.Payments[0].mobileNumber == "#present"
    # Validate the payerName is present in the response body
    * match collectionServicesResponseBody.Payments[0].payerName == "#present"
    # Validate the payerId is present in the response body
    * match collectionServicesResponseBody.Payments[0].payerId == "#present"
    # Validate the paymentStatus is present in the response body
    * match collectionServicesResponseBody.Payments[0].paymentStatus == commonConstants.expectedStatus.instrumentStatusCancelled

@workflow_payment_samePaymentID_02 @businessServices @regression @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with same paymentId
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a Payment
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Steps to process workflow
    * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')
    # Steps to process workflow with same paymentId
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorinworkflow')
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_NoPaymentID_03 @businessServices @regression @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with no paymentId
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to process workflow where paymentId field is removed from the request
    * call read('../../business-services/pretest/collectionServicesPretest.feature@removeFieldFromWorkFlow') {'removeFieldPath': '$.paymentWorkflows[0].paymentId'}
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidPaymentID_04 @businessServices @regression @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with invalid paymentId
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * def paymentId = invalidPaymentId
    # Steps to process workflow with invalid payment Id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorinworkflow')
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_OTHERreason_05 @businessServices @regression @positive @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with OTHER as reason
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a Payment
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * def reason = collectionServicesConstants.parameters.otherReason
    # Steps to process workflow
    * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')
    # Validate the response status as 200 OK
    * assert collectionServicesResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    # Validate the payments id
    * assert collectionServicesResponseBody.Payments[0].id == paymentId
    # Validate the tenantId
    * assert collectionServicesResponseBody.Payments[0].tenantId == tenantId
    # Validate the transactionNumber
    * match collectionServicesResponseBody.Payments[0].transactionNumber == "#present"
    # Validate the paymentMode
    * match collectionServicesResponseBody.Payments[0].paymentMode == "#present"
    # Validate the instrumentStatus
    * assert collectionServicesResponseBody.Payments[0].instrumentStatus == commonConstants.expectedStatus.instrumentStatusCancelled
    # Validate the paidBy
    * match collectionServicesResponseBody.Payments[0].paidBy == "#present"
    # Validate the mobileNumber
    * match collectionServicesResponseBody.Payments[0].mobileNumber == "#present"
    # Validate the payerName
    * match collectionServicesResponseBody.Payments[0].payerName == "#present"
    # Validate the payerId
    * match collectionServicesResponseBody.Payments[0].payerId == "#present"
    # Validate the paymentStatus
    * match collectionServicesResponseBody.Payments[0].paymentStatus == commonConstants.expectedStatus.instrumentStatusCancelled

@workflow_payment_NoReason_06 @businessServices @regression @negative @collectionServiceWorkflow @collectionService_bug
Scenario: Test to Cancel a payment in workflow with no reason
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a Payment
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Steps to process workflow where reason field is removed from the request
    * call read('../../business-services/pretest/collectionServicesPretest.feature@removeFieldFromWorkFlow') {'removeFieldPath': '$.paymentWorkflows[0].reason'}
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId
    * call read('../../business-services/pretest/collectionServicesPretest.feature@removeFieldFromWorkFlow')

@workflow_payment_InValidReason_07 @businessServices @regression @negative @collectionServiceWorkflow @collectionService_bug
Scenario: Test to Cancel a payment in workflow with invalid reason
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a Payment
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * def reason = invalidReason
    # Steps to process workflow with Invalid reason
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorinworkflow')
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId
    * call read('../../business-services/pretest/collectionServicesPretest.feature@removeFieldFromWorkFlow')

@workflow_payment_NotenantID_09 @businessServices @regression @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with no tenantId
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to process workflow where tenantId field is removed from the request
    * call read('../../business-services/pretest/collectionServicesPretest.feature@removeFieldFromWorkFlow') {'removeFieldPath': '$.paymentWorkflows[0].tenantId'}
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidtenantID_10 @businessServices @regression @negative @collectionServiceWorkflow @collectionServices
Scenario: Test to Cancel a payment in workflow with invalid tenantId
    # Steps to process fetchBill
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * def tenantId = randomString(5)
    # Steps to process workflow with invalid tenantId
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorInauthworkflow')
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.NotAuthorized