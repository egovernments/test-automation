Feature: FIRE-NOC-Service pretests
Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def createEChallanRequest = read('../../municipal-services/requestPayload/eChallan-Service/create.json')
    * def searchEChallanRequest = read('../../municipal-services/requestPayload/eChallan-Service/search.json')
    * def updateEChallanRequest = read('../../municipal-services/requestPayload/eChallan-Service/update.json')
    * def paymentEChallanRequest = read('../../municipal-services/requestPayload/eChallan-Service/payment.json')

@createEChallanSuccessfully
Scenario: Create eChallan Service successfully
    Given url createEchallanEvent
    And request createEChallanRequest
    When method post
    Then status 200
    And def challanResponseBody = response
    And def challanBody = challanResponseBody.challans[0]
    And def challanId = challanResponseBody.challans[0].id
    And def applicationStatus = challanResponseBody.challans[0].applicationStatus
    And def taxPeriodFrom = challanResponseBody.challans[0].taxPeriodFrom
    And def taxPeriodTo = challanResponseBody.challans[0].taxPeriodTo
    And def challanNo = challanResponseBody.challans[0].challanNo
    And def citizen = challanResponseBody.challans[0].citizen
    And def calculation = challanResponseBody.challans[0].calculation
    And def amount = challanResponseBody.challans[0].amount
    And def address = challanResponseBody.challans[0].address
    And def auditDetails = challanResponseBody.challans[0].auditDetails
    And def accountId = challanResponseBody.challans[0].accountId

@createEChallanError
Scenario: Create eChallan Service Error
    Given url createEchallanEvent
    And request createEChallanRequest
    When method post
    Then status 403
    And def challanResponseBody = response

@createEChallanError1
Scenario: Create eChallan Service Error
    Given url createEchallanEvent
    And request createEChallanRequest
    When method post
    Then status 400
    And def challanResponseBody = response

@searchEChallanSuccessfully
Scenario: Search eChallan Service successfully
    Given url searchEchallanEvent
    And params geteChallanSearchParam
    And request searchEChallanRequest
    When method post
    Then status 200
    And def challanResponseBody = response

@searchEChallanError
Scenario: Search eChallan Service Error
    Given url searchEchallanEvent
    And params geteChallanSearchParam
    And request searchEChallanRequest
    When method post
    Then status 403
    And def challanResponseBody = response

@searchEChallanError1
Scenario: Search eChallan Service Error
    Given url searchEchallanEvent
    And params geteChallanSearchParam
    And request searchEChallanRequest
    When method post
    Then status 400
    And def challanResponseBody = response

@updateEChallanSuccessfully
Scenario: Update eChallan Service successfully
    Given url updateEchallanEvent
    And request updateEChallanRequest
    When method post
    Then status 200
    And def challanResponseBody = response

@updateEChallanError
Scenario: Update eChallan Service successfully
    Given url updateEchallanEvent
    And request updateEChallanRequest
    When method post
    Then status 400
    And def challanResponseBody = response

@fetchEChallanSuccessfully
Scenario: Fetch eChallan Service successfully
    Given url fetchBill
    And params geteChallanFetchParam
    And request searchEChallanRequest
    When method post
    Then status 201
    * print response
    And def challanResponseBody = response
    And def billId = challanResponseBody.Bill[0].billDetails[0].billId
    And def amount = challanResponseBody.Bill[0].totalAmount
    And def billNumber = challanResponseBody.Bill[0].billNumber

@paymentEChallanSuccessfully
Scenario: Payment eChallan Service successfully
    Given url payment
    And request paymentEChallanRequest
    When method post
    Then status 200
    And def challanResponseBody = response

@paymentEChallaError
Scenario: Payment eChallan Service Error
    Given url payment
    And request paymentEChallanRequest
    When method post
    Then status 400
    And def challanResponseBody = response

@paymentEChallaError1
Scenario: Payment eChallan Service Error
    Given url payment
    And request paymentEChallanRequest
    When method post
    Then status 403
    And def challanResponseBody = response