Feature: Ingest new data for National dashboard.

Background:
    * def ingestPTPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestPT.json')
    * def ingestTLPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestTL.json')
    * def ingestWSPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestWS.json')
    * def ingestFirenocPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestFirenoc.json')
    * def ingestPGRPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestPGR.json')
    * def ingestOBPSPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestOBPS.json')
    * def ingestmCollectPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestmCollect.json')
    * def ingestCommonPayload = read('../../core-services/requestPayload/nationalDashboardIngest/ingestCommon.json')


@ingestPTSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestPTPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
     

@ingestPTError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestPTPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestTLSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestTLPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestTLError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestTLPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestPGRSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestPGRPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestPGRError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestPGRPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestFirenocSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestFirenocPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestFirenocError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestFirenocPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestWSSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestWSPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestWSError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestWSPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestmCollectSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestmCollectPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestmCollectError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestmCollectPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestOBPSSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestOBPSPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestOBPSError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestOBPSPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response

@ingestCommonSuccessfully
Scenario: Ingest new of data Successfully
    Given url dashboardIngest 
    And request ingestCommonPayload
    When method post
    Then status 200
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response
    And def hash = ingestResponseBody.responseHash
     

@ingestCommonError
Scenario: Ingest new of data Error
    Given url dashboardIngest 
    And request ingestCommonPayload
    When method post
    Then status 400
    And def ingestResponseHeader = responseHeaders
    And def ingestResponseBody = response