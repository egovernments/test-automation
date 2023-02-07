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
        * def doorNo = intergerToString(retMax(1000))
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
        * def photo = getUUID()
        * def apiOperation = "CREATE"
        * def hcmAuthToken = distributorAuthToken


    @HCM_individual_create_01 @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with auth token of a registrar
        * def hcmAuthToken = registrarAuthToken
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createIndividualResponseBody.Individual[0].name.givenName == givenName
        * assert createIndividualResponseBody.Individual[0].name.familyName == familyName
        * assert createIndividualResponseBody.Individual[0].name.otherNames == otherNames
        * assert createIndividualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert createIndividualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert createIndividualResponseBody.Individual[0].gender == gender
        * assert createIndividualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert createIndividualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert createIndividualResponseBody.Individual[0].email == email
        * assert createIndividualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert createIndividualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual[0].address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual[0].address[0].city == city
        * assert createIndividualResponseBody.Individual[0].address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual[0].address[0].street == street
        * assert createIndividualResponseBody.Individual[0].address[0].locality.code == code
        * assert createIndividualResponseBody.Individual[0].address[0].locality.name == name
        * assert createIndividualResponseBody.Individual[0].address[0].locality.label == label
        * assert createIndividualResponseBody.Individual[0].address[0].locality.latitude == latitude
        * assert createIndividualResponseBody.Individual[0].address[0].locality.longitude == longitude
        * assert createIndividualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert createIndividualResponseBody.Individual[0].fatherName == fatherName
        * assert createIndividualResponseBody.Individual[0].husbandName == husbandName
        * assert createIndividualResponseBody.Individual[0].photo == photo


    @HCM_individual_create_02 @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with auth token of a distributor
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualSuccess')
        * assert createIndividualResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
        * assert createIndividualResponseBody.Individual[0].name.givenName == givenName
        * assert createIndividualResponseBody.Individual[0].name.familyName == familyName
        * assert createIndividualResponseBody.Individual[0].name.otherNames == otherNames
        * assert createIndividualResponseBody.Individual[0].dateOfBirth == dateOfBirth
        * assert createIndividualResponseBody.Individual[0].bloodGroup == bloodGroup
        * assert createIndividualResponseBody.Individual[0].gender == gender
        * assert createIndividualResponseBody.Individual[0].mobileNumber == mobileNumber
        * assert createIndividualResponseBody.Individual[0].altContactNumber == altContactNumber
        * assert createIndividualResponseBody.Individual[0].email == email
        * assert createIndividualResponseBody.Individual[0].address[0].doorNo == doorNo
        * assert createIndividualResponseBody.Individual[0].address[0].addressLine1 == addressLine1
        * assert createIndividualResponseBody.Individual[0].address[0].addressLine2 == addressLine2
        * assert createIndividualResponseBody.Individual[0].address[0].landmark == landmark
        * assert createIndividualResponseBody.Individual[0].address[0].city == city
        * assert createIndividualResponseBody.Individual[0].address[0].pincode == pincode
        * assert createIndividualResponseBody.Individual[0].address[0].buildingName == buildingName
        * assert createIndividualResponseBody.Individual[0].address[0].street == street
        * assert createIndividualResponseBody.Individual[0].address[0].locality.code == code
        * assert createIndividualResponseBody.Individual[0].address[0].locality.name == name
        * assert createIndividualResponseBody.Individual[0].address[0].locality.label == label
        * assert createIndividualResponseBody.Individual[0].address[0].locality.latitude == latitude
        * assert createIndividualResponseBody.Individual[0].address[0].locality.longitude == longitude
        * assert createIndividualResponseBody.Individual[0].address[0].locality.materializedPath == materializedPath
        * assert createIndividualResponseBody.Individual[0].fatherName == fatherName
        * assert createIndividualResponseBody.Individual[0].husbandName == husbandName
        * assert createIndividualResponseBody.Individual[0].photo == photo

    @HCM_individual_create_03 @null_check_tenantId @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with null tenantId
        * def hcmTenantId = null
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "NotNull.individualRequest.individual[0].tenantId"
        * assert createIndividualResponseBody.Errors[0].message == "must not be null"

    @HCM_individual_create_04 @empty_check_tenantId @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with empty string as tenantId
        * def hcmTenantId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualNotAuthorizedError')
        * assert createIndividualResponseBody.Errors[0].code == "CustomException"
        * assert createIndividualResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError
        * assert createIndividualResponseBody.Errors[0].description == commonConstants.errorMessages.authorizedError

    @HCM_individual_create_05 @empty_check_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with empty clientReferenceId
        * def clientReferenceId = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].clientReferenceId"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_create_06 @size_check_minimum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with clientReferenceId having a size less than minimum allowed number of characters
        * def clientReferenceId = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].clientReferenceId"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_create_07 @size_check_maximum_clientReferenceId @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with clientReferenceId having a size less than maximum allowed number of characters
        * def clientReferenceId = randomString(65)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].clientReferenceId"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 64"

    @HCM_individual_create_08 @empty_check_givenName @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with empty givenName
        * def givenName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.givenName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_09 @size_check_minimum_givenName @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with givenName having a size less than minimum allowed number of characters
        * def givenName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.givenName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_10 @size_check_maximum_givenName @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with givenName having a size less than maximum allowed number of characters
        * def givenName = randomString(201)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.givenName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_11 @empty_check_familyName @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with empty familyName
        * def familyName = ""
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.familyName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_12 @size_check_minimum_familyName @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with familyName having a size less than minimum allowed number of characters
        * def familyName = "a"
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.familyName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_13 @size_check_maximum_familyName @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with givenName having a size less than maximum allowed number of characters
        * def familyName = randomString(201)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.familyName"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 2 and 200"

    @HCM_individual_create_14 @size_check_maximum_otherNames @healthServices @regression @positive @smoke @hcm_individual_create @hcm
    Scenario: Test to create an individual with otherNames having a size less than maximum allowed number of characters
        * def otherNames = randomString(201)
        * call read('../../health-services/pretest/individualServicePretest.feature@createIndividualError')
        * assert createIndividualResponseBody.Errors[0].code == "Size.individualRequest.individual[0].name.otherNames"
        * assert createIndividualResponseBody.Errors[0].message == "size must be between 0 and 200"




