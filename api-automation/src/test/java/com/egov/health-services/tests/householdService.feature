Feature: Household Services - HCM

    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def householdClientReferenceId = getUUID()
        * def memberCount = ranInteger(1)
        * def addressClientReferenceId = getUUID()
        * def doorNo = "Door No " + intergerToString(retMax(1000))
        * def type = getRandomArrayElement([ "PERMANENT", "CORRESPONDENCE", "OTHER" ])
        * def addressLine1 = "Auto_" + randomString(9) + "_Addressline1"
        * def addressLine2 = "Auto_" + randomString(9) + "_Addressline2"
        * def landmark = "Near " + randomString(9)
        * def city = "Auto_" + randomString(9)
        * def pincode = convertIntegerToString(generateRandomNumberInRange(1,999999))
        * def buildingName = "Auto_" + randomString(5) + "_BuildingName"
        * def street = "Street " + randomNumber(2)
        * def localityCode = "Auto_" + getUnixEpochTime() + randomString(5) + "_LocalityCode"
        * def localityName = "Auto_" + randomNumber(5) + "_LocalityName"
        * def localityLabel = "Auto_" + randomNumber(5) + "_LocalityLabel"
        * def localityLatitude = convertIntegerToString(generateRandomNumberInRange(-90,90))
        * def localityLongitude = convertIntegerToString(generateRandomNumberInRange(180,180))
        * def hcmTenantId = "default"
        * def hcmAuthToken = registrarAuthToken

    ## Household Create API related test cases

    @HCM_household_create_01 @healthServices @regression @positive @smoke @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with auth token of a registrar
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        ## response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.tenantId == hcmTenantId
        * assert householdResponseBody.Household.clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Household.memberCount == memberCount
        * assert householdResponseBody.Household.address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Household.address.doorNo == doorNo
        * assert householdResponseBody.Household.address.type == type
        * assert householdResponseBody.Household.address.addressLine1 == addressLine1
        * assert householdResponseBody.Household.address.addressLine2 == addressLine2
        * assert householdResponseBody.Household.address.landmark == landmark
        * assert householdResponseBody.Household.address.city == city
        * assert householdResponseBody.Household.address.pincode == pincode
        * assert householdResponseBody.Household.address.buildingName == buildingName
        * assert householdResponseBody.Household.address.street == street
        * assert householdResponseBody.Household.address.locality.code == localityCode
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 1
    ## the following fields are not saved in the DB hence not validating it.
    ## * assert createHouseholdResponseBody.Household.address.locality.name == localityName
    ## * assert createHouseholdResponseBody.Household.address.locality.label == localityLabel
    ## * assert createHouseholdResponseBody.Household.address.locality.latitude == localityLatitude
    ## * assert createHouseholdResponseBody.Household.address.locality.longitude == localityLongitude


    @HCM_household_create_02 @healthServices @regression @positive @smoke @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        ## response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.tenantId == hcmTenantId
        * assert householdResponseBody.Household.clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Household.memberCount == memberCount
        * assert householdResponseBody.Household.address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Household.address.doorNo == doorNo
        * assert householdResponseBody.Household.address.type == type
        * assert householdResponseBody.Household.address.addressLine1 == addressLine1
        * assert householdResponseBody.Household.address.addressLine2 == addressLine2
        * assert householdResponseBody.Household.address.landmark == landmark
        * assert householdResponseBody.Household.address.city == city
        * assert householdResponseBody.Household.address.pincode == pincode
        * assert householdResponseBody.Household.address.buildingName == buildingName
        * assert householdResponseBody.Household.address.street == street
        * assert householdResponseBody.Household.address.locality.code == localityCode
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 1
    ## the following fields are not saved in the DB hence not validating it.
    ## * assert createHouseholdResponseBody.Household.address.locality.name == localityName
    ## * assert createHouseholdResponseBody.Household.address.locality.label == localityLabel
    ## * assert createHouseholdResponseBody.Household.address.locality.latitude == localityLatitude
    ## * assert createHouseholdResponseBody.Household.address.locality.longitude == localityLongitude


    @HCM_household_create_03 @HCM_household_create_invalid_tenant @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with invalid tenantId
        ## Setting tenantId with an invalid value
        * def hcmTenantId = "soemthing"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdUnauthorised')
        * assert householdResponseBody.Errors[0].code == "CustomException"
        * assert householdResponseBody.Errors[0].message == "Not authorized to access this resource"
        * assert householdResponseBody.Errors[0].description == "Not authorized to access this resource"

    @HCM_household_create_04 @null_check_tenantId @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with a null tenantId
        ## Setting tenantId with null
        * def hcmTenantId = null
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].message == "must not be null"
        * assert householdResponseBody.Errors[1].message == "must not be null"

    @HCM_household_create_05 @empty_string_check_tenantId @healthServices @regression @positive @smoke @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty string for tenantId
        ## Setting tenantId with empty string
        * def hcmTenantId = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdUnauthorised')
        * assert householdResponseBody.Errors[0].code == "CustomException"
        * assert householdResponseBody.Errors[0].message == "Not authorized to access this resource"
        * assert householdResponseBody.Errors[0].description == "Not authorized to access this resource"

    @HCM_household_create_06 @size_check_minimum_clientReferenceId @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with clientReferenceId having a size less than minimum allowed number of characters
        ## Setting clientReferenceId with a string having  a size less than minimum number of characters
        * def householdClientReferenceId = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_07 @size_check_maximum_clientReferenceId @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with clientReferenceId having a size more than maximum allowed number of characters
        ## Setting clientReferenceId with a string having a size less than maximum number of characters
        * def householdClientReferenceId = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_08 @null_check_memberCount @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with memberCount being null
        ## Setting memberCount to null
        * def memberCount = null
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code ==  "NotNull.householdRequest.household.memberCount"
        * assert householdResponseBody.Errors[0].message == "must not be null"

    @HCM_household_create_09 @range_check_minimum_memberCount @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with memberCount having a value less than minimum allowed number
        ## Setting memberCount to less than allowed minimum value
        * def memberCount = -1
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Range.householdRequest.household.memberCount"
        * assert householdResponseBody.Errors[0].message == "must be between 0 and 1000"

    @HCM_household_create_10 @range_check_maximum_memberCount @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with memberCount having a range more than maximum allowed number
        ## Setting memberCount to more than allowed maximum value
        * def memberCount = 1001
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Range.householdRequest.household.memberCount"
        * assert householdResponseBody.Errors[0].message == "must be between 0 and 1000"

    @HCM_household_create_11 @empty_check_doorNo @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty doorNo
        ## Setting doorNo to an empty string
        * def doorNo = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_12 @size_check_minimum_doorNo @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with doorNo having a value less than minimum allowed number
        ## Setting doorNo with a string having a size less than minimum number of characters
        * def doorNo = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_13 @size_check_maximum_doorNo @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with doorNo having a value more than maximum allowed number
        ## Setting doorNo with a string having a size more than maximum number of characters
        * def doorNo = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_14 @empty_check_addressLine1 @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty addressLine1
        ## Setting addressLine1 to an empty string
        * def addressLine1 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_15 @size_check_minimum_addressLine1 @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with addressLine1 having a value less than minimum allowed number
        ## Setting addressLine1 with a string having a size less than minimum number of characters
        * def addressLine1 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_16 @size_check_maximum_addressLine1 @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with addressLine1 having a value more than maximum allowed number
        ## Setting addressLine1 with a string having a size more than maximum number of characters
        * def addressLine1 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_17 @empty_check_addressLine2 @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty addressLine2
        ## Setting addressLine2 to an empty string
        * def addressLine2 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_18 @size_check_minimum_addressLine2 @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with addressLine2 having a value less than minimum allowed number
        ## Setting addressLine2 with a string having a size less than minimum number of characters
        * def addressLine2 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_19 @size_check_maximum_addressLine2 @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with addressLine2 having a value more than maximum allowed number
        ## Setting addressLine2 with a string having a size more than maximum number of characters
        * def addressLine2 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_20 @empty_check_landmark @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty landmark
        ## Setting landmark to an empty string
        * def landmark = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_21 @size_check_minimum_landmark @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with landmark having a value less than minimum allowed number
        ## Setting landmark with a string having a size less than minimum number of characters
        * def landmark = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_22 @size_check_maximum_landmark @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with landmark having a value more than maximum allowed number
        ## Setting landmark with a string having a size more than maximum number of characters
        * def landmark = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_23 @empty_check_pincode @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty pincode
        ## Setting pincode to an empty string
        * def pincode = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_24 @size_check_minimum_pincode @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with pincode having a value less than minimum allowed number
        ## Setting pincode with a string having a size less than minimum number of characters
        * def pincode = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_25 @size_check_maximum_pincode @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with pincode having a value more than maximum allowed number
        ## Setting pincode with a string having a size more than maximum number of characters
        * def pincode = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_26 @empty_check_buildingName @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty buildingName
        ## Setting buildingName to an empty string
        * def buildingName = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_27 @size_check_minimum_buildingName @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with buildingName having a value less than minimum allowed number
        ## Setting buildingName with a string having a size less than minimum number of characters
        * def buildingName = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_28 @size_check_maximum_buildingName @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with buildingName having a value more than maximum allowed number
        ## Setting buildingName with a string having a size more than maximum number of characters
        * def buildingName = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_29 @empty_check_street @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with empty street
        ## Setting street to an empty string
        * def street = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_30 @size_check_minimum_street @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with street having a value less than minimum allowed number
        ## Setting street with a string having a size less than minimum number of characters
        * def street = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_31 @size_check_maximum_street @healthServices @regression @negative @hcm_household_create @hcm @householdService
    Scenario: Test to create a household with street having a value more than maximum allowed number
        ## Setting street with a string having a size more than maximum number of characters
        * def street = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    ## Household Search API related test cases

    @HCM_household_search_01 @search_household_withoutQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household without passing query parameters
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithIdWithoutQueryParams')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_02 @search_household_withOnlyLimitQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household by passing only limit query parameter
        ## * def limitOfSearch = 100
        * def idOfHousehold = 1234
        * def parameters =
            """
            {
            limit: 100
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "offset"

    @HCM_household_search_03 @search_household_withOnlyOffsetQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household by passing only offset query parameter
        ## * def offsetOfSearch = 0
        * def idOfHousehold = 1234
        * def parameters =
            """
            {
            offset: 0
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_04 @search_household_withOnlyTenantIdQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household by passing only tenantId query parameter
        * def parameters =
            """
            {
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_05 @search_household_withOnlyLimitAndOffsetQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household by passing only limit and offset query parameter
        ## * def limitOfSearch = 100
        ## * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 100,
            offset: 0
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required String parameter 'tenantId' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "tenantId"

    @HCM_household_search_06 @search_household_withOnlyTenantIdAndOffsetQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household by passing only tenantId and offset query parameter
        ## * def offsetOfSearch = 0
        * def parameters =
            """
            {
            tenantId: '##(hcmTenantId)',
            offset: 0,
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_07 @search_household_withOnlyTenantIdAndLimitQueryParams @healthServices @regression @negative @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household by passing only tenantId and limit query parameter
        ## * def limitOfSearch = 100
        * def parameters =
            """
            {
            tenantId: '##(hcmTenantId)',
            limit: 100
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "offset"

    @HCM_household_search_08 @search_household_with_all_criteria_individually @healthServices @regression @smoke @positive @hcm_household_search @hcm @householdService
    Scenario: Test to search for a household using different criteria
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1
        * def clientReferenceIdOfHousehold = householdResponseBody.Households[0].clientReferenceId
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithClientReferenceId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1
        * def boundaryCodeOfHousehold = localityCode
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithBoundaryCode')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1
        ## search for household using all criteria in one API call
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithAllCriteria')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1

    ## Household update API test cases.

    @HCM_household_update_01 @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        ## response data validations after household create
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.address.addressLine1 == addressLine1
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 1
        * def householdCreatedData = householdResponseBody.Household
        * householdCreatedData.address.addressLine1 = householdCreatedData.address.addressLine1 + " updated"
        * householdCreatedData.memberCount = 10
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdSuccess')
        ## response data validations after household update
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 2
        ## search for the same household
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations for search household after update
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == 10
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 2

    @HCM_household_update_02 @empty_check_id @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an empty id value for the household
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.id"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_03 @size_check_minimum_id @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an id value for the household which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.id"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_04 @size_check_maximum_id @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an id value for the household which is more than alowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.id"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_05 @null_check_id @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing a null value for id
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def idOfHouseholdToUpdate = null
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "VALIDATION_ERROR"
        * match householdResponseBody.Errors[0].message != null

    @HCM_household_update_06 @null_check_tenantId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing a null value for hcmTenantId
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def hcmTenantId = null
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "NotNull.householdRequest.household.tenantId"
        * match householdResponseBody.Errors[0].message == "must not be null"

    @HCM_household_update_07 @size_check_minimum_clientReferenceId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an clientReferenceId value for the household which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def householdClientReferenceId = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_08 @size_check_maximum_clientReferenceId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an clientReferenceId value for the household which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def householdClientReferenceId = randomString(200)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_09 @empty_check_clientReferenceId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def householdClientReferenceId = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_10 @size_check_minimum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an clientReferenceId value for the address of the household which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_11 @size_check_maximum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an clientReferenceId value for the household which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(200)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_12 @empty_check_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_13 @null_check_addressTenantId @healthServices @regression @positive @smoke @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household by passing a null value for address object tenantid
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = null
        * def idOfHouseholdToUpdate = randomString(36)
        * def hcmTenantId = "default"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "NotNull.householdRequest.household.address.tenantId"
        * match householdResponseBody.Errors[0].message == "must not be null"

    @HCM_household_update_14 @empty_check_doorNo @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty doorNo
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo to an empty string
        * def doorNo = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_15 @size_check_minimum_doorNo @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with doorNo having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size less than minimum number of characters
        * def doorNo = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_16 @size_check_maximum_doorNo @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with doorNo having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size more than maximum number of characters
        * def doorNo = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_17 @empty_check_addressLine1 @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty addressLine1
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 to an empty string
        * def addressLine1 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_18 @size_check_minimum_addressLine1 @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with addressLine1 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size less than minimum number of characters
        * def addressLine1 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_19 @size_check_maximum_addressLine1 @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with addressLine1 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size more than maximum number of characters
        * def addressLine1 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_20 @empty_check_addressLine2 @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty addressLine2
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 to an empty string
        * def addressLine2 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_21 @size_check_minimum_addressLine2 @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with addressLine2 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size less than minimum number of characters
        * def addressLine2 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_22 @size_check_maximum_addressLine2 @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with addressLine2 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size more than maximum number of characters
        * def addressLine2 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_23 @empty_check_landmark @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty landmark
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark to an empty string
        * def landmark = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_24 @size_check_minimum_landmark @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with landmark having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size less than minimum number of characters
        * def landmark = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_25 @size_check_maximum_landmark @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with landmark having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size more than maximum number of characters
        * def landmark = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_26 @empty_check_pincode @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty pincode
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode to an empty string
        * def pincode = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_27 @size_check_minimum_pincode @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with pincode having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size less than minimum number of characters
        * def pincode = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_28 @size_check_maximum_pincode @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with pincode having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size more than maximum number of characters
        * def pincode = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_update_29 @empty_check_buildingName @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty buildingName
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName to an empty string
        * def buildingName = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_30 @size_check_minimum_buildingName @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with buildingName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size less than minimum number of characters
        * def buildingName = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_31 @size_check_maximum_buildingName @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with buildingName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size more than maximum number of characters
        * def buildingName = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_32 @empty_check_street @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with empty street
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street to an empty string
        * def street = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_33 @size_check_minimum_street @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with street having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size less than minimum number of characters
        * def street = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_update_34 @size_check_maximum_street @healthServices @regression @negative @hcm_household_update @hcm @householdService
    Scenario: Test to update an existing household with street having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size more than maximum number of characters
        * def street = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    ## Household delete API test cases

    @HCM_household_delete_01 @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        ## response data validations after household create
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 1
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations for search household after create
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1
        * def householdCreatedData = householdResponseBody.Households[0]
        * householdCreatedData.isDeleted = true
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdSuccess')
        ## response data validations after household delete
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.isDeleted == true
        * assert householdResponseBody.Household.rowVersion == 2
        ## search for the same household
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations for search household after update
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == true
        * assert householdResponseBody.Households[0].rowVersion == 2

    @HCM_household_delete_02 @empty_check_id @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an empty id value for the household
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.id"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_03 @size_check_minimum_id @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an id value for the household which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.id"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_04 @size_check_maximum_id @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an id value for the household which is more than alowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.id"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_05 @null_check_id @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing a null value for id
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = null
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "VALIDATION_ERROR"
        * match householdResponseBody.Errors[0].message != null

    @HCM_household_delete_06 @null_check_tenantId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing a null value for hcmTenantId
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def hcmTenantId = null
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "NotNull.householdRequest.household.tenantId"
        * match householdResponseBody.Errors[0].message == "must not be null"

    @HCM_household_delete_07 @size_check_minimum_clientReferenceId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an clientReferenceId value for the household which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def householdClientReferenceId = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_08 @size_check_maximum_clientReferenceId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an clientReferenceId value for the household which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def householdClientReferenceId = randomString(200)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_09 @empty_check_clientReferenceId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def householdClientReferenceId = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_10 @size_check_minimum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an clientReferenceId value for the address of the household which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_11 @size_check_maximum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an clientReferenceId value for the household which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(200)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_12 @empty_check_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.clientReferenceId"
        * match householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_13 @null_check_addressTenantId @healthServices @regression @positive @smoke @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household by passing a null value for address object tenantid
        * def hcmAuthToken = distributorAuthToken
        * def tenantIdOfAddress = null
        * def idOfHouseholdToDelete = randomString(36)
        * def hcmTenantId = "default"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        ## response data validations
        * assert householdResponseBody.Errors[0].code == "NotNull.householdRequest.household.address.tenantId"
        * match householdResponseBody.Errors[0].message == "must not be null"

    @HCM_household_delete_14 @empty_check_doorNo @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty doorNo
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo to an empty string
        * def doorNo = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_15 @size_check_minimum_doorNo @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with doorNo having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size less than minimum number of characters
        * def doorNo = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_16 @size_check_maximum_doorNo @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with doorNo having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size more than maximum number of characters
        * def doorNo = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.doorNo"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_17 @empty_check_addressLine1 @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty addressLine1
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 to an empty string
        * def addressLine1 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_18 @size_check_minimum_addressLine1 @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with addressLine1 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size less than minimum number of characters
        * def addressLine1 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_19 @size_check_maximum_addressLine1 @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with addressLine1 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size more than maximum number of characters
        * def addressLine1 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine1"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_20 @empty_check_addressLine2 @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty addressLine2
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 to an empty string
        * def addressLine2 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_21 @size_check_minimum_addressLine2 @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with addressLine2 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size less than minimum number of characters
        * def addressLine2 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_22 @size_check_maximum_addressLine2 @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with addressLine2 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size more than maximum number of characters
        * def addressLine2 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.addressLine2"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_23 @empty_check_landmark @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty landmark
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark to an empty string
        * def landmark = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_24 @size_check_minimum_landmark @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with landmark having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size less than minimum number of characters
        * def landmark = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_25 @size_check_maximum_landmark @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with landmark having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size more than maximum number of characters
        * def landmark = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.landmark"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_26 @empty_check_pincode @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty pincode
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode to an empty string
        * def pincode = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_27 @size_check_minimum_pincode @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with pincode having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size less than minimum number of characters
        * def pincode = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_28 @size_check_maximum_pincode @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with pincode having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size more than maximum number of characters
        * def pincode = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.pincode"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_delete_29 @empty_check_buildingName @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty buildingName
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName to an empty string
        * def buildingName = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_30 @size_check_minimum_buildingName @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with buildingName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size less than minimum number of characters
        * def buildingName = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_31 @size_check_maximum_buildingName @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with buildingName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size more than maximum number of characters
        * def buildingName = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.buildingName"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_32 @empty_check_street @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with empty street
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street to an empty string
        * def street = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_33 @size_check_minimum_street @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with street having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size less than minimum number of characters
        * def street = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_delete_34 @size_check_maximum_street @healthServices @regression @negative @hcm_household_delete @hcm @householdService
    Scenario: Test to delete an existing household with street having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def hcmTenantId = "default"
        * def tenantIdOfAddress = "default"
        * def idOfHouseholdToDelete = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size more than maximum number of characters
        * def street = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdFailure')
        * assert householdResponseBody.Errors[0].code == "Size.householdRequest.household.address.street"
        * assert householdResponseBody.Errors[0].message == "size must be between 2 and 256"

    ## Household CRUD operations using individual APIs

    @HCM_Household_CRUD @healthServices @regression @positive @hcm_household_create @hcm_household_search @hcm_household_update @hcm_household_delete @hcm @householdService
    Scenario: Test to test household API CRUD operations
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        ## response data validations for create household
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.tenantId == hcmTenantId
        * assert householdResponseBody.Household.clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Household.memberCount == memberCount
        * assert householdResponseBody.Household.address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Household.address.doorNo == doorNo
        * assert householdResponseBody.Household.address.type == type
        * assert householdResponseBody.Household.address.addressLine1 == addressLine1
        * assert householdResponseBody.Household.address.addressLine2 == addressLine2
        * assert householdResponseBody.Household.address.landmark == landmark
        * assert householdResponseBody.Household.address.city == city
        * assert householdResponseBody.Household.address.pincode == pincode
        * assert householdResponseBody.Household.address.buildingName == buildingName
        * assert householdResponseBody.Household.address.street == street
        * assert householdResponseBody.Household.address.locality.code == localityCode
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 1
        ## search for the same household
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations for search household
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1
        ## update addressLine1 for the created household
        * def householdCreatedData = householdResponseBody.Households[0]
        * householdCreatedData.address.addressLine1 = householdCreatedData.address.addressLine1 + " updated"
        * call read('../../health-services/pretest/householdServicePretest.feature@updateHouseholdSuccess')
        ## response data validations for update household
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.tenantId == hcmTenantId
        * assert householdResponseBody.Household.clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Household.memberCount == memberCount
        * assert householdResponseBody.Household.address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Household.address.doorNo == doorNo
        * assert householdResponseBody.Household.address.type == type
        * assert householdResponseBody.Household.address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Household.address.addressLine2 == addressLine2
        * assert householdResponseBody.Household.address.landmark == landmark
        * assert householdResponseBody.Household.address.city == city
        * assert householdResponseBody.Household.address.pincode == pincode
        * assert householdResponseBody.Household.address.buildingName == buildingName
        * assert householdResponseBody.Household.address.street == street
        * assert householdResponseBody.Household.address.locality.code == localityCode
        * assert householdResponseBody.Household.isDeleted == false
        * assert householdResponseBody.Household.rowVersion == 2
        ## search for the same household
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations for search household after update
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 2
        ## deleting the household
        * def householdCreatedData = householdResponseBody.Households[0]
        * householdCreatedData.isDeleted = true
        * call read('../../health-services/pretest/householdServicePretest.feature@deleteHouseholdSuccess')
        ## response data validations for delete household
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Household.tenantId == hcmTenantId
        * assert householdResponseBody.Household.clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Household.memberCount == memberCount
        * assert householdResponseBody.Household.address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Household.address.doorNo == doorNo
        * assert householdResponseBody.Household.address.type == type
        * assert householdResponseBody.Household.address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Household.address.addressLine2 == addressLine2
        * assert householdResponseBody.Household.address.landmark == landmark
        * assert householdResponseBody.Household.address.city == city
        * assert householdResponseBody.Household.address.pincode == pincode
        * assert householdResponseBody.Household.address.buildingName == buildingName
        * assert householdResponseBody.Household.address.street == street
        * assert householdResponseBody.Household.address.locality.code == localityCode
        * assert householdResponseBody.Household.isDeleted == true
        * assert householdResponseBody.Household.rowVersion == 3
        ## search for the same household
        * def idOfHousehold = householdResponseBody.Household.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[1]'
        ## response data validations for search household after deletion of household
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].clientReferenceId == householdClientReferenceId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.clientReferenceId == addressClientReferenceId
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == householdCreatedData.address.addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == true
        * assert householdResponseBody.Households[0].rowVersion == 3

    ## Household CRUD operations using bulk APIs

    @HCM_Household_CRUD_bulk @healthServices @regression @positive @smoke @hcm  @householdService
    Scenario: Test to create a household with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * def householdClientReferenceId2 = getUUID()
        * def addressClientReferenceId2 = getUUID()
        * def doorNo2 = "Door No " + intergerToString(retMax(1000))
        * def addressLine12 = "Auto_" + randomString(9) + "_Addressline1"
        * def addressLine22 = "Auto_" + randomString(9) + "_Addressline2"
        * def landmark2 = "Near " + randomString(9)
        * def city2 = "Auto_" + randomString(9)
        * def pincode2 = convertIntegerToString(generateRandomNumberInRange(1,999999))
        * def buildingName2 = "Auto_" + randomString(5) + "_BuildingName"
        * def street2 = "Street " + randomNumber(2)
        * def localityCode2 = "Auto_" + getUnixEpochTime() + randomString(5) + "_LocalityCode"
        * def localityName2 = "Auto_" + randomNumber(5) + "_LocalityName"
        * def localityLabel2 = "Auto_" + randomNumber(5) + "_LocalityLabel"
        * def localityLatitude2 = convertIntegerToString(generateRandomNumberInRange(-90,90))
        * def localityLongitude2 = convertIntegerToString(generateRandomNumberInRange(180,180))
        * call read('../../health-services/pretest/householdServicePretest.feature@bulkCreateHouseholdSuccess')
        * def bulkCreateHouseholdRequestBody = bulkCreateHouseholdRequest
        ## response data validations for bulk household create
        * assert householdResponseBody.status == commonConstants.expectedStatus.success
        * match householdResponseBody.apiId == "/household/v1/bulk/_create"
        * def clientReferenceIdOfHousehold = null
        * json clientReferenceIdOfHousehold = (clientReferenceIdOfHousehold || [])
        * def newClientRefId = householdClientReferenceId
        * def void = (clientReferenceIdOfHousehold.add(newClientRefId))
        * def newClientRefId = householdClientReferenceId2
        * def void = (clientReferenceIdOfHousehold.add(newClientRefId))
        ## search for the same households created
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithMultipleClientReferenceId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(householdResponseBody, "$.Households[*].clientReferenceId")
        * match availableClientReferenceIds contains householdClientReferenceId
        * match availableClientReferenceIds contains householdClientReferenceId2
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 1
        * assert householdResponseBody.Households[1].tenantId == hcmTenantId
        * assert householdResponseBody.Households[1].memberCount == memberCount
        * assert householdResponseBody.Households[1].address.doorNo == doorNo2
        * assert householdResponseBody.Households[1].address.type == type
        * assert householdResponseBody.Households[1].address.addressLine1 == addressLine12
        * assert householdResponseBody.Households[1].address.addressLine2 == addressLine22
        * assert householdResponseBody.Households[1].address.landmark == landmark2
        * assert householdResponseBody.Households[1].address.city == city2
        * assert householdResponseBody.Households[1].address.pincode == pincode2
        * assert householdResponseBody.Households[1].address.buildingName == buildingName2
        * assert householdResponseBody.Households[1].address.street == street2
        * assert householdResponseBody.Households[1].address.locality.code == localityCode2
        * assert householdResponseBody.Households[1].isDeleted == false
        * assert householdResponseBody.Households[1].rowVersion == 1
        ## update addressLine1 for the created households
        * def householdBulkCreatedData = householdResponseBody.Households
        * householdBulkCreatedData[0].address.addressLine1 = householdBulkCreatedData[0].address.addressLine1 + " updated"
        * householdBulkCreatedData[1].address.addressLine1 = householdBulkCreatedData[1].address.addressLine1 + " updated"
        * call read('../../health-services/pretest/householdServicePretest.feature@bulkUpdateHouseholdSuccess')
        ## response data validations for bulk household update
        * assert householdResponseBody.status == commonConstants.expectedStatus.success
        * match householdResponseBody.apiId == "/household/v1/bulk/_update"
        ## search for the updated households
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithMultipleClientReferenceId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(householdResponseBody, "$.Households[*].clientReferenceId")
        * match availableClientReferenceIds contains householdClientReferenceId
        * match availableClientReferenceIds contains householdClientReferenceId2
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == householdBulkCreatedData[0].address.addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == false
        * assert householdResponseBody.Households[0].rowVersion == 2
        * assert householdResponseBody.Households[1].tenantId == hcmTenantId
        * assert householdResponseBody.Households[1].memberCount == memberCount
        * assert householdResponseBody.Households[1].address.doorNo == doorNo2
        * assert householdResponseBody.Households[1].address.type == type
        * assert householdResponseBody.Households[1].address.addressLine1 == householdBulkCreatedData[1].address.addressLine1
        * assert householdResponseBody.Households[1].address.addressLine2 == addressLine22
        * assert householdResponseBody.Households[1].address.landmark == landmark2
        * assert householdResponseBody.Households[1].address.city == city2
        * assert householdResponseBody.Households[1].address.pincode == pincode2
        * assert householdResponseBody.Households[1].address.buildingName == buildingName2
        * assert householdResponseBody.Households[1].address.street == street2
        * assert householdResponseBody.Households[1].address.locality.code == localityCode2
        * assert householdResponseBody.Households[1].isDeleted == false
        * assert householdResponseBody.Households[1].rowVersion == 2
        ## deleting the created household
        * def householdBulkCreatedData = householdResponseBody.Households
        * householdBulkCreatedData[0].isDeleted = true
        * householdBulkCreatedData[1].isDeleted = true
        * call read('../../health-services/pretest/householdServicePretest.feature@bulkDeleteHouseholdSuccess')
        ## response data validations for delete household
        * assert householdResponseBody.status == commonConstants.expectedStatus.success
        * match householdResponseBody.apiId == "/household/v1/bulk/_delete"
        ## search for the deleted households
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithMultipleClientReferenceId')
        * match householdResponseBody.Households == '##array'
        * match householdResponseBody.Households == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(householdResponseBody, "$.Households[*].clientReferenceId")
        * match availableClientReferenceIds contains householdClientReferenceId
        * match availableClientReferenceIds contains householdClientReferenceId2
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdResponseBody.Households[0].tenantId == hcmTenantId
        * assert householdResponseBody.Households[0].memberCount == memberCount
        * assert householdResponseBody.Households[0].address.doorNo == doorNo
        * assert householdResponseBody.Households[0].address.type == type
        * assert householdResponseBody.Households[0].address.addressLine1 == householdBulkCreatedData[0].address.addressLine1
        * assert householdResponseBody.Households[0].address.addressLine2 == addressLine2
        * assert householdResponseBody.Households[0].address.landmark == landmark
        * assert householdResponseBody.Households[0].address.city == city
        * assert householdResponseBody.Households[0].address.pincode == pincode
        * assert householdResponseBody.Households[0].address.buildingName == buildingName
        * assert householdResponseBody.Households[0].address.street == street
        * assert householdResponseBody.Households[0].address.locality.code == localityCode
        * assert householdResponseBody.Households[0].isDeleted == true
        * assert householdResponseBody.Households[0].rowVersion == 3
        * assert householdResponseBody.Households[1].tenantId == hcmTenantId
        * assert householdResponseBody.Households[1].memberCount == memberCount
        * assert householdResponseBody.Households[1].address.doorNo == doorNo2
        * assert householdResponseBody.Households[1].address.type == type
        * assert householdResponseBody.Households[1].address.addressLine1 == householdBulkCreatedData[1].address.addressLine1
        * assert householdResponseBody.Households[1].address.addressLine2 == addressLine22
        * assert householdResponseBody.Households[1].address.landmark == landmark2
        * assert householdResponseBody.Households[1].address.city == city2
        * assert householdResponseBody.Households[1].address.pincode == pincode2
        * assert householdResponseBody.Households[1].address.buildingName == buildingName2
        * assert householdResponseBody.Households[1].address.street == street2
        * assert householdResponseBody.Households[1].address.locality.code == localityCode2
        * assert householdResponseBody.Households[1].isDeleted == true
        * assert householdResponseBody.Households[1].rowVersion == 3
