Feature: Billing Service - Bills tests

    Background:
     * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
     * def jsUtils = read('classpath:jsUtils.js')
     * def billingServiceConstants = read('../../business-services/constants/billing-service.yaml')
     * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
     * def invalidMobileNumber = '9'+randomMobileNumGen(9)
     * def invalidConsumerCode = randomString(5)
     * def invalidBusinessService = randomString(2)
     * def invalidTenantId = randomString(5)
     * def mustNotNullError = commonConstants.errorMessages.nullParameterError
     * def noConsumerCodeErrorCode = billingServiceConstants.errorMessages.consumerCode.code
     * def noConsumerCodeErrorMessage = billingServiceConstants.errorMessages.consumerCode.message
     * def noBusinessServiceErrorCode = billingServiceConstants.errorMessages.businessService.code
     * def noTenantIdErrorCode = billingServiceConstants.errorMessages.tenantId.code
     * def noDemandFoundErrorCode = billingServiceConstants.errorMessages.invalidConsumerBusinessCode.code
     * def noDemandFoundErrorMessage = billingServiceConstants.errorMessages.invalidConsumerBusinessCode.message
     * def invalidTenantIdErrorCode = billingServiceConstants.errorMessages.invalidTenantId.code
     * def invalidTenantIdErrorMessage = billingServiceConstants.errorMessages.invalidTenantId.message

@fetchbill_01 @businessServices @positive @fetchbill @billingServiceBill
Scenario: Fetch bill with valid consumer code and business service
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)'}
    # Steps to fetch bill with specified parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * assert fetchBillResponse.Bill.size()>0
    * match fetchBillResponse.Bill[0].consumerCode == '#present'
    * match fetchBillResponse.Bill[0].businessService == '#present'
    * match fetchBillResponse.Bill[0].tenantId == '#present'
    
@fetchbill_NoConsumerCode_02 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with no consumer code parameter
    # Defining fetchBillParams with businessService and tenantId only
    * def fetchBillParams = { businessService: '#(businessService)', tenantId: '#(tenantId)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noConsumerCodeErrorCode
    * assert fetchBillResponse.Errors[0].message == noConsumerCodeErrorMessage

@fetchbill_NoBusinessService_03 @businessServices @negative @fetchbill @billingServiceBill 
Scenario: Fetch bill with no business service parameter
    # Defining fetchBillParams with consumerCode and tenantId only
    * def fetchBillParams = { consumerCode: '#(consumerCode)', tenantId: '#(tenantId)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noBusinessServiceErrorCode
    * assert fetchBillResponse.Errors[0].message == mustNotNullError

@fetchbill_noTenantId_04 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with no tenantId parameter
    # Defining fetchBillParams with consumerCode and businessService only
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noTenantIdErrorCode
    * assert fetchBillResponse.Errors[0].message == mustNotNullError

@fetchbill_InvalidConsumerCode_05 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid Consumer code
    # Defining fetchBillParams with invalid consumerCode
    * def fetchBillParams = { consumerCode: '#(invalidConsumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage

@fetchbill_InvalidBusinessService_06 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid Business Service
    # Defining fetchBillParams with invalid businessService
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(invalidBusinessService)', tenantId: '#(tenantId)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage

@fetchbill_invalidTenantId_07 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid Tenant Id
    # Defining fetchBillParams with invalid tenantId
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(invalidTenantId)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == invalidTenantIdErrorCode
    * assert fetchBillResponse.Errors[0].message == invalidTenantIdErrorMessage

@fetchbill_WithMobileNumberAndBusinessService_08 @businessServices @positive @fetchbill @billingServiceBill
Scenario: Fetch bill with mobile number
    # Defining fetchBillParams with consumerCode, businessService, tenantId and mobileNumber
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill') 
    * assert fetchBillResponse.Bill.size()>0
    * match fetchBillResponse.Bill[0].consumerCode == '#present'
    * match fetchBillResponse.Bill[0].businessService == '#present'
    * match fetchBillResponse.Bill[0].tenantId == '#present'
    * match fetchBillResponse.Bill[0].mobileNumber == '#present'

@fetchbill_WithNoParameters_09 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with no parameters
    # Defining fetchBillParams with empty parameters
    * def fetchBillParams = {}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters') 
    * assert responseStatus == 400
    * match fetchBillResponse.Errors[*].code contains ['#(noTenantIdErrorCode)', '#(noBusinessServiceErrorCode)']
   
@fetchbill_WithInvalidMobileNumber_10 @businessServices @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid mobile number
    # Defining fetchBillParams with invalid mobileNumber
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)', mobileNumber: '#(invalidMobileNumber)'}
    # Steps to fetch bill with customized parameters
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * assert responseStatus == 400 
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage
