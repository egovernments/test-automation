Feature: Pretest scenarios of egf-instrument service end points

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')

  # Instrument Types prtests

  @createInstrumentTypes
    Scenario: To create instrument types
    Given url createInstrumentTypes
        * print createInstrumentTypes
    And request instrumentTypesPayload
        * print instrumentTypesPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 400 || responseStatus == 403
    And  def instrumentTypesResponse = response

  @searchInstrumentTypes
    Scenario: To search instrument types
    Given url searchInstrumentTypes
    And params searchParams
      * print searchParams
    And request searchInstrumentTypesPayload
    When method post
    Then assert responseStatus == 200 || responseStatus == 403
    And def seachResponse = response

  @updateInstrumentTypes
    Scenario: To update instrument types
    Given url updateInstrumentTypes
        * print updateInstrumentTypes
    And request instrumentTypesPayload
        * print instrumentTypesPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 400 || responseStatus == 403
    And  def updateInstrumentTypesResponse = response