Feature: PGR Service Create

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Collections = Java.type('java.util.Collections')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # Searching Location for locality and areaCode
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    # initialising request payload variables
    * def source = "web"
    * configure headers = read('classpath:websCommonHeaders.js')
    * def name = randomString(10)
    * def mobileNumber = '78' + randomMobileNumGen(8)
    * def pgrConstants = read('../../municipal-services/constants/pgr.yaml')
   # * def serviceCode = "NonSweepingOfRoad"
    * def serviceCode = msmsCityPgrServiceCodes[0].serviceCode
    * def action = pgrConstants.actions.apply
    * def applicationStatus = pgrConstants.applicationStatus.closedAfterRejection
    * def applicationStatus = 
    * def invalidApplicationStatus = randomString(10)
    * def stateName = mdmsStatecommonMasters.StateInfo[0].name
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * def cityName = karate.jsonPath(mdmsStatetenant, "$.tenants[?(@.code=='" + tenantId + "')].name")[0]
    # Searching Location for locality and areaCode
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(5000)
@PGRCreate1 @createPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Create PGR With Valid Data
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    # Validate response body
    * match pgrResponseBody.ServiceWrappers[0].service.id == "#present"
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == "#present"
    * match pgrResponseBody.ServiceWrappers[0].service.applicationStatus == "PENDINGFORASSIGNMENT"
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == tenantId

@PGRCreate2 @createPGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Create PGR With Invalid Service
    # Create a property
    * def serviceCode = randomString(10)
    * call read('../../municipal-services/pretests/pgrPretest.feature@failCreatePGRRequest')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invaliServiceCode
    * match pgrResponseBody.Errors[0].message ==replaceString(pgrConstants.errors.errorMessages.invaliServiceCode,"<<service_code>>",serviceCode)
@PGRCreate3 @createPGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Create PGR With Invalid TenantId
    # Create a property
    * def tenantId = randomString(10)
    * call read('../../municipal-services/pretests/pgrPretest.feature@failCreatePGRRequestUnAuthorized')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidTenantId
    * match pgrResponseBody.Errors[0].message ==pgrConstants.errors.errorMessages.invalidTenantId

@PGRCreate4 @createPGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Create PGR With Invalid Action
    # Create a property
    * def action = randomString(10)
    * call read('../../municipal-services/pretests/pgrPretest.feature@failCreatePGRRequest')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidAction
    * match pgrResponseBody.Errors[0].message contains replaceString(pgrConstants.errors.errorMessages.invalidAction,"<<action_name>>",action)

@PGRCreate5 @createPGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Create PGR With Invalid Action
    # Create a property
    * def action = randomString(10)
    * call read('../../municipal-services/pretests/pgrPretest.feature@failCreatePGRRequest')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidAction
    * match pgrResponseBody.Errors[0].message contains replaceString(pgrConstants.errors.errorMessages.invalidAction,"<<action_name>>",action)

@PGRUpdate1 @updatePGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Update PGR With Valid Data
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)', serviceRequestId:'#(serviceRequestId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    * def action = "COMMENT"
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullyUpdatePGRRequest')
    # Validate response body
    * match pgrResponseBody.ServiceWrappers[0].service.id == "#present"
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == "#present"
    * match pgrResponseBody.ServiceWrappers[0].service.applicationStatus == "PENDINGFORASSIGNMENT"
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == tenantId

@PGRUpdate2 @updatePGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Update PGR With Invalid Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
     * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    * set serviceDetails.id = randomString(10)
    * call read('../../municipal-services/pretests/pgrPretest.feature@failUpdatePGRRequest')
    # Validate response body
    * match pgrResponseBody.Errors[0].message == pgrConstants.errors.errorMessages.invalidId
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidId


@PGRUpdate3 @updatePGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Update PGR With Invalid Service Request Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
     * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    * def invalidServiceRequestId = randomString(10)
    * set serviceDetails.serviceRequestId = invalidServiceRequestId
    * def action = "COMMENT"
    * call read('../../municipal-services/pretests/pgrPretest.feature@failUpdatePGRRequest')
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidAction
    * match pgrResponseBody.Errors[0].message contains replaceString(pgrConstants.errors.errorMessages.invalidAction,"<<action_name>>",action)

@PGRUpdate4 @updatePGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Update PGR With Invalid Soruce
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
     * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    * def invalidSource = randomString(10)
    * set serviceDetails.source = invalidSource
    * call read('../../municipal-services/pretests/pgrPretest.feature@failUpdatePGRRequest')
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidSource
    * match pgrResponseBody.Errors[0].message == replaceString(pgrConstants.errors.errorMessages.invalidSource,"<<source>>",invalidSource)

@PGRUpdate5 @updatePGR @negative @regression @PGRService @municipalServicesDontRun
Scenario: Update PGR With Invalid Tenant Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
     * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    * def invalidTenantId = randomString(10)
    * set serviceDetails.tenantId = invalidTenantId
    * call read('../../municipal-services/pretests/pgrPretest.feature@failUpdatePGRRequestAuthorized')
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidTenantId
    * match pgrResponseBody.Errors[0].message == pgrConstants.errors.errorMessages.invalidTenantId

@PGRUpdate6 @updatePGR @negative @regression @PGRService @municipalServicesDontRun
Scenario: Update PGR With Invalid Action
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    * def action = randomString(10)
    * call read('../../municipal-services/pretests/pgrPretest.feature@failUpdatePGRRequest')
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidAction
    * match pgrResponseBody.Errors[0].message contains replaceString(pgrConstants.errors.errorMessages.invalidAction,"<<action_name>>",action)

@PGRSearch1 @searchPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Search PGR With Valid Data - Mobile number and Tenant Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
   # * def searchPGRParams ={ tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    # Validate response body
    * match pgrResponseBody.ServiceWrappers[0].service.id == "#present"
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == tenantId
   # * match pgrResponseBody.ServiceWrappers[0].applicationStatus == pgrConstants.applicationStatus.pendingForAssignment
    * match pgrResponseBody.ServiceWrappers[0].service.accountId == "#present"


@PGRSearch2 @searchPGR  @negative @regression @PGRService @municipalServicesDontRun
Scenario: Search PGR With No Tenant Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    #* def searchPGRParams = {mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * def searchPGRParams = {mobileNumber: '#(mobileNumber)', serviceRequestId:'#(serviceRequestId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@errorSearchPGRRequestwithInvalidTenantId')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidTenantSearch
    * match pgrResponseBody.Errors[0].message == pgrConstants.errors.errorMessages.blankTenantId

    
@PGRSearch3 @searchPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Search PGR With all Records
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    #* def searchPGRParams = {mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * def searchPGRParams = {tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    # Validate response body
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == tenantId
    * match pgrResponseBody.ServiceWrappers[0].service.applicationStatus == pgrConstants.applicationStatus.pendingForAssignment
    * match pgrResponseBody.ServiceWrappers[0].service.accountId == "#present"

@PGRSearch4 @searchPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Search PGR With all Records
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    #* def searchPGRParams = {mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * def searchPGRParams = {tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    # Validate response body
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == tenantId
    #* match pgrResponseBody.ServiceWrappers[0].applicationStatus == pgrConstants.applicationStatus.pendingForAssignment
    * match pgrResponseBody.ServiceWrappers[0].service.accountId == "#present"



@PGRSearch5 @searchPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Search PGR With valid data -  - Mobile number, Tenant Id and Request Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def searchPGRParams = {tenantId: '#(tenantId)',mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullySearchPGRRequest')
    # Validate response body
    * match pgrResponseBody.ServiceWrappers[0].service.tenantId == tenantId
    #* match pgrResponseBody.ServiceWrappers[0].applicationStatus == pgrConstants.applicationStatus.pendingForAssignment
    * match pgrResponseBody.ServiceWrappers[0].service.accountId == "#present"

@PGRSearch6 @searchPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Search PGR With invalid mobile number
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def invalidMobileNumber = randomString(9)
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(invalidMobileNumber)'    , serviceRequestId: '#(invalidServiceRequestId)' }
    * call read('../../municipal-services/pretests/pgrPretest.feature@errorSearchPGRRequestwithInvalidTenantId')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidMobileNumber
    * match pgrResponseBody.Errors[0].message == pgrConstants.errors.errorMessages.invalidMobileNumber


@PGRCount1 @countPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Count PGR With Tenant Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullyCountPGRRequestWithParams')
    # Validate response body
    * match pgrResponseBody.count == "#present"

@PGRCount2 @countPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Count PGR - All
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullyCountPGRRequest')
    # Validate response body
    * match pgrResponseBody.count == "#present"

@PGRCount3 @countPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Count PGR With Invalid Tenant Id
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def invalidTenantId = randomString(2)+"."+randomString(10)
    * def countPGRParams = { tenantId: '#(invalidTenantId)' }
    * call read('../../municipal-services/pretests/pgrPretest.feature@failCountPGRRequest')
    # Validate response body
    * match pgrResponseBody.Errors[0].code == pgrConstants.errors.errorCodes.invalidTenantId
    * match pgrResponseBody.Errors[0].message ==pgrConstants.errors.errorMessages.invalidTenantId

@PGRCount4 @countPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Count PGR With Application Status
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def countPGRParams = { tenantId: '#(tenantId)', applicationStatus:  '#(applicationStatus)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullyCountPGRRequestWithParams')
    # Validate response body
    * match pgrResponseBody.count == "#present"


@PGRCount5 @countPGR  @positive @regression @PGRService @municipalServicesDontRun
Scenario: Count PGR With Invalid Application Status
    # Create a property
    * call read('../../municipal-services/pretests/pgrPretest.feature@successCreatePGRRequest')
    * def countPGRParams = { tenantId: '#(tenantId)', applicationStatus:  '#(invalidApplicationStatus)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@successfullyCountPGRRequestWithParams')
    # Validate response body
    * match pgrResponseBody.count == "#present"


