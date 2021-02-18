Feature: Business Services - Billing Service Demand tests

        Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def billingServiceDemandConstants = read('../../business-services/constants/billing-service-demand.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def consumerCode = 'PT-Test-' + ranInteger(6)
    * def consumerType = mdmsStateBillingService.BusinessService[0].businessService
    * def businessService = mdmsStateBillingService.BusinessService[0].code
    * def taxPeriodFrom = getCurrentEpochTime()
    * def taxPeriodTo = getEpochDate(2)
    * def taxHeadMasterCodes = karate.jsonPath(mdmsStateBillingService, "$.TaxHeadMaster[?(@.service=='" + businessService + "')].code")
    * def taxHeadMasterCode = taxHeadMasterCodes[randomNumber(taxHeadMasterCodes.length)]
    * def taxAmount = 200
    * def collectionAmount = 0
    * def minimumAmountPayable = 1
        
    @create_01 @regression @positive @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with valid field values
    # Steps to create a new Employee through HRMS
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Validate the status Created
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.created
    # Validate the demand id is present
    * match billingServiceDemandResponseBody.Demands[0].id == "#present"
    # Validate the tenantId of demand response is equal with current tenantId
    * match billingServiceDemandResponseBody.Demands[0].tenantId == tenantId
    # Validate the consumer code of demand response is equal with defined consumerCode
    * match billingServiceDemandResponseBody.Demands[0].consumerCode == consumerCode
    # Validate the consumerType of demand response is equal with defined consumerType
    * match billingServiceDemandResponseBody.Demands[0].consumerType == consumerType
    # Validate the businessService of demand response is equal with defined businessService
    * match billingServiceDemandResponseBody.Demands[0].businessService == businessService
    # Validate the taxPeriodFrom of demand response is equal with defined taxPeriodFrom
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodFrom == taxPeriodFrom
    # Validate the taxPeriodTo of demand response is equal with defined taxPeriodTo
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodTo == taxPeriodTo
    # Validate the demand details id is present in demand response body
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].id == "#present"
    # Validate the demandId is present in demand response body
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].demandId == "#present"
    # Validate the taxHeadMasterCode of demand response is equal with defined taxHeadMasterCode
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxHeadMasterCode == taxHeadMasterCode
    # Validate the taxAmount of demand response is equal with defined taxAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxAmount == taxAmount
    # Validate the collectionAmount of demand response is equal with defined collectionAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].collectionAmount == collectionAmount
    # Validate the minimumAmountPayable of demand response is equal with defined minimumAmountPayable
    * match billingServiceDemandResponseBody.Demands[0].minimumAmountPayable == minimumAmountPayable
    # Validate the demand status is equal with expected demand status `ACTIVE`
    * match billingServiceDemandResponseBody.Demands[0].status == billingServiceDemandConstants.parameters.status

    @create_DuplicateConsumerCode_02 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with duplicate consumer code
    # Steps to create a new employee
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to create a employee with duplicate consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    # Validate that actual error returned by API for duplicate consumer code is same as expected error message
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.duplicateConsumerCode + '[' + consumerCode + ']'

    @create_NoConsumerCode_03 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no consumer code
    # Steps to create a new employee without consumerCode field in the request 
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].consumerCode'}
    # Validate that actual error returned by API for no consumer code field is same as expected error message
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_NoConsumerType_04 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no consumer type
    # Steps to create a new employee without consumerType field in the request
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].consumerType'}
    # Validate that actual error returned by API for no consumer type field is same as expected error message
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_InvalidBusinessService_05 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with invalid business service
    # Defining businessService with invalid business service
    * def businessService = 'invalid-businessService-' + ranString(10)
    # Steps to create a new employee with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    # Validate that actual error returned by API for invalid business service is same as expected error message
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidBusinessService + '[' + businessService + ']'

    @create_ConsumerCodeWith251Characters_06 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with invalid consumer code character length
    # Defining consumerCode with invalid random value
    * def consumerCode = randomString(260)
    # Steps to create employee with invalid consumerCode
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

    @create_NoBusinessService_07 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no business service
    # Steps to create a new employee without businessService field in the request
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].businessService'}
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_InvalidTaxPeriodFrom_08 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with invalid tax period from
    # Defining taxPeriodFrom with Invalid taxPeriodFrom value
    * def taxPeriodFrom = billingServiceDemandConstants.invalidParameters.taxPeriodFrom
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.jsonDeserializeError

    @create_ZeroTaxPeriod_09 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with zero tax period from and to
    # Defining taxPeriodFrom as `0`
    * def taxPeriodFrom = 0
    # Defining taxPeriodTo as `0`
    * def taxPeriodTo = 0
    # Steps to create employee with zero values of taxPeriodFrom and taxPeriodTo fields
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.zeroTaxPeriodError

    @create_NULLTaxPeriod_10 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no tax period from and to
    * def taxPeriodFrom = null
    * def taxPeriodTo = null
    # Steps to create employee with null values of taxPeriodFrom and taxPeriodTo fields
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_InvalidTaxHeadMasterCode_11 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with invalid tax head master code
    # Defining taxHeadMasterCode with an Invalid taxHeadMasterCode
    * def taxHeadMasterCode = 'Invalid-taxHeadMasterCode-' + ranString(10)
    # Steps to create a employee with invalid taxHeadMasterCode and generate error
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTaxHeadMasterCode + '[' + taxHeadMasterCode + ']'

    @create_NoTaxHeadMasterCode_12 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no tax head master code
    # Steps to create a employee without taxHeadMasterCode
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].demandDetails[0].taxHeadMasterCode'}
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_MorethanMaxTaxAmount_13 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with tax amount more than maximum amount
    # Defining taxAmount with more than tax amount value
    * def taxAmount = billingServiceDemandConstants.invalidParameters.taxAmountGreater
    # Steps to create employee with invalid taxAmount value and generate error
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

    @create_NoTaxAmount_14 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no tax amount
    # Steps to create a employee without taxAmount field in request
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].demandDetails[0].taxAmount'}
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_collectionAmountMorethanTaxAmount_15 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with collection amount more than tax amount
    # Defining collectionAmount with more than tax amount
    * def collectionAmount = taxAmount + '0'
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message contains billingServiceDemandConstants.expectedMessages.collectionAmountMoreThanTaxAmount

    @create_NocollectionAmount_16 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no collection amount
    # Defining collectionAmount as null
    * def collectionAmount = null
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @create_MorethanMax_MinimumAmountPayable_17 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with minimum amount payable more than mamimum amount
    # Defining minimumAmountPayable with more than payable ammount
    * def minimumAmountPayable = billingServiceDemandConstants.invalidParameters.minimumAmountPayableGreater
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

    @create_InvalidTenantId_18 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with invalid tenant id
    # Defining an invalid tenantId and assigning it to tenantId
    * def tenantId = 'Invalid-tenantId-' + ranString(5)
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateBillDemand')
    * assert billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTenantId || billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

    @create_NoTenantId_19 @regression @negative @billingServiceDemandCreate @billingServiceDemand
    Scenario: Test to Create Demand with no tenant id
    # Steps to create a employee without tenantId field in the request
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorCreateRemoveField') {'removeFieldPath': '$.Demands[0].tenantId'}
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @search_01 @search_WithDemandId_09 @regression @positive @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with valid parameter values
    # Create a new employee through HRMS
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Defining demanId fetched from demand response body
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    # Validate that response status is OK
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    # Validate that response status code is 200
    * assert searchDemandResponseStatus == 200
    # Validate that demand taxPeriodFrom is equal to defined taxPeriodFrom
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodFrom == taxPeriodFrom
    # Validate that demand taxPeriodTo is equal to defined taxPeriodTo
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodTo == taxPeriodTo
    # Validate that demand businessService is equal to defined businessService
    * match billingServiceDemandResponseBody.Demands[0].businessService == businessService
    # Validate that demand minimumAmountPayable is equal to defined minimumAmountPayable
    * match billingServiceDemandResponseBody.Demands[0].minimumAmountPayable == minimumAmountPayable
    # Validate that demand consumerType is equal to defined consumerType
    * match billingServiceDemandResponseBody.Demands[0].consumerType == consumerType
    # Validate that demand tenantId is equal to defined tenantId
    * match billingServiceDemandResponseBody.Demands[0].tenantId == tenantId
    # Validate that demand consumerCode is equal to defined consumerCode
    * match billingServiceDemandResponseBody.Demands[0].consumerCode == consumerCode
    # Validate that demand status is equal to defined status `ACTIVE`
    * match billingServiceDemandResponseBody.Demands[0].status == billingServiceDemandConstants.parameters.status
    # Validate that demand demandId is equal to defined demandId 
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].demandId == demandId
    # Validate that demand taxHeadMasterCode is equal to defined taxHeadMasterCode
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxHeadMasterCode == taxHeadMasterCode
    # Validate that demand collectionAmount is equal to defined collectionAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].collectionAmount == collectionAmount
    # Validate that demand taxAmount is equal to defined taxAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxAmount == taxAmount

    @search_InvalidConsumerCode_02 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with invalid consumer code
    # Create new employee through HRMS
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    # Defining demandId with the demand id fetched from billing service demand response body
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining consumer code with Invalid consumer code value
    * def consumerCode = 'invalid-ConsumerCode-' + ranString(10)
    # Steps to search a demand with invalid consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    # Vaidate that the Demands should not contains any value
    * match billingServiceDemandResponseBody.Demands == '#[0]'

    @search_InvalidBusinessService_03 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with invalid business service
    # Create new employee through HRMS
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    # Defining demandId with the demand id fetched from billing service demand response body
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining businessService as Invalid business service
    * def businessService = 'invalid-businessService-' + ranString(10)
    # Steps to search a demand with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    # Validate that the response status is `ok`
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    # Vaidate that the Demands should not contains any value
    * match billingServiceDemandResponseBody.Demands == '#[0]'

    @search_NoConsumerCode_04 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with no consumer code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining searchDemandParams without consumer code
    * def searchDemandParams =
    """
        {
            businessService: '#(businessService)',
            tenantId: '#(tenantId)',
            demandId: '#(demandId)'
        }
    """
    # Steps to search demand without consumer code in it's parameter
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    # Vaidate that the Demands should not contains any value
    * match billingServiceDemandResponseBody.Demands != '#[0]'

    @search_NoBusinessService_05 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with no business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining searchDemandParams without business service
    * def searchDemandParams =
    """
        {
            tenantId: '#(tenantId)',
            consumerCode: '#(consumerCode)',
            demandId: '#(demandId)'
        }
    """
    # Steps to search demand without business service in it's parameter
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    # Vaidate that the Demands should not contains any value
    * match billingServiceDemandResponseBody.Demands != '#[0]'

    @search_InvalidTenantId_06 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with invalid tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining tenantId as Invalid
    * def tenantId = 'Invalid-tenantId-' + ranString(5)
    # Steps to search demand with invalid tenantId
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert searchDemandResponseStatus == 403
    * assert billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError
    
    @search_NoTenantId_07 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with no tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining searchDemandParams without tenantId
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

    @search_WithOnlyTenantId_08 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with only tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    * def demandId = billingServiceDemandResponseBody.Demands[0].id
    # Defining searchDemandParams with only tenantId
    * def searchDemandParams =
    """
        {
            'tenantId': '#(tenantId)'
        }
    """
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * assert searchDemandResponseStatus == 400
    * assert billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.onlyTenantId

    @search_InvalidDemandId_10 @regression @negative @billingServiceDemandSearch @billingServiceDemand
    Scenario: Test to Search Demand with invalid demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Defining demandId with an Invalid demandId
    * def demandId = 'invalid-demandId-' + ranString(10)
    # Steps to search a demand with invalid demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@searchDemand')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.ok
    * assert searchDemandResponseStatus == 200
    # Validate that the size of Demands should be `0` as invalid demandId passed in parameter
    * match billingServiceDemandResponseBody.Demands == '#[0]'

    @update_01 @regression @positive @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with valid field values
    # Craete a employee through HRMS
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to update employee details through HRMS
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@updateDemand')
    * print billingServiceDemandResponseBody
    # Validate that the response status is created
    * assert billingServiceDemandResponseBody.ResponseInfo.status == commonConstants.expectedStatus.created
    # Validate that the Demand is is present
    * match billingServiceDemandResponseBody.Demands[0].id == "#present"
    # Validate that the demand tenantId is equal to defined tenantId
    * match billingServiceDemandResponseBody.Demands[0].tenantId == tenantId
    # Validate that the demand consumerCode is equal to defined consumerCode
    * match billingServiceDemandResponseBody.Demands[0].consumerCode == consumerCode
    # Validate that the demand consumerType is equal to defined consumerType
    * match billingServiceDemandResponseBody.Demands[0].consumerType == consumerType
    # Validate that the demand businessService is equal to defined businessService
    * match billingServiceDemandResponseBody.Demands[0].businessService == businessService
    # Validate that the demand taxPeriodFrom is equal to defined taxPeriodFrom
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodFrom == taxPeriodFrom
    # Validate that the demand taxPeriodTo is equal to defined taxPeriodTo
    * match billingServiceDemandResponseBody.Demands[0].taxPeriodTo == taxPeriodTo
    # Validate that the demand details id is present
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].id == "#present"
    # Validate that the demand details demandId is present
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].demandId == "#present"
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxHeadMasterCode == taxHeadMasterCode
    # Validate that the demand taxAmount is equal to defined taxAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].taxAmount == taxAmount
    # Validate that the demand collectionAmount is equal to defined collectionAmount
    * match billingServiceDemandResponseBody.Demands[0].demandDetails[0].collectionAmount == collectionAmount
    # Validate that the demand minimumAmountPayable is equal to defined minimumAmountPayable
    * match billingServiceDemandResponseBody.Demands[0].minimumAmountPayable == minimumAmountPayable
    # Validate that the demand status is equal to expected status `ACTIVE`
    * match billingServiceDemandResponseBody.Demands[0].status == billingServiceDemandConstants.parameters.status

    @update_InvalidDemandId_02 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with invalid demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Defining demandId as Invalid demandId
    * def invalidDemandId = 'invalid-demandId-' + ranString(10)
    * eval Demands[0].id = invalidDemandId
    * eval Demands[0].demandDetails[0].id = invalidDemandId
    # Steps to update demand with invalid demand id and demand details id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.demandNotFound + '[' + invalidDemandId + ']'

    @update_NoDemandId_03 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with no demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Remove Demands id from the request
    * remove Demands[0].id
    # Steps to update demand without demand id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.demandIdMandatory

    @update_InvalidBusinessService_04 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Defining business servive as invalid
    * def invalidBusinessService = 'invalid-businessService-' + ranString(10)
    # Assigning invalid business service to the respective field
    * eval Demands[0].businessService = invalidBusinessService
    # Steps to update demand with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidBusinessService + '[' + invalidBusinessService + ']'

    @update_NoBusinessService_05  @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with no businessn service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Remove business service from the request
    * remove Demands[0].businessService
    # Steps to update demand with invalid business service
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @update_InvalidTaxPeriods_06 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with zero tax period from and to
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Assigning taxPeriodFrom and taxPeriodTo as `0`
    * eval Demands[0].taxPeriodFrom = 0
    * eval Demands[0].taxPeriodTo = 0
    # Steps to update demand with specified field details
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.zeroTaxPeriodError

    @update_NoTaxPeriods_07 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with no tax period from and to
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Remove taxPeriodFrom and taxPeriodTo fields from the request
    * remove Demands[0].taxPeriodFrom
    * remove Demands[0].taxPeriodTo
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @update_InvalidTaxheadMasterCode_08 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with invalid tax head master code
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Defining taxHeaderMasterCode as Invalid
    * def invalidTaxHeadMasterCode = 'Invalid-taxHeadMasterCode-' + ranString(10)
    # Assigning invalidTaxHeadMasterCode to it's respective field
    * eval Demands[0].demandDetails[0].taxHeadMasterCode = invalidTaxHeadMasterCode
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTaxHeadMasterCode + '[' + invalidTaxHeadMasterCode + ']'

    @update_NoTaxAmount_09 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with no tax amount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Remove taxAmount from the request
    * remove Demands[0].demandDetails[0].taxAmount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @update_InvalidtenantId_10 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with invalid tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Defining tenantId with Invalid tenantId
    * def invalidTenantId = 'Invalid-tenantId-' + ranString(5)
    # Assigning invalid tenantId to it's respective field
    * eval Demands[0].tenantId = invalidTenantId
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * assert billingServiceDemandResponseBody.Errors[0].message == billingServiceDemandConstants.expectedMessages.invalidTenantId || billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

    @update_NotenantId_11 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with no tenant id
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Remove tenantId from the Demands
    * remove Demands[0].tenantId
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

    @update_CollectionAmountGreaterThanTaxAmount_12 @regression @negative @billingServiceDemandUpdate @billingServiceDemand
    Scenario: Test to Update Demand with collection amount greater than tax amount
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@createBillDemand')
    * print billingServiceDemandResponseBody
    # Assigning collectionAmount with greater than tax amount
    * eval Demands[0].demandDetails[0].collectionAmount = Demands[0].demandDetails[0].taxAmount + '0'
    * call read('../../business-services/pretests/billingServiceDemandPretest.feature@errorInUpdateEmployee')
    * print billingServiceDemandResponseBody
    * match billingServiceDemandResponseBody.Errors[0].message contains billingServiceDemandConstants.expectedMessages.collectionAmountMoreThanTaxAmount