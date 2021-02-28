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
  
@InstrumentTypeCreate_01 
    Scenario: Create InstrumentType with Unique ID
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].id == id
    * match instrumentTypesResponse.instrumentTypes[0].name == name
    * match instrumentTypesResponse.instrumentTypes[0].description == description
    * match instrumentTypesResponse.instrumentTypes[0].active == active

@InstrumentTypeCreate _NullId_02 
    Scenario: Create InstrumentType with NULL ID
    * set instrumentTypesPayload.instrumentTypes[0].id = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse
    * match instrumentTypesResponse.error == commonConstants.errorMessages.internalServerError
    

@InstrumentTypeCreate_NameWith50Characters_03 
    Scenario: Create InstrumentType with Name 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(50)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == name

@InstrumentTypeCreate_NameWithMoreThan50Characters_04 
    Scenario: Create InstrumentType with Name More than 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(55)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter
    
@InstrumentTypeCreate_NameWith1Charater_05 
    Scenario: Create InstrumentType with Name 1 character
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(1)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter


@InstrumentTypeCreate_NameWith2Characters_06 
    Scenario: Create InstrumentType with Name 2 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(2)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == name

@InstrumentTypeCreate_NameWithNull_07 
    Scenario: Create InstrumentType with NULL Name
    * set instrumentTypesPayload.instrumentTypes[0].name = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.fieldNotBlank
    * match instrumentTypesResponse['error'].fields[1].message == egfInstrumentConstants.errorMessages.fieldValueIsNull
    
@InstrumentTypeCreate_DescriptionWithMorethan100Characters_08 
    Scenario: Create InstrumentType with Description More than 100 characters
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(105)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidDescriptionCharacter

@InstrumentTypeCreate_DescriptionWith100Characters_09 
    Scenario: Create InstrumentType with Description 100 characters
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(100)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * assert instrumentTypesResponse.instrumentTypes.size() != 0

@InstrumentTypeCreate_DescriptionWithEmpty_10 
    Scenario: Create InstrumentType with Empty Description
    * set instrumentTypesPayload.instrumentTypes[0].description = ""
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].description == ""

@InstrumentTypeCreate_ActiveWithFalse_11 
    Scenario: Create InstrumentType with Active False
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].active == false

@InstrumentTypeCreate_ActiveWithNULL_12 
    Scenario: Create InstrumentType with Active NULL
    * set instrumentTypesPayload.instrumentTypes[0].active = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.fieldValueIsNull
        
@InstrumentTypeCreate_InvalidTenantId_13
    Scenario: Create InstrumentType with Invalid tenantId
    * set instrumentTypesPayload.instrumentTypes[0].tenantId = invalidTenantId
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse
    * match instrumentTypesResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@InstrumentTypeCreate_DuplicateID_14 
    Scenario: Create InstrumentType with Duplicate ID
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].id = instrumentTypesResponse.instrumentTypes[0].id
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse

@InstrumentTypeCreate_DuplicateName_15 
    Scenario: Create InstrumentType with Duplicate Name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].name = instrumentTypesResponse.instrumentTypes[0].name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * print instrumentTypesResponse