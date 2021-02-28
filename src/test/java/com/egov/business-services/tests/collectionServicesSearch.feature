Feature: Business Services - Collection service - search tests

Background:
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def receiptNumber = collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber
    * def mobileNumber = collectionServicesResponseBody.Payments[0].mobileNumber
    * def invalidTenantId = randomString(5)
    * def invalidMobileNumber = '9'+randomMobileNumGen(9)
    * def invalidReceipt = 'invalid_'+randomNumber(5)

@Search_PaymentWithReceiptNumber_01 @businessServices @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with receipt number
    # Defining parameters with tenantId and receiptNumber
    * def parameters = {tenantId: '#(tenantId)',receiptNumber: '#(receiptNumber)'}
    # Steps to search payment with specified parameters
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    # Validate that receiptNumber in response body is equal to receiptNumber defined in parameters
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber

@Search_PaymentWithBillID_02 @businessServices @positive @SearchPayment @collectionServices
Scenario: Test to search payment with billID
    # Steps to search payment with valid billId where billId defined in fetchBill
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithBillId')
    # Validate that billId in response body is equal to billId defined in parameters
    * match searchResponseBody.Payments[0].paymentDetails[0].billId == billId

@Search_PaymentWithConsumerCode_03 @businessServices @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with consumer code
    # Steps to search payment with valid consumer code
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithConsumerCode')
    # Validate that consumer code in response body is equal to consumer code defined in parameters
    * match searchResponseBody.Payments[0].paymentDetails[0].bill.consumerCode == consumerCode
   
@Search_PaymentWithMobileNumber_04 @businessServices @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with mobile number
    # Defining parameters with tenantId and mobileNumber
    * def parameters = {tenantId: '#(tenantId)',mobileNumber: '#(mobileNumber)'}
    # Steps to search payment with speficied parameters
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0

@Search_PaymentWithMobileNumberAndReceiptNumber_05 @businessServices @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with mobile number and receipt number
    # Defining parameters with tenantId, mobileNumber and receiptNumbers
    * def parameters = {tenantId: '#(tenantId)',mobileNumber: '#(mobileNumber)', receiptNumbers: '#(receiptNumber)'}
    # Steps to search payment with speficied parameters
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    # Validate that receiptNumber in response body is equal to receiptNumber defined in parameters
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber

@Search_AllPayments_06 @businessServices @positive @SearchPayment @collectionServices
    Scenario: Test to search all payments
    # Defining parameters with tenantId only
    * def parameters = {tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    # Validate that Payment details should present in the response body
    * match searchResponseBody.Payments[0].paymentDetails[0] == '#present'

@Search_PaymentWith_InvalidtenatID_07 @businessServices @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid tenantID
    # Defining parameters with invalid tenantId
    * def parameters = {tenantId: '#(invalidTenantId)'}
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments.length == 0
    # Validate that Payment details should not present in the response body as tenantId is invalid
    * match searchResponseBody.Payments[0] == '#notpresent'

@Search_PaymentWith_InvalidMobileNumber_08 @businessServices @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid mobileNumber
    # Defining parameters with invalid mobile number
    * def parameters = {tenantId: '#(tenantId)',mobileNumber: '#(invalidMobileNumber)'}
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * karate.log(searchResponseBody)
    * assert searchResponseBody.Payments.length == 0
    # Validate that Payment details should not present in the response body as mobileNumber is invalid
    * match searchResponseBody.Payments[0] == '#notpresent'

@Search_PaymentWith_InvalidReceiptNumber_09 @businessServices @negative @SearchPayment @collectionServices
Scenario: Test to search payment with invalid ReceiptNumber
    # Defining parameters with invalid receipt number
    * def parameters = {tenantId: '#(tenantId)',receiptNumbers: '#(invalidReceipt)'}
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments.length == 0
    # Validate that Payment details should not present in the response body as receipt number is invalid
    * match searchResponseBody.Payments[0] == '#notpresent'