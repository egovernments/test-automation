Feature: FSM Billing Slab pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def createFSMBillingSlabRequest = read('../../municipal-services/requestPayload/fsm-billingslab/create.json')
        * def searchFSMBillingSlabRequest = read('../../municipal-services/requestPayload/fsm-billingslab/search.json')
        * def updateFSMBillingSlabRequest = read('../../municipal-services/requestPayload/fsm-billingslab/update.json')
        * def calculateFSMBillingSlabRequest = read('../../municipal-services/requestPayload/fsm-billingslab/calculate.json')
        * def estimateFSMBillingSlabRequest = read('../../municipal-services/requestPayload/fsm-billingslab/estimate.json')

    @createFSMBillingSlabSuccessfully
    Scenario: Create FSM Billing Slab Successfully
        Given url createFSMBillingSlab
        And request createFSMBillingSlabRequest
        When method post
        Then status 200
        And def fsmBillingSlabResponseBody = response
        And def fsmBillingSlab = fsmBillingSlabResponseBody.billingSlab[0]

    @createFSMBillingSlabUnSuccessfully
    Scenario: Create FSM Billing Slab UnSuccessfully
        Given url createFSMBillingSlab
        And request createFSMBillingSlabRequest
        # * print createFSMBillingSlabRequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        And def fsmBillingSlabResponseBody = response

    @searchFSMBillingSlabSuccessfully
    Scenario: Search FSM Billing Slab Successfully
        Given url searchFSMBillingSlab
        And params searchFSMBillingSlabParams
        And request searchFSMBillingSlabRequest
        When method post
        Then status 200
        And def fsmBillingSlabResponseBody = response
    @searchFSMBillingSlabUnSuccessfully
    Scenario: Search FSM Billing Slab Successfully
        Given url searchFSMBillingSlab
        And params searchFSMBillingSlabParams
        And request searchFSMBillingSlabRequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        And def fsmBillingSlabResponseBody = response
    @updateFSMBillingSlabSuccessfully
    Scenario: Create FSM Billing Slab Successfully
        Given url updateFSMBillingSlab
        And request updateFSMBillingSlabRequest
        When method post
        Then status 200
        And def fsmBillingSlabResponseBody = response
        And def fsmBillingSlab = fsmBillingSlabResponseBody.billingSlab[0]

    @updateFSMBillingSlabUnSuccessfully
    Scenario: Create FSM Billing Slab UnSuccessfully
        Given url updateFSMBillingSlab
        And request updateFSMBillingSlabRequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        And def fsmBillingSlabResponseBody = response

    @calculateFSMBillingSlabSuccessfully
    Scenario: Calculate FSM Billing Slab Successfully
        Given url calculateFSMBillingSlab
        And request calculateFSMBillingSlabRequest
        When method post
        Then status 200
        And def fsmBillingSlabResponseBody = response
   @calculateFSMBillingSlabUnSuccessfully
    Scenario: Calculate FSM Billing Slab Successfully
        Given url calculateFSMBillingSlab
        And request calculateFSMBillingSlabRequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        And def fsmBillingSlabResponseBody = response
  @estimateFSMBillingSlabSuccessfully
    Scenario: Calculate FSM Billing Slab Successfully
        Given url estimateFSMBillingSlab
        And request estimateFSMBillingSlabRequest
        When method post
        Then status 200
        And def fsmBillingSlabResponseBody = response

  @estimateFSMBillingSlabUnSuccessfully
    Scenario: Calculate FSM Billing Slab UnSuccessfully
        Given url estimateFSMBillingSlab
        And request estimateFSMBillingSlabRequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        # * print response
        And def fsmBillingSlabResponseBody = response