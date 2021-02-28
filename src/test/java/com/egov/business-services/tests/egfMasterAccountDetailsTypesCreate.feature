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
* def tableName = accountDetailTypesCreateResponseBody.accountDetailTypes[0].name
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

@accountdetailtypesCreatetable
Scenario: Accountdetailtypes Create_TableNameWith25Characters_08
#  Accountdetailtypes Create_TableNameWith25Characters_08: Accountdetailtypes Create_TableNameWith mote than 25Characters
* def tableName = randomString(25)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].tableName != null

@accountdetailtypesCreatetable
Scenario: Accountdetailtypes Create_TableNameWithMoreThan25Characters_9
#  Accountdetailtypes Create_TableNameWithMoreThan25Characters_9: Accountdetailtypes Create_TableName WithMore Than 25 Characters
* def tableName = randomString(30)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan25

@accountdetailtypesCreatetable
Scenario: Accountdetailtypes Create_EmptyTableName_10
#  Accountdetailtypes Create_EmptyTableName_10: Accountdetailtypes Create_EmptyTableName
* def tableName = commonConstant.invalidParameters.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].tableName != null

@accountdetailtypesCreatetable
Scenario: Accountdetailtypes Create_NullTableName_11
* def tableName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].tableName == null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_fullyQualifiedNameWith250Characters_12
#  Accountdetailtypes Create_fullyQualifiedNameWith250Characters_12: Accountdetailtypes fullyQualifiedName : "<250 characters>"
* def fullyQualifiedName = randomString(250)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName != null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_fullyQualifiedNameWithMorethan250Characters_13
#  Accountdetailtypes Create_fullyQualifiedNameWithMorethan250Characters_13: Accountdetailtypes fullyQualifiedName : "<more than 250 characters>"
* def fullyQualifiedName = randomString(260)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidFQNDescriptionLength

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_fullyQualifiedNameWithEmpty_14
#  Accountdetailtypes Create_fullyQualifiedNameWithEmpty_14: Accountdetailtypes fullyQualifiedName : fullyQualifiedName : ""
* def fullyQualifiedName = commonConstant.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName == null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_fullyQualifiedNameWithNull_15
#  Accountdetailtypes Create_fullyQualifiedNameWithNull_15: Create Account details types fullyQualifiedName : null
* def fullyQualifiedName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName == null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_DescriptionWithMorethan50Characters_16
#  Accountdetailtypes Create_DescriptionWithMorethan50Characters_16: Create Account details types Desception with > 50 char
* def fullyQualifiedName = randomString(60)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName != null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_DescriptionWithEmpty_17
#  Accountdetailtypes Create_DescriptionWithEmpty_17: Accountdetailtypes fullyQualifiedName description : ""
* def fullyQualifiedName = commonConstant.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName == null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_DescriptionWithNull_18
#  Accountdetailtypes Create_DescriptionWithNull_18: Create Account details types fullyQualifiedName description : null
* def fullyQualifiedName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName == null

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_ActiveWithTrue_19
#  Accountdetailtypes Create_ActiveWithTrue_19: Create Account details types active : false
* def active = false
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].active == false

@accountdetailtypesCreate
Scenario: Accountdetailtypes Create_NullActive_20
#  Accountdetailtypes Create_NullActive_20: Create Account details types active : null
* def active = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan25