Feature: events pretests
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def today = getCurrentEpochTime()
        * def tomorrow = getTomorrowEpochTime()
        * def fromDate = tomorrow
        * def toDate = tomorrow
        * def createEventsRequest = read('../../municipal-services/requestPayload/events/create.json')
        * def updateEventsRequest = read('../../municipal-services/requestPayload/events/update.json')
        * def searchEventsRequest = read('../../municipal-services/requestPayload/events/search.json')
        * def deleteEventsRequest = read('../../municipal-services/requestPayload/events/delete.json')

    @createEventsSuccessfully
    Scenario: Create events successfully
        Given url createEgovUserEvent
        And request createEventsRequest
        * print createEventsRequest
        When method post
        Then status 200
        And def eventsResponseHeaders = responseHeaders
        And def eventsResponseBody = response
        And def eventsBody = eventsResponseBody.events[0]
        And def tenantId = eventsResponseBody.events[0].tenantId
        And def source = eventsResponseBody.events[0].source

    @updateEventsSuccessfully
    Scenario: Update events successfully
        Given url updateEgovUserEvent
        And request updateEventsRequest
        When method post
        Then status 200
        And def eventsResponseHeaders = responseHeaders
        And def eventsResponseBody = response
        And def eventsBody = eventsResponseBody.events[0]

    @deleteEventsSuccessfully
    Scenario: Delete events successfully
        Given url deleteEgovUserEvent
        And request deleteEventsRequest
        When method post
        Then status 200
        And def eventsResponseHeaders = responseHeaders
        And def eventsResponseBody = response
        And def eventsBody = eventsResponseBody.events[0]

    @searchEventsSuccessfully
    Scenario: Search Events Successfully

        Given url searchEgovUserEvent
        And params getEventsSearchParam
        And request searchEventsRequest
        When method post
        Then status 200
        And def eventsResponseHeaders = responseHeaders
        And def eventsResponseBody = response
        