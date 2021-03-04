 Feature: To test egf-master-chartOfAccountDetails service 'Create' endpoint

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
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createAccountSuccessfully')
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createAccountDetailsType')
        * def requestPayload = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/create.json')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        # Chart of Account 
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = id
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.glcode = glcode
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.name = name
        * set requestPayload.chartOfAccountDetails[0].chartOfAccount.description = randomString(8)
        # Account Details Type
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = accountTypeId
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.name = accountTypeName
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.description = accountTypeDescription
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.tableName = accountTypeTableName
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.active = accountTypeIsActive
        * set requestPayload.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = accountTypefullyQualifiedName
        # Invalid values
        * def invalidGLCode = 'GL@'+ranInteger(5)
        * def invalidTenantId = 'Invalid-'+randomString(4)
  
         

@ChartOfAccountDeatilsCreate_01 @ChartOfAccountDeatilsCreate_ValidNameAndDescription_06 @ChartOfAccountDeatilsCreate_tableNameAndFullyQualifiedName_07 @positive @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with valid Id
    # Steps to create Chart Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Validate the size of `chartOfAccountDetails` response array should not be `0`
    * assert response.chartOfAccountDetails.size() != 0
    # Validate chart of account id 
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].id == chartAccountId
    # Validate chart of account glcode 
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].glcode == chartAccountGlcode
    # Validate chart of account name 
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].name == chartAccountName
    # Validate chart of account detail type - id 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].id == accountTypeId
    # Validate chart of account detail type - name 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].name == accountTypeName
    # Validate chart of account detail type - description 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].description == accountTypeDescription
    # Validate chart of account detail type - table name 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].tableName == tableName
    # Validate chart of account detail type - active
    * assert response.chartOfAccountDetails[0]['accountDetailType'].active == accountTypeIsActive
    # Validate chart of account detail type - fullyQualifiedName
    * assert response.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName == accountTypefullyQualifiedName

@ChartOfAccountDeatilsCreate_InvalidId_02 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid ids
    # Set an invalid id to chart of account id 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = randomString(5)
    # Set an invalid id to chart of account details id 
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = randomString(5)
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsCreate_InvalidGLCode_03 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid GLCode
    # Set an invalid GLCode to chart of account id 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.glcode = invalidGLCode
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Validate that API should not consider the invalid GLCode it should only conder the valid GLCode
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].glcode != invalidGLCode

@ChartOfAccountDeatilsCreate_InvalidTenantId_04 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid tenantId
    # Set invalid tenantIds into request payload 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.tenantId = invalidTenantId
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.tenantId = invalidTenantId
    * set requestPayload.chartOfAccountDetails[0].tenantId = invalidTenantId
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    # Validate the actual error message returned by API should be equal to expected error message due to invalid tenantId
    * assert response.Errors[0].message == commonConstants.errorMessages.authorizedError

@ChartOfAccountDeatilsCreate_NullID_05 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with null id
    # Set invalid tenantIds into request payload 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = null
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = null
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    # Validate the actual error message returned by API should be equal to expected error message due to invalid tenantId
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsCreate_WithNullValues_08 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with all null values
    # Set `null` values to the respective fields of Create Account 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.glcode = null
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.name = null
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.description = null
    # Set `null` values to the respective fields of Create Account Type
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.name = null
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.description = null
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.tableName = null
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.active = null
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = null
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Validate that chart account glCode field value is not updated with `null` 
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].glcode != null
    # Validate chart account name field value is not updated with `null` 
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].name != null
    # Validate that name field value is not updated with `null`  
    * assert response.chartOfAccountDetails[0]['accountDetailType'].name != null
    # Validate that description field value is not updated with `null` 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].description != null
    # Validate table name field value is not updated with `null` 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].tableName != null
    # Validate that active field value is not updated with `null` 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].active != null
    # Validate that fullyQualifiedName field value is not updated with `null` 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName != null

@ChartOfAccountDeatilsCreate_InvalidChartAccountIdId_09 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid Chart Account Id
    # Set an invalid id to chart of account id 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = 'Invalid-'+randomString(5)
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsCreate_InvalidAccountDetailTypeIdId_10 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid Account Details Type Id
    # Set an invalid id to chart of account details type id 
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = 'Invalid-'+randomString(5)
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 