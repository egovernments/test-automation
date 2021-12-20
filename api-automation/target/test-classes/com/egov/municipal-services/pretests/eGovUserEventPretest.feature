Feature: eGov User Event pretests
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def noticiationRequest = read('../../municipal-services/requestPayload/egov-user-event/notification.json')
        * def createRequest = read('../../municipal-services/requestPayload/egov-user-event/create.json')
        * def creatNullValuesRequest = read('../../municipal-services/requestPayload/egov-user-event/createNullParamss.json')
        * def updateRequest = read('../../municipal-services/requestPayload/egov-user-event/update.json')
        * def updateNullValuesRequest = read('../../municipal-services/requestPayload/egov-user-event/updateNullParames.json')
        * def searchRequest = read('../../municipal-services/requestPayload/egov-user-event/search.json')
        * def latUpdateRequest = read('../../municipal-services/requestPayload/egov-user-event/latUpdate.json')
        * def today = getCurrentEpochTime()
        * def tomorrow = getTomorrowEpochTime()
        * def fromDate = tomorrow
        * def toDate = tomorrow
        * def createEventsRequest = read('../../municipal-services/requestPayload/events/create.json')
        * def updateEventsRequest = read('../../municipal-services/requestPayload/events/update.json')
        * def searchEventsRequest = read('../../municipal-services/requestPayload/events/search.json')
        * def deleteEventsRequest = read('../../municipal-services/requestPayload/events/delete.json')

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
        And request createRequest
        * print createRequest
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

    @createEventsSuccessfully
    Scenario: Create Events successfully
        Given url createEgovUserEvent
        And request createEventsRequest
        * print createEventsRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response
        And def eGovUserEventBody = eGovUserEventResponseBody.events[0]
        And def tenantId = eGovUserEventResponseBody.events[0].tenantId
        And def source = eGovUserEventResponseBody.events[0].source

    @updateEventsSuccessfully
    Scenario: Update Events successfully
        Given url updateEgovUserEvent
        And request updateEventsRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response
        And def eGovUserEventBody = eGovUserEventResponseBody.events[0]

    @deleteEventsSuccessfully
    Scenario: Delete egov User Event successfully
        Given url deleteEgovUserEvent
        And request deleteEventsRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response
        And def eGovUserEventBody = eGovUserEventResponseBody.events[0]

    @searchEventsSuccessfully
    Scenario: Search Events Successfully

        Given url searchEgovUserEvent
        And params getEgovUserEventSearchParam
        And request searchEventsRequest
        When method post
        Then status 200
        And def eGovUserEventResponseHeaders = responseHeaders
        And def eGovUserEventResponseBody = response
        