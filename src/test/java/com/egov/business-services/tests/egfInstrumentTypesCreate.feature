 Feature: To test egf-instrument-instrumentTypes service 'Create' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def instrumentTypesPayload = read('../../business-services/requestPayload/egfInstrument/instrumentType/create.json')
        # Instrument types details
        * def id = randomString(5)
        * def name = "Instrument_"+randomString(3)
        * def description = 'Desc-'+randomString(3)
        * def active = true
        * set instrumentTypesPayload.instrumentTypes[0].id = id
        * set instrumentTypesPayload.instrumentTypes[0].name = name
        * set instrumentTypesPayload.instrumentTypes[0].description = description
        * set instrumentTypesPayload.instrumentTypes[0].active = active
        # Instrument types properties
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].id = generateUUID()
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].transactionType = 'Credit'
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].reconciledOncreate = 'false'
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnCreate = 'New'
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnUpdate = 'Deposited'
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnReconcile = 'Reconciled'
        * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].instrumentType = 'Online'
        * def invalidTenantId = 'Invalid-'+randomString(4)
        * def latestName = randomString(50)
        * def nameWithTwoChar = randomString(2)
        * def fieldMustNotBlank = egfInstrumentConstants.errorMessages.fieldNotBlank
        * def fieldMustNotBeNull = egfInstrumentConstants.errorMessages.fieldValueIsNull
  
@InstrumentTypeCreate_01 @instrumentTypeCreate @egfInstrument @positive
    Scenario: Create InstrumentType with Unique ID
    # Steps to create Instrument type
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate the id return by API should be equal to the id which has been passed
    * match instrumentTypesResponse.instrumentTypes[0].id == id
    # Validate the name return by API should be equal to the name which has been passed
    * match instrumentTypesResponse.instrumentTypes[0].name == name
    # Validate the description return by API should be equal to the description which has been passed
    * match instrumentTypesResponse.instrumentTypes[0].description == description
    # Validate the active return by API should be equal to the active which has been passed
    * match instrumentTypesResponse.instrumentTypes[0].active == active

@InstrumentTypeCreate_NullId_02 @instrumentTypeCreate @egfInstrument @negative 
    Scenario: Create InstrumentType with NULL ID
    # Set instrument type id as `null`
    * set instrumentTypesPayload.instrumentTypes[0].id = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * print instrumentTypesResponse
    * assert instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.serverError

    
@InstrumentTypeCreate_NameWith50Characters_03 @instrumentTypeCreate @egfInstrument @positive  
    Scenario: Create InstrumentType with Name 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = latestName
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == latestName

@InstrumentTypeCreate_NameWithMoreThan50Characters_04 @instrumentTypeCreate @egfInstrument @negative  
    Scenario: Create InstrumentType with Name More than 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(55)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter
    
@InstrumentTypeCreate_NameWith1Charater_05 @instrumentTypeCreate @egfInstrument @negative  
    Scenario: Create InstrumentType with Name 1 character
    # Set the name with 1 charater value
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(1)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter


@InstrumentTypeCreate_NameWith2Characters_06 @instrumentTypeCreate @egfInstrument @positive  
    Scenario: Create InstrumentType with Name 2 characters
    # Set the name with 2 charaters value
    * set instrumentTypesPayload.instrumentTypes[0].name = nameWithTwoChar
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == nameWithTwoChar

@InstrumentTypeCreate_NameWithNull_07 @instrumentTypeCreate @egfInstrument @negative 
    Scenario: Create InstrumentType with NULL Name
    # Set the name with null value
    * set instrumentTypesPayload.instrumentTypes[0].name = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * print instrumentTypesResponse
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[*].message contains ['#(fieldMustNotBlank)', '#(fieldMustNotBeNull)']
    
@InstrumentTypeCreate_DescriptionWithMorethan100Characters_08 @instrumentTypeCreate @egfInstrument @negative  
    Scenario: Create InstrumentType with Description More than 100 characters
    # Set the description with more than 100 characters value
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(105)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidDescriptionCharacter

@InstrumentTypeCreate_DescriptionWith100Characters_09 @instrumentTypeCreate @egfInstrument @egfInstrument  
    Scenario: Create InstrumentType with Description 100 characters
    # Set the description with 100 characters value
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(100)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * assert instrumentTypesResponse.instrumentTypes.size() != 0

@InstrumentTypeCreate_DescriptionWithEmpty_10 @instrumentTypeCreate @egfInstrument @positive  
    Scenario: Create InstrumentType with Empty Description
    # Set the description with blank value
    * set instrumentTypesPayload.instrumentTypes[0].description = ""
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].description == ""

@InstrumentTypeCreate_ActiveWithFalse_11 @instrumentTypeCreate @egfInstrument @positive
    Scenario: Create InstrumentType with Active False
    # Set the Active field value as false
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].active == false

@InstrumentTypeCreate_ActiveWithNULL_12 @instrumentTypeCreate @egfInstrument @negative
    Scenario: Create InstrumentType with Active NULL
    # Set the Active field value as null
    * set instrumentTypesPayload.instrumentTypes[0].active = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.fieldValueIsNull
        
@InstrumentTypeCreate_InvalidTenantId_13 @instrumentTypeCreate @egfInstrument @negative 
    Scenario: Create InstrumentType with Invalid tenantId
    # Set the tenantId field value as Invalid
    * set instrumentTypesPayload.instrumentTypes[0].tenantId = invalidTenantId
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@InstrumentTypeCreate_DuplicateID_14 @instrumentTypeCreate @egfInstrument @negative
    Scenario: Create InstrumentType with Duplicate ID
    # Steps to create instrument types 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set instrument type id as the duplicate id
    * set instrumentTypesPayload.instrumentTypes[0].id = instrumentTypesResponse.instrumentTypes[0].id
    # Steps to create instrument type with duplicate id
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * assert instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.serverError

@InstrumentTypeCreate_DuplicateName_15 @instrumentTypeCreate @egfInstrument @negative
    Scenario: Create InstrumentType with Duplicate Name
    # Steps to create instrument types 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set an unique instrument type id 
    * set instrumentTypesPayload.instrumentTypes[0].id = 'Latest'+randomString(3)
    # Set a duplicate instrument type name 
    * set instrumentTypesPayload.instrumentTypes[0].name = instrumentTypesResponse.instrumentTypes[0].name
    # Steps to create instrument type with duplicate name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.error == commonConstants.errorMessages.internalServerError