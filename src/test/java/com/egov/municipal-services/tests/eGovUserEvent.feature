Feature: eGov User Event Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
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
    
    @notifications_count_01 @positive @regression @municipalService @eGovUserEvent @eGovUserEventNotification
    Scenario: Verify get notification count through API
    * def getNotificationSearchParam = {"tenantId": '#(tenant)'}
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@notificationSuccessfully')
    * match notificationResponseBody.unreadCount == '#present'
    * match notificationResponseBody.totalCount == '#present'

    @notifications_noTenant_02 @negative @regression @municipalService @eGovUserEvent @eGovUserEventNotification
    Scenario: Verify get notification count through API without tenantID
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@notificationErro')
    * match notificationResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.withoutTenantID

    @events_create_PT_01 @positive @regression @municipalService @eGovUserEvent @eGovUserEventCreate
    Scenario: Verify create Egov user Event
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * match eGovUserEventResponseBody.events[0].tenantId == '#present'

    @events_InvalidEventType_02 @negative @regression @municipalService @eGovUserEvent @eGovUserEventCreate
    Scenario: Verify create Egov user Event with invalid event type
    * def eventType = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.invalidEventType

    @events_InvalidSource_03 @negative @regression @municipalService @eGovUserEvent @eGovUserEventCreate
    Scenario: Verify create Egov user Event with invalid source type
    * def source = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.withoutTenantID

    @events_nullValues_04 @negative @regression @municipalService @eGovUserEvent @eGovUserEventCreate
    Scenario: Verify create Egov user Event with  passing null values for eventType, source, tenantId
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventWithNullParamss')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.withoutTenantID

    @events_InValid_ToUser_05 @negative @regression @municipalService @eGovUserEvent @eGovUserEventCreate
    Scenario: Verify create Egov user Event with  passing null values for invalid UUID
    * def uuid = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.invalidUUIID

    @events_Wrong_EventType_06 @negative @regression @municipalService @eGovUserEvent @eGovUserEventCreate
    Scenario: Verify create Egov user Event with  passing null values for wrong Event Type
    * def eventType = eGovUserEventConstants.events.wrongEventy
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.wrongEventType

    @events_update_01 @positive @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * def eGovUserEventBody = eGovUserEventResponseBody.events[0]
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventSuccessfully')
    * match eGovUserEventResponseBody.events[0].id == "#present"
    * match eGovUserEventResponseBody.events[0].tenantId == "#present"

    @events_Update_InvalidEventType_02 @negative @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service with invalid event type
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * set eGovUserEventResponseBody.events[0].eventType = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.invalidEventType
    
    @events_Update_InvalidSource_03 @negative @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service with invalid source
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * set eGovUserEventResponseBody.events[0].source = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.withoutTenantID

    @events_update_nullValues_04 @negative @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service with null body values
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventNullParames')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.withoutTenantID

    @events_update_InvalidID_05 @negative @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service with invalid event ID
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * set eGovUserEventResponseBody.events[0].id = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.invalidEventId

    @events_update_Invalid_status_06 @negative @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service with invalid status
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * set eGovUserEventResponseBody.events[0].status = eGovUserEventConstants.events.status
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.invalidStatus

    @events_update_InValid_ToUser_07 @negative @regression @municipalService @eGovUserEvent @eGovUserEventUpdate
    Scenario: Update Egov User Event service with invalid UUID
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * set eGovUserEventResponseBody.events[0].recepient.toUsers[0] = randomString(8)
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@updateEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.invalidUUIID

    @events_search_01 @positive @regression @municipalService @eGovUserEvent @eGovUserEventSearch
    Scenario: Verify searching for Egov user event service
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * def getEgovUserEventSearchParam = {"tenantId": '#(tenantId)',"source": '#(source)'}
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@searchEgovUserEventSuccessfully')
    * match eGovUserEventResponseBody.events[0].tenantId == '#present'
    
    @events_search_without_tenant_02 @negative @regression @municipalService @eGovUserEvent @eGovUserEventSearch
    Scenario: Verify searching for Egov user event service without tenantID
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@createEgovUserEventSuccessfully')
    * def getEgovUserEventSearchParam = {"source": '#(source)'}
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@searchEgovUserEventError')
    * match eGovUserEventResponseBody.Errors[0].message == eGovUserEventConstants.errorMessages.withoutTenantID

    @events_search_InvalidValues_03 @positive @regression @municipalService @eGovUserEvent @eGovUserEventSearch
    Scenario: Verify searching for Egov user event service with invalid values
    * def source = randomString(8)
    * def getEgovUserEventSearchParam = {"tenantId": '#(tenantId)',"source": '#(source)'}
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@searchEgovUserEventSuccessfully')
    * match eGovUserEventResponseBody.events[0] == '#notpresent'

    @lat_update_01 @positive @regression @municipalService @eGovUserEvent @eGovUserEventLatUpdate
    Scenario: Verify lat update for Egov user event service
    * call read('../../municipal-services/pretests/eGovUserEventPretest.feature@latUpdateEgovUserEventSuccessfully')
    * match eGovUserEventResponseBody.status == commonConstants.expectedStatus.success