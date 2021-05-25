Feature: BPA Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def transactionNumber = randomString(20)
    * def applicantName = 'AUTO_NAME_' + ranInteger(10)
    * def appliactionType = mdmsStateBPA.ApplicationType[0].code
    * def applicationSubType = mdmsStateBPA.ServiceType[0].code
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@scrunity')
    * def bpaConstants = read('../../municipal-services/constants/bpaServices.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def mobileNumber = '77' + randomMobileNumGen(8)
    * def fatherOrHusbandName = randomString(10)
    * def name = 'AUTO_' + randomString(10)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def dob = getPastEpochDate(5000)
    * def correspondenceAddress = randomString(50)
    * def ownershipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code +"."+mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def floorNo = bpaConstants.parameters.florNo
    * def unitType = bpaConstants.parameters.unitType
    * def riskType = mdmsStateBPA.RiskTypeComputation[2].riskType
    * def occupancyType = mdmsStateBPA.OccupancyType[0].code
    * def action = bpaConstants.actions.initiate
    * def status = bpaConstants.status.initiate
    * def action2 = bpaConstants.actions.sendToCitizen
    * def documentType1 = bpaConstants.documentType.type1
    * def documentType2 = bpaConstants.documentType.type2
    * def documentType3 = bpaConstants.documentType.type3
    * def documentType4 = bpaConstants.documentType.type4
    * def documentType5 = bpaConstants.documentType.type5
    

@bpa_create_01 @positive @regression @bpaService
Scenario: Verify creating a bpa application through API 
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * match bpaResponseBody.BPA[0].status == bpaConstants.status.initiate
    * print bpaResponseBody

@bpa_create_duplicate_02 @negative @regression @bpaService
Scenario: Verify creating a bpa application through API  with the same edcr number
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def transactionNumber = randomString(20)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError')
    * match bpaResponseBody.Errors[0].code == bpaConstants.errorMessages.duplicateCode
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.duplicateEDCR + edcrNumber

@bpa_create_Invalid_tenant_03 @negative @regression @bpaService
Scenario: Verify creating a bpa through API call by passing an invalid tenant id and check for errors
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@bpa_create_NoParams_04 @positive @regression @bpaService
Scenario: Verify creating a bpa through API call by not passing the following params
    * def mobileNumber = commonConstants.invalidParameters.nullValue
    * def fatherOrHusbandName = commonConstants.invalidParameters.nullValue
    * def gender = commonConstants.invalidParameters.nullValue
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError')
    * match bpaResponseBody.Errors[*].message contains commonConstants.errorMessages.nullParameterError

@bpa_create_Invalid_edcr_05 @positive @regression @bpaService
Scenario: Verify creating bpa through API call by passing an invalid / non existant EDCR number and check for r
    * def edcrNumber = randomMobileNumGen(6)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.invalidEDCR

@bpa_create_Invalid_risktype_06 @positive @regression @bpaService
Scenario: Verify by not passing any value for risk type and check for errors
    * def riskType = ''
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.riskTypeSizeError
 
@bpa_create_Invalid_WF_Action_07 @positive @regression @bpaService
Scenario: Verify creating bpa through API call by not passing any value for action under workflow and check for r
    * def action = ''
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.riskTypeSizeError

@bpa_search_01 @positive @regression @bpaService
Scenario: Verify searching for a bpa application 
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * match bpaResponseBody.BPA[0] == '#present'

@bpa_search_empty_02 @positive @regression @bpaService
Scenario: Verify searching for a bpa application by passing invalid/non existant value 
    * def applicationNo = ''
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * match bpaResponseBody.BPA[0] == '#notpresent'

@bpa_search_InValidTenant_03 @positive @regression @bpaService
Scenario: Verify searching for a bpa application by passing invalid/non existant value for tenant
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPAUnauthorizedError')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@bpa_search_NullDate_04 @positive @regression @bpaService
Scenario: Verify searching for a bpa application by passing null for dates
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPAError')
    * match bpaResponseBody.Errors[0].code == bpaConstants.errorMessages.mismatchError

@bpa_update_01 @positive @regression @bpaService
Scenario: Verify updating a BPA application through API Call
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen')
    * match bpaResponseBody.BPA[0].status == 'CITIZEN_APPROVAL_INPROCESS'

@bpa_update_02 @negative @regression @bpaService
Scenario: Verify updating a BPA application through API Call when the user doesn't have the permission
    
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAError2')
    * match bpaResponseBody.Errors[0].code == bpaConstants.errorMessages.invalidUserError
    
@bpa_update_03 @negative @regression @bpaService
Scenario: Verify updating a BPA application through API Call with an invalid action
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = 'invalid'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.invalidAction

@bpa_update_04 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an null tenant id and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def tenantId = null
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@bpa_update_05 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid tenant id and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.tenantError

@bpa_update_06 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid Busines Service and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def businessService = ''
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.riskTypeSizeError

@bpa_update_07 @negative @regression @bpaService
Scenario: "Verify updating bpa through API call by passing an invalid / non existant application number and check for errors
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def appNo = applicationNo
    * def applicationNo = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.applicationError + appNo + ' and from update: ' + applicationNo + ' does not match'

@bpa_update_08 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid / non existant EDCR number and check for errors
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def edcrNumber = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.invalidEDCR

@bpa_update_09 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid / non existant status and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def status = randomString(6)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.statusError

@bpa_update_10 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid / non existant bpa id and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def id = randomString(6)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.idError

@bpa_update_11 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by not passing  bpa id parameter and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def id = null
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].code == bpaConstants.errorMessages.invalidId

@bpa_update_12 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by not passing risk type or status parameters and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def riskType = null
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@bpa_update_13 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by not passing business service parameter and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def businessService = null
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@bpa_update_14 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by not passing any value for action under workflow and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = ''
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.riskTypeSizeError

@bpa_update_15 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid / non existant ownership Category and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def ownershipCategory = null
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.ownershipError

@bpa_update_16 @negative @regression @bpaService
Scenario: Verify updating bpa through API call by passing an invalid / non existant mobile number or gender and check for r
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def mobileNumber = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.ownershipError

@bpa_update_17 @negative @regression @bpaService
Scenario: verify by not passing "gender" in the request body
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    * def action = action2
    * def gender = null
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen_Invalid')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError
