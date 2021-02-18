Feature: collection-services-Create tests

        Background:
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    * def paidBillIdError = collectionServicesConstants.errorMessages.paidBillId
    * def invalidBillIdError = collectionServicesConstants.errorMessages.invalidBillId
    * def totalAmountPaidError = collectionServicesConstants.errorMessages.totalAmountPaidNull
    * def invalidPaymentModeError = collectionServicesConstants.errorMessages.invalidPaymentMode
    * def invalidTenantIdError = commonConstants.errorMessages.invalidTenantIdError
    * def nullTenantIdError = commonConstants.errorMessages.nullParameterError
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def instrumentDateError = collectionServicesConstants.errorMessages.instrumentDateAsNull
    * def instrumentPastDateError = collectionServicesConstants.errorMessages.instrumentDatePastNinetyDays
    * def instrumentFutureDateError = collectionServicesConstants.errorMessages.futureInstrumentDate
    * def moreThanDueAmountError = collectionServicesConstants.errorMessages.moreThanDueAmount
    * def instrumentNumberError = collectionServicesConstants.errorMessages.instrumentNumberAsEmptyString
    * def transactionNumberError = collectionServicesConstants.errorMessages.transactionNumberAsEmptyString

        @Create_PaymentWithValidBillID_01 @regression @positive @CreatePayment @collectionServices
        Scenario: Make payment with valid Bill id
     * call read('../../business-services/pretests/collectionServicesPretest.feature@createPayment')
     * match response.ResponseInfo.status == '200 OK'
     * def paymentId = collectionServicesResponseBody.Payments[0].id
     * call read('../../business-services/pretests/collectionServicesPretest.feature@processworkflow')

        @Create_PaymentWithPaidBillID_02 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with paid Bill id
     * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
     * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with valid Bill id first
     * call read('../../business-services/pretests/collectionServicesPretest.feature@createPayment')
     * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Set the `billId` value with paid bill id
     * set createPaymentRequest.Payment.paymentDetails[0].billId = billId
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Calling steps to Cancel the Payment along with Payment Id
     * call read('../../business-services/pretests/collectionServicesPretest.feature@createPayment')
     * match collectionServicesResponseBody.Errors[0].message == paidBillIdError
     * call read('../../business-services/pretests/collectionServicesPretest.feature@processworkflow')

        @Create_PaymentWithInvalidBillID_03 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with invalid Bill id
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../../business-services/pretests/collectionServicesPretest.feature@errorBillId')
    * match response.Errors[0].message == invalidBillIdError
    * print collectionServicesResponseBody
    
        @Create_PaymentWithInvalidBusinessService_04 @regression @positive @CreatePayment @collectionServices
        Scenario: Make payment with invalid Business ID
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../../business-services/pretests/collectionServicesPretest.feature@errorBusinessService')
    * match response.ResponseInfo.status == '200 OK'
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Calling steps to Cancel the Payment along with Payment Id
    * call read('../../business-services/pretests/collectionServicesPretest.feature@processworkflow')

        @Create_PaymentWithAmountpaid_Null_05 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with invalid Business ID
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Bill id 
    * call read('../../business-services/pretests/collectionServicesPretest.feature@totalAmountPaidNull')
    * match response.Errors[0].message == totalAmountPaidError

        @Create_PaymentWith_PaymentModeCard_06 @regression @positive @CreatePayment @collectionServices
        Scenario: Make payment with Card payment mode
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with Card type payment mode
    * call read('../../business-services/pretests/collectionServicesPretest.feature@cardPaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

        @Create_PaymentWith_InvalidPaymentMode_07 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with invalid Payment mode
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Payment Mode
    * call read('../../business-services/pretests/collectionServicesPretest.feature@errorPaymentMode')
    * match response.Errors[0].message == invalidPaymentModeError

        @Create_PaymentWith_InvalidtenantID_08 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with invalid Tenant Id
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Teanant Id
    * call read('../../business-services/pretests/collectionServicesPretest.feature@errorTenantId')
    * match response.Errors[0].message == invalidTenantIdError

        @Create_PaymentWith_NotenantID_09 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with null Tenant Id
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with invalid Tenant Id
    * call read('../../business-services/pretests/collectionServicesPretest.feature@nullTenantIdPayment')
    * match response.Errors[0].message == nullTenantIdError

        @Create_PaymentWith_negativeAmount_10 @regression @negative @CreatePayment @collectionServices
        Scenario: Make payment with negative total amount paid
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@assessPropertySuccessfully')
    * call read('../../business-services/pretests/billingServicePretest.feature@fetchBill')
    # Make payment with negative total amount paid value
    * call read('../../business-services/pretests/collectionServicesPretest.feature@negativeTotalAmount')
    * def billId = fetchBillResponse.Bill[0].id
    * def negativeAmountError = "The amount paid for the paymentDetail with bill number: " + billId
    * match response.Errors[0].message == negativeAmountError

    @Create_PaymentWith_PaymentModeCheque_11 @regression @positive @CreatePaymentWithCheque @collectionServices
    Scenario: Test to Create Payment with paymentMode CHEQUE
    # Make a payment with cheque
    * call read('../../business-services/preTests/collectionServicesPretest.feature@chequePaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

@Create_PaymentWithNoInstrumentDate_12 @regression @negative @CreatePaymentWithCheque @collectionServices
    Scenario: Test to Create Payment with no instrument date
    # Make a payment with cheeque
    * call read('../../business-services/preTests/collectionServicesPretest.feature@errorForInstrumentDateWihChequePayment')
    * match response.Errors[0].message == instrumentDateError

@Create_PaymentWithPast90InstrumentDate_13 @regression @negative @CreatePaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with Past 90 instrument date
   # Make a payment with cheeque
   * call read('../../business-services/preTests/collectionServicesPretest.feature@errorForPastDaysInstrumentDateWihChequePayment')
   * match response.Errors[0].message == instrumentPastDateError

@Create_PaymentWithFutureInstrumentDate_14 @regression @negative @CreatePaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with future instrument date
   # Make a payment with cheeque
   * call read('../../business-services/preTests/collectionServicesPretest.feature@errorForFutureInstrumentDateWihChequePayment')
   * match response.Errors[0].message == instrumentFutureDateError

@Create_PaymentWithMorethanAmountDue_15 @regression @negative @CreatePaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with more than amount due
   # Make a payment with cheeque
   * call read('../../business-services/preTests/collectionServicesPretest.feature@errorForMorethanDueAmountWihChequePayment')
   * match response.Errors[0].message == moreThanDueAmountError

@Create_PaymentWithNoInstrumentNumber_16 @regression @negative @CreatePaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with No Instrument number
   # Make a payment with cheeque
   * call read('../../business-services/preTests/collectionServicesPretest.feature@errorForInstrumentNumberWihChequePayment')
   * match response.Errors[0].message == instrumentNumberError

@Create_PaymentWithNoTransactioNumber_17 @regression @negative @CreatePaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with No Transaction number
   # Make a payment with cheeque
   * call read('../../business-services/preTests/collectionServicesPretest.feature@errorForTransactionNumberWihChequePayment')
   * match response.Errors[0].message == transactionNumberError