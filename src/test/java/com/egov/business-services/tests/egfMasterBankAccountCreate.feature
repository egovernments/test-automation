Feature: Bank account Create
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterBankAccountConstant = read('../../business-services/constants/egfMasterBankAccount.yaml')
  # Required parameters to create acccount
  * def idForFund = commonConstant.parameters.idForFund
  * def idForBankBranch = commonConstant.parameters.idForBankBranch
  * def idForChartOfAccount = commonConstant.parameters.idForChartOfAccount
  * def accountNumberOfBankAccount = ranInteger(6)
  * def bankAccountType = ranString(5)
  * def descriptionOfBank = 'accountNumber'
  * def active = 'false'
  * def payTo = ranString(5)
  * def type = 'RECEIPTS_PAYMENTS'
  * def invalidTenantId = ranString(3)

@BankAccountCreate_01  @positive @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify creating bank account using API request
  # To create bank of account
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@createAccountSuccessfully')
  * match bankAccountCreateResponseBody.chartOfAccounts.length == '##[_ > 0]'

@BankAccountCreate_UniqueAccNum_03 @negative  @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify by passing a account number which already exists and check for errors
  # To create bank of account
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@createAccountSuccessfully')
  * def accountNumberOfBankAccount = bankAccountCreateResponseBody.bankAccounts[0].accountNumber
  # To create bank of account with existing account number
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * print bankAccountCreateResponseBody.errors[0].message
  * print egfMasterBankAccountConstant.errorMessages.forExistingAccountNumber
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forExistingAccountNumber

@BankAccountCreate_InValidActive_04  @negative  @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify by passing a invalid value for active  and check for errors
  # To create bank of account & active value as null
  * def active = null
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * print bankAccountCreateResponseBody.errors[0].message
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidActiveValue

@BankAccountCreate_InValidType_05  @negative  @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify by passing a invalid value for type  and check for errors
  # To create bank of account & type value as null
  * def type = null
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * print bankAccountCreateResponseBody.errors[0].message
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidType

@BankAccountCreate_InvalidLenNum_07  @negative  @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify by passing max. length of the account number  field
  # To create bank of account with invalid length of account number
  * def accountNumberOfBankAccount = randomNumberOfAnyLength(26)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * print bankAccountCreateResponseBody.errors[0].message
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidAccountNumber

@BankAccountCreate_InvalidLenDesc_08  @negative  @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify by passing max. length of the desceription field 
  # To create bank of account with invalid length of description
  * def descriptionOfBank = randomStringOfAnyLength(257)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * print bankAccountCreateResponseBody.errors[0].message
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidDescription

@BankAccountCreate_InvalidLenPayTo_09  @negative  @bankAccountCreate  @egfMasterBankAccount @egfMaster
Scenario: Verify by passing max. length of the Pay to field
  # To create bank of account with invalid length of payto
  * def payTo = randomStringOfAnyLength(101)
  * call read('../../business-services/pretest/egfMasterBankAccount.feature@errorInAccount')
  * print bankAccountCreateResponseBody.errors[0].message
  * assert bankAccountResponseBody.errors[0].message == egfMasterBankAccountConstant.errorMessages.forInvalidPayTo