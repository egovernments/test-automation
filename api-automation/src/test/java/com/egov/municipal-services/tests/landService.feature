Feature: Land Services Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def landServiceConstants = read('../../municipal-services/constants/landServices.yaml')
    * def tenantId = tenantId
    * def city = tenantId.split(".")[0]
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def mobileNumber = '66' + randomMobileNumGen(8)
    * def fatherOrHusbandName = randomString(10)
    * def name = 'AUTO_OWNER_' + randomString(8)
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def correspondenceAddress = randomString(50)
    * def ownershipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code +"."+mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def UsageCategory = landServiceConstants.parameters.usageCategory
    * def status = landServiceConstants.parameters.activeStatus
    * def doorNo = randomMobileNumGen(3)
    * def plotNo = randomMobileNumGen(2) + '/' + randomMobileNumGen(2)
    * def landmark = 'AUTO_LandMark_' + randomString(8)
    * def country = landServiceConstants.parameters.country
    * def buildingName = randomString(4) + '_AUTO_Apartments'
    * def street = randomString(8)
    * def emailId = randomString(10) + '@' + randomString(5) + '.com'
    * def permanentAddress = correspondenceAddress
    * def type = landServiceConstants.parameters.type
    * def source = commonConstants.parameters.source
    * def channel = landServiceConstants.parameters.channel
    * def unitType = landServiceConstants.parameters.unitType
    * def floorNo = landServiceConstants.parameters.floorNo

#Create Land Service TestCases
@land_create_01 @positive @regression @landService
Scenario: Verify creating land through API call
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * match landResponseBody.LandInfo[0].status == status
    * match landResponseBody.LandInfo[0] == '#present'

@land_create_InValidTenant_02 @negative @regression @landService
Scenario: Verify creating land through API call by passing an invalid tenant id and check for errors
    * def tenantId = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandErrorUnAuthorized')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@land_create_InValidOwnership_03 @negative @regression @landService
Scenario: Verify creating land through API call by passing an invalid ownership category and check for errors
    * def ownershipCategory = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandError')
    * match landResponseBody.Errors[0].message == "The OwnerShipCategory '" + ownershipCategory +"' does not exists"

@land_create_NullLocality_04 @negative @regression @landService
Scenario: Verify creating land through API call by passing null "code" and check for errors
    * def localityCode = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandError')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@land_create_InvalidGender_05 @negative @regression @landService
Scenario: Verify creating land through API call by passing null/invalid  "gender" and check for errors
    * def gender = randomString(5)
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandError')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@land_create_InvalidMobile_06 @negative @regression @landService
Scenario: Verify creating land through API call by passing null/invalid "mobile number" and check for erros
    * def mobileNumber = randomString(5)
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandError')
    * match landResponseBody.Errors[0].code == landServiceConstants.errorMessages.invalidMobileNumber

#Update Land Service TestCases
@land_update_01 @positive @regression @landService
Scenario: Verify updating land info through API call for a given land info id 
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def name = 'AUTO_UPDATED_OWNER_' + randomString(4)
    * call read('../../municipal-services/pretests/landServicesPretest.feature@updateLandSuccessfully')
    * match landResponseBody.LandInfo[0].owners[0].name == name

@land_update_InValidTenant_02 @negative @regression @landService
Scenario: Verify updating land info through API call by passing an invalid tenant id and check for errors
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def tenantId = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/landServicesPretest.feature@updateLandErrorUnAuthorized')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@land_update_InValidOwnership_03 @negative @regression @landService
Scenario: Verify updating land  info through API call by passing an invalid ownership category and check for errors
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def ownershipCategory = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/landServicesPretest.feature@updateLandError')
    * match landResponseBody.Errors[0].message == "The OwnerShipCategory '" + ownershipCategory +"' does not exists"

@land_update_InvalidMobile_04 @negative @regression @landService
Scenario: Verify updating land info through API call by passing null/invalid "mobile number" and check for errors
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def mobileNumber = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/landServicesPretest.feature@updateLandError')
    * match landResponseBody.Errors[0].code == landServiceConstants.errorMessages.invalidMobileNumber

@land_update_nullid_05 @negative @regression @landService
Scenario: Verify updating land info through API call by passing null  id and check for errors
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/landServicesPretest.feature@updateLandError')
    * match landResponseBody.Errors[0].message == landServiceConstants.errorMessages.idError

@land_update_gender_06 @negative @regression @landService
Scenario: Verify updating land through API call by passing null/invalid "gender" and check for erros
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def gender = randomString(5)
    * call read('../../municipal-services/pretests/landServicesPretest.feature@updateLandError')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

#Search Land Service TestCases
@land_search_01 @positive @regression @landService
Scenario: Verify searching for a land application 
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(id)'}
    * call read('../../municipal-services/pretests/landServicesPretest.feature@searchLandSuccessfully')
    * match landResponseBody.LandInfo[0] == '#present'
    * match landResponseBody.LandInfo[0].id == id

@land_search_InValidTenant_02 @negative @regression @landService
Scenario: Verify searching for a Land application by passing invalid/non existant value for tenant
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def tenantId = commonConstants.invalidParameters.invalidValue
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(id)'}
    * call read('../../municipal-services/pretests/landServicesPretest.feature@searchLandErrorUnAuthorized')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@land_search_NoTenantiId_03 @negative @regression @landService
Scenario: Verify searching for a bpa application by not passing tenant id
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * def id = landResponseBody.LandInfo[0].id
    * def tenantId = commonConstants.invalidParameters.nullValue
    * def searchParam = {"tenantId": '#(tenantId)',"ids": '#(id)'}
    * call read('../../municipal-services/pretests/landServicesPretest.feature@searchLandError')
    * match landResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

