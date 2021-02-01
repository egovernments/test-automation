Feature: Business Services - Billing Service Demand tests

Background:
    * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def billingServiceDemandConstants = read('../../business-services/constants/billing-service-demand.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def consumerCode = 'PT-Test-' + ranInteger(6)
    * def consumerType = BillingService.BusinessService[6].businessService
    * def businessService = BillingService.BusinessService[6].code
    * def taxPeriodFrom = getCurrentEpochTime()
    * def taxPeriodTo = getEpochDate(2)
    * def taxHeadMasterCodes = karate.jsonPath(BillingService, "$.TaxHeadMaster[?(@.service=='" + businessService + "')].code")
    * def taxHeadMasterCode = taxHeadMasterCodes[randomNumber(taxHeadMasterCodes.length)]
    * def taxAmount = 200
    * def collectionAmount = 0
    * def minimumAmountPayable = 1
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../../common-services/pretests/authenticationToken.feature')
    
@create_01 @positive @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with valid field values
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
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

@create_DuplicateConsumerCode_02 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with duplicate consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.duplicateConsumerCode + '[' + consumerCode + ']'

@create_NoConsumerCode_03 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].consumerCode'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_NoConsumerType_04 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no consumer type
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].consumerType'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_InvalidBusinessService_05 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with invalid business service
    * def businessService = 'invalid-businessService-' + ranString(10)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidBusinessService + '[' + businessService + ']'

@create_ConsumerCodeWith251Characters_06 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with invalid consumer code character length
    * def consumerCode = randomString(260)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@create_NoBusinessService_07 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].businessService'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_InvalidTaxPeriodFrom_08 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with invalid tax period from
    * def taxPeriodFrom = billingServiceDemandConstants.invalidParameters.taxPeriodFrom
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.jsonDeserializeError

@create_ZeroTaxPeriod_09 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with zero tax period from and to
    * def taxPeriodFrom = 0
    * def taxPeriodTo = 0
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.zeroTaxPeriodError

@create_NULLTaxPeriod_10 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no tax period from and to
    * def taxPeriodFrom = null
    * def taxPeriodTo = null
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_InvalidTaxHeadMasterCode_11 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with invalid tax head master code
    * def taxHeadMasterCode = 'Invalid-taxHeadMasterCode-' + ranString(10)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTaxHeadMasterCode + '[' + taxHeadMasterCode + ']'

@create_NoTaxHeadMasterCode_12 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no tax head master code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].demandDetails[0].taxHeadMasterCode'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_MorethanMaxTaxAmount_13 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with tax amount more than maximum amount
    * def taxAmount = billingServiceDemandConstants.invalidParameters.taxAmountGreater
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@create_NoTaxAmount_14 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no tax amount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].demandDetails[0].taxAmount'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_collectionAmountMorethanTaxAmount_15 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with collection amount more than tax amount
    * def collectionAmount = taxAmount + '0'
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message contains billingServiceDemandConstants.expectedMessages.collectionAmountMoreThanTaxAmount

@create_NocollectionAmount_16 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no collection amount
    * def collectionAmount = null
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@create_MorethanMax_MinimumAmountPayable_17 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with minimum amount payable more than mamimum amount
    * def minimumAmountPayable = billingServiceDemandConstants.invalidParameters.minimumAmountPayableGreater
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@create_InvalidTenantId_18 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with invalid tenant id
    * def tenantId = 'Invalid-tenantId-' + ranString(5)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreate')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

@create_NoTenantId_19 @negative @billingServiceDemandCreate @billingServiceDemand
Scenario: Test to Create Demand with no tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].tenantId'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@search_01 @search_WithDemandId_09 @positive @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with valid parameter values
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodFrom == taxPeriodFrom
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodTo == taxPeriodTo
    * match billingServiceDemandResponseBody.Demands[0].businessService == businessService
    * match billingServiceDemandResponseBody.Demands[0].minimumAmountPayable == minimumAmountPayable
    * match billingServiceDemandResponseBody.Demands[0].consumerType == consumerType
    * match billingServiceDemandResponseBody.Demands[0].tenantId == tenantId
    * match billingServiceDemandResponseBody.Demands[0].consumerCode == consumerCode
    * match billingServiceDemandResponseBody.Demands[0].status == billingServiceDemandConstants.parameters.status
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].demandId == demandId
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxHeadMasterCode == taxHeadMasterCode
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].collectionAmount == collectionAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxAmount == taxAmount

@search_InvalidConsumerCode_02 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with invalid consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def consumerCode = 'invalid-ConsumerCode-' + ranString(10)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    * match billingServiceDemandResponseBody.Demands == '#[0]'

@search_InvalidBusinessService_03 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def businessService = 'invalid-businessService-' + ranString(10)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    * match billingServiceDemandResponseBody.Demands == '#[0]'

@search_NoConsumerCode_04 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with no consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def searchDemandParams =
    """
        {
            businessService: '#(businessService)',
            tenantId: '#(tenantId)',
            demandId: '#(demandId)'
        }
    """
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    * match billingServiceDemandResponseBody.Demands != '#[0]'

@search_NoBusinessService_05 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with no business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def searchDemandParams =
    """
        {
            tenantId: '#(tenantId)',
            consumerCode: '#(consumerCode)',
            demandId: '#(demandId)'
        }
    """
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    * match billingServiceDemandResponseBody.Demands != '#[0]'

@search_InvalidTenantId_06 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with invalid tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def tenantId = 'Invalid-tenantId-' + ranString(5)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert searchDemandResponseStatus == 403
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError
    
@search_NoTenantId_07 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with no tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def searchDemandParams =
    """
        {
            businessService: '#(businessService)',
            consumerCode: '#(consumerCode)',
            demandId: '#(demandId)'
        }
    """
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * print billingServiceDemandResponseBody
    * assert searchDemandResponseStatus == 400
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@search_WithOnlyTenantId_08 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with only tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * def searchDemandParams =
    """
        {
            'tenantId': '#(tenantId)'
        }
    """
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * print billingServiceDemandResponseBody
    * assert searchDemandResponseStatus == 400
    * assert billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.onlyTenantId

@search_InvalidDemandId_10 @negative @billingServiceDemandSearch @billingServiceDemand
Scenario: Test to Search Demand with invalid demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def demandId = 'invalid-demandId-' + ranString(10)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    * match billingServiceDemandResponseBody.Demands == '#[0]'

@update_01 @positive @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with valid field values
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successUpdate')
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

@update_InvalidDemandId_02 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with invalid demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def invalidDemandId = 'invalid-demandId-' + ranString(10)
    * eval Demands[0].id = invalidDemandId
    * eval Demands[0].demandDetails[0].id = invalidDemandId
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.demandNotFound + '[' + invalidDemandId + ']'

@update_NoDemandId_03 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with no demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * remove Demands[0].id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.demandIdMandatory

@update_InvalidBusinessService_04 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def invalidBusinessService = 'invalid-businessService-' + ranString(10)
    * eval Demands[0].businessService = invalidBusinessService
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidBusinessService + '[' + invalidBusinessService + ']'

@update_NoBusinessService_05  @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with no businessn service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * remove Demands[0].businessService
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@update_InvalidTaxPeriods_06 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with zero tax period from and to
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * eval Demands[0].taxPeriodFrom = 0
    * eval Demands[0].taxPeriodTo = 0
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.zeroTaxPeriodError

@update_NoTaxPeriods_07 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with no tax period from and to
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * remove Demands[0].taxPeriodFrom
    * remove Demands[0].taxPeriodTo
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@update_InvalidTaxheadMasterCode_08 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with invalid tax head master code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def invalidTaxHeadMasterCode = 'Invalid-taxHeadMasterCode-' + ranString(10)
    * eval Demands[0].demandDetails[0].taxHeadMasterCode = invalidTaxHeadMasterCode
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTaxHeadMasterCode + '[' + invalidTaxHeadMasterCode + ']'

@update_NoTaxAmount_09 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with no tax amount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * remove Demands[0].demandDetails[0].taxAmount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@update_InvalidtenantId_10 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with invalid tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * def invalidTenantId = 'Invalid-tenantId-' + ranString(5)
    * eval Demands[0].tenantId = invalidTenantId
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTenantId

@update_NotenantId_11 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with no tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * remove Demands[0].tenantId
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@update_CollectionAmountGreaterThanTaxAmount_12 @negative @billingServiceDemandUpdate @billingServiceDemand
Scenario: Test to Update Demand with collection amount greater than tax amount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@successCreate')
    * print billingServiceDemandResponseBody
    * eval Demands[0].demandDetails[0].collectionAmount = Demands[0].demandDetails[0].taxAmount + '0'
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorUpdate')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message contains billingServiceDemandConstants.expectedMessages.collectionAmountMoreThanTaxAmount