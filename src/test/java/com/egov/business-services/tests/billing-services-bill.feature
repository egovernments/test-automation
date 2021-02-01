Feature: Billing Service - Bills tests

    Background:
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess') 
    * def jsUtils = read('classpath:jsUtils.js')
    # Calling access token
     * def authUsername = employeeUserName
     * def authPassword = employeePassword
     * def authUserType = employeeType
     * call read('../preTests/authenticationToken.feature')
     * def billingServiceConstants = read('../constants/billing-service.yaml')
     * def commonConstants = read('../constants/commonConstants.yaml')
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


@fetchbill_01 @positive @fetchbill @billingServiceBill
Scenario: Fetch bill with valid consumer code and business service
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@fetchBill')
    * print billResponse.ResposneInfo.status
    * assert fetchBillResponse.Bill.size()>0
    * match fetchBillResponse.Bill[0].consumerCode == '#present'
    * match fetchBillResponse.Bill[0].businessService == '#present'
    * match fetchBillResponse.Bill[0].tenantId == '#present'
    
@fetchbill_NoConsumerCode_02 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with no consumer code parameter
    * def fetchBillParams = { businessService: '#(businessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noConsumerCodeErrorCode
    * assert fetchBillResponse.Errors[0].message == noConsumerCodeErrorMessage

@fetchbill_NoBusinessService_03 @negative @fetchbill @billingServiceBill 
Scenario: Fetch bill with no business service parameter
    * def fetchBillParams = { consumerCode: '#(consumerCode)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noBusinessServiceErrorCode
    * assert fetchBillResponse.Errors[0].message == mustNotNullError

@fetchbill_noTenantId_04 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with no tenantId parameter
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noTenantIdErrorCode
    * assert fetchBillResponse.Errors[0].message == mustNotNullError

@fetchbill_InvalidConsumerCode_05 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid Consumer code
    * def fetchBillParams = { consumerCode: '#(invalidConsumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage

@fetchbill_InvalidBusinessService_06 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid Business Service
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(invalidBusinessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage

@fetchbill_invalidTenantId_07 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid Tenant Id
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(invalidTenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == invalidTenantIdErrorCode
    * assert fetchBillResponse.Errors[0].message == invalidTenantIdErrorMessage

@fetchbill_WithMobileNumberAndBusinessService_08 @positive @fetchbill @billingServiceBill
Scenario: Fetch bill with mobile number
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../preTests/billingServicePretest.feature@fetchBill') 
    * assert fetchBillResponse.Bill.size()>0
    * match fetchBillResponse.Bill[0].consumerCode == '#present'
    * match fetchBillResponse.Bill[0].businessService == '#present'
    * match fetchBillResponse.Bill[0].tenantId == '#present'
    * match fetchBillResponse.Bill[0].mobileNumber == '#present'

@fetchbill_WithNoParameters_09 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with no parameters
    * def fetchBillParams = {}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * match fetchBillResponse.Errors[*].code contains ['#(noTenantIdErrorCode)', '#(noBusinessServiceErrorCode)']
   
@fetchbill_WithInvalidMobileNumber_10 @negative @fetchbill @billingServiceBill
Scenario: Fetch bill with invalid mobile number
    * def fetchBillParams = { consumerCode: '#(consumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)', mobileNumber: '#(invalidMobileNumber)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam')
    * assert responseStatus == 400 
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage
