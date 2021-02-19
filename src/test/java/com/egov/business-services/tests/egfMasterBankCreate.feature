 Feature: To test egf-master-Bank service 'Create' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml')
        * def bankCode = randomString(5)
        * def bankName = 'Bank-'+randomString(3)
        * def bankDescription = 'Desc-'+randomString(3)
        * def isActive = false
        * def bankType = 'Type-'+randomString(3)
        * def createBankPayload = read('../../business-services/requestPayload/egfMaster/bank/create.json')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  
@BankCreate_01 @positive @bankCreate @egfMaster @regression
    Scenario: Verify creating bank account throgh API call
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * match createBankResponse.banks[0].code == bankCode
        * match createBankResponse.banks[0].name == bankName
        * match createBankResponse.banks[0].description == bankDescription
        * match createBankResponse.banks[0].active == isActive
        * match createBankResponse.banks[0].type == bankType

@Bank_Create_UniqueName_02 @negative @bankCreate @egfMaster @regression
    Scenario: Verify updating bank by passing a value for name that already exists and check for errors
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * set createBankPayload.banks[0].code = randomString(5)
        * set createBankPayload.banks[0].description = 'Desc-'+randomString(3)
        * set createBankPayload.banks[0].type = 'Type-'+randomString(3)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * def errorDescription = "The  value  "+bankName+" for the field name already exists in the system. Please provide different value"
        * match createBankResponse.errors[0].description == errorDescription
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.nameFieldValueNotUnique

@Bank_Create_UniqueCode_03 @negative @bankCreate @egfMaster @regression
    Scenario: Verify creating bank by passing a value for code that already exists and check for errors
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * set createBankPayload.banks[0].name = randomString(5)
        * set createBankPayload.banks[0].description = 'Desc-'+randomString(3)
        * set createBankPayload.banks[0].type = 'Type-'+randomString(3)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * def errorDescription = "The  value  "+bankCode+" for the field code already exists in the system. Please provide different value"
        * match createBankResponse.errors[0].description == errorDescription
        * match createBankResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.codeFieldValueNotUnique

@Bank_Create_InvalidTenant_04 @negative @bankCreate @egfMaster @regression
    Scenario: Verify creating bank using API call by passing a invalid/non existing tenant id in the request body
        * set createBankPayload.banks[0].tenantId = 'Invalid'+randomString(5)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * match createBankResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@Bank_Create_NoTenant_05 @negative @bankCreate @egfMaster @regression
    Scenario: Verify creating bank  using API call by not passing tenant id in the request body or by passing null for tenant id
        * remove createBankPayload.banks[0].tenantId
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * print createBankResponse
        * match createBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTenantIdDescription
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTenantIdMessage

@Bank_Create_activeNull_06 @negative @bankCreate @egfMaster @regression
    Scenario: Verify creating bank  by passing null value for active and check for errors
        * set createBankPayload.banks[0].type = null
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * print createBankResponse
        * match createBankResponse.errors[0].description == egfMasterConstants.errorMessages.nullTypeDescription
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.nullTypeMessage

@Bank_Create_CodeLen_07 @negative @bankCreate @egfMaster @regression
    Scenario: Verify by passing more than 50 chars for code and check for errors
        * set createBankPayload.banks[0].code = randomString(55)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * print createBankResponse
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidCodeLength

@Bank_Create_NameLen_08 @negative @bankCreate @egfMaster @regression
    Scenario: Verify by passing more than 100 chars for name and check for error
        * set createBankPayload.banks[0].name = randomString(110)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * print createBankResponse
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidNameLength

@Bank_Create_DescLen_09 @negative @bankCreate @egfMaster @regression
    Scenario: Verify by passing more than 250 chars for desc field and check for error
        * set createBankPayload.banks[0].description = randomString(260)
        * call read('../../business-services/pretest/egfMasterPreTest.feature@createBank')
        * print createBankResponse
        * match createBankResponse.errors[0].message == egfMasterConstants.errorMessages.invalidDescriptionLength
    