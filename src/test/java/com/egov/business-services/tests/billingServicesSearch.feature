Feature: Billing Services Search tests

Background:
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    *  def billingServiceConstants = read('../constants/billing-service.yaml')
    *  def jsUtils = read('classpath:jsUtils.js')
    *  call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    *  call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    *  def mobileNumber = collectionServicesResponseBody.Payments[0].mobileNumber
    *  def invalidService = randomString(2)
    *  def invalidBillId = generateUUID()
    *  def invalidMobileNumber = '9'+randomMobileNumGen(9)
    *  def invalidTenantId = randomString(5)
    *  def mandatoryFieldErrorCode = billingServiceConstants.errorMessages.mandatoryFieldError.code
    *  def mandatoryFieldErrorMessage = billingServiceConstants.errorMessages.mandatoryFieldError.message
    *  def noBusinessServiceErrorCode = billingServiceConstants.errorMessages.noBusinessServiceError.code
    *  def noBusinessServiceErrorMsg = billingServiceConstants.errorMessages.noBusinessServiceError.message
    *  def noTenantIdErrorCode = billingServiceConstants.errorMessages.notNullSearchCriteriaError.code
    *  def noTenantIdErrorMsg = billingServiceConstants.errorMessages.notNullSearchCriteriaError.message
    *  def invalidTenantIdErrorCode = billingServiceConstants.errorMessages.invalidTenantId.code
    *  def invalidTenantIdErrorMsg = billingServiceConstants.errorMessages.invalidTenantId.message
    
@search_withValidServiceAndConsumerCode_01 @businessServices @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with valid service and consumer code
    # Defining searchBillParams with all valid parameters
    * def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    # Steps to search bill with valid parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() > 0
    * assert searchBillResponse.Bill[0].businessService == businessService
    * assert searchBillResponse.Bill[0].consumerCode == consumerCode
    * assert searchBillResponse.Bill[0].tenantId == tenantId

@search_withValidBillId_02 @businessServices @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with valid Bill id
    # Defining searchBillParams with all valid parameters
    * def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    # Defining billId from searchBillResponse
    * def billId = searchBillResponse.Bill[0].id
    # Again defining searchBillParams with valid billId
    * def searchBillParams = { tenantId: '#(tenantId)', billId: '#(billId)'}
    # Steps to search bill with valid parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() > 0
    * assert searchBillResponse.Bill[0].id == billId
    * assert searchBillResponse.Bill[0].tenantId == tenantId

@search_withValidService_03 @businessServices @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with service code
    # Defining searchBillParams with tenantId and service code
    * def searchBillParams = {tenantId: '#(tenantId)', service: '#(businessService)'}
    # Steps to search bill with valid parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == mandatoryFieldErrorCode
    * assert searchBillResponse.Errors[0].message == mandatoryFieldErrorMessage

@search_withValidConsumerCode_04 @businessServices @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with a valid Consumer code
    # Defining searchBillParams with tenantId and consumerCode
    * def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)'}
    # Steps to search bill with valid parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == noBusinessServiceErrorCode
    * assert searchBillResponse.Errors[0].message.trim() == noBusinessServiceErrorMsg

# need to debug this
@search_withValidServiceAndMobileNumber_05 @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with a business service and mobile number
    # Defining searchBillParams with tenantId and service and mobileNumber
    * def searchBillParams = {tenantId: '#(tenantId)', service: '#(businessService)', mobileNumber: '#(mobileNumber)'}
    # Steps to search bill with valid parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill[0].mobileNumber == mobileNumber

@search_withInvalidService_06 @businessServices @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with invalid business service
    # Defining searchBillParams with tenantId, consumerCode and service
    *  def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    # Set service with business service code
    * set searchBillParams.service =  invalidService
    # Steps to search bill with invalid service and generate error
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() == 0

@search_withInvalidBillId_07 @businessServices @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with an invalid billId
    # Defining searchBillParams with tenantId, consumerCode and service
    *  def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    # Set an Invalid billId on billId parameter
    * set searchBillParams.billId =  invalidBillId
    # Steps to search bill with invalid bill id and generate error
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() == 0

@search_withInvalidMobileNumber_08 @businessServices @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with an invalid mobile number and service
    # Defining searchBillParams with tenantId, service and mobileNumber
    * def searchBillParams =  {tenantId: '#(tenantId)', service: '#(businessService)', mobileNumber: '#(invalidMobileNumber)'}
    # Steps to search bill with invalid mobile number and generate error
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() == 0

@search_withValidtenantId_09 @businessServices @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with tenantId
    # Defining searchBillParams with tenantId only
    * def searchBillParams =  {tenantId: '#(tenantId)'}
    # Steps to search bill with tenantId only and generate error
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == mandatoryFieldErrorCode
    * assert searchBillResponse.Errors[0].message == mandatoryFieldErrorMessage

@search_withNoParameters_10 @businessServices @negative @searchBill @billingServiceBill
Scenario: Test to search a bill without any parameters
    # Defininf searchBillParams as empty
    * def searchBillParams =  {}
    # Steps to search bill with empty parameters and generate error
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * karate.log(searchBillResponse)
    * assert searchBillResponse.Errors[0].code == noTenantIdErrorCode
    * assert searchBillResponse.Errors[0].message == noTenantIdErrorMsg

@search_withInvalidtenantId_11 @businessServices @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with an invalid tenantId
    # Defining searchBillParams with tenantId, consumerCode, service
    * def searchBillParams =  {tenantId: '#(invalidTenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    # Steps to search bill with invalid tenantId
    * call read('../../business-services/pretest/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == invalidTenantIdErrorCode
    * assert searchBillResponse.Errors[0].message == invalidTenantIdErrorMsg
    
