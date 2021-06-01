Feature: Land-Service pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def createLandRequest = read('../../municipal-services/requestPayload/land-services/create.json')
        * def searchLandRequest = read('../../municipal-services/requestPayload/land-services/search.json')
        * def updateLandRequest = read('../../municipal-services/requestPayload/land-services/update.json')

    @createLandSuccessfully
    Scenario: Create Land successfully
        Given url createLand
        And request createLandRequest
        When method post
        Then status 200
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response
        And def id = landResponseBody.LandInfo[0].id

    @createLandError
    Scenario: Create Land Error
        Given url createLand
        And request createLandRequest
        When method post
        Then status 400
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response

    @createLandErrorUnAuthorized
    Scenario: Create Land Error
        Given url createLand
        And request createLandRequest
        When method post
        Then status 403
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response

    @updateLandSuccessfully
    Scenario: Update Land successfully
        Given url updateLand
        And request updateLandRequest
        When method post
        Then status 200
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response
        And def id = landResponseBody.LandInfo[0].id

    @updateLandError
    Scenario: Update Land Error
        Given url updateLand
        And request updateLandRequest
        When method post
        Then status 400
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response

    @updateLandErrorUnAuthorized
    Scenario: Update Land Error
        Given url updateLand
        And request updateLandRequest
        When method post
        Then status 403
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response

    @searchLandSuccessfully
    Scenario: Search Land successfully
        Given url searchLand
        And params searchParam
        And request searchLandRequest
        When method post
        Then status 200
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response

    @searchLandError
    Scenario: Search Land Error
        Given url searchLand
        And params searchParam
        And request searchLandRequest
        When method post
        Then status 400
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response

    @searchLandErrorUnAuthorized
    Scenario: Search Land Error
        Given url searchLand
        And params searchParam
        And request searchLandRequest
        When method post
        Then status 403
        And def landResponseHeaders = responseHeaders
        And def landResponseBody = response