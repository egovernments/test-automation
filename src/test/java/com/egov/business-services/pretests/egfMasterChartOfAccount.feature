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
    And params chartOfAccountCreateParam
    And request chartOfAccountCreatePayload
    When method post
    Then status 201
    And def chartOfAccountCreateResponseHeader = responseHeaders
    And def chartOfAccountCreateResponseBody = response
    And def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].name
    And def functionRequired = chartOfAccountCreateResponseBody.chartOfAccounts[0].functionRequired
    And def type = chartOfAccountCreateResponseBody.chartOfAccounts[0].type
    And def classification = chartOfAccountCreateResponseBody.chartOfAccounts[0].classification
    And def glcode = chartOfAccountCreateResponseBody.chartOfAccounts[0].glcode
    And def isActiveForPosting = chartOfAccountCreateResponseBody.chartOfAccounts[0].isActiveForPosting
    And def id = chartOfAccountCreateResponseBody.chartOfAccounts[0].id
    And def budgetCheckRequired = chartOfAccountCreateResponseBody.chartOfAccounts[0].budgetCheckRequired

@errorInAccoutCreate
Scenario: Creating chart of accounts and check for error through API call
  * def chartOfAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url chartOfAccountCreate
    And params chartOfAccountCreateParam
    And request chartOfAccountCreatePayload
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
    And params chartOfAccountCreateParam
    And request chartOfAccountCreatePayload
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
    And params chartOfAccountSearcheParam
    And request chartOfAccountSearchPayload
    When method post
    Then status 200
    And def chartOfAccountSearchResponseHeader = responseHeaders
    And def chartOfAccountSearchResponseBody = response

@searchWithTenantIdSuccessfully
Scenario: Searching chart of accounts with TenantId through API call
  * def chartOfAccountSearcheParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url charOfAccountSearch 
    And params chartOfAccountSearcheParam
    And request chartOfAccountSearchPayload
    When method post
    Then status 200
    And def chartOfAccountSearchResponseHeader = responseHeaders
    And def chartOfAccountSearchResponseBody = response

@errorInSearchAccount
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
    And params chartOfAccountSearcheParam
    And request chartOfAccountSearchPayload
    When method post
    Then status 400
    And def chartOfAccountSearchResponseHeader = responseHeaders
    And def chartOfAccountSearchResponseBody = response

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
     And params chartOfAccountUpdateParam
     And request chartOfAccountUpdatePayload
     When method post
     Then status 201
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response

@errorInUpdateAccount
Scenario: Updating chart of accounts and check for error through API call
    * def chartOfAccountUpdateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
     Given url chartOfAccountUpdate 
     And params chartOfAccountUpdateParam
     And request chartOfAccountUpdatePayload
     When method post
     Then status 400
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response