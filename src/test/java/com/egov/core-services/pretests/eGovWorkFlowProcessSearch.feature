Feature: Perform search using business id

        Background:
* def workFlowProcessSearchPayload = read('../../core-services/requestPayload/eGovWorkFlow/process/processSearch.json')

        @searchWorkflowProcessSuccessfully
        Scenario: Perform search using business id
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url workFlowProcess
              And params processSearchParam
              And request workFlowProcessSearchPayload
             When method post
             Then status 200
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response
     

        @searchWorkflowProcessOffsetAndLimit
        Scenario: Perform search using offset and limit
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)',
     start: '#(start)',
     end: '#(end)'

    }
    """ 
            Given url workFlowProcess
              And params processSearchParam
              And request workFlowProcessSearchPayload
             When method post
             Then status 200
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response
     

        @searchWorkflowProcessWithoutBusinessid
        Scenario: Perform search wihtout passing business id
  * def processSearchParam = 
    """
    {
     history: '#(history)',
     tenantId: '#(tenantId)'
    }
    """ 
            Given url workFlowProcess
              And params processSearchParam
              And request workFlowProcessSearchPayload
             When method post
             Then status 200
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response
     
    
        @searchWorkflowProcessWithOnlyTenantid
        Scenario: Perform search with only tenantId
  * def processSearchParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
            Given url workFlowProcess
              And params processSearchParam
              And request workFlowProcessSearchPayload
             When method post
             Then status 200
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response

        @searchProcessWithNoParameter
        Scenario: Perform search with no parameter
            Given url workFlowProcess
              And request workFlowProcessSearchPayload
             When method post
             Then status 200
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response

        @searchProcessWithInvalidTenantid
        Scenario: Perform search with invalid tenantId
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)'

    }
    """ 
            Given url workFlowProcess
              And params processSearchParam
              And request workFlowProcessSearchPayload
             When method post
             Then status 403
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response

        @searchProcessError
        Scenario: Perform search error
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)'

    }
    """ 
            Given url workFlowProcess
              And params processSearchParam
              And request workFlowProcessSearchPayload
             When method post
             Then status 400
              And def processSearchResponseHeader = responseHeaders
              And def processSearchResponseBody = response

@searchAssigneeSuccess
Scenario: Perform search using business id
  * def processSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     assignee: '#(uuid)'
    }

    """ 
     Given url workFlowProcess 
     And params processSearchParam
     And request workFlowProcessSearchPayload
     When method post
     Then status 200
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response