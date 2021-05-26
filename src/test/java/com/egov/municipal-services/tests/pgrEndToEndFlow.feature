Feature: PGR Service for End to End Flow

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

@createPgrEndTotEndFlow @pgrEndToEndFlow
Scenario: Login as a citizen and files a Complaint
    # Steps to validate error messages of login attempt with invalid mobile number
    * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidMobileNo')
    * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
    * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo
    # Steps to login as Citizen and files Complaint
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/pgr.feature@PGRCreate1')
    * def serviceRequestId = pgrResponseBody.ServiceWrappers[0].service.id
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Assign
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Reject
    # Steps to Login GRO for Assign
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    * def status = pgrResponseBody
    # Steps to Update Complaint
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')

