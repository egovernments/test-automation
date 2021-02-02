Feature: Business Services - Collection service - search tests

Background:
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def collectionServicesConstants = read('../constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def receiptNumber = collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber
    * def mobileNumber = collectionServicesResponseBody.Payments[0].mobileNumber
    * def invalidTenantId = randomString(5)
    * def invalidMobileNumber = '9'+randomMobileNumGen(9)
    * def invalidReceipt = 'invalid_'+randomNumber(5)

@Search_PaymentWithReceiptNumber_01 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with receipt number
    * def parameters = {tenantId: '#(tenantId)',receiptNumber: '#(receiptNumber)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber

@Search_PaymentWithBillID_02 @positive @SearchPayment @collectionServices
Scenario: Test to search payment with billID
    * call read('../preTests/collectionServicesPretest.feature@successSearchBillId')
    * match searchResponseBody.Payments[0].paymentDetails[0].billId == billId

@Search_PaymentWithConsumerCode_03 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with consumer code
    * call read('../preTests/collectionServicesPretest.feature@successSearchConsumerCode')
    * match searchResponseBody.Payments[0].paymentDetails[0].bill.consumerCode == consumerCode
   
@Search_PaymentWithMobileNumber_04 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with mobile number
    * def parameters = {tenantId: '#(tenantId)',mobileNumber: '#(mobileNumber)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0


@Search_PaymentWithMobileNumberAndReceiptNumber_05 @positive @SearchPayment @collectionServices
    Scenario: Test to search payment with mobile number and receipt number
    * def parameters = {tenantId: '#(tenantId)',mobileNumber: '#(mobileNumber)', receiptNumbers: '#(receiptNumber)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber


@Search_AllPayments_06 @positive @SearchPayment @collectionServices
    Scenario: Test to search all payments
    * def parameters = {tenantId: '#(tenantId)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * match searchResponseBody.Payments[0].paymentDetails[0] == '#present'

@Search_PaymentWith_InvalidtenatID_07 @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid tenantID
    * def parameters = {tenantId: '#(invalidTenantId)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'

@Search_PaymentWith_InvalidMobileNumber_08 @negative @SearchPayment @collectionServices
    Scenario: Test to search payment with invalid mobileNumber
    * def parameters = {tenantId: '#(tenantId)',mobileNumber: '#(invalidMobileNumber)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * karate.log(searchResponseBody)
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'

@Search_PaymentWith_InvalidReceiptNumber_09 @negative @SearchPayment @collectionServices
Scenario: Test to search payment with invalid ReceiptNumber
    * def parameters = {tenantId: '#(tenantId)',receiptNumbers: '#(invalidReceipt)'}
    * call read('../preTests/collectionServicesPretest.feature@successSearchMobileNumber')
    * assert searchResponseBody.Payments.length == 0
    * match searchResponseBody.Payments[0] == '#notpresent'