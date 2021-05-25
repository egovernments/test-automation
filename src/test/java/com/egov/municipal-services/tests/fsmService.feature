Feature: Fire NOC Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(10000)
    * def propertyType = mdmsStateFsmService.PropertyType[1].code
    * def vehicalType = mdmsStateFsmService.VehicleType[2].code
    * def noOfTrips = mdmsStateFsmService.Config[0].default
    * def source = mdmsStateFsmService.ApplicationChannel[2].code
    * def tenantId = mdmsStatetenant.tenants[3].code
    * def vendorTenantId = tenantId
    * def tenantName = mdmsStatetenant.tenants[3].name
    * def sanitationtype = mdmsStateFsmService.PitType[1].code
    * def fsmConstants = read('../../municipal-services/constants/fsmService.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def localityName = searchLocationResponseBody.TenantBoundary[0].boundary[0].name
    * def localityType = searchLocationResponseBody.TenantBoundary[0].boundary[0].label
    * def boundaryNum = searchLocationResponseBody.TenantBoundary[0].boundary[0].boundaryNum
    * def mobileNumber = '77' + randomMobileNumGen(8)
    * def whatsup = "WhatsApp"
    * def regNumber = "PB 09 PA "
    * def name = 'AUTO_' + randomString(10)
    * def driverName = 'AUTO' + randomString(10)
    * def drName = 'AUTOFATHER' + randomString(10)
    * def pitDetails = randomMobileNumGen(1)
    * def trip = 2220
    * def businessService = "FSM"

    @fsm_create_01 @positive @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API 
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * match fsmResponseBody.fsm[0].id == '#present'
    * match fsmResponseBody.fsm[0].applicationNo == '#present'

    @fsm_create_InvalidMob_02 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid mobile number 
    * def mobileNumber = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidMobileNo

    @fsm_create_InvalidProperty_03 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid property
    * def propertyType = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidProperity

    @fsm_create_InvalidVehicle_04 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid vehicle Type
    * def vehicalType = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidVehicleType

    @fsm_create_InvalidSource_05 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid source
    * def source = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidSource

    @fsm_create_InvalidTenant_06 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid tenant
    * def tenantId = randomMobileNumGen(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidTenant

    @fsm_create_InvalidLocalityCode_07 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid Locality Code
    * def localityCode = randomMobileNumGen(5)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidLocalityCode

    @fsm_create_InvalidnoOfTrips_08 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid Number of Trips
    * def noOfTrips = randomString(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidNoofTrips

    @fsm_create_InvalidPitValues_09 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid Number of pit values
    * def pitDetails = randomString(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidNoofTrips

    @fsm_create_InvalidSanitationType_10 @negative @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service application through API with invalid Number of SanitationType
    * def sanitationtype = randomString(10)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidSanitationType

    @fsm_update_01 @positive @regression @municipalService @fsmService @fsmServiceUpdate
    Scenario: Verify updating a fsm service application through API
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@updateFsmSuccessfully')
    * match fsmResponseBody.fsm[0].id == '#present'
    * match fsmResponseBody.fsm[0].applicationNo == '#present'

    @fsm_update_invalid_app_status_02 @negative @regression @municipalService @fsmService @fsmServiceUpdate
    Scenario: Verify updating a fsm service application through API with invalid status
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * set fsmBody.fsm[0].status = randomString(10)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@updateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidStatus

    @fsm_update_invalid_Sanitation_Type_03 @negative @regression @municipalService @fsmService @fsmServiceUpdate
    Scenario: Verify updating a fsm service application through API with invalid sanitation type
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * set fsmBody.fsm[0].sanitationtype = randomString(10)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@updateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidSanitationType
    
    @fsm_update_invalid_Veh_Type_04 @negative @regression @municipalService @fsmService @fsmServiceUpdate
    Scenario: Verify updating a fsm service application through API with invalid Vehical type
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * set fsmBody.fsm[0].vehicleType = randomString(10)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@updateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidVehicleType

    @fsm_update_invalid_dso_id_05 @negative @regression @municipalService @fsmService @fsmServiceUpdate
    Scenario: Verify updating a fsm service application through API with invalid DSO ID
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * set fsmBody.fsm[0].dsoId = randomString(10)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@updateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidDSO

    @fsm_update_invalid_action_06 @negative @regression @municipalService @fsmService @fsmServiceUpdate
    Scenario: Verify updating a fsm service application through API with invalid Action
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * set fsmBody.fsm[0].dsoId = randomString(10)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@updateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidAction+applicationNo

    @fsm_search_01 @positive @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service
    * def getFsmSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmSuccessfully')
    * match fsmResponseBody.fsm[0] == '#present'

    @fsm_searchInvalidTenant_02 @negative @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service with invalid TenantID
    * def tenantId = randomString(10)
    * def getFsmSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmError')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @fsm_search_no_tenant_03 @negative @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service without tenantID
    * def getFsmSearchParam = {"mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmError1')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.noTenanteID

    @fsm_search_Invalid_Mobile_04 @negative @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service with invalid Mobile Number
    * def mobileNumber = randomString(10)
    * def getFsmSearchParam = {"tenantId": '#(tenantId)',"mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmError1')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidMobileNo

    @fsm_search_Invalid_App_Status_05 @negative @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service with invalid application tatus
    * def applicationStatus = randomString(10)
    * def getFsmSearchParam = {"tenantId": '#(tenantId)',"applicationStatus": '#(applicationStatus)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmSuccessfully')
    * match fsmResponseBody.fsm[0] == '#notpresent'

    @fsm_search_Multiple_App_No_06 @negative @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service with multiple application number
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def applicationStatus = randomString(10)
    * def getFsmSearchParam = {"tenantId": '#(tenantId)',"applicationNos": '#(applicatonNum,applicationStatus)'}
    * print "FSM Param ::: "+getFsmSearchParam
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmSuccessfully')
    * match fsmResponseBody.fsm[0] == '#notpresent'

    @fsm_search_null_dates_07 @negative @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service with invalid FormDate
    * def fromDate = "null"
    * def getFsmSearchParam = {"tenantId": '#(tenantId)',"fromDate": '#(fromDate)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@searchFsmError1')
    * match fsmResponseBody.Errors[0].code == fsmConstants.errorMessages.invalidFromDate

    @audit_01 @positive @regression @municipalService @fsmService @fsmServiceAudit
    Scenario: Verify Audit for a fsm service
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmAuditParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@auditFsmSuccessfully')
    * match fsmResponseBody.fsm[0] == '#notpresent'

    @audit_No_Application_02 @negative @regression @municipalService @fsmService @fsmServiceAudit
    Scenario: Verify Audit for a fsm service without passing application no
    * def getFsmAuditParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@auditFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.noApplicationNo

    @audit_No_Tenant_03 @negative @regression @municipalService @fsmService @fsmServiceAudit
    Scenario: Verify Audit for a fsm service without passing TenantID
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmAuditParam = {"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@auditFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.noTenantId

    @audit_Invalid_TenantID_04 @negative @regression @municipalService @fsmService @fsmServiceAudit
    Scenario: Verify Audit for a fsm service without passing TenantID
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def tenantId = randomString(10)
    * def getFsmAuditParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@auditFsmError1')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @audit_Invalid_App_No_05 @negative @regression @municipalService @fsmService @fsmServiceAudit
    Scenario: Verify Audit for a fsm service without passing TenantID
    * def applicationNo = randomString(10)
    * def getFsmAuditParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@auditFsmSuccessfully')
    * match fsmResponseBody.fsm[0] == '#notpresent'

    @vendor_create_01 @positive @regression @municipalService @fsmService @fsmServiceVendorCreate
    Scenario: Verify vendor creation for a fsm service
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorCreateFsmSuccessfully')
    * match fsmResponseBody.vendor[0] == '#present'

    @vendor_create_Invalid_Mobile_02 @positive @regression @municipalService @fsmService @fsmServiceVendorCreate
    Scenario: Verify vendor creation for a fsm service with invalid mobile no
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def mobileNumber = mobileNumber+randomString(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.wrongMobileNo

    @vendor_create_Invalid_Vendor_Tenant_03 @positive @regression @municipalService @fsmService @fsmServiceVendorCreate
    Scenario: Verify vendor creation for a fsm service with invalid tenant id
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def vendorTenantId = commonConstants.invalidParameters.wrongTenantId
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidLocalityCode
    
    @vendor_Search_01 @positive @regression @municipalService @fsmService @fsmServiceVendorSearch
    Scenario: Verify Vendor Search for a fsm service
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * match fsmResponseBody.vendor[0] == '#present'

    @vendor_Search_No_tenant_02 @negative @regression @municipalService @fsmService @fsmServiceVendorSearch
    Scenario: Verify Vendor Search for a fsm service without tenantID
    * def getFsmVendorSearchParam = {"mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.noTenantId

    @vendor_Search_Invalid_Mob_03 @negative @regression @municipalService @fsmService @fsmServiceVendorSearch
    Scenario: Verify Vendor Search for a fsm service with invalid Mobile number
    * def mobileNumber = randomMobileNumGen(8)
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)',"mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidMobileNo

    @vehicle_create_01 @positive @regression @municipalService @fsmService @fsmServiceVehicalCreate
    Scenario: Verify vehical create for a fsm service
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def registrationNumber = regNumber+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalCreateFsmSuccessfully')
    * match fsmResponseBody.vehicle[0] == '#present'

    @vehicle_create_Dup_Reg_02 @negative @regression @municipalService @fsmService @fsmServiceVehicalCreate
    Scenario: Verify vehical create for a fsm service
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidRegistration

    @vehicle_create_invalid_type_03 @negative @regression @municipalService @fsmService @fsmServiceVehicalCreate
    Scenario: Verify vehical create for a fsm service with invalid vehical type
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def registrationNumber = regNumber+randomMobileNumGen(4)
    * def type = randomString(8)+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.wrongVehical

    @vehicle_create_invalid_suction_04 @negative @regression @municipalService @fsmService @fsmServiceVehicalCreate
    Scenario: Verify vehical create for a fsm service with invalid vehical type
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def registrationNumber = regNumber+randomMobileNumGen(4)
    * def suctionType = randomString(8)+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidSuctionType

    @vehicle_create_access_05 @negative @regression @municipalService @fsmService @fsmServiceVehicalCreate
    Scenario: Verify vehical create for a fsm service with invalid Access Token

    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def registrationNumber = regNumber+randomMobileNumGen(4)
    * def authToken = regNumber+randomMobileNumGen(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalCreateFsmError1')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @vehicle_create_reg_mandatory_06 @negative @regression @municipalService @fsmService @fsmServiceVehicalCreate
    Scenario: Verify vehical create for a fsm service without Registration Number
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalCreateFsmError2'){'removeFieldPath': '$.vehicle[0].registrationNumber'}
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.withOutRegistration

    @vehicle_search_01 @positive @regression @municipalService @fsmService @fsmServiceVehicalSearch
    Scenario: Verify vehical Search for a fsm service
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * match fsmResponseBody.vehicle[0] == '#present'

    @vehicle_search_No_params_02 @negative @regression @municipalService @fsmService @fsmServiceVehicalSearch
    Scenario: Verify vehical Search for a fsm service with no params
    * def getFsmVehicalSearchParam = {}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.noParams

    @vehicle_search_only_tenant_03 @negative @regression @municipalService @fsmService @fsmServiceVehicalSearch
    Scenario: Verify vehical Search for a fsm service with only tenantID
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.onlyTenantId

    @vehicle_search_no_tenant_04 @negative @regression @municipalService @fsmService @fsmServiceVehicalSearch
    Scenario: Verify vehical Search for a fsm service without tenantID
    * def getFsmVehicalSearchParam = {"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.noTenantId

    @vehicle_search_Invalid_reg_05 @negative @regression @municipalService @fsmService @fsmServiceVehicalSearch
    Scenario: Verify vehical Search for a fsm service with invalid registration Number
    * def registrationNumber = randomMobileNumGen(8)
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)', "registrationNumber": '#(registrationNumber)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * match fsmResponseBody.vehicle[0] == '#notpresent'

    @vehicle_search_Invalid_tenant_06 @negative @regression @municipalService @fsmService @fsmServiceVehicalSearch
    Scenario: Verify vehical Search for a fsm service with invalid tenantID
    * def tenantId = randomMobileNumGen(8)
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)', "type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmError1')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @trip_search_01 @positive @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#present'

    @trip_search_No_Access_02 @positive @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid access token
    * def authToken = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmError')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @trip_search_Invalid_Veh_id_03 @negative @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid vehical id
    * def vehicleId = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)',"vehicleIds": '#(vehicleId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#notpresent'

    @trip_search_Invalid_businessService_04 @negative @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid Business Service
    * def businessService = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)',"businessService": '#(businessService)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#notpresent'

    @trip_search_Invalid_refno_05 @negative @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid refrence Number
    * def refernceNos = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)',"refernceNos": '#(refernceNos)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#notpresent'

    @trip_search_Invalid_app_no_06 @negative @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid Application Number
    * def applicationNos = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)',"applicationNos": '#(applicationNos)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#notpresent'

    @trip_search_Invalid_SortBy_07 @negative @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid Sort Order
    * def sortBy = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)',"sortBy": '#(sortBy)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmError1')
    * match fsmResponseBody.Errors[0].code == fsmConstants.errorMessages.invalidSort

    @trip_search_Invalid_SortOrder_08 @negative @regression @municipalService @fsmService @fsmServiceTripSearch
    Scenario: Verify vehical Trip Search for a fsm service with invalid Sort Order
    * def sortOrder = randomString(8)+randomNumber(4)
    * def getFsmTripSearchParam = {"tenantId": '#(tenantId)',"sortOrder": '#(sortOrder)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripSearchFsmError1')
    * match fsmResponseBody.Errors[0].code == fsmConstants.errorMessages.invalidSortedOrder

    @trip_Create_01 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#present'

    @trip_Create_Invalid_Veh_02 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service with invalid vehecal
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def vehicalId = randomString(8)+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidVehicalId+vehicalId

    @Trip_Create_No_Access_03 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service with wrong access token
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def authToken = randomString(8)+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmError1')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @trip_Create_Veh_Id_04 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service without vehical id
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmError2'){'removeFieldPath': '$.vehicle[0].id'}
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.withoutVehicalId

    @trip_Create_Invalid_Tank_05 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service with invalid tank capacity
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def tankCapacity = randomString(8)+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidNoofTrips

    @trip_Create_No_Ref_06 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service with invalid reference number
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def applicationNo = randomString(8)+randomNumber(4)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidTankCapacity

    @trip_Create_No_Ref_status_07 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripCreate
    Scenario: Verify vehical trip create for a fsm service with invalid ref status
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * def fsmStatus = randomString(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidRefStatus

    @trip_Update_01 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripUpdate
    Scenario: Verify vehical trip update for a fsm service
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripUpdateFsmSuccessfully')
    * match fsmResponseBody.vehicleTrip[0] == '#present'

    @trip_Update_No_Access_02 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripUpdate
    Scenario: Verify vehical trip update for a fsm service with invalid access token
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmSuccessfully')
    * def authToken = randomString(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripUpdateFsmError1')
    * match fsmResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @trip_Update_Invalid_VehicleId_03 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripUpdate
    Scenario: Verify vehical trip update for a fsm service with invalid vehical id
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmSuccessfully')
    * set fsmResponseBody.vehicleTrip[0].vehicle.id = randomString(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripUpdateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidVehicalId+fsmResponseBody.vehicleTrip[0].id
    @trip_Update_Veh_Trip_Err_04 @positive @regression @municipalService @fsmService @fsmServiceVehicalTripUpdate
    Scenario: Verify vehical trip update for a fsm service with invalid vehical trip
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmSuccessfully')
    * set fsmResponseBody.vehicleTrip[0].tripDetails[0].id = randomString(8)
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripUpdateFsmError')
    * match fsmResponseBody.Errors[0].message == fsmConstants.errorMessages.invalidTripId

    @fsm_search_location_01 @positive @regression @municipalService @fsmService @fsmServiceSearch
    Scenario: Verify searching for a fsm service
    * def getFsmSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@locationSearchFsmSuccessfully')
    * match fsmResponseBody.TenantBoundary[0] == '#present'

    @fsm_create_NoSLum_01 @positive @regression @municipalService @fsmService @fsmServiceCreate
    Scenario: Verify creating a fsm service for No SLum application through API 
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmNoSlumSuccessfully')
    * match fsmResponseBody.fsm[0].id == '#present'
    * match fsmResponseBody.fsm[0].applicationNo == '#present'
