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
    
@createFsmAsCitizen @fsmEndToEnd @e2eServices @e2eServices
Scenario: Login as a citizen
    # Steps to login as Citizen and Create a FSM
    * def authToken = citizenAuthToken
    # searching locations
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_search_location_01')
    # creating FSM using Citizen
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * Thread.sleep(5000)
    # creating No Slum for FSM
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_NoSLum_01')
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
    * call read('../../municipal-services/tests/fsmServiceEndToEndFlow.feature@fsm_billing_slab_calculate_1')
    # update FSM --> update the workflow to SUBMIT
    * set fsmbody.workflow.action = "SUBMIT"
    * call read('../../municipal-services/tests/fsmService.feature@fsm_update_without_creation')
    # need to create FSM Calculator Estimate api
    *  call read('../../municipal-services/tests/fsmService.feature@fsm_billing_slab_estimate_1') 
    # need to create FSM Calculator Demand Create
    *  call read('../../municipal-services/tests/fsmService.feature@fsm_billing_slab_calculate_1') 


@createFsmAsCitizen @fsmEndToEnd @e2eServices
Scenario: Login as a citizen and create FSM
    # Steps to login as Citizen and Create a FSM
    * def authToken = citizenAuthToken
    # searching locations
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_search_location_01')
    # creating FSM using Citizen
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * Thread.sleep(15000)
    # creating No Slum for FSM
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_NoSLum_01')
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
    * call read('../../municipal-services/tests/fsmServiceEndToEndFlow.feature@fsm_billing_slab_calculate_1')
    # update FSM --> update the workflow to SUBMIT
    * set fsmbody.workflow.action = "SUBMIT"
    * call read('../../municipal-services/tests/fsmService.feature@fsm_update_without_creation')
    # need to create FSM Calculator Estimate api
    *  call read('../../municipal-services/tests/fsmService.feature@fsm_billing_slab_estimate_1') 
    # need to create FSM Calculator Demand Create
    *  call read('../../municipal-services/tests/fsmService.feature@fsm_billing_slab_calculate_1') 
    # login as citizen
    * def authToken = citizenAuthToken
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@fsm_search_01')
    # verify the bill details through API call
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Verify PG services API Call
    * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
    # Verify Billing Service Demand Search
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@searchDemand')
    # Verify PDF Service Create
    * def pdfCreatePayload = read('../../core-services/requestPayload/pdfService/pdfCreate.json')
    # Verify FSM Search
    * call read('../../municipal-services/tests/fsmService.feature@fsm_search_01')
    # Assign Vehicle
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/tests/fsmService.feature@vendor_Search_01')

@DisposeWaste @fsmEndToEnd @e2eServices
Scenario: Login as FSPTO and dispose waste
    # Steps to login as Citizen and Create a FSM
    # searching locations
    * def getFsmSearchParam = { tenantId: '#(tenantId)'}
  * call read('../../municipal-services/pretests/fsmServicesPretest.feature@createFsmSuccessfully')
    * def getFsmVendorSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vendorSearchFsmSuccessfully')
    * def getFsmVehicalSearchParam = {"tenantId": '#(tenantId)',"type": '#(vehicalType)'}
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalSearchFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripCreateFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@vehicalTripUpdateFsmSuccessfully')
    * call read('../../municipal-services/pretests/fsmServicesPretest.feature@SearchFsmSuccessfully')
    