Feature: Pretest scenarios of egf-instrumentAccountCode service end points

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  #egfInstrumet-InstrumentsAccountCode Requests
  * def instrumentAccountCodeCreateRequest = read('../../business-services/requestPayload/dashboard-analytics/instrumentAccountCode/create.json')
  * def instrumentAccountCodeUpdateRequest = read('../../business-services/requestPayload/dashboard-analytics/instrumentAccountCode/update.json')
  * def instrumentAccountCodeSearchRequest = read('../../business-services/requestPayload/dashboard-analytics/instrumentAccountCode/search.json')

  # Instrument Account Code pretests

  @createInstrumentAccountCode
    Scenario: To create AccountCode
    Given url instrumentAccountCodeCreate
    And request instrumentAccountCodeCreateRequest
    When method post
    Then assert responseStatus == 201
    And def instrumentAccountCodeResponse = response

  @errorIncreateInstrumentAccountCode
    Scenario: error in create AccountCode
    Given url instrumentAccountCodeCreate
    And request instrumentAccountCodeCreateRequest
    When method post
    Then status 400
    And def instrumentAccountCodeResponse = response

  @errorIncreateInstrumentAccountCodeUnAuthorized
    Scenario: error in create AccountCode
    Given url instrumentAccountCodeCreate
    And request instrumentAccountCodeCreateRequest
    When method post
    Then status 403
    And def instrumentAccountCodeResponse = response

  @searchInstrumentAccountCode
    Scenario: To search instrument types
    Given url instrumentAccountCodeSearch
    And params searchParams
    And request instrumentAccountCodeSearchRequest
    When method post
    Then assert responseStatus == 200
    And def searchInstrumentAccountCodeResponse = response

  @errorInsearchInstrumentAccountCode
    Scenario: error in search instrument types
    Given url instrumentAccountCodeSearch
    And params searchParams
    And request instrumentAccountCodeSearchRequest
    When method post
    Then assert responseStatus == 403
    And def searchInstrumentAccountCodeResponse = response

  @updateInstrumentAccountCode
    Scenario: To update instrument types
    Given url instrumentAccountCodeUpdate
    And request instrumentAccountCodeUpdateRequest
    # * print instrumentUpdateRequest
    When method post
    Then assert responseStatus == 201
    And def updateInstrumentAccountCodeResponse = response

  @errorInupdateInstrumentAccountCode
    Scenario: error in update instrument types
    Given url instrumentAccountCodeUpdate
    And request instrumentAccountCodeUpdateRequest
    # * print instrumentUpdateRequest
    When method post
    Then status 400
    And def updateInstrumentAccountCodeResponse = response

  @errorInupdateInstrumentAccountCodeUnAuthorized
    Scenario: error in update instrument types
    Given url instrumentAccountCodeUpdate
    And request instrumentAccountCodeUpdateRequest
    # * print instrumentUpdateRequest
    When method post
    Then status 403
    And def updateInstrumentAccountCodeResponse = response