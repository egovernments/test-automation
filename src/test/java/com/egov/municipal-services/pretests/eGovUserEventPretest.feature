Feature: eGov User Event pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def noticiationRequest = read('../../municipal-services/requestPayload/eGovUserEvent/notification.json')
        * def creatRequest = read('../../municipal-services/requestPayload/eGovUserEvent/create.json')
        * def creatNullValuesRequest = read('../../municipal-services/requestPayload/eGovUserEvent/createNullParamss.json')
        * def updateRequest = read('../../municipal-services/requestPayload/eGovUserEvent/update.json')
        * def updateNullValuesRequest = read('../../municipal-services/requestPayload/eGovUserEvent/updateNullParames.json')
        * def searchRequest = read('../../municipal-services/requestPayload/eGovUserEvent/search.json')
        * def latUpdateRequest = read('../../municipal-services/requestPayload/eGovUserEvent/latUpdate.json')

    @notificationSuccessfully
    Scenario: notification count successfully
        Given url notificationEgovUserEvent
        And params getNotificationSearchParam
        And request noticiationRequest
        When method post
        Then status 200
        And def notificationResponseBody = response

    @notificationErro
    Scenario: notification count error
        Given url notificationEgovUserEvent
        And request noticiationRequest
        When method post
        Then status 400
        And def notificationResponseBody = response

    @createEgovUserEventSuccessfully
    Scenario: Create egov User Event successfully
        Given url createEgovUserEvent
        And request creatRequest
        When method post
        Then status 200
        And def eGovUserEventResponseBody = response
        And def eGovUserEventBody = eGovUserEventResponseBody.events[0]
        And def tenantId = eGovUserEventResponseBody.events[0].tenantId
        And def source = eGovUserEventResponseBody.events[0].source

    @createEgovUserEventError
    Scenario: Create egov User Event error
        Given url createEgovUserEvent
        And request creatRequest
        When method post
        Then status 400
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response

    @createEgovUserEventWithNullParamss
    Scenario: Create egov User Event error
        Given url createEgovUserEvent
        And request creatNullValuesRequest
        When method post
        Then status 400
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response

    @updateEgovUserEventSuccessfully
    Scenario: Update egov User Event successfully
        Given url updateEgovUserEvent
        And request updateRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response
        And def eGovUserEventBody = eGovUserEventResponseBody.events[0]

    @updateEgovUserEventError
    Scenario: Update egov User Event Error
        Given url updateEgovUserEvent
        And request updateRequest
        When method post
        Then status 400
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response

    @updateEgovUserEventNullParames
    Scenario: Update egov User Event Error
        Given url updateEgovUserEvent
        And request updateNullValuesRequest
        When method post
        Then status 400
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response

    @searchEgovUserEventSuccessfully
    Scenario: Search Egov User Event Successfully

        Given url searchEgovUserEvent
        And params getEgovUserEventSearchParam
        And request searchRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response
        
    @searchEgovUserEventError
    Scenario: Search Egov User Event Error

        Given url searchEgovUserEvent
        And params getEgovUserEventSearchParam
        And request searchRequest
        When method post
        Then status 400
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response

    @latUpdateEgovUserEventSuccessfully
    Scenario: Lat Update Egov User Event Successfully

        Given url latUpdateEgovUserEvent
        And request latUpdateRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response