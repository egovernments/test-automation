Feature: Chart of account Create
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterChartOfAccountConstant = read('../../business-services/constants/egfMasterChartOfAccount.yaml')
  # Required parameters to create acccount
  * def glcode = ranInteger(6)
  * def name = ranString(5) + "Bank"
  * def isActiveForPosting = 'false'
  * def functionRequired = 'false'
  * def budgetCheckRequired = 'false'
  * def classification = '1'
  * def type = 'B'
  * def invalidTenantId = ranString(3)

@ChartOfAccountCreate_01 @chartOfAccountCreate  @chartOfAccount  @regression @positive
Scenario: Verify creating chart of accounts through API call
# To create chart of account
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@createAccountSuccessfully')
* match chartOfAccountCreateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountCreate_UniqueBank_02  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify creating chart of accounts by passing a bank name that already exists and check for errors
# To create chart of account
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@createAccountSuccessfully')
* def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].name
# Pass the duplicate name
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@errorInAccoutCreate')
* print chartOfAccountCreateResponseBody.errors[0].description
* print egfMasterChartOfAccountConstant.errorMessages.forExistingBankName
# Validating error message with dynamic value
* def validateErrorMessage = toGetDynamicValueFromResponse(chartOfAccountCreateResponseBody.errors[0].description,egfMasterChartOfAccountConstant.errorMessages.forExistingBankName)
* print validateErrorMessage
* assert validateErrorMessage == true

@ChartOfAccountCreate_InValidTEnant_03  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify with a invalid or non existant tenant id and check for errors
# To create chart of account with invalid tenantid
* def tenantId = invalidTenantId
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@unauthorizedaccessError')
* assert chartOfAccountResponseBody.Errors[0].message == commonConstant.errorMessages.invalidTenantIdError

@ChartOfAccountCreate_GcodeLen_04  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify creating chart of accounts by passing a invalid length for glcode through API call and check for errors
# To create chart of account with invalid glcode
* def glcode = ""
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@errorInAccoutCreate')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidglcode

@ChartOfAccountCreate_nameLen_05  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify creating chart of accounts by passing a invalid length for name through API call and check for errors
# To create chart of account with invalid name
* def name = ranString(2)
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@errorInAccoutCreate')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidName

@ChartOfAccountCreate_InvalidType_06  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify creatng chart of accounts by passing a invalid value for 'type' through API call and check for errors
# To create chart of account with invalid type
* def type = null
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@errorInAccoutCreate')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidType

@ChartOfAccountCreate_UniqueGlcode_07  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify creating chart of accounts by passing a GLcode that already exists and check for errors
# To create chart of account with existing glcode
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@createAccountSuccessfully')
* def name = chartOfAccountCreateResponseBody.chartOfAccounts[0].glcode
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@errorInAccoutCreate')
* assert chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forExistingGlcode

@ChartOfAccountCreate_08  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify by pasing 'true' and 'false' - isActiveForPosting, functionRequired , budgetCheckRequired and check if its acccepting
# To create chart of account by changing budgetCheckRequired value
* def budgetCheckRequired = 'true'
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@createAccountSuccessfully')
* match chartOfAccountCreateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountCreate_nullvalues_09  @chartOfAccountCreate  @chartOfAccount  @regression @negative
Scenario: Verify creating chart of accounts by passing null values for  glcode, name, type, classification,functionrequired,budgetCheckRequired  and check for errors
# To create chart of account passing null
* def glcode = null
* def name = null
* def functionRequired = null
* def budgetCheckRequired = null
* def classification = null
* def type = null
* call read('../../business-services/pretest/egfMasterChartOfAccount.feature@errorInAccoutCreate')
* chartOfAccountCreateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidFunctionRequired