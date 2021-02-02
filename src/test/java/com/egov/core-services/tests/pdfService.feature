Feature: pdf service
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')

  * def pdfCreateConstant = read('../../core-services/constants/pdfService.yaml')

@pdf_create_PT_01  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Property Tax  module 
  * def key = pdfCreateConstant.parameters.valid.keyForPt 
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreateforptsuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'

@pdf_create_PT_FS_02  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the PT API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForPt
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreateforptsuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'

@pdf_create_TL_03  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Trade License  module 
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreatesuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'

@pdf_create_TL_FS_04  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the TL API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreatesuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message

@pdf_create_Fire_05  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Fire NOC module
  * def key = pdfCreateConstant.parameters.valid.keyForFireNoc
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreateforfirenocsuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present'
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message 

@pdf_create_Fire_FS_06  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the FireNOC API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForFireNoc
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreateforfirenocsuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message

@pdf_create_WS_05  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for water & Severage module
  * def key = pdfCreateConstant.parameters.valid.keyForWs
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreateforwssuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present' 
  * pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message 
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'

@pdf_create_WS_FS_07  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the WnS API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForWs
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreateforwssuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'
  * pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message

@pdf_create_inavlid_tenantid_08  @negative  @pdfservice
Scenario: "Verify generating PDF without tenant id and check for errors(all the modules)" 
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreatewithouttenantid')
  * print pdfCreateResponseBody
  * print pdfCreateConstant.errorMessages.invalidTenantId
  * def pdfCreate = pdfCreateResponseBody.message
  * print pdfCreate
  * assert pdfCreate == pdfCreateConstant.errorMessages.invalidTenantId

@pdf_create_invalid_key_09  @negative  @pdfservice
Scenario: "Verify generating PDF invalid/nonexistant or by not passing key and check for errors(all the modules)"
  * def key = pdfCreateConstant.parameters.invalid.key
  * call read('../../core-services/pretests/pdfServiceCreate.feature@pdfcreatefail')
  * print pdfCreateResponseBody
  * print pdfCreateConstant.errorMessages.invalidKey
  * def pdfCreateSecond = pdfCreateResponseBody.message
  * print pdfCreateSecond
  * assert pdfCreateSecond == pdfCreateConstant.errorMessages.invalidKey

@pdf_createnosave_PT_01  @positive  @pdfservice
Scenario: Generate PDF config for PT module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForPt
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@pdfcreatenosavesuccess')
  * print pdfCreateNoSaveResponseBody
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_createnosave_TL_02  @positive  @pdfservice
Scenario: Generate PDF config for TL module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@pdfcreatenosavesuccess')
  * print pdfCreateNoSaveResponseBody
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_createnosave_WS_03  @positive  @pdfservice
Scenario: Generate PDF config for WS module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForWs
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@pdfcreatenosaveforwssuccess')
  * print pdfCreateNoSaveResponseBody
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_createnosave_FireNOC_04  @positive  @pdfservice
Scenario: Generate PDF config for FireNOC module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForFireNoc
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@pdfcreatenosavesuccess')
  * print pdfCreateNoSaveResponseBody
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_noqueryparams_FireNOC_05  @negative  @pdfservice
Scenario: Generate PDF config wihtout passing key or tenantid
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@pdfcreatenosavewithoutparam')
  * print pdfCreateNoSaveResponseBody
  * pdfCreateNoSaveResponseBody.message == pdfCreateConstant.errorMessages.withoutParam

@pdf_invalidKey_06  @negative  @pdfservice
Scenario: Generate PDF config by passing invalid key 
  * def key = pdfCreateConstant.parameters.invalid.keyForWs
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@pdfcreatenosavefail')
  * print pdfCreateNoSaveResponseBody
  * pdfCreateNoSaveResponseBody.message == pdfCreateConstant.errorMessages.invalidWsKey 
  
  


