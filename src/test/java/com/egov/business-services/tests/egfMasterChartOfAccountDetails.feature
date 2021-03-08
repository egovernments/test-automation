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
        * def requestPayloadToUpdate = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/update.json')
        * def requestPayloadToSearch = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/search.json')
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
        * def invalidId = 'Id-'+ranInteger(5)
        # For Update request payload 
        * set requestPayloadToUpdate.chartOfAccountDetails = requestPayload.chartOfAccountDetails
        
         
@ChartOfAccountDeatilsCreate_01 @positive @chartOfAccountDetailsCreate @egfMaster
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

#bug: Internal Server error 500 for Invalid Ids. Should throw proper message
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

#bug: Internal Server error 500 for null Id. Should throw proper message
@ChartOfAccountDeatilsCreate_NullID_05 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with null id
    # Set invalid tenantIds into request payload 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = null
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = null
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    # Validate the actual error message returned by API should be equal to expected error message due to invalid tenantId
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 


@ChartOfAccountDeatilsCreate_ValidNameAndDescription_06 @positive @chartOfAccountDetailsCreate @egfMaster
Scenario: Create Chart Of Account Details with Valid Name & Description
    # Steps to create Chart Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Validate the size of `chartOfAccountDetails` response array should not be `0`
    * assert response.chartOfAccountDetails.size() != 0
    # Validate chart of account name 
    * assert response.chartOfAccountDetails[0]['chartOfAccount'].name == chartAccountName
    # Validate chart of account detail type - name 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].name == accountTypeName
    # Validate chart of account detail type - description 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].description == accountTypeDescription

@ChartOfAccountDeatilsCreate_tableNameAndFullyQualifiedName_07 @positive @chartOfAccountDetailsCreate @egfMaster
Scenario: Create Chart Of Account Details with Valid tableName & fully qualified name
    # Steps to create Chart Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Validate the size of `chartOfAccountDetails` response array should not be `0`
    # Validate chart of account detail type - table name 
    * assert response.chartOfAccountDetails[0]['accountDetailType'].tableName == tableName
    # Validate chart of account detail type - fullyQualifiedName
    * assert response.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName == accountTypefullyQualifiedName

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

#bug: Internal Server error 500 for Invalid Chart Account Id. Should throw proper message
@ChartOfAccountDeatilsCreate_InvalidChartAccountIdId_09 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid Chart Account Id
    # Set an invalid id to chart of account id 
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.id = 'Invalid-'+randomString(5)
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

#bug: Internal Server error 500 for Invalid Account Details Id. Should throw proper message
@ChartOfAccountDeatilsCreate_InvalidAccountDetailTypeIdId_10 @negative @chartOfAccountDetailsCreate @egfMaster
Scenario: Create chart of account details with invalid Account Details Type Id
    # Set an invalid id to chart of account details type id 
    * set requestPayload.chartOfAccountDetails[0].accountDetailType.id = 'Invalid-'+randomString(5)
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

# Update Chart of Account Details 

@ChartOfAccountDeatilsUpdateUsingExistingId_01 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with Existing ID
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = response.chartOfAccountDetails[0].id
    # Steps to create Chart of Account Details again with existing ID
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.name = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.active = 'true'
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = randomString(4)
    # Steps to update Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@updateChartOfAccountDetails')
    # Validate the response after update
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].id == id
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].glcode != requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].name != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].id == accountTypeId
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].name != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].description != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].tableName != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName

@ChartOfAccountDeatilsUpdateUsingNewId_02 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with New ID
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning ID into the update request body
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = response.chartOfAccountDetails[0].id
    # Assigning values to the fields
    * def glcode = ranInteger(6)
    * def name = ranString(5) + "Bank"
    * def invalidTenantId = ranString(3)
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createAccountSuccessfully')
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createAccountDetailsType')
    # Assigning all required request body paramter values for Update Chart of Account Details
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.id = id
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.id = accountTypeId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode = glcode
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.name = name
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name = accountTypeName
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description = accountTypeDescription
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName = accountTypeTableName
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.active = 'true'
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = accountTypefullyQualifiedName
    # Steps to update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@updateChartOfAccountDetails')
    # Validate the response after Update
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].id != accountDetailsCreateResponse.chartOfAccountDetails[0]['chartOfAccount'].id
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].glcode != accountDetailsCreateResponse.chartOfAccountDetails[0]['chartOfAccount'].glcode
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].name != accountDetailsCreateResponse.chartOfAccountDetails[0]['chartOfAccount'].name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].id != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].id
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].name != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].description != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].description
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].tableName == accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].tableName 
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName 
  
@ChartOfAccountDeatilsUpdateUsingNullId_03 @chartOfAccountDetailsUpdate @egfMaster @regression
Scenario: Update Chart Of Account Details null IDs
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning request body paramter value to Update the Chart of Account Details with null id
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = null
    # Step to Update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateChartOfAccountDetails')
    # Validate the response after update
    * assert updateResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * assert updateResponse.errors[0].message == commonConstants.errorMessages.mandatoryFieldError 

#bug: Internal Server error 500 for Invalid Ids. Should throw proper message
@ChartOfAccountDeatilsUpdateInvalidChartOfAccountIdAndAccountDetailsTypeId_04 @chartOfAccountDetailsUpdate @egfMaster @regression
Scenario: Update Chart Of Account Details invalid IDs
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning request body paramter value to Update the Chart of Account Details with invalid Ids
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.id = 'Invalid@'+randomString(3)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.id =  'Invalid@'+randomString(3)
    # Step to Update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateChartOfAccountDetails')
    # Validate the response after update
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsUpdateInvalidTenantId_05 @chartOfAccountDetailsUpdate @egfMaster @regression
Scenario: Update Chart Of Account Details with invalid tenantIds
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning request body paramter value to Update the Chart of Account Details with invalid tenant Ids
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.tenantId = invalidTenantId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tenantId =  invalidTenantId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].tenantId =  invalidTenantId
    # Step to Update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateChartOfAccountDetails')
    # Validate the response after update
    * assert updateResponse.Errors[0].message == commonConstants.errorMessages.authorizedError 

#bug: Internal Server error 500 for Invalid chart of account Id. Should throw proper message
@ChartOfAccountDeatilsUpdate_InvalidChartAccountIdId_06 @chartOfAccountDetailsUpdate @egfMaster @regression
Scenario: Update Chart Of Account Details with invalid chartOfAccountId
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning request body paramter value to Update the Chart of Account Details with null ids
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.id = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = null
    # Step to Update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateChartOfAccountDetails')
    # Validate the response after update
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

#bug: Internal Server error 500 for Invalid chart of account type Id. Should throw proper message
@ChartOfAccountDeatilsUpdate_InvalidAccountDetailTypeIdId_7 @chartOfAccountDetailsUpdate @egfMaster @regression
Scenario: Update Chart Of Account Details with invalid Account type id
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning request body paramter value to Update the Chart of Account Details with null ids
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.id =  null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = null
    # Step to Update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateChartOfAccountDetails')
    # Validate the response after update
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsUpdate_NullValues_8 @chartOfAccountDetailsUpdate @egfMaster @regression
Scenario: Update Chart Of Account Details with Null values
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning request body paramter value to Update the Chart of Account Details with null values
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = response.chartOfAccountDetails[0].id
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.name = null
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.description = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.active = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = null
    # Step to Update the Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@updateChartOfAccountDetails')
    # Validate the response after update
    * assert updateResponse.chartOfAccountDetails.size() != 0
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].id == id
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].id == accountTypeId

# Search Chart of Account Details

@ChartOfAccountDeatilsSearch_ValidId_01 @chartOfAccountDetailsSearch @egfMaster @regression
Scenario: Search chart of account details with valid Id
    # Steps to create Chart of Account Details
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    * def validIdToSearch = accountDetailsCreateResponse.chartOfAccountDetails[0].id
    # Prepare the Search parameters 
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: '#(validIdToSearch)'}
    # Steps to Search the created chart of account details with search parameter
    * call read('../../business-services/pretest/egfMasterPreTest.feature@searchChartOfAccountDetails')
    # Validate the search results
    * match searchResponse.chartOfAccountDetails.size() != 0
    * match searchResponse.chartOfAccountDetails[0].id == validIdToSearch
    * match searchResponse.chartOfAccountDetails[0].tenantId == tenantId

@ChartOfAccountDeatilsSearch_InValidId_02 @chartOfAccountDetailsSearch @egfMaster @regression
Scenario: Search chart of account details with invalid Id
    # Prepare the Search parameters with invalid id
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: '#(invalidId)'}
    * call read('../../business-services/pretest/egfMasterPreTest.feature@searchChartOfAccountDetails')
    # Validate the search result
    * match searchResponse.chartOfAccountDetails.size() == 0

@ChartOfAccountDeatilsSearch_InvalidTenantId_03 @chartOfAccountDetailsSearch @egfMaster @regression
Scenario: Search chart of account details with invalid tenantId
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    * def validIdToSearch = accountDetailsCreateResponse.chartOfAccountDetails[0].id
    # Prepare the Search parameters with invalid tenantId
    * def searchAccountDetailsParams = { tenantId: '#(invalidTenantId)', id: '#(validIdToSearch)'}
    # Steps to Search the created chart of account details with search parameter
    * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInSearchChartOfAccountDetails')
    # Validate the error message
    * assert searchResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@ChartOfAccountDeatilsSearch_All_04 @chartOfAccountDetailsSearch @egfMaster @regression
Scenario: Search chart of account details with all details
    # Steps to create chart of account details first
    * call read('../../business-services/pretest/egfMasterPreTest.feature@createChartOfAccountDetails')
    # Assigning the id in validIdToSearch global variable
    * def validIdToSearch = accountDetailsCreateResponse.chartOfAccountDetails[0].id
    # Prepare the Search parameters
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: '#(validIdToSearch)'}
    * call read('../../business-services/pretest/egfMasterPreTest.feature@searchChartOfAccountDetails')
    # Validate the Search results
    * match searchResponse.chartOfAccountDetails.size() != 0
    * match searchResponse.chartOfAccountDetails[0].id == validIdToSearch
    * match searchResponse.chartOfAccountDetails[0].tenantId == tenantId 

@ChartOfAccountDeatilsSearch_EmptyID_05 @chartOfAccountDetailsSearch @egfMaster @regression
Scenario: Search chart of account details with empty Id
    # Prepare the Search parameters with empty id
    * def searchAccountDetailsParams = { tenantId: '#(tenantId)', id: ''}
    * call read('../../business-services/pretest/egfMasterPreTest.feature@searchChartOfAccountDetails')
    # Validate the Search results
    * match searchResponse.chartOfAccountDetails.size() == 0