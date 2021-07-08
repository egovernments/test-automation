Feature: Bill Amendment Service pretests
Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def createBillAmendmentRequest = read('../../municipal-services/requestPayload/billAmendment/create.json')
    * def searchBillAmendmentRequest = read('../../municipal-services/requestPayload/billAmendment/search.json')
    * def updateBillAmendmentRequest = read('../../municipal-services/requestPayload/billAmendment/update.json')

@createBillAmendmentSuccessfully
Scenario: Create Bill Amendment successfully
    Given url createBilAmendment
    And request createBillAmendmentRequest
    When method post
    Then status 200
    And def billAmendmentResponseBody = response
    And def billAmendmentBody = billAmendmentResponseBody.Amendments[0]
    And def amendmentId = billAmendmentResponseBody.Amendments[0].amendmentId
    And def businessService = billAmendmentResponseBody.Amendments[0].businessService
    
@createBillAmendmentError
Scenario: Create Bill Amendment successfully
    Given url createBilAmendment
    And request createBillAmendmentRequest
    When method post
    Then status 403
    And def billAmendmentResponseBody = response

@createBillAmendmentError1
Scenario: Create Bill Amendment successfully
    Given url createBilAmendment
    And request createBillAmendmentRequest
    When method post
    Then status 400
    And def billAmendmentResponseBody = response

@updateBillAmendmentSuccessfully
Scenario: Update Bill Amendment successfully
    Given url updateBilAmendment
    And request updateBillAmendmentRequest
    When method post
    Then status 200
    And def billAmendmentResponseBody = response

@updateBillAmendmentError
Scenario: Update Bill Amendment Error
    Given url updateBilAmendment
    And request updateBillAmendmentRequest
    When method post
    Then status 400
    And def billAmendmentResponseBody = response

@searchBillAmendmentSuccessfully
Scenario: Search Bill Amendment successfully
    Given url searchBilAmendment
    And params getBillSearchParam
    And request searchBillAmendmentRequest
    When method post
    Then status 200
    And def billAmendmentResponseBody = response

@searchBillAmendmentError
Scenario: Search Bill Amendment Error
    Given url searchBilAmendment
    And params getBillSearchParam
    And request searchBillAmendmentRequest
    When method post
    Then status 403
    And def billAmendmentResponseBody = response

@searchBillAmendmentError1
Scenario: Search Bill Amendment Error
    Given url searchBilAmendment
    And params getBillSearchParam
    And request searchBillAmendmentRequest
    When method post
    Then status 400
    And def billAmendmentResponseBody = response
