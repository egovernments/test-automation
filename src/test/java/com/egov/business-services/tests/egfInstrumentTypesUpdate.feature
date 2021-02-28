 Feature: To test egf-instrument-instrumentTypes service 'Update' endpoint

    Background: 
        * def jsUtils = read('classpath:jsUtils.js')
        * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def instrumentTypesPayload = read('../../business-services/requestPayload/egfInstrument/instrumentType/create.json')
        * def updateInstrumentTypesPayload = read('../../business-services/requestPayload/egfInstrument/instrumentType/update.json')
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
        * def updatedName = randomString(5)
        * def updatedDescription = randomString(20)
  
@InstrumentTypeUpdate_Name_01 @instrumentTypeUpdate
    Scenario: Update Name in instrumentType details
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].name == name
    * set instrumentTypesPayload.instrumentTypes[0].name = updatedName
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].name == updatedName

@InstrumentTypeUpdate_NameWithMorethan50Characters_02 @instrumentTypeUpdate
    Scenario: Update Name with more than 50 characters
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].name = randomString(55)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.invalidNameCharacter

@InstrumentTypeUpdate_Description_03 @instrumentTypeUpdate 
    Scenario: Update instrument type description 
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * match instrumentTypesResponse.instrumentTypes[0].description == description
    * set instrumentTypesPayload.instrumentTypes[0].description = updatedDescription
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].description == updatedDescription

@InstrumentTypeUpdate_DescriptionWithMorethan100Characters_04 @instrumentTypeUpdate
    Scenario: Update Description with more than 100 characters
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].description = randomString(105)
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].fields[0].message == gfInstrumentConstants.errorMessages.invalidDescriptionCharacter

@InstrumentTypeUpdate_ActiveToTrue_05 @instrumentTypeUpdate
    Scenario: Update instrument type Active to True
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].active = true
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].active == true

@InstrumentTypeUpdate_ActiveToFalse_06 @instrumentTypeUpdate
    Scenario: Update instrument type Active to False
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].active = false
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.instrumentTypes[0].active == false

@InstrumentTypeUpdate_WithoutId_07 @instrumentTypeUpdate
    Scenario: Update Null ID in instrumentType
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].id = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].message == "id"

@InstrumentTypeUpdate_InvalidTenantID_08 @instrumentTypeUpdate
    Scenario: Update with Invalid tenantID
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].tenantId = invalidTenantId
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@InstrumentTypeUpdate_InstrumentTypeProperties_09 @instrumentTypeUpdate
    Scenario: Update with Instruemnt Type properties
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentTypes')
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].transactionType = 'Debit'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].reconciledOncreate = 'true'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnCreate = 'Pending'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnUpdate = 'Credited'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].statusOnReconcile = 'Not Reconciled'
    * set instrumentTypesPayload.instrumentTypes[0].instrumentTypeProperties[0].instrumentType = 'Offline'
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')

@InstrumentTypeUpdate_NameWithNull_10 @instrumentTypeUpdate
    Scenario: Update Name with Null
    * set instrumentTypesPayload.instrumentTypes[0].name = null
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentTypes')
    * match updateInstrumentTypesResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
    * match updateInstrumentTypesResponse['error'].fields[1].message == egfInstrumentConstants.errorMessages.fieldNotBlank
    * match updateInstrumentTypesResponse['error'].fields[0].message == egfInstrumentConstants.errorMessages.fieldValueIsNull