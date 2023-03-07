Feature: Household Member Services - HCM

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
        * def givenName = 'Auto_' + randomString(6)
        * def familyName = 'Auto_' + randomString(6)
        * def otherNames = 'Auto_' + randomString(6)
        * def clientReferenceId = getUUID()
        #* def individualClientReferenceId2 = getUUID()
        * def bloodGroup = getRandomArrayElement(["O+", "O-", "A+", "A-", "B+","B-","AB+","AB-"])
        * def gender = getRandomArrayElement(["MALE","FEMALE","OTHER"])
        * def mobileNumber = ranInteger(10)
        * def altContactNumber = ranInteger(10)
        * def email = 'auto_' + getUnixEpochTime() + '@gmail.com'
        * def dateOfBirth = getDateInFormat("dd/MM/yyyy", generateRandomNumberInRange(1000,36500))
        * def code = 'Auto_' + randomString(5)
        * def name = 'Auto_' + randomString(10)
        * def label = 'Auto_' + randomString(10)
        * def latitude = 'Auto_' + randomString(10)
        * def longitude = 'Auto_' + randomString(10)
        * def materializedPath = 'Auto_' + randomString(10)
        * def fatherName = 'Auto_' + randomString(10)
        * def husbandName = 'Auto_' + randomString(10)
        * def individualIdentifierClientReferenceId = getUUID()
        * def individualSkillClientReferenceId = getUUID()
        * def individualIdentifierType = getRandomArrayElement(["AADHAAR", "PAN", "DL", "VOTERID","PASSPORT"])
        * def individualIdentifierId = ranInteger(10)
        * def individualSkillType = getRandomArrayElement(["Type Writing", "Computer", "Science", "Singing", "Dancing", "Event Organizer"])
        * def individualSkillLevel = getRandomArrayElement(["Novice", "Learner", "Profecient", "Expert"])
        * def individualSkillExperience = getRandomArrayElement(["1 Year", "2 Years", "3 Years", "4 Years", "5 Years", "6 Years", "7 Years", "8 Years", "9 Years", "10 Years", "10+ Years"])
        * def photo = getUUID()
        * def hcmAuthToken = registrarAuthToken

    ## Household Member Create API related test cases

    @HCM_household_member_create_01 @healthServices @regression @positive @smoke @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with auth token of a registrar
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response data validations
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
        * def householdClientReferenceId = householdClientReferenceId
        * def householdId = householdResponseBody.Household.id
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createIndividualResponseBody.Individual.name.givenName == givenName
        * assert createIndividualResponseBody.Individual.name.familyName == familyName
        * assert createIndividualResponseBody.Individual.name.otherNames == otherNames
        * assert createIndividualResponseBody.Individual.dateOfBirth == dateOfBirth
        * assert createIndividualResponseBody.Individual.bloodGroup == bloodGroup
        * assert createIndividualResponseBody.Individual.gender == gender
        * assert createIndividualResponseBody.Individual.mobileNumber == mobileNumber
        * assert createIndividualResponseBody.Individual.altContactNumber == altContactNumber
        * assert createIndividualResponseBody.Individual.email == email
        * assert createIndividualResponseBody.Individual.address[0].doorNo == doorNo
        * assert createIndividualResponseBody.Individual.address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual.address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual.address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual.address[0].city == city
        * assert createIndividualResponseBody.Individual.address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual.address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual.address[0].street == street
        * assert createIndividualResponseBody.Individual.address[0].locality.code == code
        * assert createIndividualResponseBody.Individual.address[0].locality.name == name
        * assert createIndividualResponseBody.Individual.address[0].locality.label == label
        * assert createIndividualResponseBody.Individual.address[0].locality.latitude == latitude
        * assert createIndividualResponseBody.Individual.address[0].locality.longitude == longitude
        * assert createIndividualResponseBody.Individual.address[0].locality.materializedPath == materializedPath
        * assert createIndividualResponseBody.Individual.fatherName == fatherName
        * assert createIndividualResponseBody.Individual.husbandName == husbandName
        * assert createIndividualResponseBody.Individual.identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert createIndividualResponseBody.Individual.identifiers[0].individualId == createIndividualResponseBody.Individual.id
        * assert createIndividualResponseBody.Individual.identifiers[0].identifierType == individualIdentifierType
        * assert createIndividualResponseBody.Individual.identifiers[0].identifierId == individualIdentifierId
        * assert createIndividualResponseBody.Individual.skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert createIndividualResponseBody.Individual.skills[0].individualId == createIndividualResponseBody.Individual.id
        * assert createIndividualResponseBody.Individual.skills[0].type == individualSkillType
        * assert createIndividualResponseBody.Individual.skills[0].level == individualSkillLevel
        * assert createIndividualResponseBody.Individual.skills[0].experience == individualSkillExperience
        * assert createIndividualResponseBody.Individual.photo == photo
        * def individualClientReferenceId = clientReferenceId
        * def individualId = createIndividualResponseBody.Individual.id
        * def isHeadOfHousehold = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberSuccess')
        # response validations for create household member
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == false
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 1

    @HCM_household_member_create_02 @healthServices @regression @positive @smoke @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response data validations
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
        * def householdClientReferenceId = householdClientReferenceId
        * def householdId = householdResponseBody.Household.id
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createIndividualResponseBody.Individual.name.givenName == givenName
        * assert createIndividualResponseBody.Individual.name.familyName == familyName
        * assert createIndividualResponseBody.Individual.name.otherNames == otherNames
        * assert createIndividualResponseBody.Individual.dateOfBirth == dateOfBirth
        * assert createIndividualResponseBody.Individual.bloodGroup == bloodGroup
        * assert createIndividualResponseBody.Individual.gender == gender
        * assert createIndividualResponseBody.Individual.mobileNumber == mobileNumber
        * assert createIndividualResponseBody.Individual.altContactNumber == altContactNumber
        * assert createIndividualResponseBody.Individual.email == email
        * assert createIndividualResponseBody.Individual.address[0].doorNo == doorNo
        * assert createIndividualResponseBody.Individual.address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual.address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual.address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual.address[0].city == city
        * assert createIndividualResponseBody.Individual.address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual.address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual.address[0].street == street
        * assert createIndividualResponseBody.Individual.address[0].locality.code == code
        * assert createIndividualResponseBody.Individual.address[0].locality.name == name
        * assert createIndividualResponseBody.Individual.address[0].locality.label == label
        * assert createIndividualResponseBody.Individual.address[0].locality.latitude == latitude
        * assert createIndividualResponseBody.Individual.address[0].locality.longitude == longitude
        * assert createIndividualResponseBody.Individual.address[0].locality.materializedPath == materializedPath
        * assert createIndividualResponseBody.Individual.fatherName == fatherName
        * assert createIndividualResponseBody.Individual.husbandName == husbandName
        * assert createIndividualResponseBody.Individual.identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert createIndividualResponseBody.Individual.identifiers[0].individualId == createIndividualResponseBody.Individual.id
        * assert createIndividualResponseBody.Individual.identifiers[0].identifierType == individualIdentifierType
        * assert createIndividualResponseBody.Individual.identifiers[0].identifierId == individualIdentifierId
        * assert createIndividualResponseBody.Individual.skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert createIndividualResponseBody.Individual.skills[0].individualId == createIndividualResponseBody.Individual.id
        * assert createIndividualResponseBody.Individual.skills[0].type == individualSkillType
        * assert createIndividualResponseBody.Individual.skills[0].level == individualSkillLevel
        * assert createIndividualResponseBody.Individual.skills[0].experience == individualSkillExperience
        * assert createIndividualResponseBody.Individual.photo == photo
        * def individualClientReferenceId = clientReferenceId
        * def individualId = createIndividualResponseBody.Individual.id
        * def isHeadOfHousehold = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberSuccess')
        # response validations for create household member
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == false
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 1

    @HCM_household_member_create_03 @HCM_household_member_create_invalid_tenant @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with invalid tenantId
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting tenantId with an invalid value
        * def hcmTenantId = "soemthing"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberUnauthorised')
        * assert householdMemberResponseBody.Errors[0].code == "CustomException"
        * assert householdMemberResponseBody.Errors[0].message == "Not authorized to access this resource"
        * assert householdMemberResponseBody.Errors[0].description == "Not authorized to access this resource"

    @HCM_household_member_create_04 @null_check_tenantId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with a null tenantId
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting tenantId with null
        * def hcmTenantId = null
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "NotNull.householdMemberRequest.householdMember.tenantId"
        * assert householdMemberResponseBody.Errors[0].message == "must not be null"

    @HCM_household_member_create_05 @empty_string_check_tenantId @healthServices @regression @positive @smoke @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with empty string for tenantId
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting tenantId with empty string
        * def hcmTenantId = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberUnauthorised')
        * assert householdMemberResponseBody.Errors[0].code == "CustomException"
        * assert householdMemberResponseBody.Errors[0].message == "Not authorized to access this resource"
        * assert householdMemberResponseBody.Errors[0].description == "Not authorized to access this resource"

    @HCM_household_member_create_06 @size_check_minimum_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with householdClientReferenceId having a size less than minimum allowed number of characters
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting householdClientReferenceId with a string having  a size less than minimum number of characters
        * def householdClientReferenceId = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_create_07 @size_check_maximum_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with householdClientReferenceId having a size more than maximum allowed number of characters
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting householdClientReferenceId with a string having a size less than maximum number of characters
        * def householdClientReferenceId = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_create_08 @empty_string_check_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with householdClientReferenceId being an empty string
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting householdClientReferenceId with a string having a size less than maximum number of characters
        * def householdClientReferenceId = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_create_09 @size_check_minimum_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with individualClientReferenceId having a size less than minimum allowed number of characters
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting individualClientReferenceId with a string having  a size less than minimum number of characters
        * def individualClientReferenceId = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_create_10 @size_check_maximum_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with individualClientReferenceId having a size more than maximum allowed number of characters
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting individualClientReferenceId with a string having a size less than maximum number of characters
        * def individualClientReferenceId = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_create_11 @empty_string_check_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_create @hcm @householdMemberService
    Scenario: Test to create a household member with individualClientReferenceId being an empty string
        * def individualClientReferenceId = clientReferenceId
        * def isHeadOfHousehold = true
        # Setting individualClientReferenceId with a string having a size less than maximum number of characters
        * def individualClientReferenceId = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    ## Household Member Search API related test cases

    @HCM_household_member_search_01 @search_household_member_withoutQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member without passing query parameters
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithIdWithoutQueryParams')
        * assert householdMemberResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "limit"

    @HCM_household_member_search_02 @search_household_member_withOnlyLimitQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member by passing only limit query parameter
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            limit: 100
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberByIdWithQueryParamsError')
        * assert householdMemberResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "offset"

    @HCM_household_member_search_03 @search_household_member_withOnlyOffsetQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member by passing only offset query parameter
        # * def offsetOfSearch = 0
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            offset: 0
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberByIdWithQueryParamsError')
        * assert householdMemberResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "limit"

    @HCM_household_member_search_04 @search_household_member_withOnlyTenantIdQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member by passing only tenantId query parameter
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberByIdWithQueryParamsError')
        * assert householdMemberResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "limit"

    @HCM_household_member_search_05 @search_household_member_withOnlyLimitAndOffsetQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member by passing only limit and offset query parameter
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            limit: 100,
            offset: 0
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberByIdWithQueryParamsError')
        * assert householdMemberResponseBody.Errors[0].message == "Required String parameter 'tenantId' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "tenantId"

    @HCM_household_member_search_06 @search_household_member_withOnlyTenantIdAndOffsetQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member by passing only tenantId and offset query parameter
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            tenantId: '#(hcmTenantId)',
            offset: 0,
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberByIdWithQueryParamsError')
        * assert householdMemberResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "limit"

    @HCM_household_member_search_07 @search_household_member_withOnlyTenantIdAndLimitQueryParams @healthServices @regression @negative @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member by passing only tenantId and limit query parameter
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = "1234"
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            tenantId: '#(hcmTenantId)',
            limit: 100
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberByIdWithQueryParamsError')
        * assert householdMemberResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match householdMemberResponseBody.Errors[0].params contains "offset"

    @HCM_household_member_search_08 @search_household_member_with_all_criteria_individually @healthServices @regression @smoke @positive @hcm_household_member_search @hcm @householdMemberService
    Scenario: Test to search for a household member using different criteria
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response validations for create hosuehold
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def householdClientReferenceId = householdClientReferenceId
        * def householdId = householdResponseBody.Household.id
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        # response validations for create individual
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def individualClientReferenceId = clientReferenceId
        * def individualId = createIndividualResponseBody.Individual.id
        * def isHeadOfHousehold = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberSuccess')
        # response validations for create household member
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def idOfHouseholdMemberCreated = householdMemberResponseBody.HouseholdMember.id
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = idOfHouseholdMemberCreated
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by household member id
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        # search with householdClientReferenceId
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdClientReferenceId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by householdClientReferenceId
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        # search with individualClientReferenceId
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithIndividualClientReferenceId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by individualClientReferenceId
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        # search household member with all criteria
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithAllCriteria')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by using all criteria
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1

    ## Household member update test cases

    @HCM_household_member_update_01 @healthServices @regression @positive @smoke @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def householdClientReferenceId = householdClientReferenceId
        * def householdId = householdResponseBody.Household.id
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def individualClientReferenceId = clientReferenceId
        * def individualId = createIndividualResponseBody.Individual.id
        * def isHeadOfHousehold = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberSuccess')
        # response validations for create household member
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == false
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 1
        * def idOfHouseholdMemberCreated = householdMemberResponseBody.HouseholdMember.id
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = idOfHouseholdMemberCreated
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        # search with householdClientReferenceId
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdClientReferenceId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by householdClientReferenceId
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        * def householdMemberCreatedData = householdMemberResponseBody.HouseholdMembers[0]
        * householdMemberCreatedData.isHeadOfHousehold = false
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberSuccess')
        # response validations after hosuehold member has been updated
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == false
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 2
        # search for the same household member
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by household member id after data has been updated
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 2

    @HCM_household_member_update_02 @empty_string_check_id @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with id being an empty string
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def tenantIdToUpdate = "default"
        # Setting idOfHouseholdMemberToUpdate to an empty string
        * def idOfHouseholdMemberToUpdate = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.id"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_03 @size_check_minimum_id @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with id having a size less than minimum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def tenantIdToUpdate = "default"
        # Setting idOfHouseholdMemberToUpdate to an empty string
        * def idOfHouseholdMemberToUpdate = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.id"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_04 @size_check_maximum_id @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with id having a size more than maximum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def tenantIdToUpdate = "default"
        # Setting idOfHouseholdMemberToUpdate to an empty string
        * def idOfHouseholdMemberToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.id"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_05 @null_check_tenantId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with a null tenantId
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting tenantId with null
        * def tenantIdToUpdate = null
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "NotNull.householdMemberRequest.householdMember.tenantId"
        * assert householdMemberResponseBody.Errors[0].message == "must not be null"

    @HCM_household_member_update_06 @size_check_minimum_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with householdClientReferenceId having a size less than minimum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting householdClientReferenceId with a string having  a size less than minimum number of characters
        * def householdClientReferenceIdToUpdate = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_07 @size_check_maximum_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with householdClientReferenceId having a size more than maximum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting householdClientReferenceId with a string having a size more than maximum number of characters
        * def householdClientReferenceIdToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_08 @empty_string_check_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with householdClientReferenceId being an empty string
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting householdClientReferenceId with a string having a size less than maximum number of characters
        * def householdClientReferenceIdToUpdate = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_09 @size_check_minimum_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with individualClientReferenceId having a size less than minimum allowed number of characters
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        * def householdClientReferenceIdToUpdate = randomString(36)
        # Setting individualClientReferenceId with a string having  a size less than minimum number of characters
        * def individualClientReferenceIdToUpdate = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_10 @size_check_maximum_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with individualClientReferenceId having a size more than maximum allowed number of characters
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        * def householdClientReferenceIdToUpdate = randomString(36)
        # Setting individualClientReferenceId with a string having a size less than maximum number of characters
        * def individualClientReferenceIdToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_update_11 @empty_string_check_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_update @hcm @householdMemberService
    Scenario: Test to update an existing household member with individualClientReferenceId being an empty string
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        * def householdClientReferenceIdToUpdate = randomString(36)
        # Setting individualClientReferenceId with a string having a size less than maximum number of characters
        * def individualClientReferenceIdToUpdate = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    ## Household member delete test cases

    @HCM_household_member_delete_01 @healthServices @regression @positive @smoke @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response data validations
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def householdClientReferenceId = householdClientReferenceId
        * def householdId = householdResponseBody.Household.id
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def individualClientReferenceId = clientReferenceId
        * def individualId = createIndividualResponseBody.Individual.id
        * def isHeadOfHousehold = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberSuccess')
        # response validations for create household member
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == false
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 1
        * def idOfHouseholdMemberCreated = householdMemberResponseBody.HouseholdMember.id
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = idOfHouseholdMemberCreated
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        # search with householdClientReferenceId
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdClientReferenceId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by householdClientReferenceId
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        * def householdMemberCreatedData = householdMemberResponseBody.HouseholdMembers[0]
        * householdMemberCreatedData.isDelete = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberSuccess')
        # response validations after hosuehold member has been deleted
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == true
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 2
        # search for the same household member
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by household member id after data has been updated
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == true
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 2

    @HCM_household_member_delete_02 @empty_string_check_id @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with id being an empty string
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def tenantIdToUpdate = "default"
        # Setting idOfHouseholdMemberToUpdate to an empty string
        * def idOfHouseholdMemberToUpdate = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.id"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_03 @size_check_minimum_id @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with id having a size less than minimum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def tenantIdToUpdate = "default"
        # Setting idOfHouseholdMemberToUpdate to an empty string
        * def idOfHouseholdMemberToUpdate = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.id"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_04 @size_check_maximum_id @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with id having a size more than maximum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def tenantIdToUpdate = "default"
        # Setting idOfHouseholdMemberToUpdate to an empty string
        * def idOfHouseholdMemberToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.id"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_05 @null_check_tenantId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with a null tenantId
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def householdClientReferenceIdToUpdate = householdClientReferenceId
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting tenantId with null
        * def tenantIdToUpdate = null
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "NotNull.householdMemberRequest.householdMember.tenantId"
        * assert householdMemberResponseBody.Errors[0].message == "must not be null"

    @HCM_household_member_delete_06 @size_check_minimum_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with householdClientReferenceId having a size less than minimum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting householdClientReferenceId with a string having  a size less than minimum number of characters
        * def householdClientReferenceIdToUpdate = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_07 @size_check_maximum_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with householdClientReferenceId having a size more than maximum allowed number of characters
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting householdClientReferenceId with a string having a size more than maximum number of characters
        * def householdClientReferenceIdToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_08 @empty_string_check_householdClientReferenceId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with householdClientReferenceId being an empty string
        * def individualClientReferenceIdToUpdate = clientReferenceId
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        # Setting householdClientReferenceId with a string having a size less than maximum number of characters
        * def householdClientReferenceIdToUpdate = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.householdClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_09 @size_check_minimum_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with individualClientReferenceId having a size less than minimum allowed number of characters
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        * def householdClientReferenceIdToUpdate = randomString(36)
        # Setting individualClientReferenceId with a string having  a size less than minimum number of characters
        * def individualClientReferenceIdToUpdate = "a"
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_10 @size_check_maximum_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with individualClientReferenceId having a size more than maximum allowed number of characters
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        * def householdClientReferenceIdToUpdate = randomString(36)
        # Setting individualClientReferenceId with a string having a size less than maximum number of characters
        * def individualClientReferenceIdToUpdate = randomString(100)
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_household_member_delete_11 @empty_string_check_individualClientReferenceId @healthServices @regression @negative @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to delete an existing household member with individualClientReferenceId being an empty string
        * def tenantIdToUpdate = "default"
        * def idOfHouseholdMemberToUpdate = randomString(36)
        * def householdClientReferenceIdToUpdate = randomString(36)
        # Setting individualClientReferenceId with a string having a size less than maximum number of characters
        * def individualClientReferenceIdToUpdate = ""
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberError')
        * assert householdMemberResponseBody.Errors[0].code == "Size.householdMemberRequest.householdMember.individualClientReferenceId"
        * assert householdMemberResponseBody.Errors[0].message == "size must be between 2 and 64"

    ## Household member CRUD operations using individual APIs

    @HCM_HouseholdMember_CRUD @healthServices @regression @positive @hcm_household_member_create @hcm_household_member_search @hcm_household_member_update @hcm_household_member_delete @hcm @householdMemberService
    Scenario: Test to test household API CRUD operations
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/householdServicePretest.feature@createHouseholdSuccess')
        # response validations for create hosuehold
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def householdClientReferenceId = householdClientReferenceId
        * def householdId = householdResponseBody.Household.id
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        # response validations for create individual
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def individualClientReferenceId = clientReferenceId
        * def individualId = createIndividualResponseBody.Individual.id
        * def isHeadOfHousehold = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@createHouseholdMemberSuccess')
        # response validations for create household member
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * def idOfHouseholdMemberCreated = householdMemberResponseBody.HouseholdMember.id
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = idOfHouseholdMemberCreated
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by household member id
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        # update the isHeadOfHousehold to false for the household member
        * def householdMemberCreatedData = householdMemberResponseBody.HouseholdMembers[0]
        * householdMemberCreatedData.isHeadOfHousehold = false
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@updateHouseholdMemberSuccess')
        # response validations after hosuehold member has been updated
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == false
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 2
        # search for the same household member
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by household member id after data has been updated
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 2
        # deleting the household member data
        * def householdMemberCreatedData = householdMemberResponseBody.HouseholdMembers[0]
        * householdMemberCreatedData.isDeleted = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@deleteHouseholdMemberSuccess')
        # response data validations for delete household member
        * assert householdResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMember.householdId == householdId
        * assert householdMemberResponseBody.HouseholdMember.householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.individualId == individualId
        * assert householdMemberResponseBody.HouseholdMember.individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMember.tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMember.isDeleted == true
        * assert householdMemberResponseBody.HouseholdMember.rowVersion == 3
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by household member id after data has been updated
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].id == idOfHouseholdMemberCreated
        * assert householdMemberResponseBody.HouseholdMembers[0].householdId == householdId
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualId == individualId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == true
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 3

    ## Household member CRUD operations using bulk APIs
    @HCM_HouseholdMember_CRUD_bulk @healthServices @regression @positive @smoke @hcm  @householdMemberService
    Scenario: Test to create a household member with auth token of a distributor
        ## create 2 households using bulk create household API
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
        # * def bulkCreateHouseholdRequestBody = bulkCreateHouseholdRequest
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
            tenantId: '#(hcmTenantId)'
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
        ## create 2 individuals using bulk create individual API
        * def clientReferenceId2 = getUUID()
        * def givenName2 = 'Auto_' + randomString(6)
        * def familyName2 = 'Auto_' + randomString(6)
        * def otherNames2 = 'Auto_' + randomString(6)
        * def addressClientReferenceId2 = getUUID()
        * def doorNo2 = "Door No " + intergerToString(retMax(1000))
        * def addressLine12 = 'Auto_' + randomString(10)
        * def addressLine22 = 'Auto_' + randomString(10)
        * def landmark2 = 'Auto_' + randomString(10)
        * def type2 = getRandomArrayElement([ "PERMANENT", "CORRESPONDENCE", "OTHER" ])
        * def city2 = 'Auto_' + randomString(10)
        * def pincode2 = randomString(7)
        * def buildingName2 = 'Auto_' + randomString(10)
        * def street2 = 'Auto_' + randomString(10)
        * def code2 = 'Auto_' + randomString(5)
        * def name2 = 'Auto_' + randomString(10)
        * def label2 = 'Auto_' + randomString(10)
        * def latitude2 = 'Auto_' + randomString(10)
        * def longitude2 = 'Auto_' + randomString(10)
        * def materializedPath2 = 'Auto_' + randomString(10)
        * def fatherName2 = 'Auto_' + randomString(10)
        * def husbandName2 = 'Auto_' + randomString(10)
        * def individualIdentifierClientReferenceId2 = getUUID()
        * def individualSkillClientReferenceId2 = getUUID()
        * def individualIdentifierType2 = getRandomArrayElement(["AADHAAR", "PAN", "DL", "VOTERID","PASSPORT"])
        * def individualIdentifierId2 = convertIntegerToString(ranInteger(10))
        * def individualSkillType2 = getRandomArrayElement(["Type Writing", "Computer", "Science", "Singing", "Dancing", "Event Organizer"])
        * def individualSkillLevel2 = getRandomArrayElement(["Novice", "Learner", "Profecient", "Expert"])
        * def individualSkillExperience2 = getRandomArrayElement(["1 Year", "2 Years", "3 Years", "4 Years", "5 Years", "6 Years", "7 Years", "8 Years", "9 Years", "10 Years", "10+ Years"])
        * def photo2 = getUUID()
        * call read('../../health-services/pretest/individualServicePretest.feature@bulkCreateIndividualSuccess')
        * def bulkCreateIndividualRequestBody = bulkIndividualRequest
        ## response data validations for bulk individual create
        * assert individualResponseBody.status == commonConstants.expectedStatus.success
        * match individualResponseBody.apiId == "/individual/v1/bulk/_create"
        * def clientReferenceIdOfIndividual = null
        * json clientReferenceIdOfIndividual = (clientReferenceIdOfIndividual || [])
        * def newClientRefId = clientReferenceId
        * def void = (clientReferenceIdOfIndividual.add(newClientRefId))
        * def newClientRefId = clientReferenceId2
        * def void = (clientReferenceIdOfIndividual.add(newClientRefId))
        ## search for the same individuals created
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithMultipleClientReferenceId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(individualResponseBody, "$.Individual[*].clientReferenceId")
        * match availableClientReferenceIds contains clientReferenceId
        * match availableClientReferenceIds contains clientReferenceId2
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        ## create household members by using bulk household member create API
        * def individualClientReferenceId = clientReferenceId
        * def individualClientReferenceId2 = clientReferenceId2
        * def isHeadOfHousehold = true
        * def isHeadOfHousehold2 = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@bulkCreateHouseholdMemberSuccess')
        ## response data validations for bulk household member create
        * assert householdMemberResponseBody.status == commonConstants.expectedStatus.success
        * match householdMemberResponseBody.apiId == "/household/member/v1/bulk/_create"
        ## search and fetch the ID of each of the household member created.
        ## search with householdClientReferenceId for the first household member
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdClientReferenceId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        # response data validations for search household member by householdClientReferenceId
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        * def idOfHouseholdMember = null
        * json idOfHouseholdMember = (idOfHouseholdMember || [])
        * def newHouseholdMemberId = householdMemberResponseBody.HouseholdMembers[0].id
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        ## saving the first householdClientReferenceId
        * def tempHouseholdClientReferenceId = householdClientReferenceId
        * def householdClientReferenceId = householdClientReferenceId2
        ## search with householdClientReferenceId for the second household member
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdClientReferenceId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[1]'
        * def householdClientReferenceId = tempHouseholdClientReferenceId
        # response data validations for search household member by householdClientReferenceId
        * assert householdMemberResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId2
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId2
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == true
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 1
        * def newHouseholdMemberId = householdMemberResponseBody.HouseholdMembers[0].id
        * def void = (idOfHouseholdMember.add(newHouseholdMemberId))
        ## search for the created household members using ids to get the array for further processing which can be used for creation test data
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * def householdMemberCreatedData = householdMemberResponseBody.HouseholdMembers
        ## update isHeadOfHousehold to false for both the household members
        * householdMemberCreatedData[0].isHeadOfHousehold = false
        * householdMemberCreatedData[1].isHeadOfHousehold = false
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@bulkUpdateHouseholdMemberSuccess')
        ## response data validations for bulk household member update
        * assert householdMemberResponseBody.status == commonConstants.expectedStatus.success
        * match householdMemberResponseBody.apiId == "/household/member/v1/bulk/_update"
        ## validating if data was actually updated or not
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 2
        * assert householdMemberResponseBody.HouseholdMembers[1].householdClientReferenceId == householdClientReferenceId2
        * assert householdMemberResponseBody.HouseholdMembers[1].individualClientReferenceId == individualClientReferenceId2
        * assert householdMemberResponseBody.HouseholdMembers[1].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[1].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[1].isDeleted == false
        * assert householdMemberResponseBody.HouseholdMembers[1].rowVersion == 2
        ## deleting the household member
        * def householdMemberCreatedData = householdMemberResponseBody.HouseholdMembers
        * householdMemberCreatedData[0].isDeleted = true
        * householdMemberCreatedData[1].isDeleted = true
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@bulkDeleteHouseholdMemberSuccess')
        ## response data validations for bulk household member delete
        * assert householdMemberResponseBody.status == commonConstants.expectedStatus.success
        * match householdMemberResponseBody.apiId == "/household/member/v1/bulk/_delete"
        ## validating if data was actually updated or not
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '#(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@searchHouseholdMemberWithHouseholdMemberId')
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers == '#[2]'
        * assert householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == householdClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == individualClientReferenceId
        * assert householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[0].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[0].isDeleted == true
        * assert householdMemberResponseBody.HouseholdMembers[0].rowVersion == 3
        * assert householdMemberResponseBody.HouseholdMembers[1].householdClientReferenceId == householdClientReferenceId2
        * assert householdMemberResponseBody.HouseholdMembers[1].individualClientReferenceId == individualClientReferenceId2
        * assert householdMemberResponseBody.HouseholdMembers[1].isHeadOfHousehold == false
        * assert householdMemberResponseBody.HouseholdMembers[1].tenantId == hcmTenantId
        * assert householdMemberResponseBody.HouseholdMembers[1].isDeleted == true
        * assert householdMemberResponseBody.HouseholdMembers[1].rowVersion == 3