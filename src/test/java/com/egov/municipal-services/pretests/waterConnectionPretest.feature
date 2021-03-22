Feature: Water Connection service pretests

Background:
    * def createWaterConnectionRequest = read('../../municipal-services/requestpayload/waterConnection/create.json')
    * def updateWaterConnectionRequest = read('../../municipal-services/requestpayload/waterConnection/update.json')
    * def searchWaterConnectionRequest = read('../../municipal-services/requestpayload/waterConnection/search.json')

@successCreateWaterConnection
Scenario: Create water connection successfully
    Given url createWaterConnection
    And request createWaterConnectionRequest 
	When method post 
	Then status 200
	And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response
    And def WaterConnection = waterConnectionResponseBody.WaterConnection[0]
    And def waterConnectionId = WaterConnection.id
    And def waterConnectionApplicationNo = WaterConnection.applicationNo
    * print 'Application Number: ' + waterConnectionApplicationNo

@errorInCreateWaterConnection
Scenario: Create water connection error
    Given url createWaterConnection
    And request createWaterConnectionRequest 
	When method post 
	Then assert responseStatus >= 400 && responseStatus <= 403
	And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response

@successSearchWaterConnection
Scenario: Search water connection successfully
    Given url searchWaterConnection
    And params waterConnectionParams
    And request searchWaterConnectionRequest 
	When method post
    Then status 200
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response
    And def WaterConnection = waterConnectionResponseBody.WaterConnection[0]
    And def waterConnectionId = WaterConnection.id
    And def waterConnectionApplicationNo = WaterConnection.applicationNo

@errorInSearchWaterConnection
Scenario: Search water connection error
    Given url searchWaterConnection
    And params waterConnectionParams
    And request searchWaterConnectionRequest 
	When method post
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response

@successUpdateWaterConnection
Scenario: Update Water connection successfully
    * eval updateWaterConnectionRequest.WaterConnection = WaterConnection
    * eval updateWaterConnectionRequest.WaterConnection.processInstance.action = processInstanceAction
    Given url updateWaterConnection
    And request updateWaterConnectionRequest 
	When method post
    Then status 200
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response
    And def WaterConnection = waterConnectionResponseBody
    And def WaterConnection = waterConnectionResponseBody.WaterConnection[0]
    And def waterConnectionId = WaterConnection.id
    And def waterConnectionApplicationNo = WaterConnection.applicationNo

@errorInUpdateWaterConnection
Scenario: Update Water connection error
    * eval updateWaterConnectionRequest.WaterConnection = WaterConnection
    * eval updateWaterConnectionRequest.WaterConnection.processInstance.action = processInstanceAction
    Given url updateWaterConnection
    And request updateWaterConnectionRequest 
	When method post
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response