Feature: Account Details Type Create

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterAccountDetailTypesConstant = read('../../business-services/constants/egfMaster.yaml')
  * def branchName = randomString(10)

@accountdetailtypesCreate
Scenario: Create Account details types with Unique ID and validate duplicate account type name
#  Accountdetailtypes Create_UniqueName_01: Create Account details types with Unique ID
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
# Accountdetailtypes Create_DuplicateName_02: Create Account details types with Duplicate ID
* def branchName = accountDetailTypesCreateResponseBody.accountDetailTypes[0].name
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.nameFieldValueNotUnique

@accountdetailtypesCreate
Scenario: Create Account details types Name with 50 Characters
* def branchName = randomString(50)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null

@accountdetailtypesCreate
Scenario: Create Account details types Name with > 50 Characters
* def branchName = randomString(60)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesCreate
Scenario: Create Account details types Name with empty
* def branchName = commonConstant.invalidParameters.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesCreate
Scenario: Create Account details types Name with null
* def branchName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.branchNameNotNull