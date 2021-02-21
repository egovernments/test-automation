Feature: Bank account search
Background:
  * call read('../../business-services/tests/egfMasterBankAccountCreate.feature@BankAccountCreate_01')
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterBankAccountConstant = read('../../business-services/constants/egfMasterBankAccount.yaml')
  * def invalidTenantId = ranString(3)

@BankAccountSearch_01  @positive  @bankAccountSearch  @egfMasterBankAccount
Scenario: Verify searching for Bank accounts through API call . Search is performed using the following Name tenantid active 
  # Search with name, glcode, ctive & tenantId parameters
  * call read('../../business-services/pretests/egfMasterBankAccount.feature@searchAccountSuccessfully')
  * match bankAccountSearchResponseBody.chartOfAccounts.length == '##[_ > 0]'

@BankAccountSearch_InvalidTenant_02  @negative  @bankAccountSearch  @egfMasterBankAccount
Scenario: Verify searching for Bank accounts through API call by passing a invlalid or a non existing tenant id  and check for errors
  # Search with invalid tenantid
  * def tenantId = invalidTenantId
  * call read('../../business-services/pretests/egfMasterBankAccount.feature@invalidTenatId')
  * assert bankAccountSearchResponseBody.Errors[0].message == commonConstant.errorMessages.invalidTenantIdError

@BankAccountSearch_TenantIdMandatory_03  @negative  @bankAccountSearch  @egfMasterBankAccount
Scenario: Verify searching for Bank accounts through API call by not passing tenantId
  # Search without tenantid
  * call read('../../business-services/pretests/egfMasterBankAccount.feature@withoutTenantId')
  * def validationMessage = toReplaceComma(bankAccountSearchResponseBody)
  * assert validationMessage == egfMasterBankAccountConstant.errorMessages.withoutTenantId

@BankAccountSearch_AllRecords_05  @positive  @bankAccountSearch  @egfMasterBankAccount
Scenario: Verify searching for bank accounts through API call using tenantId
  * call read('../../business-services/pretests/egfMasterBankAccount.feature@searchAccountS')
  * match bankAccountSearchResponseBody.chartOfAccounts.length == '##[_ > 0]'
  