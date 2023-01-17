Feature: Product Services - HCM

    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def productType = getRandomArrayElement(["Tablet", "Bednet", "Vaccine", "Syrup", "Dry Syrup"])
        * def productName = 'Auto_' + randomString(6) + '_ProdName'
        * def productManufacturer = getRandomArrayElement(["J & J", "Cipla", "GSB", "Dr. Reddys", "Piramal"])
        * def apiOperation = "CREATE"

    @HCM_product_create_01 @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * call read('../../health-services/pretest/productServicePretest.feature@createProductSuccess')
        * assert createProductResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createProductResponseBody.Product[0].type == productType
        * assert createProductResponseBody.Product[0].name == productName
        * assert createProductResponseBody.Product[0].manufacturer == productManufacturer
        * assert createProductResponseBody.Product[0].tenantId == hcmTenantId
        * assert createProductResponseBody.Product[0].isDeleted == false
        * assert createProductResponseBody.Product[0].rowVersion == 1

    @HCM_product_create_02 @HCM_product_create_unauthorised_user @healthServices @regression @negative @hcm_product_create @hcm
    Scenario: Test to create a product with an unauthorised user
        # Setting auth token to the value of the registrar
        * def tempAuthToken = sysAdminAuthToken
        * def unauthoriseduserAuthToken = registrarAuthToken
        * def sysAdminAuthToken = unauthoriseduserAuthToken
        # Steps to generate error message for invalid employee status
        * call read('../../health-services/pretest/productServicePretest.feature@createProductAuthorizationError')
        * def sysAdminAuthToken = tempAuthToken
        # Checking actual error message returned by API with expected error message
        * assert createProductResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError
        * assert createProductResponseBody.Errors[0].description == commonConstants.errorMessages.authorizedError

    @HCM_product_create_03 @HCM_product_create_unauthorised_user @healthServices @regression @negative @hcm_product_create @hcm
    Scenario: Test to create a product with an unauthorised user
        # Setting auth token to the value of the registrar
        * def tempAuthToken = sysAdminAuthToken
        * def unauthoriseduserAuthToken = distributorAuthToken
        * def sysAdminAuthToken = unauthoriseduserAuthToken
        # Steps to generate error message for invalid employee status
        * call read('../../health-services/pretest/productServicePretest.feature@createProductAuthorizationError')
        * def sysAdminAuthToken = tempAuthToken
        # Checking actual error message returned by API with expected error message
        * assert createProductResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError
        * assert createProductResponseBody.Errors[0].description == commonConstants.errorMessages.authorizedError

    @HCM_product_create_04 @null_check_product_name @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def productName = null
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "NotNull.productRequest.product[0].name"
        * assert createProductResponseBody.Errors[0].message == "must not be null"

    @HCM_product_create_05 @null_check_product_tenantId @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def hcmTenantId = null
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "NotNull.productRequest.product[0].tenantId"
        * assert createProductResponseBody.Errors[0].message == "must not be null"

    @HCM_product_create_06 @null_check_product_type @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def productType = null
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "NotNull.productRequest.product[0].type"
        * assert createProductResponseBody.Errors[0].message == "must not be null"

    @HCM_product_create_07 @null_check_product_apiOperation @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def apiOperation = null
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "INVALID_API_OPERATION"
        * assert createProductResponseBody.Errors[0].message == "API Operation null not valid for create request"

    @HCM_product_create_08 @invalid_tenantId @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def hcmTenantId = "abcdefghijklmnopqrstuvwxyz"
        * call read('../../health-services/pretest/productServicePretest.feature@createProductAuthorizationError')
        * assert createProductResponseBody.Errors[0].code == "CustomException"
        * assert createProductResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError
        * assert createProductResponseBody.Errors[0].description == commonConstants.errorMessages.authorizedError

    @HCM_product_create_09 @invalid_type_size_min @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def productType = "a"
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "Size.productRequest.product[0].type"
        * assert createProductResponseBody.Errors[0].message == "size must be between 2 and 100"

    @HCM_product_create_10 @invalid_type_size_max @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def productType = randomString(101)
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "Size.productRequest.product[0].type"
        * assert createProductResponseBody.Errors[0].message == "size must be between 2 and 100"

    @HCM_product_create_11 @invalid_name_size_min @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def productName = "a"
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "Size.productRequest.product[0].name"
        * assert createProductResponseBody.Errors[0].message == "size must be between 2 and 1000"

    @HCM_product_create_12 @invalid_name_size_max @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def productName = randomString(1001)
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "Size.productRequest.product[0].name"
        * assert createProductResponseBody.Errors[0].message == "size must be between 2 and 1000"

    @HCM_product_create_13 @invalid_apiOperation @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def apiOperation = randomString(10)
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "INVALID_API_OPERATION"
        * assert createProductResponseBody.Errors[0].message == "API Operation null not valid for create request"

    @HCM_product_create_14 @invalid_apiOperation_emptyString @healthServices @regression @positive @smoke @hcm_product_create @hcm
    Scenario: Test to create a product
        * def apiOperation = ""
        * call read('../../health-services/pretest/productServicePretest.feature@createProductError')
        * assert createProductResponseBody.Errors[0].code == "INVALID_API_OPERATION"
        * assert createProductResponseBody.Errors[0].message == "API Operation null not valid for create request"