Feature: TL Calculator Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def tlCalculatorConstants = read('../../municipal-services/constants/tlCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../municipal-services/tests/tradeLicense.feature@tradeLicenseCreate1')
    * def consumerCode = tradeLicenseResponseBody.Licenses[0].applicationNumber
    * def index = randomNumber(mdmsStatecommonMasters.StructureType.length)
    * def indexTL = randomNumber(200)
    * def businessService = tlCalculatorConstants.parameters.businessService
    * def invalidValue = commonConstants.invalidParameters.invalidValue
    * def emptyValue = commonConstants.invalidParameters.emptyValue
    * def indexLicenseType = randomNumber(tlCalculatorConstants.parameters.licenseType.length)
    * def licenseType = tlCalculatorConstants.parameters.licenseType[indexLicenseType]
    * def indexApplicationType = randomNumber(tlCalculatorConstants.parameters.applicationType.length)
    * def applicationType = tlCalculatorConstants.parameters.applicationType[indexApplicationType]
    * def accessoryCategory = commonConstants.invalidParameters.nullValue
    * def uom = commonConstants.invalidParameters.nullValue
    * def type = tlCalculatorConstants.parameters.type
    * def fromUom = 0
    * def toUom = 0
    * def rate = ranInteger(4)
    

@TL-getBill_01 @positive @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"consumerCode": '#(consumerCode)',"businessService": "#(businessService)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillSuccessfully')
    * match billSearchResponseBody.billResponse.Bill[0] == "#present"
    * match billSearchResponseBody.billingSlabIds.consumerCode == consumerCode

@TL-getBillMandatory_02 @negative @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call by not passing tenant id or applicationNumber
    * def getBillSearchParam = {"businessService": "#(businessService)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillError')
    * match billSearchResponseBody.Errors[*].message contains commonConstants.errorMessages.nullParameterError

@TL-getBillInvalidBusSer_03 @negative @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call by passing invalid or non existant Business Service and check for errors
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"consumerCode": '#(consumerCode)',"businessService": "#(invalidValue)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillError')
    * match billSearchResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.businessServiceError

@TL-getBillInvalidConsumerCode_04 @negative @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call by passing invalid or non existant applicationNumber and check for errors
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"consumerCode": '#(invalidValue)',"businessService": "#(businessService)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillError')
    * match billSearchResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.consumerCodeError

@TL_getBillInvalidTenant_05 @negative @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call by passing invalid or non existant tenantId and check for errors
    * def getBillSearchParam = {"tenantId": '#(invalidValue)',"consumerCode": '#(consumerCode)',"businessService": "#(businessService)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillAuthorizedError')
    * match billSearchResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@TL-getBillNoConsumerCode_06 @negative @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call by not passing any value for applicationNumber and check for errors
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"consumerCode": '#(emptyValue)',"businessService": "#(businessService)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillError')
    * match billSearchResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.noConsumerCodeError

@TL-getBillNodemands_07 @negative @regression @tlCalculatorGetBill @tlCalculator
Scenario: Verify searching for bill details through API call by passing any value for applicationNumber which doesnt have any demands associated with it and check for errors
    * call read('../../municipal-services/tests/tradeLicenseEndToEndFlow.feature@createTradeLicenseAndApproveCounterEmployee')
    * def noDemandsConsumerCode = consumerCode
    # * print noDemandsConsumerCode
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"consumerCode": '#(noDemandsConsumerCode)',"businessService": "#(businessService)"}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillError')
    * match billSearchResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.noDemandError
    
@BillingSlabCreate_01 @positive @regression @tlCalculatorBillingSlabCreate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify creating a billing slab for TL through API call
    * def structureType = mdmsStatecommonMasters.StructureType[2].code
    * def tradeType = mdmsStateTradeLicense.TradeType[indexTL].code
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@createBillingSlabSuccessfully')
    * match billSlabCreateResponseBody.billingSlab[0].structureType == structureType
    * match billSlabCreateResponseBody.billingSlab[0].tradeType == tradeType

@BillingSlabCreate_SingleTenant_02 @negative @regression @tlCalculatorBillingSlabCreate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify creating a billing slab for TL through API call adding 2 different tenants and check for error
    * def structureType = mdmsStatecommonMasters.StructureType[index].code
    * def tradeType = mdmsStateTradeLicense.TradeType[indexTL].code
    * def tenantId2 = tlCalculatorConstants.parameters.otherTenantId
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@createBillingSlabMultiTenantError')
    * match billSlabCreateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.tenantError

@BillingSlabCreate_Duplicate_03 @negative @regression @tlCalculatorBillingSlabCreate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify creating a billing slab for TL through API call
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@createBillingSlabError')
    * match billSlabCreateResponseBody.Errors[0].code == tlCalculatorConstants.errorMessages.duplicateCode

@BillingSlabCreate_StructureTradeTypeCharCount_04 @negative @regression @tlCalculatorBillingSlabCreate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify creating a billing slab for TL through API call
    * def structureType = 's'
    * def tradeType = 'a'
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@createBillingSlabError')
    * match billSlabCreateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.structureTypeSizeError
    * match billSlabCreateResponseBody.Errors[1].message == tlCalculatorConstants.errorMessages.structureTypeSizeError

@BillingSlabCreate_StructureTradeTypeInValid_05 @negative @regression @tlCalculatorBillingSlabCreate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify creating a billing slab for TL through API call by passing invalid or non existant values for the structure and trade type type check for error
    * def structureType = invalidValue
    * def tradeType = invalidValue
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@createBillingSlabError')
    * match billSlabCreateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.tradeTypeError + ': ' + tradeType
    * match billSlabCreateResponseBody.Errors[1].message == tlCalculatorConstants.errorMessages.structureTypeError + ': ' + structureType
    
@BillingSlabUpdate_01 @positve @regression @tlCalculatorBillingSlabUpdate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify updating a billing slab for TL through API call using exiting billing slab id
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = billSlabCreateResponseBody.billingSlab[0].id
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@updateBillingSlabSuccessfully')
    * match billSlabUpdateResponseBody.billingSlab[0].structureType == structureType
    * match billSlabUpdateResponseBody.billingSlab[0].id == id
    * match billSlabUpdateResponseBody.billingSlab[0].tradeType == tradeType

@BillingSlabUpdate_InValidId_02 @negative @regression @tlCalculatorBillingSlabUpdate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify updating a billing slab for TL through API call by passing invalid or non existant values for the billing slab id and check for error
    #* call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = invalidValue
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@updateBillingSlabError')
    * match billSlabUpdateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.invalidIDError + ': [' + id + ']'

@BillingSlabUpdate_Error_03 @negative @regression @tlCalculatorBillingSlabUpdate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify updating a billing slab for TL through API call by passing both trade type and accessries category and check for error
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = billSlabCreateResponseBody.billingSlab[0].id
    * def accessoryCategory = tlCalculatorConstants.parameters.applicationType[1]
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@updateBillingSlabError')
    * match billSlabUpdateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.invalidSlabError

@BillingSlabUpdate_InvalidCharCount_04 @negative @regression @tlCalculatorBillingSlabUpdate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify updating a billing slab for TL through API call by passing 1 character for the structure and trade type check for error
    * def id = invalidValue
    * def structureType = 's'
    * def tradeType = 'a'
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@updateBillingSlabError')
    * match billSlabUpdateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.structureTypeSizeError
    * match billSlabUpdateResponseBody.Errors[1].message == tlCalculatorConstants.errorMessages.structureTypeSizeError

@BillingSlabUpdate_InvalidTypes_05 @negative @regression @tlCalculatorBillingSlabUpdate @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify updating a billing slab for TL through API call by passing invalid values for the structure and trade type check for error
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = billSlabCreateResponseBody.billingSlab[0].id
    * def structureType = invalidValue
    * def tradeType = invalidValue
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@updateBillingSlabError')
    * match billSlabUpdateResponseBody.Errors[0].message == tlCalculatorConstants.errorMessages.tradeTypeError + ': ' + tradeType
    * match billSlabUpdateResponseBody.Errors[1].message == tlCalculatorConstants.errorMessages.structureTypeError + ': ' + structureType

@BillingSlab_Search_01 @positve @regression @tlCalculatorBillingSlabSearch @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify Searching for billing slab details through api call for a given billing slab id
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = billSlabCreateResponseBody.billingSlab[0].id
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(id)'}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillingSlabSuccessfully')
    * match billSlabSearchResponseBody.billingSlab[0] == "#present"
    * match billSlabSearchResponseBody.billingSlab[0].id == id

@BillingSlab_Search_NoTenant_02 @negative @regression @tlCalculatorBillingSlabSearch @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify Searching for billing slab details by not passing tenant id and check for errors
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = billSlabCreateResponseBody.billingSlab[0].id
    * def searchParam = {"ids": '#(id)'}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillingSlabError')
    * match billSlabSearchResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@BillingSlab_Search_InValidTenant_03 @negative @regression @tlCalculatorBillingSlabSearch @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify searching billing slab for a invalid or non existant tenant id and check for errors
    * def tenantId = invalidValue
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(id)'}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillingSlabErrorUnAuthorized')
    * match billSlabSearchResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@BillingSlab_Search_EmptyResponse_04 @positive @regression @tlCalculatorBillingSlabSearch @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify searching billing slab by passing null for billing slab id
    * def id = commonConstants.invalidParameters.nullValue
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(id)'}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillingSlabSuccessfully')
    * match billSlabSearchResponseBody.billingSlab == []
    * match billSlabSearchResponseBody.billingSlab[0] == "#notpresent"

@BillingSlab_Search_Multiple_05 @positive @regression @tlCalculatorBillingSlabSearch @tlCalculator @tlCalculatorBillingSlab
Scenario: Verify searching billing slab by passing multiple billing slab ids
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id = billSlabCreateResponseBody.billingSlab[0].id
    * def licenseType = tlCalculatorConstants.parameters.licenseType[0]
    * call read('../../municipal-services/tests/tlCalculator.feature@BillingSlabCreate_01')
    * def id2 = billSlabCreateResponseBody.billingSlab[0].id
    * def newID = id + ',' + id2
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(newID)'}
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@searchBillingSlabSuccessfully')
    * match billSlabSearchResponseBody.billingSlab[0] == "#present"
    * match billSlabSearchResponseBody.billingSlab[*].id contains id2
    * match billSlabSearchResponseBody.billingSlab[*].id contains id

@tlcalculate_01 @positive @regression @tlCalculatorCalculate2 @tlCalculator
Scenario: Verify the Trade License Calculation through API for a given TL application number
    * def applicationNumber = consumerCode
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@calculateSuccessfully')
    * match calculateResponseBody.Calculations[0] == "#present"
    * match calculateResponseBody.Calculations[0].tradeLicense.applicationNumber == applicationNumber

@tlcalculate_InvalidApplication_02 @negative @regression @tlCalculatorCalculate34 @tlCalculator
Scenario: Verify the Trade License Calculation through API for a by passing an invalid TL application number and check for errors
    * def applicationNumber = invalidValue
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@calculateError')
    * match calculateResponseBody.Errors[0] == "#present"
    * match calculateResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@tlcalculate_InvalidTenant_03 @negative @regression @tlCalculatorCalculate @tlCalculator
Scenario: Verify by passing a invalid or non existant tenant id and check for errors
    * def applicationNumber = consumerCode
    * def tenantId = invalidValue
    * call read('../../municipal-services/pretests/tlCalculatorPretest.feature@calculateErrorUnAuthorized')
    * match calculateResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

