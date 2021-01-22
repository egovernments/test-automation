Feature: Billing Service - Bills tests

    Background: 
    # Calling access token
     * def authUsername = employeeUserName
     * def authPassword = employeePassword
     * def authUserType = employeeType
     * call read('../preTests/authenticationToken.feature')
     * def billingServiceConstants = read('../constants/billing-service.yaml')
     * def commonConstants = read('../constants/commonConstants.yaml')
     * def consumerCode = billingServiceConstants.parameters.consumerCode
     * def businessService = billingServiceConstants.parameters.businessService
     * def mobileNumber = billingServiceConstants.parameters.mobileNumber
     * def consumerCodeBill = billingServiceConstants.parameters.consumerCodeBill
     * def invalidMobileNumber = billingServiceConstants.invalidParameters.mobileNumber
     * def invalidConsumerCode = billingServiceConstants.invalidParameters.consumerCode
     * def invalidBusinessService = billingServiceConstants.invalidParameters.businessService
     * def invalidTenantId = billingServiceConstants.invalidParameters.tenantId
     * def mustNotNullError = commonConstants.errorMessages.nullParameterError
     * def noConsumerCodeErrorCode = billingServiceConstants.errorMessages.consumerCode.code
     * def noConsumerCodeErrorMessage = billingServiceConstants.errorMessages.consumerCode.message
     * def noBusinessServiceErrorCode = billingServiceConstants.errorMessages.businessService.code
     * def noTenantIdErrorCode = billingServiceConstants.errorMessages.tenantId.code
     * def noDemandFoundErrorCode = billingServiceConstants.errorMessages.invalidConsumerBusinessCode.code
     * def noDemandFoundErrorMessage = billingServiceConstants.errorMessages.invalidConsumerBusinessCode.message
     * def invalidTenantIdErrorCode = billingServiceConstants.errorMessages.invalidTenantId.code
     * def invalidTenantIdErrorMessage = billingServiceConstants.errorMessages.invalidTenantId.message


@fetchbill_01 @fetchbill
Scenario: Fetch bill with valid consumer code and business service
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', businessService: '#(businessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam')
    * match fetchBillResponse.ResposneInfo.status == '200 OK'

@fetchbill_NoConsumerCode_02 @fetchbill
Scenario: Fetch bill with no consumer code parameter
    * def fetchBillParams = { businessService: '#(businessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noConsumerCodeErrorCode
    * assert fetchBillResponse.Errors[0].message == noConsumerCodeErrorMessage

@fetchbill_NoBusinessService_03 @fetchbill
Scenario: Fetch bill with no business service parameter
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noBusinessServiceErrorCode
    * assert fetchBillResponse.Errors[0].message == mustNotNullError

@fetchbill_noTenantId_04 @fetchbill
Scenario: Fetch bill with no tenantId parameter
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', businessService: '#(businessService)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noTenantIdErrorCode
    * assert fetchBillResponse.Errors[0].message == mustNotNullError

@fetchbill_InvalidConsumerCode_05 @negative @fetchbill
Scenario: Fetch bill with invalid Consumer code
    * def fetchBillParams = { consumerCode: '#(invalidConsumerCode)', businessService: '#(businessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage

@fetchbill_InvalidBusinessService_06 @negative @fetchbill
Scenario: Fetch bill with invalid Business Service
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', businessService: '#(invalidBusinessService)', tenantId: '#(tenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage

@fetchbill_invalidTenantId_07 @negative @fetchbill
Scenario: Fetch bill with invalid Tenant Id
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', businessService: '#(businessService)', tenantId: '#(invalidTenantId)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == invalidTenantIdErrorCode
    * assert fetchBillResponse.Errors[0].message == invalidTenantIdErrorMessage

@fetchbill_WithMobileNumberAndBusinessService_08 @positive @fetchbill
Scenario: Fetch bill with mobile number
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', businessService: '#(businessService)', tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert fetchBillResponse.ResposneInfo.status == '200 OK'

@fetchbill_WithNoParameters_09 @negative @fetchbill
Scenario: Fetch bill with no parameters
    * def fetchBillParams = {}
    * call read('../preTests/billingServicePretest.feature@customizedParam') 
    * assert responseStatus == 400
    * assert fetchBillResponse.Errors[0].code == noBusinessServiceErrorCode
    * assert fetchBillResponse.Errors[1].code == noTenantIdErrorCode
   
@fetchbill_WithInvalidMobileNumber_10 @positive @fetchbill
Scenario: Fetch bill with mobile number
    * def fetchBillParams = { consumerCode: '#(consumerCodeBill)', businessService: '#(businessService)', tenantId: '#(tenantId)', mobileNumber: '#(invalidMobileNumber)'}
    * call read('../preTests/billingServicePretest.feature@customizedParam')
    * assert responseStatus == 400 
    * assert fetchBillResponse.Errors[0].code == noDemandFoundErrorCode
    * assert fetchBillResponse.Errors[0].message == noDemandFoundErrorMessage
    