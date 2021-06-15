Feature: Sewerage connection service tests


Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def billingServiceDemandConstants = read('../../business-services/constants/billing-service-demand.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def sewerageConnectionConstants = read('../../municipal-services/constants/sewerageConnection.yaml')
    * def sewerageCreateRequest = read('../../municipal-services/requestPayload/sewerage-connection/create.json')
    * def isWater = true
    * def isSewerage = true
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.initiate
    * def proposedWaterClosets = 2
    * def proposedToilets = 5
    * def service = 'Sewerage'
    #* def searchTypeConnection = sewerageConnectionConstants.searchType.connection
    * def validFromDate = "1614709800000"
    * def validToDate = "1615314599000"
    * def roadCuttingInfo = [{"roadType": "BRICKPAVING","roadCuttingArea": 50}]
    #* def sewerageConnectionType = sewerageConnectionConstants.connectionType.nonMetered
    * def sewerageConnectionType = 'Non Metered'
    * def connectionExecutionDate = getCurrentEpochTime()

@sewerageConnectionCreate1 @municipalServicesDontRun @regression @positive @sewerageConnectionCreate @sewerageConnection
    Scenario: Test to create Sewerage Connection with Valid Payload
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    # * print propertyId
    # Steps to create a new Employee through HRMS
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@successSewerageCreate')
    * assert sewerageResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * match sewerageResponseBody.SewerageConnections[0].id == "#present"
    * match sewerageResponseBody.SewerageConnections[0].propertyId == propertyId
    * match sewerageResponseBody.SewerageConnections[0].applicationStatus == sewerageConnectionConstants.parameters.applicationStatus.initiated

@SewerageConnection_UpdateToDOCUMENT_VERIFICATION_01 @positive @regression @swServices @swerageConnectionUpdate @municipalServicesDontRun
Scenario: Update sewerage connection with valid payload
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    # Create Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@successSewerageCreate')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.submitApplication
    # Update Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    # Verify response body
    # * print sewerageResponseBody
    * match sewerageResponseBody.SewerageConnections[0].id == sewerageConnectionId
    * match sewerageResponseBody.SewerageConnections[0].propertyId == propertyId
    * match sewerageResponseBody.SewerageConnections[0].applicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@SewerageConnection_SearchWithValidApplicationNumber_01 @positive @regression @swServices @sewerageConnectionSearch @municipalServicesDontRun
Scenario: Search sewerage connection with valid payload
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    # Create Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@successSewerageCreate')
    # * print sewerageConnectionNumber
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    # Search Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    # Verify response body
    # * print sewerageResponseBody
    * match sewerageResponseBody.SewerageConnections[0].id == sewerageConnectionId
    * match sewerageResponseBody.SewerageConnections[0].propertyId == propertyId
    * match sewerageResponseBody.SewerageConnections[0].applicationStatus == sewerageConnectionConstants.parameters.applicationStatus.initiated

@createActiveSewerageConnection @municipalServicesDontRun
Scenario: Create Active Sewerage connection
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@successSewerageCreate')
    # * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    # * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    # * print sewerageConnection
    * set sewerageConnection.roadCuttingInfo = [{"roadType": "BRICKPAVING","roadCuttingArea": 50}]
    * set sewerageConnection.connectionType = "Metered"
    * set sewerageConnection.additionalDetails.initialMeterReading = 100
    * set sewerageConnection.waterSource = "GROUND.BOREWELL"
    * set sewerageConnection.connectionExecutionDate = getCurrentEpochTime()
    * set sewerageConnection.meterId = randomMobileNumGen(8)
    * set sewerageConnection.meterInstallationDate = getCurrentEpochTime()
    * set sewerageConnection.waterSubSource = "BOREWELL"
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.submitApplication
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.approveConnection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * def fetchBillParams = { consumerCode: '#(sewerageConnectionApplicationNumber)', businessService: 'SW.ONE_TIME_FEE', tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.activateConnection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * def connectionNo = sewerageResponseBody.SewerageConnections[0].connectionNo

@createSewerageServiceConnection
Scenario: To create a water service connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@successSewerageCreate')

@submitApplication
Scenario: To submit the application
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    # Search Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * set sewerageConnection.roadCuttingInfo = [{"roadType": "BRICKPAVING","roadCuttingArea": 50}]
    * set sewerageConnection.connectionType = "Metered"
    * set sewerageConnection.additionalDetails.initialMeterReading = 100
    * set sewerageConnection.waterSource = "GROUND.BOREWELL"
    * set sewerageConnection.connectionExecutionDate = getCurrentEpochTime()
    * set sewerageConnection.meterId = randomMobileNumGen(8)
    * set sewerageConnection.meterInstallationDate = getCurrentEpochTime()
    * set sewerageConnection.waterSubSource = "BOREWELL"
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.submitApplication
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')

@verify
Scenario: To verify the application
    # Search Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')

@forward
Scenario: To Forward the application
    # Search Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')

@approve
Scenario: To approve the application
    # Search Water Connection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.approveConnection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')

@generateBill
Scenario: To generate Bill
    * def fetchBillParams = { consumerCode: '#(sewerageConnectionApplicationNumber)', businessService: 'SW.ONE_TIME_FEE', tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    
@payWaterServiceTax
Scenario: To Pay the Water Service Tax
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')

@connectionActive
Scenario: To actvate the connection
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.activateConnection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * def connectionNo = sewerageResponseBody.SewerageConnections[0].connectionNo
    * def connectionType = sewerageResponseBody.SewerageConnections[0].connectionType

@sendsBack
Scenario: To sends back the application
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.sendsBackToCitizen
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')

@resubmit
Scenario: To sends back the application
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.resubmitApplication
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')

@reject
Scenario: To reject the application
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.rejectApplication
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')

@sendBackToDocVerifier
Scenario: To send back to the Doc verifier
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.sendBackToDocVerifier
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')

@sendBackForInspection
Scenario: To send back to the Field Inspector
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.sendBackForInspection
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
