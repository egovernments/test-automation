Feature: Chart of account search

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def chartOfAccountSearchPayload = read('../../business-services/requestPayload/egfMasterChartOfAccount/search.json')

@searchAccountSuccessfully
Scenario: Searching chart of accounts through API call
  * call read('../../business-services/tests/egfMasterChartOfAccount.feature@ChartOfAccountCreate_01')
  * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)',
     id: '#(id)',
     glcode: '#(glcode)',
     classification: '#(classification)',
     name: '#(name)',
     isActiveForPosting: '#(isActiveForPosting)'
    }
    """ 
            Given url charOfAccountSearch
     * print charOfAccountSearch 
              And params chartOfAccountSearcheParam
     * print chartOfAccountSearcheParam
              And request chartOfAccountSearchPayload
     * print chartOfAccountSearchPayload
             When method post
             Then status 200
              And def chartOfAccountSearchResponseHeader = responseHeaders
              And def chartOfAccountSearchResponseBody = response
     * print chartOfAccountSearchResponseBody

@searchWithTenantIdSuccessfully
        Scenario: Searching chart of accounts through API call
  * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
            Given url charOfAccountSearch
     * print charOfAccountSearch 
              And params chartOfAccountSearcheParam
     * print chartOfAccountSearcheParam
              And request chartOfAccountSearchPayload
     * print chartOfAccountSearchPayload
             When method post
             Then status 200
              And def chartOfAccountSearchResponseHeader = responseHeaders
              And def chartOfAccountSearchResponseBody = response
     * print chartOfAccountSearchResponseBody

@searchAccountError
        Scenario: Searching chart of accounts through API call
  * call read('../../business-services/tests/egfMasterChartOfAccount.feature@ChartOfAccountCreate_01')
  * def chartOfAccountSearcheParam = 
    """
    {
     id: '#(id)',
     glcode: '#(glcode)',
     classification: '#(classification)',
     name: '#(name)',
     isActiveForPosting: '#(isActiveForPosting)'
    }
    """ 
            Given url charOfAccountSearch
     * print charOfAccountSearch 
              And params chartOfAccountSearcheParam
     * print chartOfAccountSearcheParam
              And request chartOfAccountSearchPayload
     * print chartOfAccountSearchPayload
             When method post
             Then status 400
              And def chartOfAccountSearchResponseHeader = responseHeaders
              And def chartOfAccountSearchResponseBody = response
     * print chartOfAccountSearchResponseBody

@unauthorizedaccessError
        Scenario: Searching chart of accounts through API call
  * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)',
     id: '#(id)',
     glcode: '#(glcode)',
     classification: '#(classification)',
     name: '#(name)',
     isActiveForPosting: '#(isActiveForPosting)'
    }
    """ 
            Given url charOfAccountSearch
     * print charOfAccountSearch 
              And params chartOfAccountSearcheParam
     * print chartOfAccountSearcheParam
              And request chartOfAccountSearchPayload
     * print chartOfAccountSearchPayload
             When method post
             Then status 403
              And def chartOfAccountSearchResponseHeader = responseHeaders
              And def chartOfAccountSearchResponseBody = response
     * print chartOfAccountSearchResponseBody