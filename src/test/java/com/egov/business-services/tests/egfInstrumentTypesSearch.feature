 Feature: To test egf-instrument-instrumentTypes service 'Search' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def searchInstrumentTypesPayload = read('../../business-services/requestPayload/egfInstrument/instrumentType/search.json')
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
        * def invalidName = 'Name'+randomString(5)
        * def invalidId = 'Id'+randomString(5)
  
@InstrumentTypeSearch_All_01 @instrumentTypesSearch @egfInstrument @positive
    Scenario: Search all instrument types
    # Prepare searchParams with tenantId
    * def searchParams = {tenantId: '#(tenantId)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0

@InstrumentTypeSearch_WithName_02 @instrumentTypesSearch @egfInstrument @positive 
    Scenario: Search Instrument type with valid name
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Prepare searchParams with name
    * def searchParams = {name:'#(name)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0
    * match searchResponse.instrumentTypes[0].name == instrumentTypesResponse.instrumentTypes[0].name

@InstrumentTypeSearch_WithInvalidName_03 @instrumentTypesSearch @egfInstrument @nagative
    Scenario: Search Instrument type with Invalid name
    # Prepare searchParams with invalid name
    * def searchParams = {name: '#(invalidName)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() == 0

@InstrumentTypeSearch_WithId_04 @instrumentTypesSearch @egfInstrument @positive
    Scenario: Search Instrument type with valid ID
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Prepare searchParams with id
    * def searchParams = {id: '#(id)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0
    * match searchResponse.instrumentTypes[0].id == id

@InstrumentTypeSearch_WithInvalidID_05 @instrumentTypesSearch @egfInstrument @nagative 
    Scenario: Search Instrument type with Invalid ID
    # Prepare searchParams with invalid id
    * def searchParams = {id: '#(invalidId)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() == 0

@InstrumentTypeSearch_WithActiveTrue_06 @instrumentTypesSearch @egfInstrument @positive
    Scenario: Search Instrument type with Active true
    # Prepare searchParams with active
    * def searchParams = {active: '#(active)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * def condition = function(x){ return x.active != 'false' }
    * def filtered = karate.filter(searchResponse.instrumentTypes, condition)
    * match deterMineActiveFieldValue(filtered, true) == true
    

@InstrumentTypeSearch_WithActiveFalse_07 @instrumentTypesSearch @egfInstrument @positive
    Scenario: Search Instrument type with Active false
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    # Prepare searchParams with active
    * def searchParams = {active: 'false'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * def condition = function(x){ return x.active != 'true' }
    * def filtered = karate.filter(searchResponse.instrumentTypes, condition)
    * match deterMineActiveFieldValue(filtered, false) == true

@InstrumentTypeSearch_WithInvalidtenantID_08 @instrumentTypesSearch @egfInstrument @nagative
    Scenario: Search Instrument type with Invalid tenantID
    # Prepare searchParams with invalidTenantId
    * def searchParams = {tenantId: '#(invalidTenantId)'}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInSearchInstrumentTypes')
    * match searchResponse.Errors[0].message == commonConstants.errorMessages.authorizedError
    
@InstrumentTypeSearch_WithNotenantID_09 @instrumentTypesSearch @egfInstrument @nagative
    Scenario: Search Instrument type with No tenantID
    # Prepare serachParams with blank
    * def searchParams = {}
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypes')
    * match searchResponse.instrumentTypes.size() != 0