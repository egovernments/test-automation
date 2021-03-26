Feature: Water Connection Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
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
    # Create Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.WaterConnection[0].id == "#present"
    * match waterConnectionResponseBody.WaterConnection[0].propertyId == propertyId
    * match waterConnectionResponseBody.WaterConnection[0].applicationStatus == waterConnectionConstants.parameters.applicationStatus.initiated
@WaterConnection_CreateWithInValidPropertyId_02 @negative @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with invalid propertyId
    # Create Water Connection
    * def propertyId = 'invalid-porpertyId-' + randomString(5)
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@errorInCreateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.Errors[0].message == waterConnectionConstants.errorMessages.invalidPropertyId

@WaterConnection_CreateWithInValidTenantID_03 @negative @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with invalid tenantId
    # Create Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@errorInCreateWaterConnectionWithInvalidTenantId')
    # Verify response body
    * match waterConnectionResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

@WaterConnection_CreateWithNullPropertyID_04 @WaterConnection_CreateWithEmptyPropertyID_04 @negative @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with propertyId as null
    # Create Water Connection
    * def propertyId = null
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@errorInCreateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.Errors[0].message == waterConnectionConstants.errorMessages.propertyIdNotNull

@WaterConnection_Create_MorethanMaxProposedTaps_05 @negative @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with invalid proposedTaps
    # Create Water Connection
    * def proposedTaps = 9999999999
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@errorInCreateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.Errors[0].message == commonConstants.errorMessages.jsonDeserializeError

@WaterConnection_CreateWithInValidAction_07 @negative @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with invalid action
    # Create Water Connection
    * def processInstanceAction = 'invalid-instance-' + randomString(5)
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@errorInCreateWaterConnection')
    # Verify response body
    * def expectedMessage = waterConnectionConstants.errorMessages.actionNotFound
    * replace expectedMessage.processInstanceAction = processInstanceAction
    * match waterConnectionResponseBody.Errors[0].message contains expectedMessage

@WaterConnection_CreateWithNullAction_08 @negative @regression @wsServices @waterConnectionCreate
Scenario: Create water connection with action as null
    # Create Water Connection
    * def processInstanceAction = null
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@errorInCreateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.Errors[0].message == waterConnectionConstants.errorMessages.actionNotNull

@WaterConnection_UpdateToDOCUMENT_VERIFICATION_01 @swcSubmit @positive @regression @wsServices @waterConnectionUpdate
Scenario: Update water connection with valid payload
    # Create Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.submitApplication
    # Update Water Connection
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    # Verify response body
    * match waterConnectionResponseBody.WaterConnection[0].id == waterConnectionId
    * match waterConnectionResponseBody.WaterConnection[0].propertyId == propertyId
    * match waterConnectionResponseBody.WaterConnection[0].applicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@WaterConnection_UpdateToDOCUMENT_VERIFICATION_01 @positive @regression @wsServices @waterConnectionUpdate
Scenario: Update water connection with valid payload
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
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successCreateWaterConnection')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenSuperuser')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@setWaterConnectionVariablesToUpdate')
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
