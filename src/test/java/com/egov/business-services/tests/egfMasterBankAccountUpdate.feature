Feature: Bank account update
Background:
  * call read('../../business-services/tests/egfMasterBankAccountCreate.feature@BankAccountCreate_01')
  * def idForBankAccount = id
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterBankAccountConstant = read('../../business-services/constants/egfMasterBankAccount.yaml')
  # Required parameters to update acccount
  * def idForFund = commonConstant.parameters.idForFund
  * def idForBankBranch = commonConstant.parameters.idForBankBranch
  * def idForChartOfAccount = commonConstant.parameters.idForChartOfAccount
  * def bankAccountType = ranString(5)
  * def invalidTenantId = ranString(3)

@BankAccountUpdate_01  @positive  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify updating bank account using API request
  # To update bank account
  * def accountNumberOfBankAccount = ranInteger(6)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@updateAccountSuccessfully')
  * match bankAccountCreateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@BankAccountUpdate_InValidActive_03  @negative  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify by passing a invalid value for active  and check for errors
  # Update account with invalid value of active
  * def active = null
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidActiveValue

@BankAccountUpdate_InValidType_04  @negative  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify by passing a invalid value for type  and check for errors
  # Update account with invalid value of type
  * def type = null
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidType

@BankAccountUpdate_InvalidLenNum_05  @negative  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify by passing max. length of the account number  field
  # Update bank account with invalid length of account number
  * def accountNumberOfBankAccount = randomNumberOfAnyLength(26)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidAccountNumber

@BankAccountUpdate_InvalidLenDesc_06  @negative  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify by passing max. length of the desceription field
  # To update bank of account with invalid length of description
  * def descriptionOfBank = randomStringOfAnyLength(257)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  # * print bankAccountResponseBody.errors[0].message
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidDescription

@BankAccountUpdate_InvalidLenPayTo_07  @negative  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify by passing max. length of the Pay to field
  # To update bank of account with invalid length of payto
  * def payTo = randomStringOfAnyLength(101)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidPayTo

@BankAccountUpdate_UniqueAccNum_08  @negative  @bankAccountUpdate  @egfMasterBankAccount @egfMaster @regression @businessServices
Scenario: Verify by passing a account number which already exists and check for errors
  # To update back of account with existing account number
  * def accountNumberOfBankAccount = accountNumber
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forExistingAccountNumber