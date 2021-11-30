Feature: Perform search to get the count of process

Background:
* def workFlowProcessCountPayload = read('../../core-services/requestPayload/egov-workflow/process/processCount.json')

@searchWorkflowProcessCountSuccessfully
Scenario: search workflow process using business id
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js') 
  * def processCountParam = 
    """
    {
     tenantId: '#(tenantId)'
    }

    """
     Given url workFlowProcessCount 
     And params processCountParam 
     And request workFlowProcessCountPayload
     When method post
     Then status 200
     And def processCountResponseHeader = responseHeaders
     And def processCountResponseBody = response