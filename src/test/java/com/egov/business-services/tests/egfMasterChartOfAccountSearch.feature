Feature: Chart of account Search
Background:
  * call read('../../business-services/tests/egfMasterChartOfAccountCreate.feature@ChartOfAccountCreate_01')
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterChartOfAccountConstant = read('../../business-services/constants/egfMasterChartOfAccount.yaml')
  * def invalidTenantId = ranString(3)

@ChartOfAccountSearch_01  @chartOfAccountSearch  @chartOfAccount  @regression @positive
Scenario: Verify searching for chart of accounts through API call using tenantId, id, glcode,classification, name, activeforposting,accountCodePurpose,
description,functionRequired,budgetCheckRequired,pageSize,offset, majorCodeisSubLedgersortBy
# Search for chart of account
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@searchAccountSuccessfully')
* match chartOfAccountSearchResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountSearch_InvalidTenant_02  @chartOfAccountSearch  @chartOfAccount  @regression @negative
Scenario: Verify with a invalid or non existant tenant id and check for errors
# Search with invalid tenantId
* def tenantId = invalidTenantId
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@unauthorizedaccessError')
* assert chartOfAccountResponseBody.Errors[0].message == commonConstant.errorMessages.invalidTenantIdError

@ChartOfAccountSearch_InvalidType_03  @chartOfAccountSearch  @chartOfAccount  @regression @positive
Scenario: Verify with a invalid or non existant , different case of type
# Search with invalid type
* def type = "A"
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@searchAccountSuccessfully')
* match chartOfAccountSearchResponseBody == '#present'

@ChartOfAccountSearch_AllRecords_04  @chartOfAccountSearch  @chartOfAccount  @regression @positive
Scenario: Verify searching for chart of accounts through API call using tenantId
# Search with only tenantId
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@searchWithTenantIdSuccessfully')
* match chartOfAccountSearchResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountSearch_TenantIdMandatory_06  @chartOfAccountSearch  @chartOfAccount  @regression @negative
Scenario: Verify searching for chart of accounts through API call by not passing tenantId
# Search for chart of accounts without passing tenantId
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@errorInSearchAccount')
* print egfMasterChartOfAccountConstant.errorMessages.withoutTenantId
* def validationMessage = toReplaceComma(chartOfAccountSearchResponseBody)
* print validationMessage
* assert validationMessage == egfMasterChartOfAccountConstant.errorMessages.withoutTenantId