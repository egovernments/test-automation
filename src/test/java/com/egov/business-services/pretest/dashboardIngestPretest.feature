Feature: Pretest scenarios of dashboard-ingest service end points
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def savePayload = read('../../business-services/requestPayload/dashboard-ingest/save.json')
  * def migratePayload = read('../../business-services/requestPayload/dashboard-ingest/migrate.json')
  
@saveDashboardIngest
Scenario: Save dashboard ingest
    * configure headers = read('classpath:websCommonHeaders.js')
    Given url dashboardIngestSave 
    And request savePayload
    When method post
    Then status 201

@migrateDashboardIngest
Scenario: Migrate dashboard ingest
    * configure headers = read('classpath:websCommonHeaders.js')
    Given url dashboardIngestMigrate
    And request migratePayload
    When method post
    Then status 201

@uploadToDashboardIngest
Scenario: upload file to dashboard ingest
    Given url dashboardIngestUpload
    And multipart file file = fileParam
    When method post
    Then status 201
    * def uploadResponse = response

@uploadMutlipleFilesToDashboardIngest
Scenario: upload file to dashboard ingest
    Given url dashboardIngestUpload
    And multipart file file = file1
    And multipart file file = file2
    When method post
    Then status 201
    * def uploadResponse = response

@errorInUploadToDashboardIngest
Scenario: upload file to dashboard ingest
    Given url dashboardIngestUpload
    And multipart file file = fileParam
    When method post
    Then status 500
    * def uploadResponse = response
    # * print uploadResponse

@errorInUploadMutlipleFilesToDashboardIngest
Scenario: upload file to dashboard ingest
    Given url dashboardIngestUpload
    And multipart file file = file1
    And multipart file file = file2
    When method post
    Then status 500
    * def uploadResponse = response