Feature: Account Details Type Create

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def commonConstant = read('../../common-services/constants/genericConstants.yaml')
  * def egfMasterAccountDetailTypesConstant = read('../../business-services/constants/egfMaster.yaml')
  * def branchName = randomString(10)
  * def active = egfMasterAccountDetailTypesConstant.chartOfAccountDeatails.params.active
  * def branchName = randomString(10)
  * def tableName = egfMasterAccountDetailTypesConstant.chartOfAccountDeatails.params.tableName
  * def fullyQualifiedName = randomString(3)+"/"+tableName
  * def description = 'TEST_'+randomString(5)
  * def bankName = randomString(10)
  * def bankDescription = randomString(10)
  
@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Create Account details types with Unique ID and validate duplicate account type name
#  Accountdetailtypes Create_UniqueName_01: Create Account details types with Unique ID
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
# Accountdetailtypes Create_DuplicateName_02: Create Account details types with Duplicate ID
* def branchName = accountDetailTypesCreateResponseBody.accountDetailTypes[0].name
* def tableName = accountDetailTypesCreateResponseBody.accountDetailTypes[0].name
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.nameFieldValueNotUnique

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Create Account details types Name with 50 Characters
* def branchName = randomString(50)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Create Account details types Name with > 50 Characters
* def branchName = randomString(60)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Create Account details types Name with empty
* def branchName = commonConstant.invalidParameters.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Create Account details types Name with null
* def branchName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.branchNameNotNull

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_TableNameWith25Characters_08
#  Accountdetailtypes Create_TableNameWith25Characters_08: Accountdetailtypes Create_TableNameWith mote than 25Characters
* def tableName = randomString(25)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].tableName != null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_TableNameWithMoreThan25Characters_9
#  Accountdetailtypes Create_TableNameWithMoreThan25Characters_9: Accountdetailtypes Create_TableName WithMore Than 25 Characters
* def tableName = randomString(30)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan25

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_EmptyTableName_10
#  Accountdetailtypes Create_EmptyTableName_10: Accountdetailtypes Create_EmptyTableName
* def tableName = commonConstant.invalidParameters.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].tableName != null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_NullTableName_11
* def tableName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].tableName == null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_fullyQualifiedNameWith250Characters_12
#  Accountdetailtypes Create_fullyQualifiedNameWith250Characters_12: Accountdetailtypes fullyQualifiedName : "<250 characters>"
* def fullyQualifiedName = randomString(250)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName != null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_fullyQualifiedNameWithMorethan250Characters_13
#  Accountdetailtypes Create_fullyQualifiedNameWithMorethan250Characters_13: Accountdetailtypes fullyQualifiedName : "<more than 250 characters>"
* def fullyQualifiedName = randomString(260)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidFQNDescriptionLength

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_fullyQualifiedNameWithEmpty_14
#  Accountdetailtypes Create_fullyQualifiedNameWithEmpty_14: Accountdetailtypes fullyQualifiedName : fullyQualifiedName : ""
* def fullyQualifiedName = commonConstant.invalidParameters.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidFQNDescriptionLength

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_fullyQualifiedNameWithNull_15
#  Accountdetailtypes Create_fullyQualifiedNameWithNull_15: Create Account details types fullyQualifiedName : null
* def fullyQualifiedName = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName == null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_DescriptionWithMorethan50Characters_16
#  Accountdetailtypes Create_DescriptionWithMorethan50Characters_16: Create Account details types Desception with > 50 char
* def fullyQualifiedName = randomString(60)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].fullyQualifiedName != null

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_DescriptionWithEmpty_17
#  Accountdetailtypes Create_DescriptionWithEmpty_17: Accountdetailtypes fullyQualifiedName description : ""
* def fullyQualifiedName = commonConstant.invalidParameters.emptyValue
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidFQNDescriptionLength

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_DescriptionWithNull_18
#  Accountdetailtypes Create_DescriptionWithNull_18: Create Account details types fullyQualifiedName description : null
* def description = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.descriptionNameNotNull

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_ActiveWithTrue_19
#  Accountdetailtypes Create_ActiveWithTrue_19: Create Account details types active : false
* def active = false
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].active == false

@accountdetailtypesCreate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Create_NullActive_20
#  Accountdetailtypes Create_NullActive_20: Create Account details types active : null
* def active = commonConstant.invalidParameters.passValusAsNull
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeTestCase')
* match accountDetailTypesCreateResponseBody.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.activeNotNull

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Verify updating bank account using API request
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
#  Accountdetailtypes Update_Name_01 Accountdetailtypes Update_tableNameAndDescription_05 Accountdetailtypes Update_fullyQualifiedNameAndActive_06
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@updateAccountSuccessfully')
* match accountDetailTypesUpdateResponseBody.accountDetailTypes[0].id != null

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_NameWithMoreThanMaxCharacters_02
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def bankName = randomString(60)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeUpdate')
* match $.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_NameWithNull_04
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def bankName = null
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeUpdate')
* match $.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.forNullValueOfName

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_NameWithEmpty_03
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def bankName = ''
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeUpdate')
* match $.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_TableNameWithMoreThanMaxCharacters_07
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def tableName = randomString(60)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeUpdate')
* match $.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan25

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_fullyQualifiedNameWithMoreThanMaxCharacters_08
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def fullyQualifiedName = randomString(260)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeUpdate')
* match $.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidFQNDescriptionLength

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_DescriptionWithMoreThanMaxCharacters_09
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def bankDescription = randomString(260)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeUpdate')
* match $.errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.invalidNameGtrThan50

@accountdetailtypesUpdate @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Accountdetailtypes Update_InvalidTenantId_10
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@createAccountSuccessfully')
* match accountDetailTypesCreateResponseBody.accountDetailTypes[0].name != null
* def bankId = accountDetailTypesCreateResponseBody.accountDetailTypes[0].id
* def tenantId = randomString(10)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@invalidTenantIdUpdate')
* match $.Errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.forbiddenError

@accountdetailtypesSearch @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Search All AccountdetailsTypes
# Accountdetailtypes Search_All_01 Accountdetailtypes Search_Name_02 Accountdetailtypes Search_ID_03
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@searchAccount')
* match accountDetailTypesSearchResponseBody.accountDetailTypes[0].id != null

@accountdetailtypesSearch @egfMaster @regression @businessServices @accountdetailtypes
Scenario: Search AccountdetailsTypes with Invalid tenantID
# Accountdetailtypes Search_InvalidTenantID_06
* def tenantId = "pb."+randomString(5)
* call read('../../business-services/pretest/egfMasterAccountDetailsTypesPreTest.feature@negativeSearchUnAuthorized')
* match $.Errors[0].message == egfMasterAccountDetailTypesConstant.errorMessages.forbiddenError