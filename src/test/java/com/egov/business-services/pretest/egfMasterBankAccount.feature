Feature: Bank of account
Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  * def bankAccountCreatePayload = read('../../business-services/requestPayload/egf-master-bank-account/create.json')
  * def banktAccountSearchPayload = read('../../business-services/requestPayload/egf-master-bank-account/search.json')
  * def bankAccountUpdatePayload = read('../../business-services/requestPayload/egf-master-bank-account/update.json')

# Create Bank Account
@createAccountSuccessfully
Scenario: Creating bank of accounts through API call
  * def bankAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url backAccountCreate 
    And params bankAccountCreateParam
    And request bankAccountCreatePayload
    When method post
    Then status 201
    And def bankAccountCreateResponseHeader = responseHeaders
    And def bankAccountCreateResponseBody = response
    * def id = bankAccountCreateResponseBody.bankAccounts[0].id
    * def accountNumber = bankAccountCreateResponseBody.bankAccounts[0].accountNumber
    * def accountType = bankAccountCreateResponseBody.bankAccounts[0].accountType
    * def description = bankAccountCreateResponseBody.bankAccounts[0].description
    * def active = bankAccountCreateResponseBody.bankAccounts[0].active
    * def payTo = bankAccountCreateResponseBody.bankAccounts[0].payTo
    * def type = bankAccountCreateResponseBody.bankAccounts[0].type
    * def ids = bankAccountCreateResponseBody.bankAccounts[0].bankBranch.createdBy.id
    * def glcode = bankAccountCreateResponseBody.bankAccounts[0].chartOfAccount.glcode
    * def name = bankAccountCreateResponseBody.bankAccounts[0].chartOfAccount.name

@errorInAccount
Scenario: Creating bank of accounts and check for errors
  * def bankAccountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url backAccountCreate 
    And params bankAccountCreateParam
    And request bankAccountCreatePayload
    When method post
    Then status 400
    And def bankAccountResponseHeader = responseHeaders
    And def bankAccountResponseBody = response

# Update bank account
@updateAccountSuccessfully
Scenario: Update bank of accounts through API call
  * def bankAccountUpdateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url backAccountCreate 
    And params bankAccountUpdateParam
    And request bankAccountUpdatePayload
    When method post
    Then status 201
    And def bankAccountUpdateResponseHeader = responseHeaders
    And def bankAccountUpdateResponseBody = response

# Search bank account
@searchAccountSuccessfully
Scenario: Search bank of accounts through API call
  * def bankAccountSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     name: '#(name)',
     active: '#(active)',
     glcode: '#(glcode)'
    }
    """ 
    Given url backAccountSearch 
    And params bankAccountSearchParam
    And request banktAccountSearchPayload
    When method post
    Then status 200
    And def bankAccountSearchResponseHeader = responseHeaders
    And def bankAccountSearchResponseBody = response

@searchAccountS
Scenario: Search bank of accounts through API call
  * def bankAccountSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     name: '#(name)',
     accountNumber: '#(accountNumber)',
     accountType: '#(accountType)',
     payTo: '#(payTo)',
     active: '#(active)',
     glcode: '#(glcode)'
    }
    """ 
    Given url backAccountSearch 
    And params bankAccountSearchParam
    And request banktAccountSearchPayload
    When method post
    Then status 200
    And def bankAccountSearchResponseHeader = responseHeaders
    And def bankAccountSearchResponseBody = response

@withoutTenantId
Scenario: Search bank of accounts without tenantid
  * def bankAccountSearchParam = 
    """
    {
     name: '#(name)',
     active: '#(active)',
     glcode: '#(glcode)'
    }
    """ 
    Given url backAccountSearch 
    And params bankAccountSearchParam
    And request banktAccountSearchPayload
    When method post
    Then status 400
    And def bankAccountSearchResponseHeader = responseHeaders
    And def bankAccountSearchResponseBody = response

@invalidTenatId
Scenario: Search bank of accounts with invalid tenantid
  * def bankAccountSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     name: '#(name)',
     active: '#(active)',
     glcode: '#(glcode)'
    }
    """ 
    Given url backAccountSearch 
    And params bankAccountSearchParam
    And request banktAccountSearchPayload
    When method post
    Then status 403
    And def bankAccountSearchResponseHeader = responseHeaders
    And def bankAccountSearchResponseBody = response

@invalidActiveValue
Scenario: Search bank of accounts with invalid tenantid
  * def bankAccountSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     name: '#(name)',
     active: '#(active)',
     glcode: '#(glcode)'
    }
    """ 
    Given url backAccountSearch 
    And params bankAccountSearchParam
    And request banktAccountSearchPayload
    When method post
    Then status 400
    And def bankAccountSearchResponseHeader = responseHeaders
    And def bankAccountSearchResponseBody = response