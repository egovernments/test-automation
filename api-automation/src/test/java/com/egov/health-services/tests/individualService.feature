Feature: Individual Services - HCM

    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def givenName = 'Auto_' + randomString(6)
        * def familyName = 'Auto_' + randomString(6)
        * def otherNames = 'Auto_' + randomString(6)
        * def clientReferenceId = getUUID()
        * def bloodGroup = getRandomArrayElement(["O+", "O-", "A+", "A-", "B+","B-","AB+","AB-"])
        * def gender = getRandomArrayElement(["MALE","FEMALE","OTHER"])
        * def mobileNumber = ranInteger(10)
        * def altContactNumber = ranInteger(10)
        * def email = 'auto_' + getUnixEpochTime() + '@gmail.com'
        * def dateOfBirth = getDateInFormat("dd/MM/yyyy", generateRandomNumberInRange(1000,36500))
        * def doorNo = "Door No " + intergerToString(retMax(1000))
        * def addressClientReferenceId = getUUID()
        * def addressLine1 = 'Auto_' + randomString(10)
        * def addressLine2 = 'Auto_' + randomString(10)
        * def landmark = 'Auto_' + randomString(10)
        * def type = getRandomArrayElement([ "PERMANENT", "CORRESPONDENCE", "OTHER" ])
        * def city = 'Auto_' + randomString(10)
        * def pincode = randomString(7)
        * def buildingName = 'Auto_' + randomString(10)
        * def street = 'Auto_' + randomString(10)
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
        * def individualIdentifierId = convertIntegerToString(ranInteger(10))
        * def individualSkillType = getRandomArrayElement(["Type Writing", "Computer", "Science", "Singing", "Dancing", "Event Organizer"])
        * def individualSkillLevel = getRandomArrayElement(["Novice", "Learner", "Profecient", "Expert"])
        * def individualSkillExperience = getRandomArrayElement(["1 Year", "2 Years", "3 Years", "4 Years", "5 Years", "6 Years", "7 Years", "8 Years", "9 Years", "10 Years", "10+ Years"])
        * def photo = getUUID()
        * def hcmAuthToken = distributorAuthToken

    ## Individual create API related test cases

    @HCM_individual_create_01 @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with auth token of a registrar
        * def hcmAuthToken = registrarAuthToken
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
        * assert createIndividualResponseBody.Individual.address[0].clientReferenceId == addressClientReferenceId
        * assert createIndividualResponseBody.Individual.address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual.address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual.address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual.address[0].city == city
        * assert createIndividualResponseBody.Individual.address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual.address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual.address[0].street == street
        * assert createIndividualResponseBody.Individual.address[0].locality.code == code
        # * assert createIndividualResponseBody.Individual.address[0].locality.name == name
        # * assert createIndividualResponseBody.Individual.address[0].locality.label == label
        # * assert createIndividualResponseBody.Individual.address[0].locality.latitude == latitude
        # * assert createIndividualResponseBody.Individual.address[0].locality.longitude == longitude
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


    @HCM_individual_create_02 @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with auth token of a distributor
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
        * assert createIndividualResponseBody.Individual.address[0].clientReferenceId == addressClientReferenceId
        * assert createIndividualResponseBody.Individual.address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual.address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual.address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual.address[0].city == city
        * assert createIndividualResponseBody.Individual.address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual.address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual.address[0].street == street
        * assert createIndividualResponseBody.Individual.address[0].locality.code == code
        # * assert createIndividualResponseBody.Individual.address[0].locality.name == name
        # * assert createIndividualResponseBody.Individual.address[0].locality.label == label
        # * assert createIndividualResponseBody.Individual.address[0].locality.latitude == latitude
        # * assert createIndividualResponseBody.Individual.address[0].locality.longitude == longitude
        # * assert createIndividualResponseBody.Individual.address[0].locality.materializedPath == materializedPath
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

    @HCM_individual_create_03 @null_check_tenantId @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with null tenantId
        * def hcmTenantId = null
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "NotNull.individualRequest.individual.tenantId"
        * assert createIndividualResponseBody.Errors[0].message == "must not be null"

    @HCM_individual_create_04 @empty_check_tenantId @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with empty string as tenantId
        * def hcmTenantId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualNotAuthorizedError')
        * assert createIndividualResponseBody.Errors[0].code == "CustomException"
        * assert createIndividualResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError
        * assert createIndividualResponseBody.Errors[0].description == commonConstants.errorMessages.authorizedError

    @HCM_individual_create_05 @empty_check_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with empty clientReferenceId
        * def clientReferenceId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_create_06 @size_check_minimum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with clientReferenceId having a size less than minimum allowed number of characters
        * def clientReferenceId = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_create_07 @size_check_maximum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with clientReferenceId having a size less than maximum allowed number of characters
        * def clientReferenceId = randomString(65)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_create_08 @empty_check_givenName @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with empty givenName
        * def givenName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_09 @size_check_minimum_givenName @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with givenName having a size less than minimum allowed number of characters
        * def givenName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_10 @size_check_maximum_givenName @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with givenName having a size less than maximum allowed number of characters
        * def givenName = randomString(201)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_11 @empty_check_familyName @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with empty familyName
        * def familyName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_12 @size_check_minimum_familyName @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with familyName having a size less than minimum allowed number of characters
        * def familyName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_13 @size_check_maximum_familyName @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with givenName having a size less than maximum allowed number of characters
        * def familyName = randomString(201)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_14 @size_check_maximum_otherNames @healthServices @regression @positive @smoke @hcm_individual_create @hcm @individualService
    Scenario: Test to create an individual with otherNames having a size less than maximum allowed number of characters
        * def otherNames = randomString(201)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.otherNames"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 0 and 200"


    ## Individual search API realted test cases

    @HCM_individual_search_01 @search_individual_withoutQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual without passing query parameters
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithIdWithoutQueryParams')
        * assert searchIndividualResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "limit"

    @HCM_individual_search_02 @search_individual_withOnlyLimitQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual by passing only limit query parameter
        * def idOfIndividual = "1234"
        * def parameters =
            """
            {
            limit: 100
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchByIndividualIdWithQueryParamsError')
        * assert searchIndividualResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "offset"

    @HCM_individual_search_03 @search_individual_withOnlyOffsetQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual by passing only offset query parameter
        * def idOfIndividual = "1234"
        * def parameters =
            """
            {
            offset: 0
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchByIndividualIdWithQueryParamsError')
        * assert searchIndividualResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "limit"

    @HCM_individual_search_04 @search_individual_withOnlyTenantIdQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual by passing only tenantId query parameter
        * def idOfIndividual = "1234"
        * def parameters =
            """
            {
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchByIndividualIdWithQueryParamsError')
        * assert searchIndividualResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "limit"

    @HCM_individual_search_05 @search_individual_withOnlyLimitAndOffsetQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual by passing only limit and offset query parameter
        * def idOfIndividual = "1234"
        * def parameters =
            """
            {
            limit: 100,
            offset: 0
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchByIndividualIdWithQueryParamsError')
        * assert searchIndividualResponseBody.Errors[0].message == "Required String parameter 'tenantId' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "tenantId"

    @HCM_individual_search_06 @search_individual_withOnlyTenantIdAndOffsetQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual by passing only tenantId and offset query parameter
        * def idOfIndividual = "1234"
        * def parameters =
            """
            {
            tenantId: '##(hcmTenantId)',
            offset: 0,
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchByIndividualIdWithQueryParamsError')
        * assert searchIndividualResponseBody.Errors[0].message == "Required Integer parameter 'limit' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "limit"

    @HCM_individual_search_07 @search_individual_withOnlyTenantIdAndLimitQueryParams @healthServices @regression @negative @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual by passing only tenantId and limit query parameter
        * def idOfIndividual = "1234"
        * def parameters =
            """
            {
            tenantId: '##(hcmTenantId)',
            limit: 100
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchByIndividualIdWithQueryParamsError')
        * assert searchIndividualResponseBody.Errors[0].message == "Required Integer parameter 'offset' is not present"
        * match searchIndividualResponseBody.Errors[0].params contains "offset"

    @HCM_individual_search_08 @search_individual_with_all_criteria_individually @healthServices @regression @smoke @positive @hcm_individual_search @hcm @individualService
    Scenario: Test to search for an individual using different criteria
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        ## search for individual using individual id
        * def idOfIndividual = createIndividualResponseBody.Individual.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithId')
        * match individualResponseBody.Individuals == '##array'
        * match individualResponseBody.Individuals == '##[1]'
        ## response data validations
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].clientReferenceId == clientReferenceId
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        ## search for individual using individual clientReferenceId
        * def clientReferenceIdOfIndividual = individualResponseBody.Individual[0].clientReferenceId
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithClientReferenceId')
        * match individualResponseBody.Individuals == '##array'
        * match individualResponseBody.Individuals == '##[1]'
        ## response data validations
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].clientReferenceId == clientReferenceId
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        ## search for individual using individual name
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithName')
        * match individualResponseBody.Individuals == '##array'
        * match individualResponseBody.Individuals == '##[1]'
        ## response data validations
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        ## search for individual with date of birth
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithDateOfBirth')
        * match individualResponseBody.Individuals == '##array'
        ## response data validations. There can be many data with same date of birth.
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * def availableDateOfBirth = karate.jsonPath(individualResponseBody, "$.Individual[*].dateOfBirth")
        * match availableDateOfBirth contains dateOfBirth
        ## search for individual with gender
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithGender')
        * match individualResponseBody.Individuals == '##array'
        ## response data validations. There can be many data with same gender.
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].gender == gender
        * def availableGender = karate.jsonPath(individualResponseBody, "$.Individual[*].gender")
        * match availableGender contains gender
        ## search for individual with identifier
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithIdentifier')
        * match individualResponseBody.Individuals == '##array'
        ## response data validations. There can be many data with same identifier data.
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * def availableIdentifierTypes = karate.jsonPath(individualResponseBody, "$.Individual[*].identifiers[*].identifierType")
        * match availableIdentifierTypes contains individualIdentifierType
        * def availableIdentifierIds = karate.jsonPath(individualResponseBody, "$.Individual[*].identifiers[*].identifierId")
        * match availableIdentifierIds contains individualIdentifierId
        # ## search for individual with boundaryCode
        # * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithBoundaryCode')
        # * match individualResponseBody.Individuals == '##array'
        # ## response data validations. There can be many data with same boundaryCode.
        # * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        # * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * def availableBoundaryCode = karate.jsonPath(individualResponseBody, "$.Individual[*].address[*].locality.code")
        # * match availableBoundaryCode contains code
        ## search with all criteria
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithAllCriteria')
        * match individualResponseBody.Individuals == '##array'
        * match individualResponseBody.Individuals == '##[1]'
        ## response data validations
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].clientReferenceId == clientReferenceId
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo

    ## Individual update API related test cases.

    @HCM_individual_update_01 @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        ## response data validations after individual create
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createIndividualResponseBody.Individual.isDeleted == false
        * assert createIndividualResponseBody.Individual.rowVersion == 1
        * def individualCreatedData = createIndividualResponseBody.Individual
        * individualCreatedData.mobileNumber = "9876098765"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualSuccess')
        ## response data validations after individual update
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual.mobileNumber == "9876098765"
        * assert individualResponseBody.Individual.isDeleted == false
        * assert individualResponseBody.Individual.rowVersion == 2
        ## search for the same individual
        * def idOfIndividual = individualResponseBody.Individual.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[1]'
        ## response data validations for search individual after update
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == "9876098765"
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == idOfIndividual
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == idOfIndividual
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == false
        * assert individualResponseBody.Individual[0].rowVersion == 2

    @HCM_individual_update_02 @empty_check_id @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an empty id value for the individual
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.id"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_03 @size_check_minimum_id @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an id value for the individual which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.id"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_04 @size_check_maximum_id @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an id value for the individual which is more than alowed maximum length
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(100)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.id"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_05 @null_check_id @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing a null value for id
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def idOfIndividualToUpdate = null
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "VALIDATION_ERROR"
        * match individualResponseBody.Errors[0].message != null

    @HCM_individual_update_06 @null_check_tenantId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing a null value for hcmTenantId
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def hcmTenantId = null
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "NotNull.individualRequest.individual.tenantId"
        * match individualResponseBody.Errors[0].message == "must not be null"

    @HCM_individual_update_07 @size_check_minimum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the individual which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def clientReferenceId = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_08 @size_check_maximum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the individual which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def clientReferenceId = randomString(200)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_09 @empty_check_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def clientReferenceId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_10 @size_check_minimum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the address of the individual which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_11 @size_check_maximum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the individual which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(200)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_12 @empty_check_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_13 @empty_check_doorNo @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty doorNo
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo to an empty string
        * def doorNo = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].doorNo"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_14 @size_check_minimum_doorNo @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with doorNo having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size less than minimum number of characters
        * def doorNo = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].doorNo"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_15 @size_check_maximum_doorNo @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with doorNo having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size more than maximum number of characters
        * def doorNo = randomString(100)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].doorNo"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_16 @empty_check_addressLine1 @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty addressLine1
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 to an empty string
        * def addressLine1 = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine1"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_17 @size_check_minimum_addressLine1 @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with addressLine1 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size less than minimum number of characters
        * def addressLine1 = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine1"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_18 @size_check_maximum_addressLine1 @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with addressLine1 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size more than maximum number of characters
        * def addressLine1 = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine1"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_19 @empty_check_addressLine2 @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty addressLine2
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 to an empty string
        * def addressLine2 = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine2"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_20 @size_check_minimum_addressLine2 @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with addressLine2 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size less than minimum number of characters
        * def addressLine2 = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine2"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_21 @size_check_maximum_addressLine2 @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with addressLine2 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size more than maximum number of characters
        * def addressLine2 = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine2"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_22 @empty_check_landmark @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty landmark
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark to an empty string
        * def landmark = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].landmark"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_23 @size_check_minimum_landmark @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with landmark having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size less than minimum number of characters
        * def landmark = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].landmark"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_24 @size_check_maximum_landmark @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with landmark having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size more than maximum number of characters
        * def landmark = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].landmark"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_25 @empty_check_pincode @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty pincode
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode to an empty string
        * def pincode = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].pincode"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_26 @size_check_minimum_pincode @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with pincode having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size less than minimum number of characters
        * def pincode = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].pincode"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_27 @size_check_maximum_pincode @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with pincode having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size more than maximum number of characters
        * def pincode = randomString(100)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].pincode"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_update_28 @empty_check_buildingName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty buildingName
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName to an empty string
        * def buildingName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].buildingName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_29 @size_check_minimum_buildingName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with buildingName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size less than minimum number of characters
        * def buildingName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].buildingName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_30 @size_check_maximum_buildingName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with buildingName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size more than maximum number of characters
        * def buildingName = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].buildingName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_31 @empty_check_street @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty street
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street to an empty string
        * def street = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].street"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_32 @size_check_minimum_street @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with street having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size less than minimum number of characters
        * def street = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].street"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_33 @size_check_maximum_street @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with street having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken

        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size more than maximum number of characters
        * def street = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].street"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_update_34 @empty_check_givenName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty givenName
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting givenName to an empty string
        * def givenName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_update_35 @size_check_minimum_givenName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with givenName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting givenName with a string having a size less than minimum number of characters
        * def givenName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_update_36 @size_check_maximum_givenName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with givenName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting givenName with a string having a size more than maximum number of characters
        * def givenName = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"


    @HCM_individual_update_37 @empty_check_familyName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty familyName
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting familyName to an empty string
        * def familyName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_update_38 @size_check_minimum_familyName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with familyName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting familyName with a string having a size less than minimum number of characters
        * def familyName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_update_39 @size_check_maximum_familyName @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with familyName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting familyName with a string having a size more than maximum number of characters
        * def familyName = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"


    @HCM_individual_update_39 @size_check_maximum_mobileNumber @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with mobileNumber having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting mobileNumber with a string having a size more than maximum number of characters
        * def mobileNumber = randomString(21)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.mobileNumber"
        * assert individualResponseBody.Errors[0].message == "size must be between 0 and 20"

    @HCM_individual_update_39 @size_check_maximum_altContactNumber @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with altContactNumber having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting altContactNumber with a string having a size more than maximum number of characters
        * def altContactNumber = randomString(21)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.altContactNumber"
        * assert individualResponseBody.Errors[0].message == "size must be between 0 and 16"

    @HCM_individual_update_40 @empty_check_email @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with empty email
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting email to an empty string
        * def email = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.email"
        * assert individualResponseBody.Errors[0].message == "size must be between 5 and 200"

    @HCM_individual_update_41 @size_check_minimum_email @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with email having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting email with a string having a size less than minimum number of characters
        * def email = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.email"
        * assert individualResponseBody.Errors[0].message == "size must be between 5 and 200"

    @HCM_individual_update_42 @size_check_maximum_email @healthServices @regression @negative @hcm_individual_update @hcm @individualService
    Scenario: Test to update an existing individual with email having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting email with a string having a size more than maximum number of characters
        * def email = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.email"
        * assert individualResponseBody.Errors[0].message == "size must be between 5 and 200"

    ## Individual delete API related test cases.

    @HCM_individual_delete_01 @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        ## response data validations after individual create
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createIndividualResponseBody.Individual.isDeleted == false
        * assert createIndividualResponseBody.Individual.rowVersion == 1
        * def individualCreatedData = createIndividualResponseBody.Individual
        * individualCreatedData.isDeleted = true
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualSuccess')
        ## response data validations after individual delete
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual.isDeleted == true
        * assert individualResponseBody.Individual.rowVersion == 2
        ## search for the same individual
        * def idOfIndividual = individualResponseBody.Individual.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[1]'
        ## response data validations for search individual after update
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == idOfIndividual
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == idOfIndividual
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == true
        * assert individualResponseBody.Individual[0].rowVersion == 2

    @HCM_individual_delete_02 @empty_check_id @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an empty id value for the individual
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.id"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_03 @size_check_minimum_id @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an id value for the individual which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.id"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_04 @size_check_maximum_id @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an id value for the individual which is more than alowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(100)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.id"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_05 @null_check_id @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing a null value for id
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def idOfIndividualToUpdate = null
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "VALIDATION_ERROR"
        * match individualResponseBody.Errors[0].message != null

    @HCM_individual_delete_06 @null_check_tenantId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing a null value for hcmTenantId
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def hcmTenantId = null
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "NotNull.individualRequest.individual.tenantId"
        * match individualResponseBody.Errors[0].message == "must not be null"

    @HCM_individual_delete_07 @size_check_minimum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the individual which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def clientReferenceId = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_08 @size_check_maximum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the individual which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def clientReferenceId = randomString(200)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_09 @empty_check_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def clientReferenceId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_10 @size_check_minimum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the address of the individual which is less than required minimum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_11 @size_check_maximum_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an clientReferenceId value for the individual which is more than allowed maximum length
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(200)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_12 @empty_check_addressClientReferenceId @healthServices @regression @positive @smoke @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual by passing an empty value for clientReferenceId
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        ## response data validations
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].clientReferenceId"
        * match individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_13 @empty_check_doorNo @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty doorNo
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo to an empty string
        * def doorNo = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].doorNo"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_14 @size_check_minimum_doorNo @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with doorNo having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size less than minimum number of characters
        * def doorNo = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].doorNo"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_15 @size_check_maximum_doorNo @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with doorNo having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting doorNo with a string having a size more than maximum number of characters
        * def doorNo = randomString(100)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].doorNo"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_16 @empty_check_addressLine1 @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty addressLine1
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 to an empty string
        * def addressLine1 = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine1"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_17 @size_check_minimum_addressLine1 @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with addressLine1 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size less than minimum number of characters
        * def addressLine1 = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine1"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_18 @size_check_maximum_addressLine1 @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with addressLine1 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine1 with a string having a size more than maximum number of characters
        * def addressLine1 = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine1"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_19 @empty_check_addressLine2 @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty addressLine2
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 to an empty string
        * def addressLine2 = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine2"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_20 @size_check_minimum_addressLine2 @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with addressLine2 having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size less than minimum number of characters
        * def addressLine2 = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine2"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_21 @size_check_maximum_addressLine2 @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with addressLine2 having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting addressLine2 with a string having a size more than maximum number of characters
        * def addressLine2 = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].addressLine2"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_22 @empty_check_landmark @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty landmark
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark to an empty string
        * def landmark = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].landmark"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_23 @size_check_minimum_landmark @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with landmark having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size less than minimum number of characters
        * def landmark = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].landmark"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_24 @size_check_maximum_landmark @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with landmark having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting landmark with a string having a size more than maximum number of characters
        * def landmark = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].landmark"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_25 @empty_check_pincode @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty pincode
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode to an empty string
        * def pincode = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].pincode"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_26 @size_check_minimum_pincode @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with pincode having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size less than minimum number of characters
        * def pincode = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].pincode"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_27 @size_check_maximum_pincode @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with pincode having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting pincode with a string having a size more than maximum number of characters
        * def pincode = randomString(100)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].pincode"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_delete_28 @empty_check_buildingName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty buildingName
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName to an empty string
        * def buildingName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].buildingName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_29 @size_check_minimum_buildingName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with buildingName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size less than minimum number of characters
        * def buildingName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].buildingName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_30 @size_check_maximum_buildingName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with buildingName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting buildingName with a string having a size more than maximum number of characters
        * def buildingName = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].buildingName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_31 @empty_check_street @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty street
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street to an empty string
        * def street = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].street"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_32 @size_check_minimum_street @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with street having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size less than minimum number of characters
        * def street = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].street"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_33 @size_check_maximum_street @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with street having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting street with a string having a size more than maximum number of characters
        * def street = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.address[0].street"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 256"

    @HCM_individual_delete_34 @empty_check_givenName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty givenName
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting givenName to an empty string
        * def givenName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_delete_35 @size_check_minimum_givenName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with givenName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting givenName with a string having a size less than minimum number of characters
        * def givenName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_delete_36 @size_check_maximum_givenName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with givenName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting givenName with a string having a size more than maximum number of characters
        * def givenName = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.givenName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"


    @HCM_individual_delete_37 @empty_check_familyName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty familyName
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting familyName to an empty string
        * def familyName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_delete_38 @size_check_minimum_familyName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with familyName having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting familyName with a string having a size less than minimum number of characters
        * def familyName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_delete_39 @size_check_maximum_familyName @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with familyName having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting familyName with a string having a size more than maximum number of characters
        * def familyName = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.name.familyName"
        * assert individualResponseBody.Errors[0].message == "size must be between 2 and 200"


    @HCM_individual_delete_39 @size_check_maximum_mobileNumber @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with mobileNumber having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting mobileNumber with a string having a size more than maximum number of characters
        * def mobileNumber = randomString(21)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.mobileNumber"
        * assert individualResponseBody.Errors[0].message == "size must be between 0 and 20"

    @HCM_individual_delete_39 @size_check_maximum_altContactNumber @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with altContactNumber having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting altContactNumber with a string having a size more than maximum number of characters
        * def altContactNumber = randomString(21)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.altContactNumber"
        * assert individualResponseBody.Errors[0].message == "size must be between 0 and 16"

    @HCM_individual_delete_40 @empty_check_email @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with empty email
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting email to an empty string
        * def email = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.email"
        * assert individualResponseBody.Errors[0].message == "size must be between 5 and 200"

    @HCM_individual_delete_41 @size_check_minimum_email @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with email having a value less than minimum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting email with a string having a size less than minimum number of characters
        * def email = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.email"
        * assert individualResponseBody.Errors[0].message == "size must be between 5 and 200"

    @HCM_individual_delete_42 @size_check_maximum_email @healthServices @regression @negative @hcm_individual_delete @hcm @individualService
    Scenario: Test to update an existing individual with email having a value more than maximum allowed number
        * def hcmAuthToken = distributorAuthToken
        * def idOfIndividualToUpdate = randomString(36)
        * def addressClientReferenceId = randomString(36)
        ## Setting email with a string having a size more than maximum number of characters
        * def email = randomString(257)
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualFailure')
        * assert individualResponseBody.Errors[0].code == "Size.individualRequest.individual.email"
        * assert individualResponseBody.Errors[0].message == "size must be between 5 and 200"

    ## Individual CRUD operations using individual APIs

    @HCM_Individual_CRUD @healthServices @regression @positive @hcm_individual_create @hcm_individual_search @hcm_individual_update @hcm_individual_delete @hcm @individualService
    Scenario: Test to test individual API CRUD operations
        * def hcmAuthToken = distributorAuthToken
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        ## response validations for individual create
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
        * assert createIndividualResponseBody.Individual.address[0].clientReferenceId == addressClientReferenceId
        * assert createIndividualResponseBody.Individual.address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual.address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual.address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual.address[0].city == city
        * assert createIndividualResponseBody.Individual.address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual.address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual.address[0].street == street
        * assert createIndividualResponseBody.Individual.address[0].locality.code == code
        # * assert createIndividualResponseBody.Individual.address[0].locality.name == name
        # * assert createIndividualResponseBody.Individual.address[0].locality.label == label
        # * assert createIndividualResponseBody.Individual.address[0].locality.latitude == latitude
        # * assert createIndividualResponseBody.Individual.address[0].locality.longitude == longitude
        # * assert createIndividualResponseBody.Individual.address[0].locality.materializedPath == materializedPath
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
        * assert createIndividualResponseBody.Individual.isDeleted == false
        * assert createIndividualResponseBody.Individual.rowVersion == 1
        ## search for the same individual
        * def idOfIndividual = createIndividualResponseBody.Individual.id
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[1]'
        ## response data validations for search individual
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == createIndividualResponseBody.Individual.id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == createIndividualResponseBody.Individual.id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == false
        * assert individualResponseBody.Individual[0].rowVersion == 1
        ## update mobileNumber for the created individual
        * def individualCreatedData = individualResponseBody.Individual[0]
        * individualCreatedData.mobileNumber = "9999999999"
        * call read('../../health-services/pretest/individualServicePretest.feature@updateIndividualSuccess')
        ## response data validations for update individual
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual.mobileNumber == "9999999999"
        * assert individualResponseBody.Individual.isDeleted == false
        * assert individualResponseBody.Individual.rowVersion == 2
        ## search for the same individual after update
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[1]'
        ## response data validations for search individual after update
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == "9999999999"
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == createIndividualResponseBody.Individual.id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == createIndividualResponseBody.Individual.id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == false
        * assert individualResponseBody.Individual[0].rowVersion == 2
        ## deleting the individual
        * def individualCreatedData = individualResponseBody.Individual[0]
        * individualCreatedData.isDeleted = true
        * call read('../../health-services/pretest/individualServicePretest.feature@deleteIndividualSuccess')
        ## response data validations after individual delete
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual.isDeleted == true
        * assert individualResponseBody.Individual.rowVersion == 3
        ## search for the same individual after deletion
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)',
            includeDeleted: true
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[1]'
        ## response data validations for search individual after deletion
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == "9999999999"
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == idOfIndividual
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == idOfIndividual
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == true
        * assert individualResponseBody.Individual[0].rowVersion == 3

    ## Individual CRUD operations using bulk APIs

    @HCM_Individual_CRUD_bulk @healthServices @regression @positive @smoke @hcm  @individualService
    Scenario: Test to create a individual with auth token of a distributor
        * def hcmAuthToken = distributorAuthToken
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
        * def parameters =
            """
            {
            limit: 100,
            offset: 0,
            tenantId: '##(hcmTenantId)'
            }
            """
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithMultipleClientReferenceId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(individualResponseBody, "$.Individual[*].clientReferenceId")
        * match availableClientReferenceIds contains clientReferenceId
        * match availableClientReferenceIds contains clientReferenceId2
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == false
        * assert individualResponseBody.Individual[0].rowVersion == 1
        * assert individualResponseBody.Individual[1].name.givenName == givenName2
        * assert individualResponseBody.Individual[1].name.familyName == familyName2
        * assert individualResponseBody.Individual[1].name.otherNames == otherNames2
        * assert individualResponseBody.Individual[1].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[1].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[1].gender == gender
        * assert individualResponseBody.Individual[1].mobileNumber == mobileNumber
        * assert individualResponseBody.Individual[1].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[1].email == email
        * assert individualResponseBody.Individual[1].address[0].doorNo == doorNo2
        * assert individualResponseBody.Individual[1].address[0].clientReferenceId == addressClientReferenceId2
        * assert individualResponseBody.Individual[1].address[0].addressLine1 == addressLine12
        * assert individualResponseBody.Individual[1].address[0].addressLine2 == addressLine22
        * assert individualResponseBody.Individual[1].address[0].landmark == landmark2
        * assert individualResponseBody.Individual[1].address[0].city == city2
        * assert individualResponseBody.Individual[1].address[0].pincode == pincode2
        * assert individualResponseBody.Individual[1].address[0].buildingName == buildingName2
        * assert individualResponseBody.Individual[1].address[0].street == street2
        * assert individualResponseBody.Individual[1].address[0].locality.code == code2
        # * assert individualResponseBody.Individual[1].address[0].locality.name == name2
        # * assert individualResponseBody.Individual[1].address[0].locality.label == label2
        # * assert individualResponseBody.Individual[1].address[0].locality.latitude == latitude2
        # * assert individualResponseBody.Individual[1].address[0].locality.longitude == longitude2
        # * assert individualResponseBody.Individual[1].address[0].locality.materializedPath == materializedPath2
        * assert individualResponseBody.Individual[1].fatherName == fatherName2
        * assert individualResponseBody.Individual[1].husbandName == husbandName2
        * assert individualResponseBody.Individual[1].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId2
        * assert individualResponseBody.Individual[1].identifiers[0].individualId == individualResponseBody.Individual[1].id
        * assert individualResponseBody.Individual[1].identifiers[0].identifierType == individualIdentifierType2
        * assert individualResponseBody.Individual[1].identifiers[0].identifierId == individualIdentifierId2
        * assert individualResponseBody.Individual[1].skills[0].clientReferenceId == individualSkillClientReferenceId2
        * assert individualResponseBody.Individual[1].skills[0].individualId == individualResponseBody.Individual[1].id
        * assert individualResponseBody.Individual[1].skills[0].type == individualSkillType2
        * assert individualResponseBody.Individual[1].skills[0].level == individualSkillLevel2
        * assert individualResponseBody.Individual[1].skills[0].experience == individualSkillExperience2
        * assert individualResponseBody.Individual[1].photo == photo2
        * assert individualResponseBody.Individual[1].isDeleted == false
        * assert individualResponseBody.Individual[1].rowVersion == 1
        ## bulk update mobileNumber for the created individuals
        * def individualBulkCreatedData = individualResponseBody.Individual
        * individualBulkCreatedData[0].mobileNumber = "9090909090"
        * individualBulkCreatedData[1].mobileNumber = "9090909091"
        * call read('../../health-services/pretest/individualServicePretest.feature@bulkUpdateIndividualSuccess')
        ## response data validations for bulk individual update
        * assert individualResponseBody.status == commonConstants.expectedStatus.success
        * match individualResponseBody.apiId == "/individual/v1/bulk/_update"
        ## search for the updated individuals
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithMultipleClientReferenceId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(individualResponseBody, "$.Individual[*].clientReferenceId")
        * match availableClientReferenceIds contains clientReferenceId
        * match availableClientReferenceIds contains clientReferenceId2
        * def availableMobileNumbers = karate.jsonPath(individualResponseBody, "$.Individual[*].mobileNumber")
        * match availableMobileNumbers contains "9090909090"
        * match availableMobileNumbers contains "9090909091"
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == false
        * assert individualResponseBody.Individual[0].rowVersion == 2
        * assert individualResponseBody.Individual[1].name.givenName == givenName2
        * assert individualResponseBody.Individual[1].name.familyName == familyName2
        * assert individualResponseBody.Individual[1].name.otherNames == otherNames2
        * assert individualResponseBody.Individual[1].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[1].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[1].gender == gender
        * assert individualResponseBody.Individual[1].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[1].email == email
        * assert individualResponseBody.Individual[1].address[0].doorNo == doorNo2
        * assert individualResponseBody.Individual[1].address[0].clientReferenceId == addressClientReferenceId2
        * assert individualResponseBody.Individual[1].address[0].addressLine1 == addressLine12
        * assert individualResponseBody.Individual[1].address[0].addressLine2 == addressLine22
        * assert individualResponseBody.Individual[1].address[0].landmark == landmark2
        * assert individualResponseBody.Individual[1].address[0].city == city2
        * assert individualResponseBody.Individual[1].address[0].pincode == pincode2
        * assert individualResponseBody.Individual[1].address[0].buildingName == buildingName2
        * assert individualResponseBody.Individual[1].address[0].street == street2
        * assert individualResponseBody.Individual[1].address[0].locality.code == code2
        # * assert individualResponseBody.Individual[1].address[0].locality.name == name2
        # * assert individualResponseBody.Individual[1].address[0].locality.label == label2
        # * assert individualResponseBody.Individual[1].address[0].locality.latitude == latitude2
        # * assert individualResponseBody.Individual[1].address[0].locality.longitude == longitude2
        # * assert individualResponseBody.Individual[1].address[0].locality.materializedPath == materializedPath2
        * assert individualResponseBody.Individual[1].fatherName == fatherName2
        * assert individualResponseBody.Individual[1].husbandName == husbandName2
        * assert individualResponseBody.Individual[1].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId2
        * assert individualResponseBody.Individual[1].identifiers[0].individualId == individualResponseBody.Individual[1].id
        * assert individualResponseBody.Individual[1].identifiers[0].identifierType == individualIdentifierType2
        * assert individualResponseBody.Individual[1].identifiers[0].identifierId == individualIdentifierId2
        * assert individualResponseBody.Individual[1].skills[0].clientReferenceId == individualSkillClientReferenceId2
        * assert individualResponseBody.Individual[1].skills[0].individualId == individualResponseBody.Individual[1].id
        * assert individualResponseBody.Individual[1].skills[0].type == individualSkillType2
        * assert individualResponseBody.Individual[1].skills[0].level == individualSkillLevel2
        * assert individualResponseBody.Individual[1].skills[0].experience == individualSkillExperience2
        * assert individualResponseBody.Individual[1].photo == photo2
        * assert individualResponseBody.Individual[1].isDeleted == false
        * assert individualResponseBody.Individual[1].rowVersion == 2
        ## bulk deleting the created individual
        * def individualBulkCreatedData = individualResponseBody.Individual
        * individualBulkCreatedData[0].isDeleted = true
        * individualBulkCreatedData[1].isDeleted = true
        * call read('../../health-services/pretest/individualServicePretest.feature@bulkDeleteIndividualSuccess')
        ## response data validations for bulk delete individuals
        * assert individualResponseBody.status == commonConstants.expectedStatus.success
        * match individualResponseBody.apiId == "/individual/v1/bulk/_delete"
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
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithMultipleClientReferenceId')
        * match individualResponseBody.Individual == '##array'
        * match individualResponseBody.Individual == '##[2]'
        ## search response data validations
        * def availableClientReferenceIds = karate.jsonPath(individualResponseBody, "$.Individual[*].clientReferenceId")
        * match availableClientReferenceIds contains clientReferenceId
        * match availableClientReferenceIds contains clientReferenceId2
        * def availableMobileNumbers = karate.jsonPath(individualResponseBody, "$.Individual[*].mobileNumber")
        * match availableMobileNumbers contains "9090909090"
        * match availableMobileNumbers contains "9090909091"
        * assert individualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert individualResponseBody.Individual[0].name.givenName == givenName
        * assert individualResponseBody.Individual[0].name.familyName == familyName
        * assert individualResponseBody.Individual[0].name.otherNames == otherNames
        * assert individualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[0].gender == gender
        * assert individualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[0].email == email
        * assert individualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert individualResponseBody.Individual[0].address[0].clientReferenceId == addressClientReferenceId
        * assert individualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert individualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert individualResponseBody.Individual[0].address[0].landmark == landmark
        * assert individualResponseBody.Individual[0].address[0].city == city
        * assert individualResponseBody.Individual[0].address[0].pincode == pincode
        * assert individualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert individualResponseBody.Individual[0].address[0].street == street
        * assert individualResponseBody.Individual[0].address[0].locality.code == code
        # * assert individualResponseBody.Individual[0].address[0].locality.name == name
        # * assert individualResponseBody.Individual[0].address[0].locality.label == label
        # * assert individualResponseBody.Individual[0].address[0].locality.latitude == latitude
        # * assert individualResponseBody.Individual[0].address[0].locality.longitude == longitude
        # * assert individualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert individualResponseBody.Individual[0].fatherName == fatherName
        * assert individualResponseBody.Individual[0].husbandName == husbandName
        * assert individualResponseBody.Individual[0].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId
        * assert individualResponseBody.Individual[0].identifiers[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].identifiers[0].identifierType == individualIdentifierType
        * assert individualResponseBody.Individual[0].identifiers[0].identifierId == individualIdentifierId
        * assert individualResponseBody.Individual[0].skills[0].clientReferenceId == individualSkillClientReferenceId
        * assert individualResponseBody.Individual[0].skills[0].individualId == individualResponseBody.Individual[0].id
        * assert individualResponseBody.Individual[0].skills[0].type == individualSkillType
        * assert individualResponseBody.Individual[0].skills[0].level == individualSkillLevel
        * assert individualResponseBody.Individual[0].skills[0].experience == individualSkillExperience
        * assert individualResponseBody.Individual[0].photo == photo
        * assert individualResponseBody.Individual[0].isDeleted == true
        * assert individualResponseBody.Individual[0].rowVersion == 3
        * assert individualResponseBody.Individual[1].name.givenName == givenName2
        * assert individualResponseBody.Individual[1].name.familyName == familyName2
        * assert individualResponseBody.Individual[1].name.otherNames == otherNames2
        * assert individualResponseBody.Individual[1].dateOfBirth == dateOfBirth
        * assert individualResponseBody.Individual[1].bloodGroup == bloodGroup
        * assert individualResponseBody.Individual[1].gender == gender
        * assert individualResponseBody.Individual[1].altContactNumber == altContactNumber
        * assert individualResponseBody.Individual[1].email == email
        * assert individualResponseBody.Individual[1].address[0].doorNo == doorNo2
        * assert individualResponseBody.Individual[1].address[0].clientReferenceId == addressClientReferenceId2
        * assert individualResponseBody.Individual[1].address[0].addressLine1 == addressLine12
        * assert individualResponseBody.Individual[1].address[0].addressLine2 == addressLine22
        * assert individualResponseBody.Individual[1].address[0].landmark == landmark2
        * assert individualResponseBody.Individual[1].address[0].city == city2
        * assert individualResponseBody.Individual[1].address[0].pincode == pincode2
        * assert individualResponseBody.Individual[1].address[0].buildingName == buildingName2
        * assert individualResponseBody.Individual[1].address[0].street == street2
        * assert individualResponseBody.Individual[1].address[0].locality.code == code2
        # * assert individualResponseBody.Individual[1].address[0].locality.name == name2
        # * assert individualResponseBody.Individual[1].address[0].locality.label == label2
        # * assert individualResponseBody.Individual[1].address[0].locality.latitude == latitude2
        # * assert individualResponseBody.Individual[1].address[0].locality.longitude == longitude2
        # * assert individualResponseBody.Individual[1].address[0].locality.materializedPath == materializedPath2
        * assert individualResponseBody.Individual[1].fatherName == fatherName2
        * assert individualResponseBody.Individual[1].husbandName == husbandName2
        * assert individualResponseBody.Individual[1].identifiers[0].clientReferenceId == individualIdentifierClientReferenceId2
        * assert individualResponseBody.Individual[1].identifiers[0].individualId == individualResponseBody.Individual[1].id
        * assert individualResponseBody.Individual[1].identifiers[0].identifierType == individualIdentifierType2
        * assert individualResponseBody.Individual[1].identifiers[0].identifierId == individualIdentifierId2
        * assert individualResponseBody.Individual[1].skills[0].clientReferenceId == individualSkillClientReferenceId2
        * assert individualResponseBody.Individual[1].skills[0].individualId == individualResponseBody.Individual[1].id
        * assert individualResponseBody.Individual[1].skills[0].type == individualSkillType2
        * assert individualResponseBody.Individual[1].skills[0].level == individualSkillLevel2
        * assert individualResponseBody.Individual[1].skills[0].experience == individualSkillExperience2
        * assert individualResponseBody.Individual[1].photo == photo2
        * assert individualResponseBody.Individual[1].isDeleted == true
        * assert individualResponseBody.Individual[1].rowVersion == 3