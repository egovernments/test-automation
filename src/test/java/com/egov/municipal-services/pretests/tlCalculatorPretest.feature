Feature: TL Calculator Pretests

Background:
    * def getBillRequest = read('../../municipal-services/requestPayload/tl-calculator/getBill.json')
    * def billingSlabCreate = read('../../municipal-services/requestPayload/tl-calculator/billingSlabCreate.json')
    * def billingSlabMultiCreate = read('../../municipal-services/requestPayload/tl-calculator/multiCreate.json')
    * def billingSlabUpdate = read('../../municipal-services/requestPayload/tl-calculator/billingSlabUpdate.json')
    * def billingSlabSearch = read('../../municipal-services/requestPayload/tl-calculator/billingSlabSearch.json')
    * def calculateRequest = read('../../municipal-services/requestPayload/tl-calculator/calculate.json')


@searchBillSuccessfully
Scenario: Searching bill through API call

    Given url tlCalculatorGetBill
    And params getBillSearchParam
    And request getBillRequest
    When method post
    Then status 200
    And def billSearchResponseHeader = responseHeaders
    And def billSearchResponseBody = response

@searchBillError
Scenario: Searching bill through API call

    Given url tlCalculatorGetBill
    And params getBillSearchParam
    And request getBillRequest
    When method post
    Then status 400
    And def billSearchResponseHeader = responseHeaders
    And def billSearchResponseBody = response

@searchBillAuthorizedError
Scenario: Searching bill through API call

    Given url tlCalculatorGetBill
    And params getBillSearchParam
    And request getBillRequest
    When method post
    Then status 403
    And def billSearchResponseHeader = responseHeaders
    And def billSearchResponseBody = response

@createBillingSlabSuccessfully
Scenario: Creating billingSlab through API call

    Given url tlCalculatorCreateBillingSlab
    And request billingSlabCreate
    When method post
    Then status 200
    And def billSlabCreateResponseHeader = responseHeaders
    And def billSlabCreateResponseBody = response
    And def structureType = billSlabCreateResponseBody.billingSlab[0].structureType
    And def tradeType = billSlabCreateResponseBody.billingSlab[0].tradeType

@createBillingSlabMultiTenantError
Scenario: Creating billingSlab through API call

    Given url tlCalculatorCreateBillingSlab
    And request billingSlabMultiCreate
    When method post
    Then status 400
    And def billSlabCreateResponseHeader = responseHeaders
    And def billSlabCreateResponseBody = response

@createBillingSlabError
Scenario: Creating billingSlab through API call

    Given url tlCalculatorCreateBillingSlab
    And request billingSlabCreate
    When method post
    Then status 400
    And def billSlabCreateResponseHeader = responseHeaders
    And def billSlabCreateResponseBody = response

@updateBillingSlabSuccessfully
Scenario: Updating billingSlab through API call

    Given url tlCalculatorUpdateBillingSlab
    And request billingSlabUpdate
    When method post
    Then status 200
    And def billSlabUpdateResponseHeader = responseHeaders
    And def billSlabUpdateResponseBody = response

@updateBillingSlabError
Scenario: Updating billingSlab through API call

    Given url tlCalculatorUpdateBillingSlab
    And request billingSlabUpdate
    When method post
    Then status 400
    And def billSlabUpdateResponseHeader = responseHeaders
    And def billSlabUpdateResponseBody = response

@searchBillingSlabSuccessfully
Scenario: Searching billingSlab through API call

    Given url tlCalculatorSearchBillingSlab
    And params searchParam
    And request billingSlabSearch
    When method post
    Then status 200
    And def billSlabSearchResponseHeader = responseHeaders
    And def billSlabSearchResponseBody = response

@searchBillingSlabError
Scenario: Searching billingSlab through API call

    Given url tlCalculatorSearchBillingSlab
    And params searchParam
    And request billingSlabSearch
    When method post
    Then status 400
    And def billSlabSearchResponseHeader = responseHeaders
    And def billSlabSearchResponseBody = response

@searchBillingSlabErrorUnAuthorized
Scenario: Searching billingSlab through API call

    Given url tlCalculatorSearchBillingSlab
    And params searchParam
    And request billingSlabSearch
    When method post
    Then status 403
    And def billSlabSearchResponseHeader = responseHeaders
    And def billSlabSearchResponseBody = response

@calculateSuccessfully
Scenario: TL Calculate through API call

    Given url tlCalculatorCalculate
    And request calculateRequest
    When method post
    Then status 200
    And def calculateResponseHeader = responseHeaders
    And def calculateResponseBody = response

@calculateError
Scenario: TL Calculate through API call

    Given url tlCalculatorCalculate
    And request calculateRequest
    When method post
    Then status 400
    And def calculateResponseHeader = responseHeaders
    And def calculateResponseBody = response

@calculateErrorUnAuthorized
Scenario: TL Calculate through API call

    Given url tlCalculatorCalculate
    And request calculateRequest
    When method post
    Then status 403
    And def calculateResponseHeader = responseHeaders
    And def calculateResponseBody = response