Feature: Event Tests

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
    
    @eventsCreate_01 @positive @municipalServices @events @eventsCreate @r2dot6
    Scenario: Verify create an event
    * call read('../../municipal-services/pretests/eventsPretest.feature@createEventsSuccessfully')
    * match eventsResponseBody.events[0].tenantId == '#present'

    @eventsUpdate_01 @positive @municipalServices @events @eventsUpdate @r2dot6
    Scenario: Update events service
    * call read('../../municipal-services/pretests/eventsPretest.feature@createEventsSuccessfully')
    * def eventsBody = eventsResponseBody.events[0]
    * call read('../../municipal-services/pretests/eventsPretest.feature@updateEventsSuccessfully')
    * match eventsResponseBody.events[0].id == "#present"
    * match eventsResponseBody.events[0].tenantId == "#present"

    @eventsSearch_01 @positive @municipalServices @events @eventsSearch @r2dot6
    Scenario: Verify searching for events service
    * call read('../../municipal-services/pretests/eventsPretest.feature@creatEventsSuccessfully')
    * def getEventsSearchParam = {"tenantId": '#(tenantId)',"eventTypes": 'EVENTSONGROUND'}
    * call read('../../municipal-services/pretests/eventsPretest.feature@searchEventsSuccessfully')
    * match eventsResponseBody.events[0].tenantId == '#present'


    @eventsDelete_01 @positive @municipalServices @events @eventsDelete @r2dot6
    Scenario: Verify deleting an event
    * call read('../../municipal-services/pretests/eventsPretest.feature@createEventsSuccessfully')
    * def eventsToDeleteid = eventsResponseBody.events[0].id
    * def eventsToDeleteeventDetailsid = eventsResponseBody.events[0].eventDetails.id
    * def eventsToDeleteeventDetailseventId = eventsResponseBody.events[0].eventDetails.eventId
    * def eventsToDeletepostedBy = eventsResponseBody.events[0].postedBy
    * call read('../../municipal-services/pretests/eventsPretest.feature@deleteEventsSuccessfully')
    * match eventsResponseBody.events[0].tenantId == '#present'

    