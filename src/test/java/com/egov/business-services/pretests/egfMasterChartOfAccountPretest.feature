Feature: Pretest scenarios for egf-master-ChartOfAccount Service endpoints

    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml') 
        * def name = randomString(10)
        * def tableName = egfMasterConstants.chartOfAccountDeatails.params.tableName
        * def fullyQualifiedName = randomString(3)+"/"+tableName
        * def description = 'TEST_'+randomString(5)
        * def active = egfMasterConstants.chartOfAccountDeatails.params.active
        * def accountDetailsTypePayload = read('../../business-services/requestPayload/egfMaster/accountDetailsType.json')
        * def accountDetailsUpdatePayload = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/update.json')
        # Need to be removed
        * def glcode = randomString(6)
        * def isActiveForPosting = egfMasterConstants.chartOfAccount.params.isActiveForPosting
        * def type = egfMasterConstants.chartOfAccount.params.type
        * def classification = egfMasterConstants.chartOfAccount.params.classification
        * def functionRequired = egfMasterConstants.chartOfAccount.params.functionRequired
        * def budgetCheckRequired = egfMasterConstants.chartOfAccount.params.budgetCheckRequired
        * def chartOfAccountCreatePayload = read('../../business-services/requestPayload/egfMaster/chartOfAccountCreate.json')
        * configure headers = read('classpath:websCommonHeaders.js')
   

# Need to be removed (Duplicate)
@createChartOfAccount
    Scenario: To create Chart of Account
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url createCharOfAccount
    And params params
    And request chartOfAccountCreatePayload
    When method post
    Then status 201
    And def chartAccountId = response.chartOfAccounts[0].id
    And def chartAccountGlcode = response.chartOfAccounts[0].glcode
    And def chartAccountName = response.chartOfAccounts[0].name
    And def chartOfAccountResponse = response

@createAccountDetailsType
    Scenario: To create account details type
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url accountDetailsType
    And params params
    And request accountDetailsTypePayload
    When method post
    Then status 201
    And def accountTypeId = response.accountDetailTypes[0].id
    And def accountTypeName = response.accountDetailTypes[0].name
    And def accountTypeDescription = response.accountDetailTypes[0].description
    And def accountTypeTableName = response.accountDetailTypes[0].tableName
    And def accountTypeIsActive = response.accountDetailTypes[0].active
    And def accountTypefullyQualifiedName = response.accountDetailTypes[0].fullyQualifiedName
    And def accountDetailsTypeResponse = response
  
@createChartOfAccountDetails
    Scenario: To create chart of account details
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url createAccountDetails
    And params params
    And request requestPayload
        * print requestPayload
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 403
    And def accountDetailsCreateResponse = response

@updateChartOfAccountDetails
    Scenario: To update chart of account details
    * def params = 
    """
    {
        tenantId: '#(tenantId)'
    }    
    """
    Given url updateAccountDetails
    And params params
    And request requestPayloadToUpdate
        * print requestPayloadToUpdate
    When method post
    Then assert responseStatus == 201 || responseStatus == 500 || responseStatus == 403 || responseStatus == 400
    And def updateResponse = response
        * print updateResponse
    
@searchChartOfAccountDetails
    Scenario: To search chart of account details
    Given url searchAccountDetails
    And params searchAccountDetailsParams
        * print searchAccountDetailsParams
    And request requestPayloadToSearch
        * print requestPayloadToUpdate
    When method post
    Then assert responseStatus == 200 || responseStatus == 403
    And def searchResponse = response
        * print searchResponse

