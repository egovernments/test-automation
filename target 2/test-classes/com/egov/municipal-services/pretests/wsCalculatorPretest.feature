Feature: WS Calculator Pretests

Background:
    * def estimateRequest = read('../../municipal-services/requestPayload/ws-calculator/estimate.json')
    * def calculateRequest = read('../../municipal-services/requestPayload/ws-calculator/calculate.json')
    * def createMeterConnectionRequest = read('../../municipal-services/requestPayload/ws-calculator/createMeterConnection.json')
    * def searchMeterConnectionRequest = read('../../municipal-services/requestPayload/ws-calculator/searchMeterConnection.json')
    * def addAdhocTaxRequest = read('../../municipal-services/requestPayload/ws-calculator/addAdhocTax.json')

@successEstimateWsCalculator
Scenario: Estimate WS Calculator successfully
    Given url wsCalculatorEstimate
    And request estimateRequest
    When method post
    Then status 200
    And def wsCalculatorResponseHeaders = responseHeaders
    And def wsCalculatorResponseBody = response

@successCalculateWsCalculator
Scenario: Calculate WS Calculator Successfully
    Given url wsCalculatorCalculate
    And request calculateRequest
    When method post
    Then status 200
    And def wsCalculatorResponseHeaders = responseHeaders
    And def wsCalculatorResponseBody = response

@successCreateMeterConnection
Scenario: Create Meter Connection Successfully
    Given url wsCalculatorCreateMeterConnection
    And request createMeterConnectionRequest
    When method post
    Then status 200
    And def wsCalculatorResponseHeaders = responseHeaders
    And def wsCalculatorResponseBody = response

@successSearchMeterConnection
Scenario: Search Meter Connection Successfully
    Given url wsCalculatorSearchMeterConnection
    And params searchMeterConnectionParams
    And request searchMeterConnectionRequest
    When method post
    Then status 200
    And def wsCalculatorResponseHeaders = responseHeaders
    And def wsCalculatorResponseBody = response

@successAddAdhocTax
Scenario: Add Adhoc Tax Successfully
    Given url wsCalculatorApplyAdhocTax
    And request addAdhocTaxRequest
    When method post
    Then status 200
    And def wsCalculatorResponseHeaders = responseHeaders
    And def wsCalculatorResponseBody = response