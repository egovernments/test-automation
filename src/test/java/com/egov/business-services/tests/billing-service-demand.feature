Feature: Business Services - Billing Service Demand tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def billingServiceDemandConstants = read('../constants/billing-service-demand.yaml')
    * def commonConstants = read('../constants/commonConstants.yaml')
    * def tenantId = tenantId
    * def consumerCode = billingServiceDemandConstants.parameters.consumerCode + ranInteger(6)
    * def consumerType = billingServiceDemandConstants.parameters.consumerType
    * def businessService = billingServiceDemandConstants.parameters.businessService
    * def taxPeriodFrom = getCurrentEpochTime()
    * def taxPeriodTo = getEpochDate(2)
    * def taxHeadMasterCode = billingServiceDemandConstants.parameters.taxHeadMasterCode
    * def taxAmount = billingServiceDemandConstants.parameters.taxAmount
    * def collectionAmount = billingServiceDemandConstants.parameters.collectionAmount
    * def minimumAmountPayable = billingServiceDemandConstants.parameters.minimumAmountPayable
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../preTests/authenticationToken.feature')
    
@create_01 @positive @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with valid field values
    * call read('../preTests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.created
    * match billingServiceDemandResponseBody.Demands[0].id == "#present"
    * match billingServiceDemandResponseBody.Demands[0].tenantId == tenantId
    * match billingServiceDemandResponseBody.Demands[0].consumerCode == consumerCode
    * match billingServiceDemandResponseBody.Demands[0].consumerType == consumerType
    * match billingServiceDemandResponseBody.Demands[0].businessService == businessService
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodFrom == taxPeriodFrom
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodTo == taxPeriodTo
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].id == "#present"
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].demandId == "#present"
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxHeadMasterCode == taxHeadMasterCode
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxAmount == taxAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].collectionAmount == collectionAmount
    * match billingServiceDemandResponseBody.Demands[0].minimumAmountPayable == minimumAmountPayable
    * match billingServiceDemandResponseBody.Demands[0].status == billingServiceDemandConstants.parameters.status

@create_DuplicateConsumerCode_02 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with duplicate consumer code
    * call read('../preTests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.duplicateConsumerCode + '[' + consumerCode + ']'

@create_NoConsumerCode_03 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no consumer code
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].consumerCode'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_NoConsumerType_04 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no consumer type
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].consumerType'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_InvalidBusinessService_05 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with invalid business service
    * def businessService = billingServiceDemandConstants.invalidParameters.businessService
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidBusinessService + '[' + businessService + ']'

@create_ConsumerCodeWith251Characters_06 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with invalid consumer code character length
    * def consumerCode = ranString(260)
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@create_NoBusinessService_07 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no business service
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].businessService'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_InvalidTaxPeriodFrom_08 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with invalid tax period from
    * def taxPeriodFrom = billingServiceDemandConstants.invalidParameters.taxPeriodFrom
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.jsonDeserializeError

@create_ZeroTaxPeriod_09 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with zero tax period from and to
    * def taxPeriodFrom = 0
    * def taxPeriodTo = 0
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.zeroTaxPeriodError

@create_NULLTaxPeriod_10 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no tax period from and to
    * def taxPeriodFrom = null
    * def taxPeriodTo = null
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_InvalidTaxHeadMasterCode_11 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with invalid tax head master code
    * def taxHeadMasterCode = billingServiceDemandConstants.invalidParameters.taxHeadMasterCode
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTaxHeadMasterCode + '[' + taxHeadMasterCode + ']'

@create_NoTaxHeadMasterCode_12 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no tax head master code
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].demandDetails[0].taxHeadMasterCode'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_MorethanMaxTaxAmount_13 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with tax amount more than maximum amount
    * def taxAmount = billingServiceDemandConstants.invalidParameters.taxAmountGreater
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@create_NoTaxAmount_14 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no tax amount
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].demandDetails[0].taxAmount'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_collectionAmountMorethanTaxAmount_15 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with collection amount more than tax amount
    * def collectionAmount = taxAmount + '0'
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message contains billingServiceDemandConstants.expectedMessages.collectionAmountMoreThanTaxAmount

@create_NocollectionAmount_16 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no collection amount
    * def collectionAmount = null
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_MorethanMax_MinimumAmountPayable_17 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with minimum amount payable more than mamimum amount
    * def minimumAmountPayable = billingServiceDemandConstants.invalidParameters.minimumAmountPayableGreater
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@create_InvalidTenantId_18 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with invalid tenant id
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

@create_NoTenantId_19 @negative @billingServiceDemand_create @billingServiceDemand
Scenario: Test to Create Demand with no tenant id
    * call read('../preTests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].tenantId'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError