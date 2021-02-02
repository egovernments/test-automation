Feature: Billing Services Search tests

Background:
    *  call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    *  def authUsername = employeeUserName
    *  def authPassword = employeePassword
    *  def authUserType = employeeType
    *  call read('../preTests/authenticationToken.feature')
    *  def billingServiceConstants = read('../constants/billing-service.yaml')
    *  def jsUtils = read('classpath:jsUtils.js')
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * call read('../preTests/collectionServicesPretest.feature@successPayment')
    * def mobileNumber = collectionServicesResponseBody.Payments[0].mobileNumber
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
    
@search_withValidServiceAndConsumerCode_01 @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with valid service and consumer code
    *  def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() > 0
    * assert searchBillResponse.Bill[0].businessService == businessService
    * assert searchBillResponse.Bill[0].consumerCode == consumerCode
    * assert searchBillResponse.Bill[0].tenantId == tenantId

@search_withValidBillId_02 @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with valid Bill id
    * def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * def billId = searchBillResponse.Bill[0].id
    * def searchBillParams = { tenantId: '#(tenantId)', billId: '#(billId)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() > 0
    * assert searchBillResponse.Bill[0].id == billId
    * assert searchBillResponse.Bill[0].tenantId == tenantId

@search_withValidService_03 @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with service code
    * def searchBillParams = {tenantId: '#(tenantId)', service: '#(businessService)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == mandatoryFieldErrorCode
    * assert searchBillResponse.Errors[0].message == mandatoryFieldErrorMessage

@search_withValidConsumerCode_04 @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with a valid Consumer code
    * def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == noBusinessServiceErrorCode
    * assert searchBillResponse.Errors[0].message.trim() == noBusinessServiceErrorMsg

@search_withValidServiceAndMobileNumber_05 @positive @searchBill @billingServiceBill
Scenario: Test to search a bill with a business service and mobile number
    * def searchBillParams = {tenantId: '#(tenantId)', service: '#(businessService)', mobileNumber: '#(mobileNumber)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill[0].mobileNumber == mobileNumber

@search_withInvalidService_06 @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with invalid business service
    *  def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    * set searchBillParams.service =  invalidService
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() == 0

@search_withInvalidBillId_07 @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with an invalid billId
    *  def searchBillParams = {tenantId: '#(tenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    * set searchBillParams.billId =  invalidBillId
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() == 0

@search_withInvalidMobileNumber_08 @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with an invalid mobile number and service
    * def searchBillParams =  {tenantId: '#(tenantId)', service: '#(businessService)', mobileNumber: '#(invalidMobileNumber)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Bill.size() == 0

@search_withValidtenantId_09 @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with tenantId
    * def searchBillParams =  {tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == mandatoryFieldErrorCode
    * assert searchBillResponse.Errors[0].message == mandatoryFieldErrorMessage

@search_withNoParameters_10 @negative @searchBill @billingServiceBill
Scenario: Test to search a bill without any parameters
    * def searchBillParams =  {}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * karate.log(searchBillResponse)
    * assert searchBillResponse.Errors[0].code == noTenantIdErrorCode
    * assert searchBillResponse.Errors[0].message == noTenantIdErrorMsg

@search_withInvalidtenantId_11 @negative @searchBill @billingServiceBill
Scenario: Test to search a bill with an invalid tenantId
    * def searchBillParams =  {tenantId: '#(invalidTenantId)', consumerCode: '#(consumerCode)', service: '#(businessService)'}
    * call read('../preTests/billingServicePretest.feature@successSearchBill')
    * assert searchBillResponse.Errors[0].code == invalidTenantIdErrorCode
    * assert searchBillResponse.Errors[0].message == invalidTenantIdErrorMsg
    
