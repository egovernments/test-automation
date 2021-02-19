 Feature: To test egf-master-chartOfAccountDetails service 'Search' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml')
        # Required parameters to create acccount
        * def glcode = ranInteger(6)
        * def name = ranString(5) + "Bank"
        * def isActiveForPosting = 'false'
        * def functionRequired = 'false'
        * def budgetCheckRequired = 'false'
        * def classification = '1'
        * def type = 'B'
        * def invalidTenantId = ranString(3)
        * call read('../../business-services/preTests/egfMasterPreTest.feature@createAccountSuccessfully')
        * call read('../../business-services/pretests/egfMasterPreTest.feature@createAccountDetailsType')
        * def requestPayload = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/create.json')
        * def requestPayloadToSearch = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/search.json')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        # Chart of Account 
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = chartAccountId
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.glcode = chartAccountGlcode
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.name = chartAccountName
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.description = randomString(8)
        # Account Details Type
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = accountTypeId
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.name = accountTypeName
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.description = accountTypeDescription
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.tableName = accountTypeTableName
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.active = accountTypeIsActive
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = accountTypefullyQualifiedName
        * call read('../../business-services/pretests/egfMasterPreTest.feature@createChartOfAccountDetails')
        # Invalid values
        * def validIdToSearch = accountDetailsCreateResponse.chartOfAccountDetails[0].id
        * def invalidGLCode = 'GL@'+ranInteger(5)
        * def invalidTenantId = 'tenant-'+randomString(4)
        * def invalidId = 'Id-'+ranInteger(5)
         

@ChartOfAccountDeatilsSearch_ValidId_01 @chartOfAccountDetailsSearch @egfMaster
Scenario: Search chart of account details with valid Id
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: '#(validIdToSearch)'}
    * call read('../../business-services/pretests/egfMasterPreTest.feature@searchChartOfAccountDetails')
    * match searchResponse.chartOfAccountDetails.size() != 0
    * match searchResponse.chartOfAccountDetails[0].id == validIdToSearch
    * match searchResponse.chartOfAccountDetails[0].tenantId == tenantId

@ChartOfAccountDeatilsSearch_InValidId_02 @chartOfAccountDetailsSearch @egfMaster
Scenario: Search chart of account details with invalid Id
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: '#(invalidId)'}
    * call read('../../business-services/pretests/egfMasterPreTest.feature@searchChartOfAccountDetails')
    * match searchResponse.chartOfAccountDetails.size() == 0

@ChartOfAccountDeatilsSearch_InvalidTenantId_03 @chartOfAccountDetailsSearch @egfMaster
Scenario: Search chart of account details with invalid tenantId
    * def searchAccountDetailsParams = { tenantId: '#(invalidTenantId)', id: '#(validIdToSearch)'}
    * call read('../../business-services/pretests/egfMasterPreTest.feature@searchChartOfAccountDetails')
    * assert searchResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@ChartOfAccountDeatilsSearch_All_04 @chartOfAccountDetailsSearch @egfMaster
Scenario: Search chart of account details with all details
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: '#(validIdToSearch)'}
    * call read('../../business-services/pretests/egfMasterPreTest.feature@searchChartOfAccountDetails')
    * match searchResponse.chartOfAccountDetails.size() != 0
    * match searchResponse.chartOfAccountDetails[0].id == validIdToSearch
    * match searchResponse.chartOfAccountDetails[0].tenantId == tenantId 

@ChartOfAccountDeatilsSearch_EmptyID_05 @chartOfAccountDetailsSearch @egfMaster
Scenario: Search chart of account details with empty Id
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: ''}
    * call read('../../business-services/pretests/egfMasterPreTest.feature@searchChartOfAccountDetails')
    * match searchResponse.chartOfAccountDetails.size() == 0

    