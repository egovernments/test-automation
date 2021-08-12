Feature: Billing Service Pretest

Background:
    * def billingServiceConstants = read('../../business-services/constants/billing-service.yaml')
    * def apportionServiceConstants = read('../../business-services/constants/apportionService.yaml')
    * def businessService = billingServiceConstants.parameters.businessService
    * def apportionbusinessService = apportionServiceConstants.parameters.businessService
    * def cancelBillReason1 = apportionServiceConstants.parameters.reason1
    * def cancelBillReason2 = apportionServiceConstants.parameters.reason2
    * def cancelBillReason3 = apportionServiceConstants.parameters.reason3
    * def cancelBillReason4 = apportionServiceConstants.parameters.reason4
    #* def consumerCode = 'Consumer-Code-Test-' + ranInteger(6)
    * def fetchBillRequest = read('../../business-services/requestPayload/collection-services/fetchBill.json')
    * def cancelBillRequest = read('../../business-services/requestPayload/collection-services/cancelBill.json')
    * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

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
    # * print fetchBillParams
    And request fetchBillRequest
    When method post
    # * print fetchBillResponse
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
    # * print fetchBillRequest
    When method post
    Then def fetchBillResponse = response
    # * print fetchBillResponse
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
        * print searchBillResponse
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

@successCancelBill
    Scenario: Verify cancel Bill
    Given url cancelBillURL
    And request cancelBillRequest
    When method post
    Then status 201
    And def cancelBillResponse = response
    * print cancelBillResponse
    And def cancelBillMessage = cancelBillResponse.Message

@errorCancelBill
    Scenario: Verify cancel Bill
    Given url cancelBillURL
    And request cancelBillRequest
        * print cancelBillRequest
    When method post
    Then status 400
    And def cancelBillResponse = response
    * print cancelBillResponse
    And def cancelBillMessage = cancelBillResponse.Message