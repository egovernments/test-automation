Feature: Business Services - Collection service tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../constants/collection-services.yaml')
    * def commonConstants = read('../constants/commonConstants.yaml')
    * def tenantId = tenantId
    * def businessService = collectionServicesConstants.parameters.businessService
    * def propertyId = collectionServicesConstants.parameters.propertyId
    * def paymentMode = collectionServicesConstants.parameters.paymentMode
    * def paidBy = collectionServicesConstants.parameters.paidBy
    * def mobileNumber = collectionServicesConstants.parameters.mobileNumber
    * def payerName = collectionServicesConstants.parameters.payerName
    * def invalidBillId = collectionServicesConstants.parameters.billId
    * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def paidBillIdError = collectionServicesConstants.errorMessages.paidBillId
    * def invalidBillIdError = collectionServicesConstants.errorMessages.invalidBillId
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../preTests/authenticationToken.feature')
 Background:
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

@validBillId @positive
Scenario: Make payment with valid Bill id
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * match response.ResponseInfo.status == 'successful'
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@paidBillId @negative @collectionService
    Scenario: Make payment with paid Bill id 
    # Make payment with valid Bill id first
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../tests/collection-services.feature@validBillId')
    # Set the `billId` value with paid bill id
    * set createPaymentRequest.Payment.paymentDetails[0].billId = billId
    Given url payment
    And request createPaymentRequest
    * print createPaymentRequest
    When method post
    Then status 400
    And match response.Errors[0].message == paidBillIdError
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')

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


@workflow_payment_01 @workflow_payment_CHEQUEBOUNCEreason_08 @positive @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with valid field values
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.ResponseInfo.status == commonConstants.status.ok
    * assert collectionServicesResponseBody.Payments[0].id == paymentId
    * assert collectionServicesResponseBody.Payments[0].tenantId == tenantId
    * match collectionServicesResponseBody.Payments[0].transactionNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentMode == "#present"
    * assert collectionServicesResponseBody.Payments[0].instrumentStatus == commonConstants.status.instrumentStatusCancelled
    * match collectionServicesResponseBody.Payments[0].paidBy == "#present"
    * match collectionServicesResponseBody.Payments[0].mobileNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].payerName == "#present"
    * match collectionServicesResponseBody.Payments[0].payerId == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentStatus == commonConstants.status.instrumentStatusCancelled

@workflow_payment_samePaymentID_02 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with same paymentId
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_NoPaymentID_03 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with no paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].paymentId'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidPaymentID_04 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with invalid paymentId
    * def paymentId = collectionServicesConstants.invalidParameters.paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_OTHERreason_05 @positive @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with OTHER as reason
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * def reason = collectionServicesConstants.parameters.otherReason
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.ResponseInfo.status == commonConstants.status.ok
    * assert collectionServicesResponseBody.Payments[0].id == paymentId
    * assert collectionServicesResponseBody.Payments[0].tenantId == tenantId
    * match collectionServicesResponseBody.Payments[0].transactionNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentMode == "#present"
    * assert collectionServicesResponseBody.Payments[0].instrumentStatus == commonConstants.status.instrumentStatusCancelled
    * match collectionServicesResponseBody.Payments[0].paidBy == "#present"
    * match collectionServicesResponseBody.Payments[0].mobileNumber == "#present"
    * match collectionServicesResponseBody.Payments[0].payerName == "#present"
    * match collectionServicesResponseBody.Payments[0].payerId == "#present"
    * match collectionServicesResponseBody.Payments[0].paymentStatus == commonConstants.status.instrumentStatusCancelled

@workflow_payment_NoReason_06 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with no reason
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].reason'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_InValidReason_07 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with invalid paymentId
    * def reason = collectionServicesConstants.invalidParameters.reason
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_NotenantID_09 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with no tenantId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].tenantId'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidtenantID_10 @negative @collection_services_workflow @collection_services
Scenario: Test to Cancel a payment in workflow with invalid tenantId
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * call read('../pretests/collectionServicesPretest.feature@error_auth_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.NotAuthorized