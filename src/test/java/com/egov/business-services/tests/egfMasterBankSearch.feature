 Feature: To test egf-master-Bank service 'Search' endpoint

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
        * def searchBankPayload = read('../../business-services/requestPayload/egfMaster/bank/search.json')
        * def invalidTenantId = 'Invalid-'+randomString(3)
        * def uniqueBankId = 'Unique-'+randomString(4)
  
@Bank_Search_01 @positive @bankSearch @egfMaster @businessServices @regression
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

@Bank_Search_InvalidTenant_02 @negative @bankSearch @egfMaster @businessServices @regression
    Scenario: Verify searching for Bank through API call by passing a invlalid or a non existing tenant id  and check for errors
        # Defining search parameters with InvalidTenantID
        * def searchParams = { tenantId: '#(invalidTenantId)', code: '#(bankCode)', name: '#(bankName)', description: '#(bankDescription)', active: '#(isActive)', type: '#(bankType)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that the error returns by API due to invalid tenantId should be equal with expected error
        * match searchBankResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError
        
@Bank_Search_TenantIdMandatory_03 @negative @bankSearch @egfMaster @businessServices @regression
    Scenario: Verify searching for Bank through API call by not passing tenantId
        # Defining search parameters without tenantID
        * def searchParams = { code: '#(bankCode)', name: '#(bankName)', description: '#(bankDescription)', active: '#(isActive)', type: '#(bankType)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that the error returns by API due to tenantId missing should be equal with expected error 
        * match searchBankResponse == egfMasterConstants.errorMessages.missingTenantId

@Bank_Search_AllRecords_04 @positive @bankSearch @egfMaster @businessServices @regression
    Scenario: Verify searching for bank through API call using tenantId
        # Defining search parameters with only tenantId
        * def searchParams = { tenantId: '#(tenantId)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that the searchResponse should not be empty
        * match searchBankResponse.banks.size() != 0

@Bank_Search_empty_05 @positive @bankSearch @egfMaster @businessServices @regression
    Scenario: Verify search by passing different combinations of the search params
        # Defining search parameters without unique or new bank ID 
        * def searchParams = { tenantId: '#(tenantId)', id: '#(uniqueBankId)'}
        * call read('../../business-services/pretest/egfMasterPreTest.feature@searchBank')
        # Validate that the search response should be empty and the new id is not present for the given tenantId
        * match searchBankResponse.banks.size() == 0

@Bank Search_multiple_06 @positive @bankSearch @egfMaster @businessServices @regression
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