Feature: Chart of account
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def glcode = ranInteger(6)
  * def name = ranString(5) + "Bank"
  * def egfMasterChartOfAccountConstant = read('../../business-services/constants/egfMasterChartOfAccount.yaml')
  # Required parameters to create acccount
  * def isActiveForPosting = 'false'
  * def functionRequired = 'false'
  * def budgetCheckRequired = 'false'
  * def classification = '1'
  * def type = 'B'
  * def invalidTenantId = ranString(3)

@ChartOfAccountCreate_01 @chartOfAccountCreate  @chartOfAccount
Scenario: Verify creating chart of accounts through API call
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
* match chartOfAccountCreateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountCreate_UniqueBank_02  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify creating chart of accounts by passing a bank name that already exists and check for errors
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
* def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].name
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountError')
* print chartOfAccountCreateResponseBody.errors[0].description
* print egfMasterChartOfAccountConstant.errorMessages.forExistingBankName
* def validateErrorMessage = toGetDynamicValueFromResponse(chartOfAccountCreateResponseBody.errors[0].description,egfMasterChartOfAccountConstant.errorMessages.forExistingBankName)
* print validateErrorMessage
* assert validateErrorMessage == true

@ChartOfAccountCreate_InValidTEnant_03  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify with a invalid or non existant tenant id and check for errors
* def tenantId = invalidTenantId
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@unauthorizedaccessError')
* assert chartOfAccountCreateResponseBody.Errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidTenantId

@ChartOfAccountCreate_GcodeLen_04  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify creating chart of accounts by passing a invalid length for glcode through API call and check for errors
* def glcode = ""
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountError')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidglcode

@ChartOfAccountCreate_nameLen_05  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify creating chart of accounts by passing a invalid length for name through API call and check for errors
* def name = ranString(2)
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountError')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidName

@ChartOfAccountCreate_InvalidType_06  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify creatng chart of accounts by passing a invalid value for 'type' through API call and check for errors
* def type = null
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountError')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidType

@ChartOfAccountCreate_UniqueGlcode_07  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify creating chart of accounts by passing a GLcode that already exists and check for errors
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
* def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].glcode
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountError')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forExistingGlcode

@ChartOfAccountCreate_08  @chartOfAccountCreate  @chartOfAccount
Scenario: Verify by pasing 'true' and 'false' - isActiveForPosting, functionRequired , budgetCheckRequired and check if its acccepting
* def budgetCheckRequired = 'true'
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountSuccessfully')
* match chartOfAccountCreateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountCreate_nullvalues_09  @chartOfAccountCreate  @chartOfAccount
Scenario: "Verify creating chart of accounts by passing null values for  glcode, name, type, classification,functionrequired,budgetCheckRequired  and check for errors"
* def glcode = null
* def name = null
* def functionRequired = null
* def budgetCheckRequired = null
* def classification = null
* def type = null
* call read('../../business-services/preTests/egfMasterChartOfAccountCreate.feature@createAccountError')
* chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidFunctionRequired

@ChartOfAccountSearch_01  @chartOfAccountSearch  @chartOfAccount
Scenario: "Verify searching for chart of accounts through API call using tenantId, id, glcode,classification, name, activeforposting,accountCodePurpose,
description,functionRequired,budgetCheckRequired,pageSize,offset, majorCodeisSubLedgersortBy"
* call read('../../business-services/preTests/egfMasterChartOfAccountSearch.feature@searchAccountSuccessfully')
* match chartOfAccountSearchResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountSearch_InvalidTenant_02  @chartOfAccountSearch  @chartOfAccount 
Scenario: Verify with a invalid or non existant tenant id and check for errors
* def tenantId = invalidTenantId
* call read('../../business-services/preTests/egfMasterChartOfAccountSearch.feature@unauthorizedaccessError')
* assert chartOfAccountSearchResponseBody.Errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidTenantId

@ChartOfAccountSearch_InvalidType_03  @chartOfAccountSearch  @chartOfAccount
Scenario: Verify with a invalid or non existant , different case of  'type'
* def type = 'A'
* call read('../../business-services/preTests/egfMasterChartOfAccountSearch.feature@searchAccountSuccessfully')
* match chartOfAccountSearchResponseBody == '#present'

@ChartOfAccountSearch_AllRecords_04  @chartOfAccountSearch  @chartOfAccount
Scenario: Verify searching for chart of accounts through API call using tenantId
* call read('../../business-services/preTests/egfMasterChartOfAccountSearch.feature@searchWithTenantIdSuccessfully')
* match chartOfAccountSearchResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountSearch_TenantIdMandatory_06  @chartOfAccountSearch  @chartOfAccount
Scenario: Verify searching for chart of accounts through API call by not passing tenantId
* call read('../../business-services/preTests/egfMasterChartOfAccountSearch.feature@searchAccountError')
* print egfMasterChartOfAccountConstant.errorMessages.withoutTenantId
* def validationMessage = toReplaceComma(chartOfAccountSearchResponseBody)
* print validationMessage
* assert validationMessage == egfMasterChartOfAccountConstant.errorMessages.withoutTenantId