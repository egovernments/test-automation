 Feature: To test egf-master-chartOfAccountDetails service 'Update' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml')
        * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@createChartOfAccount')
        * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@createAccountDetailsType')
        * def requestPayload = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/create.json')
        * def requestPayloadToUpdate = read('../../business-services/requestPayload/egfMaster/chartOfAccountDetails/update.json')
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
        # Steps to create Chart Account Details
        * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@createChartOfAccountDetails')
        # For Update request payload 
        * set requestPayloadToUpdate.chartOfAccountDetails = requestPayload.chartOfAccountDetails
        * set requestPayloadToUpdate.chartOfAccountDetails[0].id = response.chartOfAccountDetails[0].id
        # Invalid values
        * def invalidGLCode = 'GL@'+ranInteger(5)
        * def invalidTenantId = 'Invalid-'+randomString(4)
         

@ChartOfAccountDeatilsUpdateUsingExistingId_01 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with Existing ID
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.name = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName = randomString(4)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.active = 'true'
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = randomString(4)
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].id == chartAccountId
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].glcode != requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].name != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].id == accountTypeId
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].name != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].description != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].tableName != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName != requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName

@ChartOfAccountDeatilsUpdateUsingNewId_02 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with New ID
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@createChartOfAccount')
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@createAccountDetailsType')
    # * set requestPayloadToUpdate.chartOfAccountDetails = requestPayload.chartOfAccountDetails
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.id = chartAccountId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.id =  accountTypeId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode = chartAccountGlcode
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.name = chartAccountName
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name = accountTypeName
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description = accountTypeDescription
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName = accountTypeTableName
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.active = 'true'
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = accountTypefullyQualifiedName
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].id != accountDetailsCreateResponse.chartOfAccountDetails[0]['chartOfAccount'].id
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].glcode != accountDetailsCreateResponse.chartOfAccountDetails[0]['chartOfAccount'].glcode
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].name != accountDetailsCreateResponse.chartOfAccountDetails[0]['chartOfAccount'].name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].id != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].id
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].name != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].name
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].description != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].description
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].tableName == accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].tableName 
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName != accountDetailsCreateResponse.chartOfAccountDetails[0]['accountDetailType'].fullyQualifiedName 
  
@ChartOfAccountDeatilsUpdateUsingNullId_03 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details null IDs
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = null
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert updateResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * assert updateResponse.errors[0].message == commonConstants.errorMessages.mandatoryFieldError 

@ChartOfAccountDeatilsUpdateInvalidChartOfAccountIdAndAccountDetailsTypeId_04 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details invalid IDs
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.id = 'Invalid@'+randomString(3)
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.id =  'Invalid@'+randomString(3)
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsUpdateInvalidTenantId_05 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with invalid tenantIds
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.tenantId = invalidTenantId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tenantId =  invalidTenantId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].tenantId =  invalidTenantId
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert updateResponse.Errors[0].message == commonConstants.errorMessages.authorizedError 

@ChartOfAccountDeatilsUpdate_InvalidChartAccountIdId_06 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with invalid chartOfAccountId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.id = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = null
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsUpdate_InvalidAccountDetailTypeIdId_7 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with invalid chartOfAccountId
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.id =  null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].id = null
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert response.responseInfo.status == commonConstants.expectedStatus.serverError
    * assert response.error.message == commonConstants.errorMessages.internalServerError 

@ChartOfAccountDeatilsUpdate_NullValues_8 @chartOfAccountDetailsUpdate @egfMaster
Scenario: Update Chart Of Account Details with Null values
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.glcode = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].chartOfAccount.name = null
    * set requestPayload.chartOfAccountDetails[0].chartOfAccount.description = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.name = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.description = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.tableName = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.active = null
    * set requestPayloadToUpdate.chartOfAccountDetails[0].accountDetailType.fullyQualifiedName = null
    * call read('../../business-services/pretests/egfMasterChartOfAccountPretest.feature@updateChartOfAccountDetails')
    * assert updateResponse.chartOfAccountDetails.size() != 0
    * assert updateResponse.chartOfAccountDetails[0]['chartOfAccount'].id == chartAccountId
    * assert updateResponse.chartOfAccountDetails[0]['accountDetailType'].id == accountTypeId