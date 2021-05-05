Feature: Fire NOC Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(10000)
    * def propertyLocalityCity = mdmsStateFireNocService.FireStations[0].city
    * def propertyLocalityCode = mdmsStateFireNocService.FireStations[0].code
    * def stationCode = mdmsStateFireNocService.FireStations[0].code
    * def tenantId = mdmsStateFireNocService.FireStations[0].baseTenantId
    * def provisional = mdmsStateFireNocService.ApplicationType[0].code
    * def usageType = mdmsStateFireNocService.BuildingType[0].code
    * def hight = mdmsStateFireNocService.UOMs[0].code
    * def floors = mdmsStateFireNocService.UOMs[6].code
    * def basements = mdmsStateFireNocService.UOMs[8].code
    * def platSize = mdmsStateFireNocService.UOMs[7].code
    * def singleOwner = mdmsStatecommonMasters.OwnerShipCategory[0].code
    #* def financialYear = mdmsStatecommonMasters.FinancialYear[7].code
    * def financialYear = '2019-20'
    * def fireNocConstants = read('../../municipal-services/constants/fireNocService.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def mobileNumber = '77' + randomMobileNumGen(8)
    * def fatherOrHusbandName = randomString(10)
    * def name = 'AUTO_' + randomString(10)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def gender = fireNocConstants.gender[randomNumber(fireNocConstants.gender.length)]
    * def dob = getPastEpochDate(5000)
    * def correspondenceAddress = randomString(50)
    * def action = fireNocConstants.actions.initiate
    * def counter = fireNocConstants.channel.counter
    * def single = fireNocConstants.building.single
    * def usageTypeMajor = fireNocConstants.usageType.usageTypeMajor
    * def ownerShipMajorType = fireNocConstants.ownerShip.ownerShipMajorType
    * def isActiveUom = fireNocConstants.actions.isActiveUom
    * def active = fireNocConstants.actions.active
    * def noofFloors = 1
    * def plotSize = 123

    @fireNoc_Create_01 @positive @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API 
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    * match fireNocResponseBody.ResponseInfo.status == fireNocConstants.status.status

    @fireNoc_Create_Invalid_noBuildings_02 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid building type
    * def single = randomString(10)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidBuildType

    @fireNoc_Create_nvalid_UsageType_03 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid usage type
    * def usageType = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].params.keyword == fireNocConstants.errorMessages.invalidUsage
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidUsageType

    @fireNoc_Create_Invalid_uom_04 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid UOMs
    * def hight = randomString(8)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].params.keyword == fireNocConstants.errorMessages.invlidUom
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidUomCode

    @fireNoc_Create_Invalid_active_05 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid active
    * def isActiveUom = commonConstants.invalidParameters.nullValue
    * def active = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidUomActive

    @fireNoc_Create_Invalid_mob_06 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid active
    * def mobileNumber = commonConstants.invalidParameters.invalidMobileNumber
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidMobileNumber

    @fireNoc_Create_null_values_07 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid relationship
    * def relationship = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[1].message == fireNocConstants.errorMessages.invalidBuildType

    @fireNoc_Create_action_error_08 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid action type
    * def action = randomString(8)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidBuildType

    @fireNoc_Create_Invalid_tenant_09 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid tenantID
    * def tenantId = randomString(8)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createBPAError2')
    * match fireNocResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @fireNoc_Create_invalid_FirestnID_10 @negative @regression @municipalService @fireNocService @fireNocServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid firestationId
    * def stationCode = randomString(8)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocError1')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidFirestation

    @search_01 @positive @regression @municipalService @fireNocService @fireNocServiceSearch
    Scenario: Verify searching for a firenoc service
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    * def getFireNocSearchParam = {"tenantId": '#(tenantId)',"applicationNumber": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/fireNocPretest.feature@searchFireNocSuccessfully')
    * match fireNocResponseBody.FireNOCs[0] == '#present'

    @search_AllRecords_02 @positive @regression @municipalService @fireNocService @fireNocServiceSearch
    Scenario: Verify searching for a firenoc service without Params
    * call read('../../municipal-services/pretests/fireNocPretest.feature@searchFireNocWithoutParamsSuccessfully')
    * match fireNocResponseBody.FireNOCs[0] == '#present'

    @search_InvalidTenant_03 @negative @regression @municipalService @fireNocService @fireNocServiceSearch
    Scenario: Verify searching for a firenoc service with invalid tenant id
    * def tenantId = randomString(8)
    * def getFireNocSearchParam = {"tenantId": tenantId}
    * call read('../../municipal-services/pretests/fireNocPretest.feature@searchFireNocAuthorizedError')
    * match fireNocResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @Search_empty_04 @positive @regression @municipalService @fireNocService @fireNocServiceSearch
    Scenario: Verify searching for a firenoc service with invalid firestation
    * def firestationId = randomString(8)
    * def getFireNocSearchParam = {"firestationId": firestationId}
    * call read('../../municipal-services/pretests/fireNocPretest.feature@searchFireNocSuccessfully')
    * match fireNocResponseBody.FireNOCs[0] == '#notpresent'

    @search_InvalidMob_05 @negative @regression @municipalService @fireNocService @fireNocServiceSearch
    Scenario: Verify searching for a firenoc service with invalid mobile number
    * def mobileNumber = randomMobileNumGen(8)
    * def getFireNocSearchParam = {"mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/fireNocPretest.feature@searchFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidMObileNo

    @updateNoc_01 @positive  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    * def fireNocBody = fireNocResponseBody.FireNOCs[0]
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocSuccessfully')
    * match fireNocResponseBody.FireNOCs[0].id == "#present"
    * match fireNocResponseBody.FireNOCs[0].fireNOCDetails.applicationNumber == "#present"
    * match fireNocResponseBody.FireNOCs[0].tenantId == tenantId

    @update_Invalid_noBuildings_02 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid building type
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.fireNOCType = randomString(10)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.billingSlabError
    
    @update_Invalid_UsageType_03 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid usage type
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.buildings[0].usageType = randomString(10)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidUsageType

    @update_Invalid_uom_04 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid UOM values
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.buildings[0].uoms[0].code = randomString(10)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidUomCode

    @update_Invalid_active_05 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid active and isActiveUom
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.buildings[0].uoms[0].isActiveUom = commonConstants.invalidParameters.nullValue
    * set fireNocBody.fireNOCDetails.buildings[0].uoms[0].active = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidUomActive

    @update_Invalid_mob_06 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid mobile number
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.applicantDetails.owners[0].mobileNumber = '23456789'
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidMobileNumber

    @update_null_values_07 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid relationship
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.applicantDetails.owners[0].relationship = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.relationShipError
    * match fireNocResponseBody.Errors[1].message == fireNocConstants.errorMessages.invalidBuildType

    @update_action_error_08 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid action
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    * def applicationNo = fireNocResponseBody.FireNOCs[0].fireNOCDetails.applicationNumber
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.action = fireNocConstants.actions.approve
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidAction + ': ' + applicationNo

    @update_Invalid_tenant_09 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid tanentID
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.tenantId = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocUnAuthError')
    * match fireNocResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @update_Invalid_action_10 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid action
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.action = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidBuildType

    @update_invalid_FirestnID_11 @negative  @regression @municipalService @fireNocService @fireNocServiceUpdate
    Scenario: Update FireNoc service with invalid action
    * call read('../../municipal-services/pretests/fireNocPretest.feature@createFireNocSuccessfully')
    # Initializing search query params
    * set fireNocBody.fireNOCDetails.firestationId = randomString(8)
    * call read('../../municipal-services/pretests/fireNocPretest.feature@updateFireNocError')
    * match fireNocResponseBody.Errors[0].message == fireNocConstants.errorMessages.invalidFirestation