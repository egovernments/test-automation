Feature: FIRE-NOC-Service pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def createFireNocRequest = read('../../municipal-services/requestPayload/firenoc-service/create.json')
        * def searchFireNocRequest = read('../../municipal-services/requestPayload/firenoc-service/search.json')
        * def updateFireNocRequest = read('../../municipal-services/requestPayload/firenoc-service/update.json')

    @createFireNocSuccessfully
    Scenario: Create BPA successfully
        Given url createFireNocService
        And request createFireNocRequest
        When method post
        Then status 200
        And def fireNocResponseBody = response
        And def fireNocBody = fireNocResponseBody.FireNOCs[0]
        And def fireNocId = fireNocResponseBody.FireNOCs[0].id
        And def applicationNo = fireNocResponseBody.FireNOCs[0].fireNOCDetails.applicationNumber
        And def tenantId = fireNocResponseBody.FireNOCs[0].tenantId

    @createFireNocError1
    Scenario: Create BPA Error
        Given url createFireNocService
        And request createFireNocRequest
        * print createFireNocRequest
        When method post
        Then status 400
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response

    @createBPAError2
    Scenario: Create BPA Error
        Given url createFireNocService
        And request createFireNocRequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response

    @searchFireNocSuccessfully
    Scenario: Search FireNoc Successfully

        Given url searchFireNocService
        And params getFireNocSearchParam
        And request searchFireNocRequest
        When method post
        Then status 200
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response

    @searchFireNocWithoutParamsSuccessfully
    Scenario: Search FireNoc Successfully

        Given url searchFireNocService
        And request searchFireNocRequest
        When method post
        Then status 200
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response

    @searchFireNocError
    Scenario: Search FireNoc Error

        Given url searchFireNocService
        And params getFireNocSearchParam
        And request searchFireNocRequest
        When method post
        Then status 400
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response
        * print fireNocResponseBody

    @searchFireNocAuthorizedError
    Scenario: Search FireNoc Error

        Given url searchFireNocService
        And params getFireNocSearchParam
        And request searchFireNocRequest
        When method post
        Then status 403
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response
        * print fireNocResponseBody

    @updateFireNocSuccessfully
    Scenario: Update FireNoc Successfully

        Given url updateFireNocService
        And request updateFireNocRequest
        When method post
        Then status 200
        And def fireNocResponseHeaders = responseHeaders
	    And def fireNocResponseBody = response
        And def fireNocBody = fireNocResponseBody.FireNOCs[0]

    @updateFireNocError
    Scenario: Update FireNoc Error

        Given url updateFireNocService
        And request updateFireNocRequest
        When method post
        Then status 400
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response

    @updateFireNocUnAuthError
    Scenario: Update FireNoc Error

        Given url updateFireNocService
        And request updateFireNocRequest
        When method post
        Then status 403
        And def fireNocResponseHeaders = responseHeaders
        And def fireNocResponseBody = response