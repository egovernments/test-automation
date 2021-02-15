Feature: Chart of account create

  Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def chartOfAccountCreatePayload = read('../../business-services/requestPayload/egfMasterChartOfAccount/create.json')

  @createAccountSuccessfully
        Scenario: Creating chart of accounts through API call
  * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
            Given url chartOfAccountCreate
     * print chartOfAccountCreate 
              And params chartOfAccountCreateParam
     * print chartOfAccountCreateParam
              And request chartOfAccountCreatePayload
     * print chartOfAccountCreatePayload
             When method post
             Then status 201
              And def chartOfAccountCreateResponseHeader = responseHeaders
              And def chartOfAccountCreateResponseBody = response
              And def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].name
              And def functionRequired = chartOfAccountCreateResponseBody.chartOfAccounts[0].functionRequired
              * print functionRequired
              And def type = chartOfAccountCreateResponseBody.chartOfAccounts[0].type
              * print type
              And def classification = chartOfAccountCreateResponseBody.chartOfAccounts[0].classification
              * print classification
              And def glcode = chartOfAccountCreateResponseBody.chartOfAccounts[0].glcode
              * print glcode
              And def isActiveForPosting = chartOfAccountCreateResponseBody.chartOfAccounts[0].isActiveForPosting
              * print isActiveForPosting
              And def id = chartOfAccountCreateResponseBody.chartOfAccounts[0].id
              * print id
              And def budgetCheckRequired = chartOfAccountCreateResponseBody.chartOfAccounts[0].budgetCheckRequired
              * print budgetCheckRequired
     * print chartOfAccountCreateResponseBody

@createAccountError
        Scenario: Creating chart of accounts through API call
  * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
            Given url chartOfAccountCreate
     * print chartOfAccountCreate 
              And params chartOfAccountCreateParam
     * print chartOfAccountCreateParam
              And request chartOfAccountCreatePayload
     * print chartOfAccountCreatePayload
             When method post
             Then status 400
              And def chartOfAccountCreateResponseHeader = responseHeaders
              And def chartOfAccountCreateResponseBody = response
     * print chartOfAccountCreateResponseBody

@unauthorizedaccessError
        Scenario: Creating chart of accounts through API call
  * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
            Given url chartOfAccountCreate
     * print chartOfAccountCreate 
              And params chartOfAccountCreateParam
     * print chartOfAccountCreateParam
              And request chartOfAccountCreatePayload
     * print chartOfAccountCreatePayload
             When method post
             Then status 403
              And def chartOfAccountCreateResponseHeader = responseHeaders
              And def chartOfAccountCreateResponseBody = response
     * print chartOfAccountCreateResponseBody