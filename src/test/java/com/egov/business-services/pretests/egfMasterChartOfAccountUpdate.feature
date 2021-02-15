Feature: Chart of account update

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
  * def chartOfAccountUpdatePayload = read('../../business-services/requestPayload/egfMasterChartOfAccount/update.json')
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].id = id
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].glcode = glcode 
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].name = name
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].isActiveForPosting = isActiveForPosting
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].type = type
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].classification = classification
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].functionRequired = functionRequired
    * set chartOfAccountUpdatePayload.chartOfAccounts[0].budgetCheckRequired = budgetCheckRequired

@updateAccountSuccessfully
Scenario: Updating chart of accounts through API call
  #  * call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
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

@unAuthorizedAccessError
Scenario: Updating chart of accounts  and check for error through API call
  #  * call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
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
     Then status 403
     And def chartOfAccountUpdateResponseHeader = responseHeaders
     And def chartOfAccountUpdateResponseBody = response
     * print chartOfAccountUpdateResponseBody