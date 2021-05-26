Feature: Fire NOC Billing Slab Feature

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Collections = Java.type('java.util.Collections')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # Searching Location for locality and areaCode
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def fireNocBillignSlabConstants = read('../../municipal-services/constants/fireNocBillingSlab.yaml')
    # initialising request payload variables
    * configure headers = read('classpath:websCommonHeaders.js')
    * def uom = mdmsStateTradeLicense.AccessoriesCategory[0].uom
    * def calculationType = fireNocBillignSlabConstants.calculationTypes.flat
    * def buildingUsageType = "GROUP_A_RESIDENTIAL.SUBDIVISIONA-1"
    * def fireNOCId = randomString(10)
    * def fireNOCType = fireNocBillignSlabConstants.allowedValues.fireNOCNew
    * def apiId = "Rainmaker"
    * def ver = ".01"
    * def action = ""
    * def did = "1"
    * def msgId = "20170310130900|en_IN"
    * def rate = ranInteger(2)
    * def fireNOCApplicationNumber = "PB-FN-2021-04-06-010023"
    * def fireStationId = mdmsStateFireNocService.FireStations[0].code
    * def financialYear = "2019-20"
    * def action = fireNocBillignSlabConstants.actions.apply
    * def channel = fireNocBillignSlabConstants.channel.counter
    * def noOfBuildings = fireNocBillignSlabConstants.building.single
    * def buildingName = randomString(10)
    * def buildingUsageType = "GROUP_A_RESIDENTIAL.SUBDIVISIONA-1"
    * def ownerShipType = mdmsStatecommonMasters.OwnerShipCategory[0].code
    * def tenantIdRoles = tenantId

@SearchFireNOCBillingFeature1 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Search Fire NOC BIlling Slab Feature with Valid Inputs
    # Search FireNOC Billing slab
    * def searchFireNOCBillingSlabParams = { tenantId:'#(tenantId)', uom: '#(uom)', calculationType: '#(calculationType)',buildingUsageType:'#(buildingUsageType)',fireNOCType:"NEW"}
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@searchFireNOCBIllingSlabFeature')
    # Validate response body
    * match fireNOCBillingSlabResponse.BillingSlabs[0].tenantId == "#present"
    * match fireNOCBillingSlabResponse.BillingSlabs[0].id == "#present"
    * match fireNOCBillingSlabResponse.BillingSlabs[0].buildingUsageType == buildingUsageType
    * match fireNOCBillingSlabResponse.BillingSlabs[0].uom == uom

@SearchFireNOCBillingFeature2 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Search Fire NOC BIlling Slab Feature with invalid tenant id
    # Search FireNOC Billing slab
    * def invalidtenantId = randomString(2) + "." + randomString(10)
    * def searchFireNOCBillingSlabParams = { tenantId:'#(invalidtenantId)', uom: '#(uom)', calculationType: '#(calculationType)',buildingUsageType:'#(buildingUsageType)',fireNOCType:"NEW"}
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failSearchFireNOCBIllingSlabFeatureUnAuthorized')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].code == fireNocBillignSlabConstants.Errors.errorCodes.invalidTenantId
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.invalidTenantId
@SearchFireNOCBillingFeature3 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Search Fire NOC BIlling Slab Feature with no tenant id
    # Search FireNOC Billing slab
    * def searchFireNOCBillingSlabParams = { uom: '#(uom)', calculationType: '#(calculationType)',buildingUsageType:'#(buildingUsageType)',fireNOCType:"NEW"}
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failSearchFireNOCBIllingSlabFeature')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].params.missingProperty == fireNocBillignSlabConstants.Errors.params.missingProperty.tenandId
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.missingTenantId
@SearchFireNOCBillingFeature4 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Search Fire NOC BIlling Slab Feature - all records
    # Search FireNOC Billing slab
    * def searchFireNOCBillingSlabParams = { tenantId:'#(tenantId)'}
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@searchFireNOCBIllingSlabFeatureAllRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.BillingSlabs[0].tenantId == "#present"
    * match fireNOCBillingSlabResponse.BillingSlabs[0].id == "#present"
    * match fireNOCBillingSlabResponse.BillingSlabs[0].buildingUsageType == buildingUsageType
@SearchFireNOCBillingFeature5 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Search Fire NOC BIlling Slab Feature - No records
    # Search FireNOC Billing slab
    * def invalidBillingUsageType = randomString(10)
    * def searchFireNOCBillingSlabParams = { tenantId:'#(tenantId)',uom: '#(uom)', calculationType: '#(calculationType)',buildingUsageType:'#(invalidBillingUsageType)',fireNOCType:"NEW"}
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@searchFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.BillingSlabs == "#present"

@SearchFireNOCBillingFeature6 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Search Fire NOC BIlling Slab Feature - Invalid
    # Search FireNOC Billing slab
    * def invalidCalculationType = randomString(10)
    * def searchFireNOCBillingSlabParams = { tenantId:'#(tenantId)',uom: '#(uom)', calculationType: '#(invalidCalculationType)',buildingUsageType:'#(invalidBillingUsageType)',fireNOCType:"NEW"}
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failSearchFireNOCBIllingSlabFeature')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors == "#present"
    * match fireNOCBillingSlabResponse.Errors[0].params.allowedValues == "#present"
    * match fireNOCBillingSlabResponse.Errors[0].message == "#present"



@CreateFireNOCBillingFeature1 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Valid Inputs
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@createFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.BillingSlabs[0].tenantId == "#present"
    * match fireNOCBillingSlabResponse.BillingSlabs[0].id == "#present"
    * match fireNOCBillingSlabResponse.BillingSlabs[0].buildingUsageType == buildingUsageType
    * match fireNOCBillingSlabResponse.BillingSlabs[0].uom == uom


@CreateFireNOCBillingFeature2 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Invalid Tenant Id
    * def tenantId = null
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCreateFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.createInvalidTenantId
@CreateFireNOCBillingFeature3 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Invalid Fire NOC
    * def fireNOCType = randomString(10)
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCreateFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].params.allowedValues[*] contains fireNocBillignSlabConstants.Errors.allowedValues.fireNOCNew
    * match fireNOCBillingSlabResponse.Errors[0].params.allowedValues[*] contains fireNocBillignSlabConstants.Errors.allowedValues.fireNOCProvisional

@CreateFireNOCBillingFeature4 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Building usage Type
    * def buildingUsageType = randomString(10)
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCreateFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.createInvalidBuildingUsageType


@CreateFireNOCBillingFeature5 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Building usage Type
    * def uom = randomString(10)
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCreateFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.createInvalidUOM

@CreateFireNOCBillingFeature6 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Building usage Type
    * def rate = null
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCreateFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.createNullRate

@CreateFireNOCBillingFeature7 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Create Fire NOC BIlling Slab Feature with Building usage Type
    * def calculationType = fireNocBillignSlabConstants.calculationTypes.singleSlab
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCreateFireNOCBIllingSlabNoRecords')
    # Validate response body
    * match fireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.createSingleSlab

@CalculateFireNoc1 @fireNOCBillingFeature  @positive @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Valid data 
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@successCalculateFireNOCBIllingSlab')
    # Validate response body
    * match calculateFireNOCBillingSlabResponse.Calculation[0].applicationNumber == "#present"
    * match calculateFireNOCBillingSlabResponse.Calculation[0].fireNoc.tenantId == tenantId
    * match calculateFireNOCBillingSlabResponse.Calculation[0].fireNoc.fireNOCDetails.fireNOCType == fireNOCType
    * match calculateFireNOCBillingSlabResponse.Calculation[0].taxHeadEstimates[0].category == "#present"
    * match calculateFireNOCBillingSlabResponse.Calculation[0].taxHeadEstimates[0].taxHeadCode == "#present"
    * match calculateFireNOCBillingSlabResponse.Calculation[0].taxHeadEstimates[0].estimateAmount == "#present"

@CalculateFireNoc2 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Invalid Tenant Id
    # Create FireNOC Billing slab
    * def tenantId = randomString(10)
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlab')
    * match calculateFireNOCBillingSlabResponse.Errors[0].code == fireNocBillignSlabConstants.Errors.errorCodes.calculateInvalidTenantId
    * match calculateFireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.calculateInvalidTenantId


#Bug --> Giving 200 Response even when fireNOCType is invalid
@CalculateFireNoc3 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Invalid NOC Type ----- Bug --> Giving 200 Response even when fireNOCType is invalid
    # Create FireNOC Billing slab
    * def fireNOCType = randomString(10)
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlab')
    * match calculateFireNOCBillingSlabResponse.Errors[0].code == fireNocBillignSlabConstants.Errors.errorCodes.calculateInvalidNOCType
    * match calculateFireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.calculateInvalidNOCType

@CalculateFireNoc4 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Invalid NOC Type
    # Create FireNOC Billing slab
    * def fireNOCApplicationNumber = null
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlab')
    * match calculateFireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.calculateInvalidFireNOCNumber 
@CalculateFireNoc5 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Invalid FireNOC Length
    # Create FireNOC Billing slab
    * def fireNOCId = ""
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlab')
    * match calculateFireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.calculateInvalidLenthFireNOCId 

@CalculateFireNoc6 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Invalid NOC Application Length
    # Create FireNOC Billing slab
    * def fireNOCApplicationNumber = ""
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlab')
    * match calculateFireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.calculateInvalidLenthFireNOCId
@CalculateFireNoc7 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With Invalid Tenant Id Role
    # Create FireNOC Billing slab
    * def tenantIdRoles = ""
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlabUnAuthorized')
    * match calculateFireNOCBillingSlabResponse.Errors[0].message == fireNocBillignSlabConstants.Errors.errorMessages.invalidTenantId


 @CalculateFireNoc8 @fireNOCBillingFeature  @negative @regression @NOCService @municipalServices
Scenario: Calculate FireNOC With no mandatory parameters
    # Create FireNOC Billing slab
    * call read('../../municipal-services/pretests/fireNOCBillingSlabPretest.feature@failCalculateFireNOCBIllingSlabMandatoryParams')
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyTenantId
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyFireNOCType
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyFireStationId
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyFinancialYear
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyAction
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyChannel
    * match calculateFireNOCBillingSlabResponse.Errors[*].message contains fireNocBillignSlabConstants.Errors.errorMessages.missingPropertyNoOfBuildings


