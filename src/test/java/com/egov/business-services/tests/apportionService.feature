Feature: Business Services - Apportion service tests

   Background:
     * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
     * def jsUtils = read('classpath:jsUtils.js')
     * configure headers = read('classpath:websCommonHeaders.js')
     * def apportionServiceData = read('../../business-services/constants/apportionService.yaml')
     * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
     * call read('../../business-services/preTests/billingServicePretest.feature@fetchBill')
     * def businessService = apportionServiceData.parameters.businessService
     * def amountPaid = totalAmount
     * def isAdvanceAllowed = apportionServiceData.parameters.isAdvanceAllowed
     * def expiryDate = getTomorrowEpochTime()
     * def fromPeriod = getCurrentEpochTime()
     * def toPeriod = getCurrentEpochTime()
     * def demandDetailId = apportionServiceData.parameters.demandDetailId
     * def billAmount1 = randomNumber(3)
     * def billAmount2 = randomNumber(3)
     * def billAmount3 = randomNumber(3)
     * def billAmount4 = randomNumber(3)
     * def taxHeadCode1 = apportionServiceData.parameters.taxHeadCode1
     * def taxHeadCode2 = apportionServiceData.parameters.taxHeadCode2
     * def taxHeadCode3 = apportionServiceData.parameters.taxHeadCode3
     * def taxHeadCode4 = apportionServiceData.parameters.taxHeadCode4
     * def paidValue = totalAmount
     
# For some parameters there are NO validations in this Service
# This test is dependent on port forwarding which is not automated yet. Hence ignored it.
# These tests are related to `apportionService` and has been executed with manual port forwarding
# Next suite of automation code will have automated port forward configuration.
   @apportion_bill_01 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with valid data
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportion')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0

   @apportion_billWithAdjustedAmount_02 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with valid adjusted amount
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportion')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[0].adjustedAmount == billAmount1
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[1].adjustedAmount == billAmount2
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[2].adjustedAmount == billAmount3
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[3].adjustedAmount == billAmount4

   @apportion_bill_InvalidBusinessService_03 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with Invalid businessService
     * def businessService = commonConstants.invalidParameters.invalidValue
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == apportionServiceData.errorMessages.invalidBusinessService + ' businessService: ' + businessService

   @apportion_bill_amountPaidNULL_04 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with AmountPaid as a NULL
     * def amountPaid = {}
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

   @apportion_bill_IsAdvanceAllowedNULL_05 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with isAdvanceAllowed as a NULL
     * def isAdvanceAllowed = {}
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

   @apportion_bill_WithOneTaxHeadCode_06 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with one tax HeadCode
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportionWithOneTaxHeadCode')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0

   @apportion_bill_WithNoBillAccountDetails_07 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with no bill account details
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportionWithNoBillDetails')
     * match apportionResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

   @apportion_bill_WithexpiryDateNull_08 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with Expiry date as NULL
     * def expiryDate = {}
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

   @apportion_bill_NULLtaxHeadCode_09 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with Tax HeadCode as NULL
     * def taxHeadCode1 = {}
     * def taxHeadCode2 = {}
     * def taxHeadCode3 = {}
     * def taxHeadCode4 = {}
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

   @apportion_bill_NoTenantId_10 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with No tenantId
     * def tenantId = {}
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

   @apportion_bill_InValidTenantId_11 @negative @apportionService @ignore
   Scenario: Test to apportion a bill with Invalid tenantId
     * def tenantId = commonConstants.invalidParameters.invalidTenantId
     * call read('../../business-services/preTests/apportionServicePretest.feature@errorApportion')
     * match apportionResponseBody.Errors[0].message == apportionServiceData.errorMessages.invalidTenantMessage

   @apportion_bill_PartialAmount_12 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with Partial Amount
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportion')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0
     * assert apportionResponseBody.Bills[0].totalAmount == totalAmount
     * assert apportionResponseBody.Bills[0].amountPaid == amountPaid

   @apportion_bill_FullAmount_13 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with Full Amount
     * def amountPaid = totalAmount
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportion')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0
     * assert apportionResponseBody.Bills[0].totalAmount == totalAmount
     * assert apportionResponseBody.Bills[0].amountPaid == amountPaid

   @apportion_bill_AdvancePayment_14 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with Advance payment
     * def amountPaid = 1500
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportion')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0
     * assert apportionResponseBody.Bills[0].totalAmount == totalAmount
     * assert apportionResponseBody.Bills[0].amountPaid == amountPaid
     * print apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[3].amount

   @apportion_bill_VerifyOrder_15 @positive @apportionService @ignore
   Scenario: Test to apportion a bill with an Order
     * call read('../../business-services/preTests/apportionServicePretest.feature@successApportion')
     * match apportionResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
     * assert apportionResponseBody.Bills[0].billDetails.length != 0
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[0].order == 0
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[1].order == 1
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[2].order == 2
     * match apportionResponseBody.Bills[0].billDetails[0].billAccountDetails[3].order == 3