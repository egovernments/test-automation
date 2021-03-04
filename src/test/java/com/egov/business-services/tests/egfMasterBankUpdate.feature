 Feature: To test egf-master-Bank service 'Update' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml')
        * def bankCode = randomString(5)
        * def bankName = 'Bank-'+randomString(3)
        * def bankDescription = 'Desc-'+randomString(3)
        * def isActive = false
        * def bankType = 'Type-'+randomString(3)
        * def createBankPayload = read('../../business-services/requestPayload/egfMaster/bank/create.json')
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * def bankId = createBankResponse.banks[0].id
        * def updateBankPayload = read('../../business-services/requestPayload/egfMaster/bank/update.json')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        
  
@Bank_Update_01 @positive @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify creating bank account throgh API call
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

@Bank_Update_UniqueName_02 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify updating bank by passing a value for name that already exists and check for errors
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

@Bank_Update_UniqueCode_03 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify updating bank by passing a value for code that already exists and check for errors
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

@Bank_Update_InvalidTenant_04 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify updating bank using API call by passing a invalid/non existing tenant id in the request body
        # Set an Invalid tenantId
        * set updateBankPayload.banks[0].tenantId = 'Invalid'+randomString(5)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error description returned by API due to Invalid tenantId is equal with expected error
        * match updateBankResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@Bank_Update_NoTenant_05 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify updating bank  using API call by not passing tenant id in the request body or by passing null for tenant id
        # Remove tenantId field from upload payload
        * remove updateBankPayload.banks[0].tenantId
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error description returned by API due to missing tenantId field is equal with expected error
        * match updateBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTenantIdDescription
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTenantIdMessage

@Bank_Update_activeNull_06 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify updating bank  by passing null value for active and check for errors
        # Set bank type as `null`
        * set updateBankPayload.banks[0].type = null
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to null bank type is equal with expected error
        * match updateBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTypeDescription
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTypeMessage

@Bank_Update_CodeLen_07 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify by passing more than 50 chars for code and check for errors
        # Set bank code value more that 50 charecters
        * set updateBankPayload.banks[0].code = randomString(55)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to invalid char length of bank code is equal with expected error
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidCodeLength

@Bank_Update_NameLen_08 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify by passing more than 100 chars for name and check for error
        # Set bank name with more than 100 charecters
        * set updateBankPayload.banks[0].name = randomString(110)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to invalid char length of bank name is equal with expected error
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidNameLength

@Bank_Update_DescLen_09 @negative @bankUpdate @egfMaster @egfMasterBankAccount @businessServices @regression
    Scenario: Verify by passing more than 250 chars for desc field and check for error
        # Set bank description with more than 250 charecters
        * set updateBankPayload.banks[0].description = randomString(260)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@errorInUpdateBank')
        # Validate that the error returned by API due to invalid char length of bank description is equal with expected error
        * match updateBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidDescriptionLength
    