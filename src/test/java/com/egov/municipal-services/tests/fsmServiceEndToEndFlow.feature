Feature: FSM Service - End to End Flow

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
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
    * def cash = "CASH"
    * def owner = "OWNER"
    
@createFsmAsCitizen @fsmEndToEnd
Scenario: Login as a citizen
    # Steps to login as Citizen and Create a FSM
    * def authToken = citizenAuthToken
    # searching locations
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_search_location_01')
    # creating FSM using Citizen
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * Thread.sleep(15000)
    # creating No Slum for FSM
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_NoSLum_01')
    # need to check Kafka step


    # login using super suer
    * def authToken = superUserAuthToken
    # step for serching FSM
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_search_01')
    # step to verify vendor Search
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@vendor_Search_01')
    # step to verify vehical Search
    * def getFsmSearchParam = { tenantId: '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/tests/fsmService.feature@vehicle_search_01')
    # step to verify vehical trip Search
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@trip_search_01')
    # need to create FSM Calculator Billing slab api


    # update FSM
    * call read('../../municipal-services/tests/fsmService.feature@fsm_payment_01')
    # need to create FSM Calculator Estimate api

    # need to create FSM Calculator Demand Create

    # need to verify Kafka step

    # login to citizon for payment 
    * def authToken = citizenAuthToken