Feature: Chart of account Update
Background:
  * call read('../../business-services/tests/egfMasterChartOfAccountCreate.feature@ChartOfAccountCreate_01')
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterChartOfAccountConstant = read('../../business-services/constants/egfMasterChartOfAccount.yaml')
  * def invalidTenantId = ranString(3)

@ChartOfAccountUpdate_01  @chartOfAccountUpdate  @chartOfAccount  @regression @positive  
Scenario: Verify updating chart of accounts through API call
# Update the existing glcode with new glcode
* def glcode = glcode
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@updateAccountSuccessfully')
* match chartOfAccountUpdateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@ChartOfAccountUpdate_glcodeLen_02  @chartOfAccountUpdate  @chartOfAccount  @regression @negative
Scenario: Verify updating chart of accounts by passing a invalid length for glcode through API call and check for errors
# Update glcode with empty string
* def glcode = ""
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@errorInUpdateAccount')
* assert chartOfAccountUpdateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidglcode

@ChartOfAccountUpdate_nameLen_03  @chartOfAccountUpdate  @chartOfAccount  @regression @negative
Scenario: Verify updating chart of accounts by passing a invalid length for name through API call and check for errors
# Update name with invalid length
* def name = ranString(2)
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@errorInUpdateAccount')
* assert chartOfAccountUpdateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidName

@ChartOfAccountUpdate_InvalTyp_04  @chartOfAccountUpdate  @chartOfAccount  @regression @negative
Scenario: Verify updating chart of accounts by passing a invalid value for 'type' through API call and check for errors
# Update tpye as null
* def type = null
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@errorInUpdateAccount')
* assert chartOfAccountUpdateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forInvalidType

@ChartOfAccountUpdate_UniqueGlcode_06  @chartOfAccountUpdate  @chartOfAccount  @regression @negative
Scenario: Verify updating chart of accounts by passing a GLcode that already exists and check for errors
# Update the glcode
* def glcode = "GLCODE"
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@errorInUpdateAccount')
* assert chartOfAccountUpdateResponseBody.errors[0].message == egfMasterChartOfAccountConstant.errorMessages.forExistingGlcode

@ChartOfAccountUpdate_nullValues_07  @chartOfAccountUpdate  @chartOfAccount  @regression @negative
Scenario: Verify updating chart of accounts by passing null values for  glcode, name, type, classification,functionrequired,budgetCheckRequired  and check for errors
# Update all the parameter as null
* def glcode = null
* def name = null
* def functionRequired = null
* def budgetCheckRequired = null
* def classification = null
* def type = null
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@errorInUpdateAccount')

@ChartOfAccountUpdate_Invaltenant_08  @chartOfAccountUpdate  @chartOfAccount  @regression @negative
Scenario: Verify with a invalid or non existant tenant id and check for errors
# Update the chart of account with invalid tenantId
* def tenantId = invalidTenantId
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@unauthorizedaccessError')
* assert chartOfAccountResponseBody.Errors[0].message == commonConstant.errorMessages.invalidTenantIdError

@ChartOfAccountUpdate_09  @chartOfAccountUpdate  @chartOfAccount  @regression @positive
Scenario: Verify by change 'true' to 'false' and vice versa for - isActiveForPosting, functionRequired , budgetCheckRequired
# Update by changing the value of functionRequired,budgetCheckRequired,isActiveForPosting
* def functionRequired = 'true'
* def budgetCheckRequired = 'true'
* def isActiveForPosting = 'true'
* call read('../../business-services/preTests/egfMasterChartOfAccount.feature@updateAccountSuccessfully')
* match chartOfAccountUpdateResponseBody.chartOfAccounts.length == '##[_ > 0]'