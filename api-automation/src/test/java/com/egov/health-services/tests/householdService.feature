Feature: Household Services - HCM

    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def clientReferenceId = getUUID()
        * def memberCount = ranInteger(1)
        * def doorNo = intergerToString(retMax(1000))
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
        * def apiOperation = "CREATE"
        * def hcmAuthToken = registrarAuthToken

    # Household Create API related test cases

    @HCM_household_create_01 @healthServices @regression @positive @smoke @hcm_household_create @hcm
    Scenario: Test to create a household with auth token of a registrar
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response data validations
        * assert createHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createHouseholdResponseBody.Household[0].tenantId == hcmTenantId
        * assert createHouseholdResponseBody.Household[0].clientReferenceId == clientReferenceId
        * assert createHouseholdResponseBody.Household[0].memberCount == memberCount
        * assert createHouseholdResponseBody.Household[0].address.doorNo == doorNo
        * assert createHouseholdResponseBody.Household[0].address.type == type
        * assert createHouseholdResponseBody.Household[0].address.addressLine1 == addressLine1
        * assert createHouseholdResponseBody.Household[0].address.addressLine2 == addressLine2
        * assert createHouseholdResponseBody.Household[0].address.landmark == landmark
        * assert createHouseholdResponseBody.Household[0].address.city == city
        * assert createHouseholdResponseBody.Household[0].address.pincode == pincode
        * assert createHouseholdResponseBody.Household[0].address.buildingName == buildingName
        * assert createHouseholdResponseBody.Household[0].address.street == street
        * assert createHouseholdResponseBody.Household[0].address.locality.code == localityCode
        * assert createHouseholdResponseBody.Household[0].isDeleted == false
        * assert createHouseholdResponseBody.Household[0].rowVersion == 1
    # the following fields are not saved in the DB hence not validating it.
    # * assert createHouseholdResponseBody.Household[0].address.locality.name == localityName
    # * assert createHouseholdResponseBody.Household[0].address.locality.label == localityLabel
    # * assert createHouseholdResponseBody.Household[0].address.locality.latitude == localityLatitude
    # * assert createHouseholdResponseBody.Household[0].address.locality.longitude == localityLongitude


    @HCM_household_create_02 @healthServices @regression @positive @smoke @hcm_household_create @hcm
    Scenario: Test to create a household with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response data validations
        * assert createHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createHouseholdResponseBody.Household[0].tenantId == hcmTenantId
        * assert createHouseholdResponseBody.Household[0].clientReferenceId == clientReferenceId
        * assert createHouseholdResponseBody.Household[0].memberCount == memberCount
        * assert createHouseholdResponseBody.Household[0].address.doorNo == doorNo
        * assert createHouseholdResponseBody.Household[0].address.type == type
        * assert createHouseholdResponseBody.Household[0].address.addressLine1 == addressLine1
        * assert createHouseholdResponseBody.Household[0].address.addressLine2 == addressLine2
        * assert createHouseholdResponseBody.Household[0].address.landmark == landmark
        * assert createHouseholdResponseBody.Household[0].address.city == city
        * assert createHouseholdResponseBody.Household[0].address.pincode == pincode
        * assert createHouseholdResponseBody.Household[0].address.buildingName == buildingName
        * assert createHouseholdResponseBody.Household[0].address.street == street
        * assert createHouseholdResponseBody.Household[0].address.locality.code == localityCode
        * assert createHouseholdResponseBody.Household[0].isDeleted == false
        * assert createHouseholdResponseBody.Household[0].rowVersion == 1
    # the following fields are not saved in the DB hence not validating it.
    # * assert createHouseholdResponseBody.Household[0].address.locality.name == localityName
    # * assert createHouseholdResponseBody.Household[0].address.locality.label == localityLabel
    # * assert createHouseholdResponseBody.Household[0].address.locality.latitude == localityLatitude
    # * assert createHouseholdResponseBody.Household[0].address.locality.longitude == localityLongitude


    @HCM_household_create_03 @HCM_household_create_invalid_tenant @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with invalid tenantId
        # Setting tenantId with an invalid value
        * def hcmTenantId = "soemthing"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdUnauthorised')
        * assert createHouseholdResponseBody.Errors[0].code == "CustomException"
        * assert createHouseholdResponseBody.Errors[0].message == "Not authorized to access this resource"
        * assert createHouseholdResponseBody.Errors[0].description == "Not authorized to access this resource"

    @HCM_household_create_04 @null_check_tenantId @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with a null tenantId
        # Setting tenantId with null
        * def hcmTenantId = null
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].message == "must not be null"
        * assert createHouseholdResponseBody.Errors[1].message == "must not be null"

    @HCM_household_create_05 @empty_string_check_tenantId @healthServices @regression @positive @smoke @hcm_household_create @hcm
    Scenario: Test to create a household with empty string for tenantId
        # Setting tenantId with empty string
        * def hcmTenantId = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdUnauthorised')
        * assert createHouseholdResponseBody.Errors[0].code == "CustomException"
        * assert createHouseholdResponseBody.Errors[0].message == "Not authorized to access this resource"
        * assert createHouseholdResponseBody.Errors[0].description == "Not authorized to access this resource"

    @HCM_household_create_06 @size_check_minimum_clientReferenceId @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with clientReferenceId having a size less than minimum allowed number of characters
        # Setting clientReferenceId with a string having  a size less than minimum number of characters
        * def clientReferenceId = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].clientReferenceId"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_07 @size_check_maximum_clientReferenceId @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with clientReferenceId having a size more than maximum allowed number of characters
        # Setting clientReferenceId with a string having a size less than maximum number of characters
        * def clientReferenceId = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].clientReferenceId"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_08 @null_check_memberCount @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with memberCount being null
        # Setting memberCount to null
        * def memberCount = null
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code ==  "NotNull.householdRequest.household[0].memberCount"
        * assert createHouseholdResponseBody.Errors[0].message == "must not be null"

    @HCM_household_create_09 @range_check_minimum_memberCount @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with memberCount having a value less than minimum allowed number
        # Setting memberCount to less than allowed minimum value
        * def memberCount = -1
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Range.householdRequest.household[0].memberCount"
        * assert createHouseholdResponseBody.Errors[0].message == "must be between 0 and 1000"

    @HCM_household_create_10 @range_check_maximum_memberCount @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with memberCount having a range more than maximum allowed number
        # Setting memberCount to more than allowed maximum value
        * def memberCount = 1001
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Range.householdRequest.household[0].memberCount"
        * assert createHouseholdResponseBody.Errors[0].message == "must be between 0 and 1000"

    @HCM_household_create_11 @empty_check_doorNo @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty doorNo
        # Setting doorNo to an empty string
        * def doorNo = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.doorNo"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_12 @size_check_minimum_doorNo @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with doorNo having a value less than minimum allowed number
        # Setting doorNo with a string having a size less than minimum number of characters
        * def doorNo = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.doorNo"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_13 @size_check_maximum_doorNo @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with doorNo having a value more than maximum allowed number
        # Setting doorNo with a string having a size more than maximum number of characters
        * def doorNo = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.doorNo"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_14 @empty_check_addressLine1 @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty addressLine1
        # Setting addressLine1 to an empty string
        * def addressLine1 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.addressLine1"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_15 @size_check_minimum_addressLine1 @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with addressLine1 having a value less than minimum allowed number
        # Setting addressLine1 with a string having a size less than minimum number of characters
        * def addressLine1 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.addressLine1"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_16 @size_check_maximum_addressLine1 @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with addressLine1 having a value more than maximum allowed number
        # Setting addressLine1 with a string having a size more than maximum number of characters
        * def addressLine1 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.addressLine1"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_17 @empty_check_addressLine2 @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty addressLine2
        # Setting addressLine2 to an empty string
        * def addressLine2 = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.addressLine2"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_18 @size_check_minimum_addressLine2 @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with addressLine2 having a value less than minimum allowed number
        # Setting addressLine2 with a string having a size less than minimum number of characters
        * def addressLine2 = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.addressLine2"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_19 @size_check_maximum_addressLine2 @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with addressLine2 having a value more than maximum allowed number
        # Setting addressLine2 with a string having a size more than maximum number of characters
        * def addressLine2 = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.addressLine2"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_20 @empty_check_landmark @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty landmark
        # Setting landmark to an empty string
        * def landmark = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.landmark"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_21 @size_check_minimum_landmark @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with landmark having a value less than minimum allowed number
        # Setting landmark with a string having a size less than minimum number of characters
        * def landmark = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.landmark"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_22 @size_check_maximum_landmark @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with landmark having a value more than maximum allowed number
        # Setting landmark with a string having a size more than maximum number of characters
        * def landmark = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.landmark"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_23 @empty_check_pincode @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty pincode
        # Setting pincode to an empty string
        * def pincode = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.pincode"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_24 @size_check_minimum_pincode @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with pincode having a value less than minimum allowed number
        # Setting pincode with a string having a size less than minimum number of characters
        * def pincode = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.pincode"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_25 @size_check_maximum_pincode @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with pincode having a value more than maximum allowed number
        # Setting pincode with a string having a size more than maximum number of characters
        * def pincode = randomString(100)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.pincode"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_create_26 @empty_check_buildingName @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty buildingName
        # Setting buildingName to an empty string
        * def buildingName = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.buildingName"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_27 @size_check_minimum_buildingName @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with buildingName having a value less than minimum allowed number
        # Setting buildingName with a string having a size less than minimum number of characters
        * def buildingName = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.buildingName"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_28 @size_check_maximum_buildingName @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with buildingName having a value more than maximum allowed number
        # Setting buildingName with a string having a size more than maximum number of characters
        * def buildingName = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.buildingName"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_29 @empty_check_street @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty street
        # Setting street to an empty string
        * def street = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.street"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_30 @size_check_minimum_street @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with street having a value less than minimum allowed number
        # Setting street with a string having a size less than minimum number of characters
        * def street = "a"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.street"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_31 @size_check_maximum_street @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with street having a value more than maximum allowed number
        # Setting street with a string having a size more than maximum number of characters
        * def street = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "Size.householdRequest.household[0].address.street"
        * assert createHouseholdResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_household_create_32 @empty_check_apiOperation @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with empty apiOperation
        # Setting apiOperation to an empty string
        * def apiOperation = ""
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "INVALID_API_OPERATION"
        * assert createHouseholdResponseBody.Errors[0].message == "API Operation null not valid for create request"

    @HCM_household_create_30 @invalid_check_apiOperation @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with apiOperation having an invalid value
        # Setting apiOperation with a string having a size less than minimum number of characters
        * def apiOperation = "TESTING"
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "INVALID_API_OPERATION"
        * assert createHouseholdResponseBody.Errors[0].message == "API Operation null not valid for create request"

    @HCM_household_create_31 @null_check_apiOperation @healthServices @regression @negative @hcm_household_create @hcm
    Scenario: Test to create a household with apiOperation having a null value
        # Setting apiOperation with a string having a size more than maximum number of characters
        * def apiOperation = randomString(257)
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdError')
        * assert createHouseholdResponseBody.Errors[0].code == "INVALID_API_OPERATION"
        * assert createHouseholdResponseBody.Errors[0].message == "API Operation null not valid for create request"

    # Household Search API related test cases

    @HCM_household_search_01 @search_household_withoutQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household without passing query parameters
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithIdWithoutQueryParams')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_02 @search_household_withOnlyLimitQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household by passing only limit query parameter
        # * def limitOfSearch = 100
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

    @HCM_household_search_03 @search_household_withOnlyOffsetQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household by passing only offset query parameter
        # * def offsetOfSearch = 0
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

    @HCM_household_search_04 @search_household_withOnlyTenantIdQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household by passing only tenantId query parameter
        * def parameters =
            """
            {
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_05 @search_household_withOnlyLimitAndOffsetQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household by passing only limit and offset query parameter
        # * def limitOfSearch = 100
        # * def offsetOfSearch = 0
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

    @HCM_household_search_06 @search_household_withOnlyTenantIdAndOffsetQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household by passing only tenantId and offset query parameter
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            tenantId: '#(hcmTenantId)',
            offset: 0,
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "limit"

    @HCM_household_search_07 @search_household_withOnlyTenantIdAndLimitQueryParams @healthServices @regression @negative @hcm_household_search @hcm
    Scenario: Test to search for a household by passing only tenantId and limit query parameter
        # * def limitOfSearch = 100
        * def parameters =
            """
            {
            tenantId: '#(hcmTenantId)',
            limit: 100
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        * assert searchHouseholdResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match searchHouseholdResponseBody.Errors[0].params contains "offset"

    @HCM_household_search_07 @search_household_withHouseholdId @healthServices @regression @smoke @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a valid household id
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        * def idOfHousehold = createHouseholdResponseBody.Household[0].id
        # * def limitOfSearch = 100
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match searchHouseholdResponseBody.Household == '#array'
        * match searchHouseholdResponseBody.Household == '#[1]'
        # response data validations
        * assert searchHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert searchHouseholdResponseBody.Household[0].tenantId == hcmTenantId
        * assert searchHouseholdResponseBody.Household[0].clientReferenceId == clientReferenceId
        * assert searchHouseholdResponseBody.Household[0].memberCount == memberCount
        * assert searchHouseholdResponseBody.Household[0].address.doorNo == doorNo
        * assert searchHouseholdResponseBody.Household[0].address.type == type
        * assert searchHouseholdResponseBody.Household[0].address.addressLine1 == addressLine1
        * assert searchHouseholdResponseBody.Household[0].address.addressLine2 == addressLine2
        * assert searchHouseholdResponseBody.Household[0].address.landmark == landmark
        * assert searchHouseholdResponseBody.Household[0].address.city == city
        * assert searchHouseholdResponseBody.Household[0].address.pincode == pincode
        * assert searchHouseholdResponseBody.Household[0].address.buildingName == buildingName
        * assert searchHouseholdResponseBody.Household[0].address.street == street
        * assert searchHouseholdResponseBody.Household[0].address.locality.code == localityCode
        * assert searchHouseholdResponseBody.Household[0].isDeleted == false
        * assert searchHouseholdResponseBody.Household[0].rowVersion == 1

    @HCM_household_search_08 @search_household_withClientReferenceId @healthServices @regression @smoke @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a valid clientReferenceId
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        * def clientReferenceIdOfHousehold = createHouseholdResponseBody.Household[0].clientReferenceId
        # * def limitOfSearch = 100
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithClientReferenceId')
        * match searchHouseholdResponseBody.Household == '#array'
        * match searchHouseholdResponseBody.Household == '#[1]'
        # response data validations
        * assert searchHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert searchHouseholdResponseBody.Household[0].tenantId == hcmTenantId
        * assert searchHouseholdResponseBody.Household[0].clientReferenceId == clientReferenceId
        * assert searchHouseholdResponseBody.Household[0].memberCount == memberCount
        * assert searchHouseholdResponseBody.Household[0].address.doorNo == doorNo
        * assert searchHouseholdResponseBody.Household[0].address.type == type
        * assert searchHouseholdResponseBody.Household[0].address.addressLine1 == addressLine1
        * assert searchHouseholdResponseBody.Household[0].address.addressLine2 == addressLine2
        * assert searchHouseholdResponseBody.Household[0].address.landmark == landmark
        * assert searchHouseholdResponseBody.Household[0].address.city == city
        * assert searchHouseholdResponseBody.Household[0].address.pincode == pincode
        * assert searchHouseholdResponseBody.Household[0].address.buildingName == buildingName
        * assert searchHouseholdResponseBody.Household[0].address.street == street
        * assert searchHouseholdResponseBody.Household[0].address.locality.code == localityCode
        * assert searchHouseholdResponseBody.Household[0].isDeleted == false
        * assert searchHouseholdResponseBody.Household[0].rowVersion == 1

    @HCM_household_search_09 @search_household_withBoundaryCode @healthServices @regression @smoke @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a valid boundary code
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        * def boundaryCodeOfHousehold = localityCode
        # * def limitOfSearch = 100
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithBoundaryCode')
        * match searchHouseholdResponseBody.Household == '#array'
        * match searchHouseholdResponseBody.Household == '#[1]'
        # response data validations
        * assert searchHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert searchHouseholdResponseBody.Household[0].tenantId == hcmTenantId
        * assert searchHouseholdResponseBody.Household[0].clientReferenceId == clientReferenceId
        * assert searchHouseholdResponseBody.Household[0].memberCount == memberCount
        * assert searchHouseholdResponseBody.Household[0].address.doorNo == doorNo
        * assert searchHouseholdResponseBody.Household[0].address.type == type
        * assert searchHouseholdResponseBody.Household[0].address.addressLine1 == addressLine1
        * assert searchHouseholdResponseBody.Household[0].address.addressLine2 == addressLine2
        * assert searchHouseholdResponseBody.Household[0].address.landmark == landmark
        * assert searchHouseholdResponseBody.Household[0].address.city == city
        * assert searchHouseholdResponseBody.Household[0].address.pincode == pincode
        * assert searchHouseholdResponseBody.Household[0].address.buildingName == buildingName
        * assert searchHouseholdResponseBody.Household[0].address.street == street
        * assert searchHouseholdResponseBody.Household[0].address.locality.code == localityCode
        * assert searchHouseholdResponseBody.Household[0].isDeleted == false
        * assert searchHouseholdResponseBody.Household[0].rowVersion == 1

    @HCM_household_search_10 @null_check_search_household_withHouseholdId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing null for household id
        * def idOfHousehold = null
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithId')
        * match searchHouseholdResponseBody.Household == '#array'
        * match searchHouseholdResponseBody.Household == '#[10]'
        # response data validations
        * assert searchHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success

    @HCM_household_search_11 @empty_data_check_search_household_withHouseholdId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing empty string for household id
        * def idOfHousehold = ""
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        # response data validations
        * assert searchHouseholdResponseBody.Errors[0].code == "Size.householdSearchRequest.household.id"
        * assert searchHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_search_12 @size_check_minimum_search_household_withHouseholdId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a string whose size is less than minimum accepted length for household id
        * def idOfHousehold = "H"
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        # response data validations
        * assert searchHouseholdResponseBody.Errors[0].code == "Size.householdSearchRequest.household.id"
        * assert searchHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_search_13 @size_check_maximum_search_household_withHouseholdId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a string whose size is less than maximum accepted length for household id
        * def idOfHousehold = randomString(65)
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdIdWithQueryParamsError')
        # response data validations
        * assert searchHouseholdResponseBody.Errors[0].code == "Size.householdSearchRequest.household.id"
        * assert searchHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_search_14 @null_check_search_household_withHouseholdClientReferenceId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing null for household clientReferenceId
        * def clientReferenceIdOfHousehold = null
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithClientReferenceId')
        * match searchHouseholdResponseBody.Household == '#array'
        * match searchHouseholdResponseBody.Household == '#[10]'
        # response data validations
        * assert searchHouseholdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success

    @HCM_household_search_15 @empty_data_check_search_household_withHouseholdClientReferenceId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing empty string for household clientReferenceId
        * def clientReferenceIdOfHousehold = ""
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdClientReferenceIdWithQueryParamsError')
        # response data validations
        * assert searchHouseholdResponseBody.Errors[0].code == "Size.householdSearchRequest.household.clientReferenceId"
        * assert searchHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_search_16 @size_check_minimum_search_household_withHouseholdClientReferenceId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a string whose size is less than minimum accepted length for household clientReferenceId
        * def clientReferenceIdOfHousehold = "H"
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdClientReferenceIdWithQueryParamsError')
        # response data validations
        * assert searchHouseholdResponseBody.Errors[0].code == "Size.householdSearchRequest.household.clientReferenceId"
        * assert searchHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_search_17 @size_check_maximum_search_household_withHouseholdClientReferenceId @healthServices @regression @positive @hcm_household_search @hcm
    Scenario: Test to search for a household by passing a string whose size is less than maximum accepted length for household clientReferenceId
        * def clientReferenceIdOfHousehold = randomString(65)
        # * def limitOfSearch = 10
        # * def offsetOfSearch = 0
        * def parameters =
            """
            {
            limit: 10,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdServicePretest.feature@searchByHouseholdClientReferenceIdWithQueryParamsError')
        # response data validations
        * assert searchHouseholdResponseBody.Errors[0].code == "Size.householdSearchRequest.household.clientReferenceId"
        * assert searchHouseholdResponseBody.Errors[0].message == "size must be between 2 and 64"
