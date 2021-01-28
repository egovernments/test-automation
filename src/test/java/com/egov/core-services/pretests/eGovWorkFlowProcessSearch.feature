Feature: Perform search using business id

Background:
* def workFlowProcessSearchPayload = read('../requestPayload/eGovWorkFlow/process/processSearch.json')

@processsearchsuccess
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url workFlowProcess 
     * print workFlowProcess 
     And params processSearchParam
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 200
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody

@processsearchoffset&limit
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js') 
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
     * print workFlowProcess 
     And params processSearchParam
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 200
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody

@processsearchwithoutbusinessid
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js')
  * def processSearchParam = 
    """
    {
     history: '#(history)',
     tenantId: '#(tenantId)'
    }
    """ 
     Given url workFlowProcess 
     * print workFlowProcess 
     And params processSearchParam 
     * print processSearchParam
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 200
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody
    
@processsearchonlytenantid
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js')
  * def processSearchParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
     Given url workFlowProcess 
     * print workFlowProcess
     And params processSearchParam  
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 200
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody

@processsearchnoparameter
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js')
     Given url workFlowProcess 
     * print workFlowProcess  
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 200
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody

@processsearchinvalidtenantid
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js')
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)'

    }
    """ 
     Given url workFlowProcess 
     * print workFlowProcess  
     And params processSearchParam
     * print processSearchParam
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 403
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody

@processsearchfail
Scenario: Perform search using business id
  * configure headers = read('classpath:websCommonHeaders.js')
  * def processSearchParam = 
    """
    {
     businessIds: '#(businessIds)',
     history: '#(history)',
     tenantId: '#(tenantId)'

    }
    """ 
     Given url workFlowProcess 
     * print workFlowProcess  
     And params processSearchParam
     * print processSearchParam
     And request workFlowProcessSearchPayload
     * print workFlowProcessSearchPayload
     When method post
     Then status 400
     And def processSearchResponseHeader = responseHeaders
     And def processSearchResponseBody = response
     * print processSearchResponseBody