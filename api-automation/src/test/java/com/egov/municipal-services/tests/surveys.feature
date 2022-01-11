Feature: Surveys Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(10000)
    * def eGovUserEventConstants = read('../../municipal-services/constants/eGovUserEvent.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def tenant = 'pb'
    * def name = 'AUTO_' + randomString(10)
    * def eventType = eGovUserEventConstants.events.eventType
    * def source = eGovUserEventConstants.events.source
    * def description = eGovUserEventConstants.events.description
    

    @surveysSearch_01 @positive @municipalServices @surveys @surveysSearch @r2dot6
    Scenario: Verify searching for events service
    * call read('../../municipal-services/pretests/surveysPretest.feature@searchSurveysSuccessfully')
    * match surveysResponseBody.surveys[0].tenantId == '#present'


 