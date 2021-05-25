Feature: Fire NOC Service

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Collections = Java.type('java.util.Collections')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # Searching Location for locality and areaCode
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def nocConstants = read('../../municipal-services/constants/noc.yaml')
    # initialising request payload variables
    * configure headers = read('classpath:websCommonHeaders.js')
    * def nocType = nocConstants.nocType.fireNoc
    * def source = "BPA"
    * def comment = randomString(10)
    * def action = nocConstants.actions.forward

@NOCCreate1 @createNOC  @positive @regression @NOCService @municipalServices
Scenario: Create  Noc With Valid Data
    # Create a NOC
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    # Validate response body
    * match nocResponseBody.Noc[0].tenantId == "#present"
    * match nocResponseBody.Noc[0].nocType == nocType
@NOCCreate1 @createNOC  @positive @regression @NOCService @municipalServices
Scenario: Create Noc With Valid Data
    # Create a NOC
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    # Validate response body
    * match nocResponseBody.Noc[0].tenantId == "#present"
    * match nocResponseBody.Noc[0].nocType == nocConstants.nocType.fireNoc
@NOCCreate2 @createNOC  @positive @regression @NOCService @municipalServices
Scenario: Create Noc With invalid Tenant Id
    # Create a NOC
    * def tenantId = randomString(10)
    * call read('../../municipal-services/pretests/NOCPretest.feature@failCreateNOCRequest')
    # Validate response body
    * match nocResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError
    * match nocResponseBody.Errors[0].code == nocConstants.Errors.errorCodes.invalidTenantId

@NOCCreate3 @createNOC  @positive @regression @NOCService @municipalServices
Scenario: Create Noc With invalid NOC Type
    # Create a NOC
    * def nocType = randomString(10)
    * call read('../../municipal-services/pretests/NOCPretest.feature@failCreateNOCRequest')
    # Validate response body
    * match nocResponseBody.Errors[0].code == nocConstants.Errors.errorCodes.invalidNOCType
    * match nocResponseBody.Errors[0].message == replaceString(nocConstants.Errors.errorMessages.invalidNOCType,"<<noc_type>>",nocType)

@NOCCreate4 @createNOC  @positive @regression @NOCService @municipalServices
Scenario: Create Noc With invalid soruce
    # Create a NOC
    * def source = ""
    * call read('../../municipal-services/pretests/NOCPretest.feature@failCreateNOCRequest')
    # Validate response body
    * match nocResponseBody.Errors[0].code == nocConstants.Errors.errorCodes.invalidSource
    * match nocResponseBody.Errors[0].message == nocConstants.Errors.errorMessages.invalidSource

@NOCSearch1 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Search with Valid Data
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { tenantId: '#(tenantId)', id: '#(nocId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithValidData')
    * match nocResponseBody.Noc[0].tenantId == "#present"
    * match nocResponseBody.Noc[0].nocType == nocType

@NOCSearch2 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Search with No Tenant Id
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { id: '#(nocId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithInvalidData')
    * match nocResponseBody.Errors[0].code == nocConstants.Errors.errorCodes.searchNoTenantId
    * match nocResponseBody.Errors[0].message == nocConstants.Errors.errorMessages.searchNoTenantId

@NOCSearch3 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Search with only tenant id
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithValidData')
    * match nocResponseBody.Noc[0].tenantId == tenantId


@NOCUpdate1 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Update with Valid Data
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { tenantId: '#(tenantId)', id: '#(nocId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithValidData')
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithValidData')
    * match nocResponseBody.Noc[0].tenantId == "#present"
    * match nocResponseBody.Noc[0].nocType == nocConstants.nocType.fireNoc

@NOCUpdate2 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Update with Invalid Id
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { tenantId: '#(tenantId)', id: '#(nocId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithValidData')
    * def invalidId = randomString(10)
    * set nocDetail.id = invalidId
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithInValidData')
    * match nocResponseBody.Errors[0].code == nocConstants.Errors.errorCodes.invalidId
    * match nocResponseBody.Errors[0].message == replaceString(nocConstants.Errors.errorMessages.invalidId,"<<invalid_id>>",invalidId)

#BUG - JSON RESPONSE IS NOT FORMATTED PROPERLY
@NOCUpdate3 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Update with Invalid WF
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { tenantId: '#(tenantId)', id: '#(nocId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithValidData')
    * set nocDetail.workflow.action = randomString(10)
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithInValidData')
    * match nocResponseBody.Noc[0].tenantId == "#present"
    * match nocResponseBody.Noc[0].nocType == nocType

#BUG: Getting Error message as [{\"code\":\"INVALID ACTION\",\"message\":\"Action sTjBXeBzzv not found in config for the businessId: PB-NOCSRV-2021-04-12-000835\",\"description\":null,\"params\":null}]
@NOCUpdate4 @searchNOC  @positive @regression @NOCService @municipalServices
Scenario: Update NOC with Invalid Source
    * call read('../../municipal-services/pretests/NOCPretest.feature@successCreateNOCRequest')
    * def searchNOCParams = { tenantId: '#(tenantId)', id: '#(nocId)'}
    * call read('../../municipal-services/pretests/NOCPretest.feature@searchNOCWithValidData')
    * set nocDetail.source = ""
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithInValidData')
    * match nocResponseBody.Errors[0].code == nocConstants.Errors.errorCodes.invalidSource
    * match nocResponseBody.Errors[0].message == nocConstants.Errors.errorMessages.invalidSource

