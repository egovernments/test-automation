 Feature: To test egf-instrument-instrumentTypes service 'Create' endpoint

    Background: 
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def instrumentTypesPayload = read('../../business-services/requestPayload/egf-instrument/instrumentType/create.json')
        * def searchInstrumentTypesPayload = read('../../business-services/requestPayload/egf-instrument/instrumentType/search.json')
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
        * def updatedName = randomString(5)
        * def updatedDescription = randomString(20)
        * def fieldMustNotBlank = egfInstrumentConstants.errorMessages.fieldNotBlank
        * def fieldMustNotBeNull = egfInstrumentConstants.errorMessages.fieldValueIsNull
        * def invalidName = 'Name'+randomString(5)
        * def invalidId = 'Id'+randomString(5)
  
@InstrumentTypeCreate_01 @instrumentTypeCreate @egfInstrument @regression @businessServices @positive
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

#bug: Internal Server error 500 for null instrument type id. Should throw proper message
@InstrumentTypeCreate_NullId_02 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative 
    Scenario: Create InstrumentType with NULL ID
    # Set instrument type id as `null`
    * set instrumentTypesPayload.instrumentTypes[0].id = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypesServerError')
    # Validate that the error message returned by the API should be equal with expected error
    # * print instrumentTypesResponse
    * assert instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.serverError

    
@InstrumentTypeCreate_NameWith50Characters_03 @instrumentTypeCreate @egfInstrument @regression @businessServices @positive  
    Scenario: Create InstrumentType with Name 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = latestName
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == latestName

@InstrumentTypeCreate_NameWithMoreThan50Characters_04 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative  
    Scenario: Create InstrumentType with Name More than 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(55)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter
    
@InstrumentTypeCreate_NameWith1Charater_05 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative  
    Scenario: Create InstrumentType with Name 1 character
    # Set the name with 1 charater value
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(1)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter


@InstrumentTypeCreate_NameWith2Characters_06 @instrumentTypeCreate @egfInstrument @regression @businessServices @positive  
    Scenario: Create InstrumentType with Name 2 characters
    # Set the name with 2 charaters value
    * set instrumentTypesPayload.instrumentTypes[0].name = nameWithTwoChar
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == nameWithTwoChar

@InstrumentTypeCreate_NameWithNull_07 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative 
    Scenario: Create InstrumentType with NULL Name
    # Set the name with null value
    * set instrumentTypesPayload.instrumentTypes[0].name = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    # * print instrumentTypesResponse
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[*].message contains ['#(fieldMustNotBlank)', '#(fieldMustNotBeNull)']
    
@InstrumentTypeCreate_DescriptionWithMorethan100Characters_08 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative  
    Scenario: Create InstrumentType with Description More than 100 characters
    # Set the description with more than 100 characters value
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(105)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidDescriptionCharacter

@InstrumentTypeCreate_DescriptionWith100Characters_09 @instrumentTypeCreate @egfInstrument @regression @businessServices @egfInstrument @regression @businessServices  
    Scenario: Create InstrumentType with Description 100 characters
    # Set the description with 100 characters value
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(100)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * assert instrumentTypesResponse.instrumentTypes.size() != 0

@InstrumentTypeCreate_DescriptionWithEmpty_10 @instrumentTypeCreate @egfInstrument @regression @businessServices @positive  
    Scenario: Create InstrumentType with Empty Description
    # Set the description with blank value
    * set instrumentTypesPayload.instrumentTypes[0].description = ""
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].description == ""

@InstrumentTypeCreate_ActiveWithFalse_11 @instrumentTypeCreate @egfInstrument @regression @businessServices @positive
    Scenario: Create InstrumentType with Active False
    # Set the Active field value as false
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].active == false

@InstrumentTypeCreate_ActiveWithNULL_12 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative
    Scenario: Create InstrumentType with Active NULL
    # Set the Active field value as null
    * set instrumentTypesPayload.instrumentTypes[0].active = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.fieldValueIsNull
        
@InstrumentTypeCreate_InvalidTenantId_13 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative 
    Scenario: Create InstrumentType with Invalid tenantId
    # Set the tenantId field value as Invalid
    * set instrumentTypesPayload.instrumentTypes[0].tenantId = invalidTenantId
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypesUnAuthorized')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

#bug: Internal Server error 500 for Duplicate Instrument type id. Should throw proper message
@InstrumentTypeCreate_DuplicateID_14 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative
    Scenario: Create InstrumentType with Duplicate ID
    # Steps to create instrument types 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set instrument type id as the duplicate id
    * set instrumentTypesPayload.instrumentTypes[0].id = instrumentTypesResponse.instrumentTypes[0].id
    # Steps to create instrument type with duplicate id
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * assert instrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.serverError

#bug: Internal Server error 500 for Duplicate Instrument type name. Should throw proper message
@InstrumentTypeCreate_DuplicateName_15 @instrumentTypeCreate @egfInstrument @regression @businessServices @negative
    Scenario: Create InstrumentType with Duplicate Name
    # Steps to create instrument types 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set an unique instrument type id 
    * set instrumentTypesPayload.instrumentTypes[0].id = 'Latest'+randomString(3)
    # Set a duplicate instrument type name 
    * set instrumentTypesPayload.instrumentTypes[0].name = instrumentTypesResponse.instrumentTypes[0].name
    # Steps to create instrument type with duplicate name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstrumentTypes')
    # Validate that the error message returned by the API should be equal with expected error
    * match instrumentTypesResponse.error == commonConstants.errorMessages.internalServerError

# Update Instrument Type

@InstrumentTypeUpdate_Name_01 @instrumentTypeUpdate @positive @egfInstrument @regression @businessServices
    Scenario: Update Name in instrumentType details
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == name
    # Set an updated name as a instrument type name
    * set instrumentTypesPayload.instrumentTypes[0].name = updatedName
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].name == updatedName

@InstrumentTypeUpdate_NameWithMorethan50Characters_02 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update Name with more than 50 characters
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set an updated name with more than 50 characters
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(55)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstrumentTypes')
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter

@InstrumentTypeUpdate_Description_03 @instrumentTypeUpdate @positive @egfInstrument @regression @businessServices
    Scenario: Update instrument type description 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].description == description
    # Set an updated description as an instrument type description
    * set instrumentTypesPayload.instrumentTypes[0].description = updatedDescription
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].description == updatedDescription

@InstrumentTypeUpdate_DescriptionWithMorethan100Characters_04 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update Description with more than 100 characters
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set an updated description with more than 100 characters
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(105)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstrumentTypes')
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidDescriptionCharacter

@InstrumentTypeUpdate_ActiveToTrue_05 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update instrument type Active to True
    # Set the instrument type active field as false
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    # Steps to create instrument type
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set instrument type field value as true again 
    * set instrumentTypesPayload.instrumentTypes[0].active = true
    # Steps to update the instrument type with updated type
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].active == true

@InstrumentTypeUpdate_ActiveToFalse_06 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update instrument type Active to False
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set the instrument type active field as false
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].active == false

@InstrumentTypeUpdate_WithoutId_07 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update Null ID in instrumentType
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set the instrument type id field as null
    * set instrumentTypesPayload.instrumentTypes[0].id = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstrumentTypes')
    # Validate the error message returned by API which should be equal with expected error
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].message == "id"

@InstrumentTypeUpdate_InvalidTenantID_08 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update with Invalid tenantID
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Set the tenant id value with an invalid tenant id
    * set instrumentTypesPayload.instrumentTypes[0].tenantId = invalidTenantId
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstrumentTypesUnAuthorized')
    # Validate the error message returned by API which should be equal with expected error
    * match updateInstrumentTypesResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@InstrumentTypeUpdate_InstrumentTypeProperties_09 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update with Instruemnt Type properties
    # Create an instrument type 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Updating the existing field values
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].transactionType = 'Debit'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].reconciledOncreate = 'true'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnCreate = 'Pending'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnUpdate = 'Credited'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnReconcile = 'Not Reconciled'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].instrumentType = 'Offline'
    # Steps to create instrument type with updated data
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes.size() != 0

@InstrumentTypeUpdate_NameWithNull_10 @instrumentTypeUpdate @nagative @egfInstrument @regression @businessServices
    Scenario: Update Name with Null
    # Set name as `null`
    * set instrumentTypesPayload.instrumentTypes[0].name = null
    # Steps to update instrument type with null name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstrumentTypes')
    # Validate the error message returned by API which should be equal with expected error
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].fields[*].message contains ['#(fieldMustNotBlank)', '#(fieldMustNotBeNull)']

# Search Instrument Type

@InstrumentTypeSearch_All_01 @instrumentTypesSearch @egfInstrument @regression @businessServices @positive
    Scenario: Search all instrument types
    # Prepare searchParams with tenantId
    * def searchParams = {tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0

@InstrumentTypeSearch_WithName_02 @instrumentTypesSearch @egfInstrument @regression @businessServices @positive 
    Scenario: Search Instrument type with valid name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Prepare searchParams with name
    * def searchParams = {name:'#(name)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0
    * match searchResponse.instrumentTypes[0].name == instrumentTypesResponse.instrumentTypes[0].name

@InstrumentTypeSearch_WithInvalidName_03 @instrumentTypesSearch @egfInstrument @regression @businessServices @nagative
    Scenario: Search Instrument type with Invalid name
    # Prepare searchParams with invalid name
    * def searchParams = {name: '#(invalidName)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() == 0

@InstrumentTypeSearch_WithId_04 @instrumentTypesSearch @egfInstrument @regression @businessServices @positive
    Scenario: Search Instrument type with valid ID
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Prepare searchParams with id
    * def searchParams = {id: '#(id)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0
    * match searchResponse.instrumentTypes[0].id == id

@InstrumentTypeSearch_WithInvalidID_05 @instrumentTypesSearch @egfInstrument @regression @businessServices @nagative 
    Scenario: Search Instrument type with Invalid ID
    # Prepare searchParams with invalid id
    * def searchParams = {id: '#(invalidId)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() == 0

@InstrumentTypeSearch_WithActiveTrue_06 @instrumentTypesSearch @egfInstrument @regression @businessServices @positive
    Scenario: Search Instrument type with Active true
    # Prepare searchParams with active
    * def searchParams = {active: '#(active)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * def condition = function(x){ return x.active != 'false' }
    * def filtered = karate.filter(searchResponse.instrumentTypes, condition)
    * match deterMineActiveFieldValue(filtered, true) == true
    

@InstrumentTypeSearch_WithActiveFalse_07 @instrumentTypesSearch @egfInstrument @regression @businessServices @positive
    Scenario: Search Instrument type with Active false
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Prepare searchParams with active
    * def searchParams = {active: 'false'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * def condition = function(x){ return x.active != 'true' }
    * def filtered = karate.filter(searchResponse.instrumentTypes, condition)
    * match deterMineActiveFieldValue(filtered, false) == true

@InstrumentTypeSearch_WithInvalidtenantID_08 @instrumentTypesSearch @egfInstrument @regression @businessServices @nagative
    Scenario: Search Instrument type with Invalid tenantID
    # Prepare searchParams with invalidTenantId
    * def searchParams = {tenantId: '#(invalidTenantId)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInSearchInstrumentTypes')
    * match searchResponse.Errors[0].message == commonConstants.errorMessages.authorizedError
    
@InstrumentTypeSearch_WithNotenantID_09 @instrumentTypesSearch @egfInstrument @regression @businessServices @nagative
    Scenario: Search Instrument type with No tenantID
    # Prepare serachParams with blank
    * def searchParams = {}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0