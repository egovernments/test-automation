Feature: To test egf-Instrument-Instruments service tests

Background: 
  * def jsUtils = read('classpath:jsUtils.js')
  #egf-Instruments Constants file
  * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
  # Creating an instrumentType
  * call read('../../business-services/tests/egfInstrumentTypesCreate.feature@InstrumentTypeCreate_01')
  * def instrumentTypeName = instrumentTypesResponse.instrumentTypes[0].name
  # Creating ChartOfAccount
  * call read('../../business-services/tests/egfMasterChartOfAccountCreate.feature@ChartOfAccountCreate_01')
  * def glcode = chartAccountGlcode
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  
  #Create InstrumentAccountCode TCs

@InstrumentAccountCode_Create_01 @positive @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with valid instrument type & accountCode
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  # Validating response body
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  * match instrumentAccountCodeResponse.instrumentAccountCodes[0].instrumentType.name == instrumentTypeName 
  * match instrumentAccountCodeResponse.instrumentAccountCodes[0].accountCode.glcode == glcode 
  * def duplicateTypeName = instrumentTypeName

@InstrumentAccountCode_Create_DuplicateInstrumentTypeName_02 @negative @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with duplicate instrument typeName
  * call read('../../business-services/tests/egfInstrumentAccountCode.feature@InstrumentAccountCode_Create_01')
  * def instrumentTypeName = duplicateTypeName
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorIncreateInstrumentAccountCode')
  # Validating response body
  * match instrumentAccountCodeResponse.message == egfInstrumentConstants.errorMessages.message 

@InstrumentAccountCode_Create_InvalidInstrumentTypeName_03 @negative @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with Invalid instrument typeName
  * def instrumentTypeName = randomString(7)
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorIncreateInstrumentAccountCode')
  # Validating response body
  * match instrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match instrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.instrumentTypeMessage

@InstrumentAccountCode_Create_EmptyInstrumentTypeName_04 @negative @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with empty instrument typeName
  * def instrumentTypeName = commonConstants.invalidParameters.emptyValue
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorIncreateInstrumentAccountCode')
  # Validating response body
  * match instrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match instrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.instrumentTypeMessage

@InstrumentAccountCode_Create_InvalidGLCode_05 @negative @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with Invalid GLCode
  * def glcode = randomString(7)
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorIncreateInstrumentAccountCode')
  # Validating response body
  * match instrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match instrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.accountCode

@InstrumentAccountCode_Create_EmptyGLCode_06 @negative @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with empty GLCode
  * def glcode = commonConstants.invalidParameters.emptyValue
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorIncreateInstrumentAccountCode')
  # Validating response body
  * match instrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match instrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.accountCode

@InstrumentAccountCode_Create_InvalidTenantID_07 @negative @instrumentAcountCodeCreate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with Invalid tenantId
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorIncreateInstrumentAccountCode')
  * match instrumentAccountCodeResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

#Update InstrumentAccountCode TCs

@InstrumentAccountCode_Update_ValidID_01 @positive @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with valid ID
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@updateInstrumentAccountCode')
  * print updateInstrumentAccountCodeResponse
  * match updateInstrumentAccountCodeResponse.instrumentAccountCodes[0].id == id
  * match updateInstrumentAccountCodeResponse.instrumentAccountCodes[0].instrumentType.name == instrumentTypeName 
  * match updateInstrumentAccountCodeResponse.instrumentAccountCodes[0].accountCode.glcode == glcode 

@InstrumentAccountCode_Update_InvalidID_02 @positive @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with Invalid ID

  # Creating an instrumentAccountCode
  * call read('../../business-services/tests/egfInstrumentAccountCode.feature@InstrumentAccountCode_Create_01')
  * def instrumentTypeName = duplicateTypeName
  * def id = commonConstants.invalidParameters.invalidValue
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * print updateInstrumentAccountCodeResponse
  * match updateInstrumentAccountCodeResponse.message == egfInstrumentConstants.errorMessages.message

@InstrumentAccountCode_Update_NullID_03 @positive @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with Null ID

  * def id = commonConstants.invalidParameters.nullValue
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * print updateInstrumentAccountCodeResponse
  * match updateInstrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match updateInstrumentAccountCodeResponse.error.message == 'id'

@InstrumentAccountCode_Update_InvalidInstrumentTypeName_04 @negative @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with Invalid instrument typeName
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  * def instrumentTypeName = randomString(7)
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * match updateInstrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match updateInstrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.instrumentTypeMessage

@InstrumentAccountCode_Update_EmptyInstrumentTypeName_05 @negative @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with empty instrument typeName
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  * def instrumentTypeName = commonConstants.invalidParameters.emptyValue
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * match updateInstrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match updateInstrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.instrumentTypeMessage

@InstrumentAccountCode_Update_InvalidGLCode_06 @negative @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with InvalidGLCode
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  * def glcode = randomString(7)
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * match updateInstrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match updateInstrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.accountCode

@InstrumentAccountCode_Update_EmptyGLCode_07 @negative @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with empty GLCode
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  * def glcode = commonConstants.invalidParameters.emptyValue
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * match updateInstrumentAccountCodeResponse.responseInfo.status == commonConstants.expectedStatus.badRequest
  * match updateInstrumentAccountCodeResponse.error.message == egfInstrumentConstants.errorMessages.accountCode

@InstrumentAccountCode_Update_InvalidTenantID_08 @negative @instrumentAcountCodeUpdate @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Update InstrumentAccountCode with Invalid tenantId
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  * def tenantId = commonConstants.invalidParameters.invalidValue
  # Updating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInupdateInstrumentAccountCode')
  # Validating response body
  * match updateInstrumentAccountCodeResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@InstrumentAccountCode_Search_ValidID_01 @positive @instrumentAcountCodeSearch @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with valid instrument type & accountCode
  # Creating an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@createInstrumentAccountCode')
  * def id = instrumentAccountCodeResponse.instrumentAccountCodes[0].id
  # Prepare searchParams with name
  * def searchParams = {id:'#(id)'}
  # Searching an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@searchInstrumentAccountCode')
  * match searchInstrumentAccountCodeResponse.instrumentAccountCodes.size() != 0
  * match searchInstrumentAccountCodeResponse.instrumentAccountCodes[0].id == id

@InstrumentAccountCode_Search_InValidID_02 @positive @instrumentAcountCodeSearch @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with valid instrument type & accountCode

  * def id = commonConstants.invalidParameters.invalidValue
  # Prepare searchParams with name
  * def searchParams = {id:'#(id)'}
  # Searching an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@searchInstrumentAccountCode')
  * match searchInstrumentAccountCodeResponse.instrumentAccountCodes.size() == 0
  
@InstrumentAccountCode_Search_InValidID_02 @positive @instrumentAcountCodeSearch @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with valid instrument type & accountCode

  * def id = commonConstants.invalidParameters.emptyValue
  # Prepare searchParams with name
  * def searchParams = {id:'#(id)'}
  # Searching an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@searchInstrumentAccountCode')
  * match searchInstrumentAccountCodeResponse.instrumentAccountCodes.size() == 0

@InstrumentAccountCode_Search_InValidTenantID_02 @positive @instrumentAcountCodeSearch @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with valid instrument type & accountCode

  * def tenantId = commonConstants.invalidParameters.invalidValue
  # Prepare searchParams with name
  * def searchParams = {tenantId:'#(tenantId)'}
  # Searching an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@errorInsearchInstrumentAccountCode')
  * match searchInstrumentAccountCodeResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@InstrumentAccountCode_Search_All_05 @positive @instrumentAcountCodeSearch @egfInstrument_InstrumentsAccountCode @egfInstrument @regression
Scenario: Create InstrumentAccountCode with valid instrument type & accountCode

  # Prepare searchParams with name
  * def searchParams = {tenantId:'#(tenantId)'}
  # Searching an instrumentAccountCode
  * call read('../../business-services/pretest/egfInstrumentAccountCodePretest.feature@searchInstrumentAccountCode')
  * match searchInstrumentAccountCodeResponse.instrumentAccountCodes.size() != 0