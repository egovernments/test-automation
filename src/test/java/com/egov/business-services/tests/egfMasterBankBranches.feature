 Feature: To test egf-master-Bank service 'Create' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * call read('../../business-services/tests/egfMasterBankCreate.feature@BankCreate_01')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml')
        * def Collections = Java.type('java.util.Collections')
        * def branchCode = 'BranchCode'+randomString(3)
        * def branchName = 'BranchName'+randomString(3)
        * def branchAddress = randomString(5)
        * def branchAddress2 = randomString(5)
        * def pincode = '5' + randomMobileNumGen(5)
        * def phoneNumber = '76' + randomMobileNumGen(8)
        * def fax = '76' + randomMobileNumGen(8)
        * def contactPerson = randomString(8)
        * def isActive = false
        * def branchDescription = 'Description'+randomString(3)
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  
@BankBranches_Create_01 @positive @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch with valid request body
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Validating response body
        * match createBankBranchResponse.bankBranches[0].code == branchCode
        * match createBankBranchResponse.bankBranches[0].name == branchName
        * match createBankBranchResponse.bankBranches[0].description == branchDescription
        * match createBankBranchResponse.bankBranches[0].active == isActive

@BankBranches_Create_NulValues_02 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch py passing name, code and bankId as null
        # setting request body values
        * def branchCode = null
        * def branchName = null
        * def bankId = null
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def errorMessages = $createBankBranchResponse.errors[*].message
        * Collections.sort(errorMessages, java.lang.String.CASE_INSENSITIVE_ORDER)
        # Validating error messages
        * match errorMessages[0] == egfMasterConstants.errorMessages.bankIdNotNull
        * match errorMessages[1] == egfMasterConstants.errorMessages.branchCodeNotNull
        * match errorMessages[2] == egfMasterConstants.errorMessages.branchNameNotNull


@BankBranches_Create_UniqueCode_03 @BankBranches_Create_UniqueName_04 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch which is already existing
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Try to create a bank branch which is already existing
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def errorMessages = $createBankBranchResponse.errors[*].message
        * Collections.sort(errorMessages, java.lang.String.CASE_INSENSITIVE_ORDER)
        # Validating error messages
        * match errorMessages[0] == egfMasterConstants.errorMessages.codeFieldValueNotUnique
        * match errorMessages[1] == egfMasterConstants.errorMessages.nameFieldValueNotUnique

@BankBranches_Create_NullActive_05 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch by passing active as null
        # setting request body values
        * def isActive = null
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Validating error messages
        * match createBankBranchResponse.errors[0].message == egfMasterConstants.errorMessages.activeNotNull

@BankBranches_Create_Active_06 @positive @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch changing the active to true from false(default)
        # setting request body values
        * def isActive = true
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Validating response body
        * match createBankBranchResponse.bankBranches[0].code == branchCode
        * match createBankBranchResponse.bankBranches[0].name == branchName
        * match createBankBranchResponse.bankBranches[0].description == branchDescription
        * match createBankBranchResponse.bankBranches[0].active == isActive

@BankBranches_Create_TenantMandatory_07 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch without passing tenantId in query params
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranchWithoutParams')
        * match createBankBranchResponse == egfMasterConstants.errorMessages.tenantParamMandatory

@BankBranches_Create_InvalidTenant_08 @BankBranches_Create_Tenant_10 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch passing invalid/non-existing tenantId
        # setting request body values
        * def tenantId = 'InvalidTenantId-' + randomString(5)
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Validating error messages
        * match createBankBranchResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

@BankBranches_Create_Validation_09 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch py passing fields with character length more than the limit
        # setting request body values
        * def branchCode = 'BranchCode'+randomString(60)
        * def branchName = 'BranchName'+randomString(60)
        * def branchAddress = randomString(60)
        * def branchAddress2 = randomString(60)
        * def pincode = '5' + randomMobileNumGen(60)
        * def phoneNumber = '76' + randomMobileNumGen(60)
        * def fax = '76' + randomMobileNumGen(60)
        * def contactPerson = randomString(60)
        * def branchDescription = 'Description'+randomString(60)
        * def cityCode = randomString(60)
        * def stateCode = randomString(60)
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def errorMessages = $createBankBranchResponse.errors[*].message
        * Collections.sort(errorMessages, java.lang.String.CASE_INSENSITIVE_ORDER)
        # Validating error messages
        * match errorMessages[0] == egfMasterConstants.errorMessages.invalidCharacterLength

@BankBranches_Create_InvalidName_11 @negative @bankBranchCreate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify creating bank branch passing invalid characters for branch name
        # setting request body values
        * def branchName = "!@#$%^&*()"
        # Creating a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Validating error messages
        * match createBankBranchResponse.errors[0].message == egfMasterConstants.errorMessages.nameInvalid

@BankBranches_Update_01 @positive @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch with valid request body
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Set new branch code
        * eval bankBranches[0].code = 'UpdatedBranchCode'+randomString(5)
        # Set new brqanch name
        * eval bankBranches[0].name = 'UpdatedBranchName'+randomString(3)
        # Set new description
        * eval bankBranches[0].description = 'UpdatedDescrption'+randomString(3)
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        # Validating response body
        * match updateBankBranchResponse.bankBranches[0].code == bankBranches[0].code
        * match updateBankBranchResponse.bankBranches[0].name == bankBranches[0].name
        * match updateBankBranchResponse.bankBranches[0].description == bankBranches[0].description

@BankBranches_Update_UniqueName_02 @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch with already existing branch name
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def existingBranchName = bankBranches[0].name
        # Creating another Bank Branch to update it with the branch name which is already existing
        * def branchCode = 'BranchCode'+randomString(3)
        * def branchName = 'BranchName'+randomString(3)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Set new brqanch name
        * eval bankBranches[0].name = existingBranchName
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        # Validating error messages
        * match updateBankBranchResponse.errors[0].message == egfMasterConstants.errorMessages.nameFieldValueNotUnique

@BankBranches_Update_UniqueCode_03 @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch with already existing branch code
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def existingBranchCode = bankBranches[0].code
        # Creating another Bank Branch to update it with the branch name which is already existing
        * def branchCode = 'BranchCode'+randomString(3)
        * def branchName = 'BranchName'+randomString(3)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Set new brqanch name
        * eval bankBranches[0].code = existingBranchCode
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        # Validating error messages
        * match updateBankBranchResponse.errors[0].message == egfMasterConstants.errorMessages.codeFieldValueNotUnique

@BankBranches_Update_InvalidTenant_04 @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch passing invalid/non-existing tenantId
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # setting request body values
        * def invalidTenantId = 'InvalidTenantId-' + randomString(5)
        * def tenantId = invalidTenantId
        * eval bankBranches[0].tenantId = invalidTenantId
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        # Validating error messages
        * match updateBankBranchResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

#bug: should not accept isActive as null
@BankBranches_Update_activeNull_05 @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch passing active as null
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # setting request body values
        * eval bankBranches[0].isActive = null
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        # Validating error messages
        * match updateBankBranchResponse.errors[0].message == egfMasterConstants.errorMessages.activeNotNull

@BankBranches_Update_Validations_06  @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch passing fields with characters length more than the limit
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # setting request body values
        * eval bankBranches[0].branchCode = 'BranchCode'+randomString(60)
        * eval bankBranches[0].branchName = 'BranchName'+randomString(60)
        * eval bankBranches[0].branchAddress = randomString(60)
        * eval bankBranches[0].branchAddress2 = randomString(60)
        * eval bankBranches[0].pincode = '5' + randomMobileNumGen(60)
        * eval bankBranches[0].phoneNumber = '76' + randomMobileNumGen(60)
        * eval bankBranches[0].fax = '76' + randomMobileNumGen(60)
        * eval bankBranches[0].contactPerson = randomString(60)
        * eval bankBranches[0].branchDescription = 'Description'+randomString(60)
        * eval bankBranches[0].cityCode = randomString(60)
        * eval bankBranches[0].stateCode = randomString(60)
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        * def errorMessages = $updateBankBranchResponse.errors[*].message
        * Collections.sort(errorMessages, java.lang.String.CASE_INSENSITIVE_ORDER)
        # Validating error messages
        * match errorMessages[0] == egfMasterConstants.errorMessages.invalidCharacterLength

@BankBranches_Update_NameInvalid_07 @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch passing invalid characters for branch name
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # setting request body values
        * eval bankBranches[0].name = "!@#$%^&*()"
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        # Validating error messages
        * match updateBankBranchResponse.errors[0].message == egfMasterConstants.errorMessages.nameInvalid

@BankBranches_Update_NulValues_08 @negative @bankBranchUpdate @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify updating bank branch passing invalid characters for branch name
        # Creating Bank Branch before Updating it
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # setting request body values
        * eval bankBranches[0].code = null
        * eval bankBranches[0].name = null
        * eval bankBranches[0].bank = null
        # Updating bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBankBranch')
        * def errorMessages = $updateBankBranchResponse.errors[*].message
        * Collections.sort(errorMessages, java.lang.String.CASE_INSENSITIVE_ORDER)
        # Validating error messages
        * match errorMessages[0] == egfMasterConstants.errorMessages.bankIdNotNull
        * match errorMessages[1] == egfMasterConstants.errorMessages.branchCodeNotNull
        * match errorMessages[2] == egfMasterConstants.errorMessages.branchNameNotNull

@Bank_Branch_Search_01 @positive @bankBranchSearch @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify searching bank branch by passing valid query parameters
        # Creating a new Bank Branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def id = bankBranches[0].id
        # Defining search parameters
        * def searchParams = { tenantId: '#(tenantId)', code: '#(branchCode)', name: '#(branchName)', id: '#(id)'}
        # Searching a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBankBranch')
        # Validating response body
        * match searchBankBranchResponse.bankBranches.size() != 0
        * match searchBankBranchResponse.bankBranches[0].code == branchCode
        * match searchBankBranchResponse.bankBranches[0].name == branchName
        * match searchBankBranchResponse.bankBranches[0].id == bankBranches[0].id
        * match searchBankBranchResponse.bankBranches[0].tenantId == tenantId

@Bank_Branch_Search_InvalidTenant_02 @negative @bankBranchSearch @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify searching bank branch by passing invalid tenantId
        # Creating a new Bank Branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def tenantId = 'InvalidTenantId-'+randomString(6)
        # Defining search parameters
        * def searchParams = { tenantId: '#(tenantId)', code: '#(branchCode)', name: '#(branchName)'}
        # Searching a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBankBranch')
        # Validating error messages
        * match searchBankBranchResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError

@Bank_Branch_Search_TenantIdMandatory_03 @negative @bankBranchSearch @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify searching bank branch without passing tenantId
        # Creating a new Bank Branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def tenantId = 'InvalidTenantId-'+randomString(6)
        # Defining search parameters
        * def searchParams = { code: '#(branchCode)', name: '#(branchName)'}
        # Searching a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBankBranch')
        * match searchBankBranchResponse ==  egfMasterConstants.errorMessages.tenantParamMandatory


@Bank_Branch_Search_AllRecords_04 @positive @bankBranchSearch @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify searching all bank branches by passing only tenantId
        # Creating a new Bank Branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Defining search parameters
        * def searchParams = { tenantId: '#(tenantId)'}
        # Searching a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBankBranch')
        # Validating response body
        * match searchBankBranchResponse.bankBranches.size() != 0

@Bank_Branch_Search_empty_05 @positive @bankBranchSearch @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify searching bank branch by passing invalid params
        # Creating a new Bank Branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        * def invalidBranchId = randomString(6)
        # Defining search parameters
        * def searchParams = { tenantId: '#(tenantId)',code: '#(branchCode)', name: '#(branchName)', id: '#(invalidBranchId)'}
        # Searching a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBankBranch')
        # Validating response body
        * match searchBankBranchResponse.bankBranches.size() == 0

@Bank_Branch_Search_combination_06 @positive @bankBranchSearch @egfMasterBankBranches @egfMaster @businessServices @regression
    Scenario: Verify searching bank branch by passing invalid params
        # Creating a new Bank Branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBankBranch')
        # Defining search parameters
        * def searchParams = { tenantId: '#(tenantId)',code: '#(branchCode)', name: '#(branchName)'}
        # Searching a bank branch
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBankBranch')
        # Validating response body
        * match searchBankBranchResponse.bankBranches.size() != 0
        * match searchBankBranchResponse.bankBranches[0].code == branchCode
        * match searchBankBranchResponse.bankBranches[0].name == branchName
        * match searchBankBranchResponse.bankBranches[0].tenantId == tenantId