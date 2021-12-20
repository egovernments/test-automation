Feature: Public message Brodcast Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(10000)
    * def tenantId = mdmsStateFireNocService.FireStations[0].baseTenantId
    * def eGovUserEventConstants = read('../../municipal-services/constants/eGovUserEvent.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def tenant = 'pb'
    * def name = 'AUTO_' + randomString(10)
    * def eventType = eGovUserEventConstants.events.eventType
    * def source = eGovUserEventConstants.events.source
    * def description = eGovUserEventConstants.events.description
    
    @publicMessageBroadcastCreate_01 @positive @municipalServices @publicMessageBroadcast @publicMessageBroadcastCreate @r2dot6
    Scenario: Verify create an event
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@createPublicMessageBroadcastSuccessfully')
    * match publicMessageBroadcastResponseBody.events[0].tenantId == '#present'

    @publicMessageBroadcastUpdate_01 @positive @municipalServices @publicMessageBroadcast @publicMessageBroadcastUpdate @r2dot6
    Scenario: Update events service
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@createPublicMessageBroadcastSuccessfully')
    * def publicMessageBroadcastBody = publicMessageBroadcastResponseBody.events[0]
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@updatePublicMessageBroadcastSuccessfully')
    * match publicMessageBroadcastResponseBody.events[0].id == "#present"
    * match publicMessageBroadcastResponseBody.events[0].tenantId == "#present"

    @publicMessageBroadcastSearch_01 @positive @municipalServices @publicMessageBroadcast @publicMessageBroadcastSearch @r2dot6
    Scenario: Verify searching for events service
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@createPublicMessageBroadcastSuccessfully')
    * def getpublicMessageBroadcastSearchParam = {"tenantId": '#(tenantId)',"eventTypes": 'BROADCAST'}
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@searchPublicMessageBroadcastSuccessfully')
    * match publicMessageBroadcastResponseBody.events[0].tenantId == '#present'


    @publicMessageBroadcastDelete_01 @positive @municipalServices @publicMessageBroadcast @publicMessageBroadcastDelete @r2dot6
    Scenario: Verify deleting an event
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@createPublicMessageBroadcastSuccessfully')
    * def publicMessageBroadcastToDeleteid = publicMessageBroadcastResponseBody.events[0].id
    * def publicMessageBroadcastToDeleteeventDetailsid = publicMessageBroadcastResponseBody.events[0].eventDetails.id
    * def publicMessageBroadcastToDeleteeventDetailseventId = publicMessageBroadcastResponseBody.events[0].eventDetails.eventId
    * def publicMessageBroadcastToDeletepostedBy = publicMessageBroadcastResponseBody.events[0].postedBy
    * call read('../../municipal-services/pretests/publicMessageBroadcastPretest.feature@deletePublicMessageBroadcastSuccessfully')
    * match publicMessageBroadcastResponseBody.events[0].tenantId == '#present'

    