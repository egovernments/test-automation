Feature: National Dashboard Ingest

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(10000)

@ingestPT  @coreServices @regression @positive  @nationalDashboardIngest
Scenario: Ingest National dashboard data for PT
    # calling ingest pretest
    * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestSuccessfully')
    * match ingestResponseBody == '#present'

  