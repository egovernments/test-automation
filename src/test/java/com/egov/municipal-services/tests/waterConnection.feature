Feature: Water Connection Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def waterConnectionConstants = read('../../municipal-services/constants/waterConnection.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # initializing request payload variables
    * def isWater = true
    * def isSewerage = true
    * def proposedTaps = 5
    * def proposedPipeSize = 1
    * def service = 'Water'
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.initiate
    * def roadType = 'BRICKPAVING'
    * def roadCuttingArea = 50

@WaterConnection_CreateWithValidPropertyId_01 @positive @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with valid payload
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    # Create Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.WaterConnection[0].id == "#present"
    * match waterConnectionResponseBody.WaterConnection[0].propertyId == propertyId
    * match waterConnectionResponseBody.WaterConnection[0].applicationStatus == waterConnectionConstants.parameters.applicationStatus.initiated

@WaterConnection_UpdateToDOCUMENT_VERIFICATION_01 @positive @regression @wsServices @waterConnectionUpdate
Scenario: Update water connection with valid payload
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    # Create Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.submitApplication
    # Update Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.WaterConnection[0].id == waterConnectionId
    * match waterConnectionResponseBody.WaterConnection[0].propertyId == propertyId
    * match waterConnectionResponseBody.WaterConnection[0].applicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@WaterConnection_SearchWithValidApplicationNumber_01 @positive @regression @wsServices @waterConnectionSearch
Scenario: Search water connection with valid payload
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    # Create Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    * print waterConnectionApplicationNumber
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    # Search Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.WaterConnection[0].id == waterConnectionId
    * match waterConnectionResponseBody.WaterConnection[0].propertyId == propertyId
    * match waterConnectionResponseBody.WaterConnection[0].applicationStatus == waterConnectionConstants.parameters.applicationStatus.initiated

@createActiveWaterConnection
Scenario: Create Active Water connection
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    # * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    # * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * set WaterConnection.roadCuttingInfo = [{"roadType": "BRICKPAVING","roadCuttingArea": 50}]
    * set WaterConnection.connectionType = "Metered"
    * set WaterConnection.additionalDetails.initialMeterReading = 100
    * set WaterConnection.waterSource = "GROUND.BOREWELL"
    * set WaterConnection.connectionExecutionDate = getCurrentEpochTime()
    * set WaterConnection.meterId = randomMobileNumGen(8)
    * set WaterConnection.meterInstallationDate = getCurrentEpochTime()
    * set WaterConnection.waterSubSource = "BOREWELL"
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.submitApplication
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.approveConnection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * def fetchBillParams = { consumerCode: '#(waterConnectionApplicationNo)', businessService: 'WS.ONE_TIME_FEE', tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.activateConnection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * def connectionNo = waterConnectionResponseBody.WaterConnection[0].connectionNo

@createWaterServiceConnection
Scenario: To create a water service connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')

@submitApplication
Scenario: To submit the application
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    # Search Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * set WaterConnection.roadCuttingInfo = [{"roadType": "BRICKPAVING","roadCuttingArea": 50}]
    * set WaterConnection.connectionType = "Metered"
    * set WaterConnection.additionalDetails.initialMeterReading = 100
    * set WaterConnection.waterSource = "GROUND.BOREWELL"
    * set WaterConnection.connectionExecutionDate = getCurrentEpochTime()
    * set WaterConnection.meterId = randomMobileNumGen(8)
    * set WaterConnection.meterInstallationDate = getCurrentEpochTime()
    * set WaterConnection.waterSubSource = "BOREWELL"
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.submitApplication
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')


@submitApplicationForNonMetered
Scenario: To submit the application for Non metered connection
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    # Search Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * set WaterConnection.roadCuttingInfo = [{"roadType": "BRICKPAVING","roadCuttingArea": 50}]
    * set WaterConnection.connectionType = "Non Metered"
    * set WaterConnection.additionalDetails.initialMeterReading = 100
    * set WaterConnection.waterSource = "GROUND.BOREWELL"
    * set WaterConnection.connectionExecutionDate = getCurrentEpochTime()
    * set WaterConnection.meterId = randomMobileNumGen(8)
    * set WaterConnection.meterInstallationDate = getCurrentEpochTime()
    * set WaterConnection.waterSubSource = "BOREWELL"
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.submitApplication
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')

@verify
Scenario: To verify the application
    # Search Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')

@forward
Scenario: To Forward the application
    # Search Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.verifyAndForward
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')

@approve
Scenario: To approve the application
    # Search Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.approveConnection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')

@generateBill
Scenario: To generate Bill
    * def fetchBillParams = { consumerCode: '#(waterConnectionApplicationNo)', businessService: 'WS.ONE_TIME_FEE', tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    
@payWaterServiceTax
Scenario: To Pay the Water Service Tax
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')

@connectionActive
Scenario: To actvate the connection
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.activateConnection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * def connectionNo = waterConnectionResponseBody.WaterConnection[0].connectionNo
    * def connectionType = waterConnectionResponseBody.WaterConnection[0].connectionType

@sendsBack
Scenario: To sends back the application
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.sendsBackToCitizen
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')

@resubmit
Scenario: To sends back the application
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.resubmitApplication
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')

@reject
Scenario: To reject the application
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.rejectApplication
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')

@sendBackToDocVerifier
Scenario: To send back to the Doc verifier
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.sendBackToDocVerifier
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')

@sendBackForInspection
Scenario: To send back to the Field Inspector
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.sendBackForInspection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')