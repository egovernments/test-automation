 Feature: To test egf-master-Bank service endpointS

    Background: 
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml')
        * def bankCode = randomString(5)
        * def bankName = 'Bank-'+randomString(3)
        * def bankDescription = 'Desc-'+randomString(3)
        * def isActive = false
        * def bankType = 'Type-'+randomString(3)
        * def createBankPayload = read('../../business-services/requestPayload/egf-master/bank/create.json')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def updateBankPayload = read('../../business-services/requestPayload/egf-master/bank/update.json')
        * def searchBankPayload = read('../../business-services/requestPayload/egf-master/bank/search.json')
        * def invalidTenantId = 'Invalid-'+randomString(3)
        * def uniqueBankId = 'Unique-'+randomString(4)
  
@BankCreate_01 @positive @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank account throgh API call
        # Steps to create Bank
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Validate the Create Bank details
        * match createBankResponse.banks[0].code == bankCode
        * match createBankResponse.banks[0].name == bankName
        * match createBankResponse.banks[0].description == bankDescription
        * match createBankResponse.banks[0].active == isActive
        * match createBankResponse.banks[0].type == bankType

@Bank_Create_UniqueName_02 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify updating bank by passing a value for name that already exists and check for errors
        # Steps to create Bank
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Re-assigning few field parameter values 
        * set createBankPayload.banks[0].code = randomString(5)
        * set createBankPayload.banks[0].description = 'Desc-'+randomString(3)
        * set createBankPayload.banks[0].type = 'Type-'+randomString(3)
        # Steps to create bank to generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Preparing the dynamic error message
        * def errorDescription = "The  value  "+bankName+" for the field name already exists in the system. Please provide different value"
        # Validate the response
        * match createBankResponse.errors[0].description == errorDescription
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.nameFieldValueNotUnique

@Bank_Create_UniqueCode_03 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank by passing a value for code that already exists and check for errors
        # Steps to create Bank
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Re-assigning few field parameter values
        * set createBankPayload.banks[0].name = randomString(5)
        * set createBankPayload.banks[0].description = 'Desc-'+randomString(3)
        * set createBankPayload.banks[0].type = 'Type-'+randomString(3)
        # Steps to create bank to generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Preparing the dynamic error message
        * def errorDescription = "The  value  "+bankCode+" for the field code already exists in the system. Please provide different value"
        # Validate the response
        * match createBankResponse.errors[0].description == errorDescription
        * match createBankResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.codeFieldValueNotUnique

@Bank_Create_InvalidTenant_04 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank using API call by passing a invalid/non existing tenant id in the request body
        # Assigning tenant id with invalid value
        * set createBankPayload.banks[0].tenantId = 'Invalid'+randomString(5)
        # Steps to create bank to generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBankUnAuthorized')
        # Validate the response
        * match createBankResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@Bank_Create_NoTenant_05 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank  using API call by not passing tenant id in the request body or by passing null for tenant id
        # Remove tenantId field
        * remove createBankPayload.banks[0].tenantId
        # Steps to create bank to generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Validate the response
        * match createBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTenantIdDescription
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTenantIdMessage

@Bank_Create_activeNull_06 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank  by passing null value for active and check for errors
        # Assigning bank type as null
        * set createBankPayload.banks[0].type = null
        # Steps to create bank and generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Validate the response
        * match createBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTypeDescription
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTypeMessage

@Bank_Create_CodeLen_07 @negative @bankCreate @egfMaster  @egfMasterBank @businessServices @regression
    Scenario: Verify by passing more than 50 chars for code and check for errors
        # Assigning bank code as random value
        * set createBankPayload.banks[0].code = randomString(55)
        # Steps to create bank and generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Validate the response
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidCodeLength

@Bank_Create_NameLen_08 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify by passing more than 100 chars for name and check for error
        # Assigning bank name as random value
        * set createBankPayload.banks[0].name = randomString(110)
        # Steps to create bank and generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Validate the response
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidNameLength

@Bank_Create_DescLen_09 @negative @bankCreate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify by passing more than 250 chars for desc field and check for error
        # Assigning bank description as random value
        * set createBankPayload.banks[0].description = randomString(260)
        # Steps to create bank and generate error response
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInCreateBank')
        # Validate the response
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidDescriptionLength
    
# Update Bank Tests

@Bank_Update_01 @positive @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank account throgh API call
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Set new bank code
        * set updateBankPayload.banks[0].code = randomString(5)
        # Set new bank name
        * set updateBankPayload.banks[0].name = 'BANK-'+randomString(3)
        # Set new bank description
        * set updateBankPayload.banks[0].description = 'Desc-'+randomString(3)
        # Set new bank type
        * set updateBankPayload.banks[0].type = 'Type-'+randomString(3)
        # Steps to update bank 
        * call read('../../business-services/pretest/egfMasterPreTest.feature@updateBank')
        # Validate that the new values should get updated 
        * match updateBankResponse.banks[0].code == updateBankPayload.banks[0].code
        * match updateBankResponse.banks[0].name == updateBankPayload.banks[0].name
        * match updateBankResponse.banks[0].description == updateBankPayload.banks[0].description
        * match updateBankResponse.banks[0].type == updateBankPayload.banks[0].type

@Bank_Update_UniqueName_02 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify updating bank by passing a value for name that already exists and check for errors
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Set new code and name to create a new Bank 
        * set createBankPayload.banks[0].code = bankCode+'-latest'
        * set createBankPayload.banks[0].name = bankName+'-latest'
        # Steps to create a new Bank with latest details
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Set existing Bank ID to update the details
        * set updateBankPayload.banks[0].id = createBankResponse.banks[0].id
        # Set new code to update the existing Bank record
        * set updateBankPayload.banks[0].code = randomString(5)
        # Set new description to update the existing Bank record
        * set updateBankPayload.banks[0].description = 'Desc-'+randomString(3)
        # Set new type to update the existing Bank record
        * set updateBankPayload.banks[0].type = 'Type-'+randomString(3)
        # Only Bank name is remain same and calling the steps to update existing bank details with existing name
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Preparing dynamic error description
        * def errorDescription = "The  value  "+bankName+" for the field name already exists in the system. Please provide different value"
        # Validate that the error description and message returned by API should be same with expected error
        * match updateBankResponse.errors[0].description == errorDescription
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.nameFieldValueNotUnique

@Bank_Update_UniqueCode_03 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify updating bank by passing a value for code that already exists and check for errors
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Set new code and name to create a new Bank 
        * set createBankPayload.banks[0].code = bankCode+'-latest'
        * set createBankPayload.banks[0].name = bankName+'-latest'
        # Steps to create a new Bank with latest details
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Set existing Bank ID to update the details
        * set updateBankPayload.banks[0].id = createBankResponse.banks[0].id
        * set updateBankPayload.banks[0].name = randomString(5)
        * set updateBankPayload.banks[0].description = 'Desc-'+randomString(3)
        * set updateBankPayload.banks[0].type = 'Type-'+randomString(3)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Preparing error description with dynamic bank code
        * def errorDescription = "The  value  "+bankCode+" for the field code already exists in the system. Please provide different value"
        # Validate that the error description returned by API due to existing bank code is equal with expected error 
        * match updateBankResponse.errors[0].description == errorDescription
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.codeFieldValueNotUnique

@Bank_Update_InvalidTenant_04 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify updating bank using API call by passing a invalid/non existing tenant id in the request body
        # Set an Invalid tenantId
        * set updateBankPayload.banks[0].tenantId = 'Invalid'+randomString(5)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBankUnAuthorized')
        # Validate that the error description returned by API due to Invalid tenantId is equal with expected error
        * match updateBankResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@Bank_Update_NoTenant_05 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify updating bank  using API call by not passing tenant id in the request body or by passing null for tenant id
        # Remove tenantId field from upload payload
        * remove updateBankPayload.banks[0].tenantId
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error description returned by API due to missing tenantId field is equal with expected error
        * match updateBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTenantIdDescription
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTenantIdMessage

@Bank_Update_activeNull_06 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify updating bank  by passing null value for active and check for errors
        # Set bank type as `null`
        * set updateBankPayload.banks[0].type = null
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to null bank type is equal with expected error
        * match updateBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTypeDescription
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTypeMessage

@Bank_Update_CodeLen_07 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify by passing more than 50 chars for code and check for errors
        # Set bank code value more that 50 charecters
        * set updateBankPayload.banks[0].code = randomString(55)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to invalid char length of bank code is equal with expected error
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidCodeLength

@Bank_Update_NameLen_08 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify by passing more than 100 chars for name and check for error
        # Set bank name with more than 100 charecters
        * set updateBankPayload.banks[0].name = randomString(110)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to invalid char length of bank name is equal with expected error
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidNameLength

@Bank_Update_DescLen_09 @negative @bankUpdate @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify by passing more than 250 chars for desc field and check for error
        # Set bank description with more than 250 charecters
        * set updateBankPayload.banks[0].description = randomString(260)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to invalid char length of bank description is equal with expected error
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidDescriptionLength

# Search Bank

@Bank_Search_01 @positive @bankSearch @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify creating bank account throgh API call with tenantId, code, name, description, type and active details
        # Steps to craete a new Bank
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Defining search parameters
        * def searchParams = { tenantId: '#(tenantId)', code: '#(bankCode)', name: '#(bankName)', description: '#(bankDescription)', active: '#(isActive)', type: '#(bankType)'}
        # Steps to search a bank
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that serach response should contain bank details as per the specified parameters
        * match searchBankResponse.banks.size() != 0
        * match searchBankResponse.banks[0].code == bankCode
        * match searchBankResponse.banks[0].name == bankName
        * match searchBankResponse.banks[0].description == bankDescription
        * match searchBankResponse.banks[0].active == isActive
        * match searchBankResponse.banks[0].type == bankType
        * match searchBankResponse.banks[0].tenantId == tenantId

@Bank_Search_InvalidTenant_02 @negative @bankSearch @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify searching for Bank through API call by passing a invlalid or a non existing tenant id  and check for errors
        # Defining search parameters with InvalidTenantID
        * def searchParams = { tenantId: '#(invalidTenantId)', code: '#(bankCode)', name: '#(bankName)', description: '#(bankDescription)', active: '#(isActive)', type: '#(bankType)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInSearchBankUnAuthorized')
        # Validate that the error returns by API due to invalid tenantId should be equal with expected error
        * match searchBankResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError
        
@Bank_Search_TenantIdMandatory_03 @negative @bankSearch @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify searching for Bank through API call by not passing tenantId
        # Defining search parameters without tenantID
        * def searchParams = { code: '#(bankCode)', name: '#(bankName)', description: '#(bankDescription)', active: '#(isActive)', type: '#(bankType)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInSearchBank')
        # Validate that the error returns by API due to tenantId missing should be equal with expected error 
        * match searchBankResponse == egfMasterConstants.errorMessages.missingTenantId

@Bank_Search_AllRecords_04 @positive @bankSearch @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify searching for bank through API call using tenantId
        # Defining search parameters with only tenantId
        * def searchParams = { tenantId: '#(tenantId)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that the searchResponse should not be empty
        * match searchBankResponse.banks.size() != 0

@Bank_Search_empty_05 @positive @bankSearch @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify search by passing different combinations of the search params
        # Defining search parameters without unique or new bank ID 
        * def searchParams = { tenantId: '#(tenantId)', id: '#(uniqueBankId)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that the search response should be empty and the new id is not present for the given tenantId
        * match searchBankResponse.banks.size() == 0

@BankSearch_multiple_06 @positive @bankSearch @egfMaster @egfMasterBank @businessServices @regression
    Scenario: Verify search by passing different combinations of the search params
        # Steps to craete a new Bank 
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        # Defining search parameters with multiple field values
        * def searchParams = { tenantId: '#(tenantId)', code: '#(bankCode)', name: '#(bankName)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that serach response should contain bank details as per the specified parameters
        * match searchBankResponse.banks[0].code == bankCode
        * match searchBankResponse.banks[0].name == bankName
        * match searchBankResponse.banks[0].tenantId == tenantId