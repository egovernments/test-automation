Feature: Business Services - Collection service tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../constants/collection-services.yaml')
    * def commonConstants = read('../constants/commonConstants.yaml')
    * def collectionServicePropertyData = read('../constants/propertyTaxAssessment.yaml')
    * def tenantId = tenantId
    * def businessService = collectionServicesConstants.parameters.businessService
    * def paymentMode = collectionServicesConstants.parameters.paymentMode
    * def paidBy = collectionServicesConstants.parameters.paidBy
    * def mobileNumber = collectionServicesConstants.parameters.mobileNumber
    * def payerName = collectionServicesConstants.parameters.payerName
    * def transactionNumber = collectionServicesConstants.parameters.transactionNumber
    * def instrumentNumber = collectionServicesConstants.parameters.instrumentNumber
    * def invalidBillId = collectionServicesConstants.parameters.billId
    * def createPaymentRequest = read('../requestPayload/collection-services/create.json')
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def paidBillIdError = collectionServicesConstants.errorMessages.paidBillId
    * def invalidBillIdError = collectionServicesConstants.errorMessages.invalidBillId
    * def totalAmountPaidError = collectionServicesConstants.errorMessages.totalAmountPaidNull
    * def invalidPaymentModeError = collectionServicesConstants.errorMessages.invalidPaymentMode
    * def invalidTenantIdError = commonConstants.errorMessages.invalidTenantIdError
    * def nullTenantIdError = commonConstants.errorMessages.nullParameterError
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../preTests/authenticationToken.feature')
    
@workflow_payment_01 @workflow_payment_CHEQUEBOUNCEreason_08 @positive @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with valid field values
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
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

@workflow_payment_samePaymentID_02 @negative @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with same paymentId
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')
    * print collectionServicesResponseBody
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_NoPaymentID_03 @negative @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with no paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].paymentId'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidPaymentID_04 @negative @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with invalid paymentId
    * def paymentId = collectionServicesConstants.invalidParameters.paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId

@workflow_payment_OTHERreason_05 @positive @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with OTHER as reason
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
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

@workflow_payment_NoReason_06 @negative @collectionService_workflow @collectionService_bug
Scenario: Test to Cancel a payment in workflow with no reason
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].reason'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField')

@workflow_payment_InValidReason_07 @negative @collectionService_workflow @collectionService_bug
Scenario: Test to Cancel a payment in workflow with invalid reason
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * def reason = collectionServicesConstants.invalidParameters.reason
    * call read('../pretests/collectionServicesPretest.feature@error_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.invalidReceipt + paymentId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField')

@workflow_payment_NotenantID_09 @negative @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with no tenantId
    * call read('../pretests/collectionServicesPretest.feature@error_workflow_removeField') {'removeFieldPath': '$.paymentWorkflows[0].tenantId'}
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.mustNotBeNull

@workflow_payment_InValidtenantID_10 @negative @collectionService_workflow @collectionServices
Scenario: Test to Cancel a payment in workflow with invalid tenantId
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * call read('../pretests/collectionServicesPretest.feature@error_auth_workflow')
    * print collectionServicesResponseBody
    * assert collectionServicesResponseBody.Errors[0].message == collectionServicesConstants.errorMessages.NotAuthorized

# Create Payment    
@Create_PaymentWithValidBillID_01 @positive @CreatePayment @collectionServices
    Scenario: Make payment with valid Bill id 
     * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
     * call read('../preTests/billingServicePretest.feature@fetchBill')
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match response.ResponseInfo.status == '200 OK'
     * def paymentId = collectionServicesResponseBody.Payments[0].id
     # Calling steps to Cancel the Payment along with Payment Id
     * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithPaidBillID_02 @negative @CreatePayment @collectionServices
    Scenario: Make payment with paid Bill id 
     * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
     * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with valid Bill id first
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Set the `billId` value with paid bill id
     * set createPaymentRequest.Payment.paymentDetails[0].billId = billId
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Calling steps to Cancel the Payment along with Payment Id
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match collectionServicesResponseBody.Errors[0].message == paidBillIdError
     * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithInvalidBillID_03 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Bill id
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBillId')
    * match response.Errors[0].message == invalidBillIdError
    * print collectionServicesResponseBody
    
@Create_PaymentWithInvalidBusinessService_04 @positive @CreatePayment @collectionServices
    Scenario: Make payment with invalid Business ID
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBusinessService')
    * match response.ResponseInfo.status == '200 OK'
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Calling steps to Cancel the Payment along with Payment Id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithAmountpaid_Null_05 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Business ID
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@totalAmountPaidNull')
    * match response.Errors[0].message == totalAmountPaidError

@Create_PaymentWith_PaymentModeCard_06 @positive @CreatePayment @collectionServices
    Scenario: Make payment with Card payment mode
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with Card type payment mode
    * call read('../preTests/collectionServicesPretest.feature@cardPaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

@Create_PaymentWith_InvalidPaymentMode_07 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Payment mode
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Payment Mode
    * call read('../preTests/collectionServicesPretest.feature@errorPaymentMode')
    * match response.Errors[0].message == invalidPaymentModeError

@Create_PaymentWith_InvalidtenantID_08 @negative @CreatePayment @collectionServices
    Scenario: Make payment with invalid Tenant Id
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@errorTenantId')
    * match response.Errors[0].message == invalidTenantIdError

@Create_PaymentWith_NotenantID_09 @negative @CreatePayment @collectionServices
    Scenario: Make payment with null Tenant Id
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@nullTenantIdPayment')
    * match response.Errors[0].message == nullTenantIdError

@Create_PaymentWith_negativeAmount_10 @negative @CreatePayment @collectionServices
    Scenario: Make payment with negative total amount paid
    * call read('../../municipal-services/preTests/propertyServicesPretest.feature@successAssessProperty')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with negative total amount paid value
    * call read('../preTests/collectionServicesPretest.feature@negativeTotalAmount')
    * def billId = fetchBillResponse.Bill[0].id
    * def negativeAmountError = "The amount paid for the paymentDetail with bill number: " + billId
    * match response.Errors[0].message == negativeAmountError


# Search Payment

@Search_PaymentWithReceiptNumber_01 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with receipt number
    
    * def mobileNumber = collectionServicesConstants.parameters.nullValue
    * def receiptNumber = collectionServicesConstants.parameters.receiptNumber
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber


@Search_PaymentWithBillID_02 @positive @SearchPayment @collectionServices
Scenario: Test to search payment with billID

    #* call read('../preTests/collectionServicesPretest.feature@fetchBill')
    * def billId = collectionServicesConstants.parameters.validBillId
    * call read('../preTests/collectionServicesPretest.feature@successSearchBillId')
    * match searchResponseBody.Payments[0].paymentDetails[0].billId == billId


@Search_PaymentWithConsumerCode_03 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with consumer code

    * def consumerCode = propertyId
    * call read('../preTests/collectionServicesPretest.feature@successSearchConsumerCode')
        * print searchResponseBody
    * match searchResponseBody.Payments[0].paymentDetails[0].bill.consumerCode == consumerCode


@Search_PaymentWithMobileNumber_04 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with mobile number

    * def receiptNumber = collectionServicesConstants.parameters.nullValue
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0


@Search_PaymentWithMobileNumberAndReceiptNumber_05 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with mobile number and receipt number

    * def receiptNumber = collectionServicesConstants.parameters.receiptNumber
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber


@Search_AllPayments_06 @positive @SearchPayment @collectionServices
    Scenario: Test to search all payments

    * def receiptNumber = collectionServicesConstants.parameters.nullValue
    * def mobileNumber = collectionServicesConstants.parameters.nullValue
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0] == '#present'


@Search_PaymentWith_InvalidtenatID_07 @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid tenantID

    * call read('../preTests/collectionServicesPretest.feature@successSearchInvalid')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'


@Search_PaymentWith_InvalidMobileNumber_08 @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid mobileNumber

    * call read('../preTests/collectionServicesPretest.feature@successSearchInvalidMobile')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'


@Search_PaymentWith_InvalidReceiptNumber_09 @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid ReceiptNumber

    * def mobileNumber = collectionServicesConstants.parameters.nullValue
    * def receiptNumber = collectionServicesConstants.parameters.invalidValue
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'