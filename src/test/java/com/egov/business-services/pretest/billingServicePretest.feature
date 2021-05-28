Feature: Billing Service Pretest

Background:
    * def billingServiceConstants = read('../../business-services/constants/billing-service.yaml')
    * def businessService = billingServiceConstants.parameters.businessService
    * def fetchBillRequest = read('../../business-services/requestPayload/collection-services/fetchBill.json')
    * configure headers = read('classpath:websCommonHeaders.js')

@fetchBill
    Scenario: Fetch Bill
    * def fetchBillParams = 
    """
    {
       consumerCode: '#(consumerCode)',
       businessService: '#(businessService)',
       tenantId: '#(tenantId)'
    }
    """
    Given url fetchBill
    And params fetchBillParams
    * print fetchBillParams
    And request fetchBillRequest
    When method post
    * print fetchBillResponse
    Then status 201
    And def fetchBillResponse = response
    And def totalAmount = response.Bill[0].totalAmount
    And def billId = response.Bill[0].id
    And def txnAmount = totalAmount
    And def totalAmountPaid = totalAmount
    And def totalDue = totalAmount
    
@fetchBillWithCustomizedParameters
    Scenario: Fetch Bill with customized parameters
    Given url fetchBill
    And params fetchBillParams
    And request fetchBillRequest
    * print fetchBillRequest
    When method post
    Then def fetchBillResponse = response
    * print fetchBillResponse
    And def totalAmount = response.Bill[0].totalAmount
    And def billId = response.Bill[0].id
    And def txnAmount = totalAmount
    And def totalAmountPaid = totalAmount
    And def totalDue = totalAmount
    
@successSearchBill
    Scenario: Search bill with customized parameters
    Given url searchBill
    And params searchBillParams
    And request fetchBillRequest
    When method post
    Then def searchBillResponse = response
    And assert searchBillResponse != null
    And assert responseStatus == 200

@errorInSearchBill
    Scenario: Negative pretest to search bill
    Given url searchBill
    And params searchBillParams
    And request fetchBillRequest
    When method post
    Then def searchBillResponse = response
    And assert searchBillResponse != null
    And assert responseStatus == 400