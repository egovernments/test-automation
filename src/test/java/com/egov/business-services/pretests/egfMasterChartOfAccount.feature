Feature: Chart of account create
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def chartOfAccountCreatePayload = read('../../business-services/requestPayload/egfMasterChartOfAccount/create.json')
  * def chartOfAccountSearchPayload = read('../../business-services/requestPayload/egfMasterChartOfAccount/search.json')
  * def chartOfAccountUpdatePayload = read('../../business-services/requestPayload/egfMasterChartOfAccount/update.json')

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
Scenario: Creating chart of accounts and check for error through API call
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

@unauthorizedaccessError
Scenario: Creating chart of accounts and check for errors through API call
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
    And def chartOfAccountResponseHeader = responseHeaders
    And def chartOfAccountResponseBody = response

# Chart of account search pretest
@searchAccountSuccessfully
Scenario: Searching chart of accounts through API call
  * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)',
     id: '#(id)',
     glcode: '#(glcode)',
     type: '#(type)',
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
Scenario: Searching chart of accounts with TenantId through API call
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
Scenario: Searching chart of accounts and check for error through API call
  * def chartOfAccountSearcheParam = 
    """
    {
     id: '#(id)',
     glcode: '#(glcode)',
     classification: '#(classification)',
     name: '#(name)',
     type: '#(type)',
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

# Chart of Account Update
@updateAccountSuccessfully
Scenario: Updating chart of accounts through API call
    * def chartOfAccountUpdateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
     Given url chartOfAccountUpdate
     * print chartOfAccountUpdate 
     And params chartOfAccountUpdateParam
     * print chartOfAccountUpdateParam
     And request chartOfAccountUpdatePayload
     * print chartOfAccountUpdatePayload
     When method post
     Then status 201
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response
     * print chartOfAccountUpdateResponseBody

@updateAccountError
Scenario: Updating chart of accounts and check for error through API call
    * def chartOfAccountUpdateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
     Given url chartOfAccountUpdate
     * print chartOfAccountUpdate 
     And params chartOfAccountUpdateParam
     * print chartOfAccountUpdateParam
     And request chartOfAccountUpdatePayload
     * print chartOfAccountUpdatePayload
     When method post
     Then status 400
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response
     * print chartOfAccountUpdateResponseBody