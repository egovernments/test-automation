Feature: Business Services - Collection service tests

 Background:
     * def jsUtils = read('classpath:jsUtils.js')
     * configure headers = read('classpath:websCommonHeaders.js')
     * def collectionServiceData = read('../constants/collection-services.yaml')
     * def collectionServicePropertyData = read('../constants/propertyTaxAssessment.yaml')
     * def commonConstants = read('../constants/commonConstants.yaml')
     * def tenantId = tenantId
     * def businessService = collectionServiceData.parameters.businessService
     * def propertyId = collectionServicePropertyData.parameters.propertyId
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
     * def invalidTenantIdError = commonConstants.errorMessages.invalidTenantIdError
     * def nullTenantIdError = commonConstants.errorMessages.nullParameterError
     * def reason = collectionServiceData.parameters.reason
     * def action = collectionServiceData.parameters.action
      # Calling access token
     * def authUsername = employeeUserName
     * def authPassword = employeePassword
     * def authUserType = employeeType
     * call read('../preTests/authenticationToken.feature')

# Create Payment    
@Create_PaymentWithValidBillID_01 @positive @CreatePayment @collectionService
    Scenario: Make payment with valid Bill id 
     * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
     * call read('../preTests/billingServicePretest.feature@fetchBill')
     * call read('../preTests/collectionServicesPretest.feature@successPayment')
     * match response.ResponseInfo.status == '200 OK'
     * def paymentId = collectionServicesResponseBody.Payments[0].id
     # Calling steps to Cancel the Payment along with Payment Id
     * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithPaidBillID_02 @negative @CreatePayment @collectionService
    Scenario: Make payment with paid Bill id 
     * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
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

@Create_PaymentWithInvalidBillID_03 @negative @CreatePayment @collectionService
    Scenario: Make payment with invalid Bill id
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBillId')
    * match response.Errors[0].message == invalidBillIdError
    * print collectionServicesResponseBody
    
@Create_PaymentWithInvalidBusinessService_04 @positive @CreatePayment @collectionService
    Scenario: Make payment with invalid Business ID
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@errorBusinessService')
    * match response.ResponseInfo.status == '200 OK'
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Calling steps to Cancel the Payment along with Payment Id
    * call read('../pretests/collectionServicesPretest.feature@success_workflow')

@Create_PaymentWithAmountpaid_Null_05 @negative @CreatePayment @collectionService
    Scenario: Make payment with invalid Business ID
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../preTests/collectionServicesPretest.feature@totalAmountPaidNull')
    * match response.Errors[0].message == totalAmountPaidError

@Create_PaymentWith_PaymentModeCard_06 @positive @CreatePayment @collectionService
    Scenario: Make payment with Card payment mode
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with Card type payment mode
    * call read('../preTests/collectionServicesPretest.feature@cardPaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

@Create_PaymentWith_InvalidPaymentMode_07 @negative @CreatePayment @collectionService
    Scenario: Make payment with invalid Payment mode
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Payment Mode
    * call read('../preTests/collectionServicesPretest.feature@errorPaymentMode')
    * match response.Errors[0].message == invalidPaymentModeError

@Create_PaymentWith_InvalidtenantID_08 @negative @CreatePayment @collectionService
    Scenario: Make payment with invalid Tenant Id
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@errorTenantId')
    * match response.Errors[0].message == invalidTenantIdError

@Create_PaymentWith_NotenantID_09 @negative @CreatePayment @collectionService
    Scenario: Make payment with null Tenant Id
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../preTests/collectionServicesPretest.feature@nullTenantIdPayment')
    * match response.Errors[0].message == nullTenantIdError

@Create_PaymentWith_negativeAmount_10 @negative @CreatePayment @collectionService
    Scenario: Make payment with negative total amount paid
    * call read('../preTests/propertyTaxAssessmentPretest.feature@assessment')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    # Make payment with negative total amount paid value
    * call read('../preTests/collectionServicesPretest.feature@negativeTotalAmount')
    * def billId = fetchBillResponse.Bill[0].id
    * def negativeAmountError = "The amount paid for the paymentDetail with bill number: " + billId
    * match response.Errors[0].message == negativeAmountError

# Search Payment

@Search_PaymentWithReceiptNumber_01 @positive @SearchPayment @collectionService
    Scenario: Test to search payment with receipt number
    
    * def mobileNumber = collectionServiceData.parameters.nullValue
    * def receiptNumber = collectionServiceData.parameters.receiptNumber
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber

@Search_PaymentWithBillID_02 @positive @SearchPayment @collectionService
Scenario: Test to search payment with billID

    #* call read('../preTests/collectionServicesPretest.feature@fetchBill')
    * def billId = collectionServiceData.parameters.validBillId
    * call read('../preTests/collectionServicesPretest.feature@successSearchBillId')
    * match searchResponseBody.Payments[0].paymentDetails[0].billId == billId

@Search_PaymentWithConsumerCode_03 @positive @SearchPayment @collectionService
    Scenario: Test to search payment with consumer code

    * def consumerCode = propertyId
    * call read('../preTests/collectionServicesPretest.feature@successSearchConsumerCode')
    * match searchResponseBody.Payments[0].paymentDetails[0].bill.consumerCode == consumerCode

@Search_PaymentWithMobileNumber_04 @positive @SearchPayment @collectionService
    Scenario: Test to search payment with mobile number

    * def receiptNumber = collectionServiceData.parameters.nullValue
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0

@Search_PaymentWithMobileNumberAndReceiptNumber_05 @positive @SearchPayment @collectionService
    Scenario: Test to search payment with mobile number and receipt number

    * def receiptNumber = collectionServiceData.parameters.receiptNumber
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber

@Search_AllPayments_06 @positive @SearchPayment @collectionService
    Scenario: Test to search all payments

    * def receiptNumber = collectionServiceData.parameters.nullValue
    * def mobileNumber = collectionServiceData.parameters.nullValue
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0] == '#present'

@Search_PaymentWith_InvalidtenatID_07 @negative @SearchPayment @collectionService
    Scenario: Test to search payment with invalid tenantID

    * call read('../preTests/collectionServicesPretest.feature@successSearchInvalid')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'

@Search_PaymentWith_InvalidMobileNumber_08 @negative @SearchPayment @collectionService
    Scenario: Test to search payment with invalid mobileNumber

    * call read('../preTests/collectionServicesPretest.feature@successSearchInvalidMobile')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'

@Search_PaymentWith_InvalidReceiptNumber_09 @negative @SearchPayment @collectionService
    Scenario: Test to search payment with invalid ReceiptNumber

    * def mobileNumber = collectionServiceData.parameters.nullValue
    * def receiptNumber = collectionServiceData.parameters.invalidValue
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'