Feature: Public message broadcast pretests
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def today = getCurrentEpochTime()
        * def tomorrow = getTomorrowEpochTime()
        * def fromDate = tomorrow
        * def toDate = tomorrow
        * def createPublicMessageBroadcastRequest = read('../../municipal-services/requestPayload/public-message-broadcast/create.json')
        * def updatePublicMessageBroadcastRequest = read('../../municipal-services/requestPayload/public-message-broadcast/update.json')
        * def searchPublicMessageBroadcastRequest = read('../../municipal-services/requestPayload/public-message-broadcast/search.json')
        * def deletePublicMessageBroadcastRequest = read('../../municipal-services/requestPayload/public-message-broadcast/delete.json')

    @createPublicMessageBroadcastSuccessfully
    Scenario: Create Public Message Broadcast successfully
        Given url createEgovUserEvent
        And request createPublicMessageBroadcastRequest
        * print createPublicMessageBroadcastRequest
        When method post
        Then status 200
        And def publicMessageBroadcastResponseHeaders = responseHeaders
        And def publicMessageBroadcastResponseBody = response
        And def publicMessageBroadcastBody = publicMessageBroadcastResponseBody.events[0]
        And def tenantId = publicMessageBroadcastResponseBody.events[0].tenantId
        And def source = publicMessageBroadcastResponseBody.events[0].source

    @updatePublicMessageBroadcastSuccessfully
    Scenario: Update public message broadcast successfully
        Given url updateEgovUserEvent
        And request updatePublicMessageBroadcastRequest
        When method post
        Then status 200
        And def publicMessageBroadcastResponseHeaders = responseHeaders
        And def publicMessageBroadcastResponseBody = response
        And def publicMessageBroadcastBody = publicMessageBroadcastResponseBody.events[0]

    @deletePublicMessageBroadcastSuccessfully
    Scenario: Delete public message broadcast successfully
        Given url deleteEgovUserEvent
        And request deletePublicMessageBroadcastRequest
        When method post
        Then status 200
        And def publicMessageBroadcastResponseHeaders = responseHeaders
        And def publicMessageBroadcastResponseBody = response
        And def publicMessageBroadcastBody = publicMessageBroadcastResponseBody.events[0]

    @searchPublicMessageBroadcastSuccessfully
    Scenario: Search public message broadcast Successfully

        Given url searchEgovUserEvent
        And params getpublicMessageBroadcastSearchParam
        And request searchPublicMessageBroadcastRequest
        When method post
        Then status 200
        And def publicMessageBroadcastResponseHeaders = responseHeaders
        And def publicMessageBroadcastResponseBody = response
        