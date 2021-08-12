Feature: pdf service
Background:
  # reading javascript utils for using generic methods
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def pdfCreateConstant = read('../../core-services/constants/pdfService.yaml')
  * call read('../../business-services/tests/collectionServicesCreate.feature@Create_PaymentWithValidBillID_01')

@pdf_create_PT_01  @coreServices @regression @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Property Tax  module
  * def key = pdfCreateConstant.parameters.valid.keyForPt
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForPtSuccessfully')
  * match pdfCreateResponseBody == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'

@pdf_create_PT_FS_02  @coreServices @regression @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the PT API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForPt
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForPtSuccessfully')
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'

@pdf_create_TL_03  @coreServices @regression @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Trade License  module
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfSuccessfully')
  
  * match pdfCreateResponseBody == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'

@pdf_create_TL_FS_04  @coreServices @regression @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the TL API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfSuccessfully')
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message

@pdf_create_Fire_05  @coreServices @regression @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Fire NOC module
  * def key = pdfCreateConstant.parameters.valid.keyForFireNoc
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForFireNocSuccessfully')
  
  * match pdfCreateResponseBody == '#present'
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message 

@pdf_create_Fire_FS_06  @coreServices @regression @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the FireNOC API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForFireNoc
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForFireNocSuccessfully')
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'
  * assert pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message

@pdf_create_WS_05  @coreServices @regression @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for water & Severage module
  * def key = pdfCreateConstant.parameters.valid.keyForWs
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForWSSuccessfully')
  
  * match pdfCreateResponseBody == '#present' 
  * pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message 
  * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'

@pdf_create_WS_FS_07  @coreServices @regression @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the WnS API call for PDF generation service
  * def key = pdfCreateConstant.parameters.valid.keyForWs
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForWSSuccessfully')
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'
  * pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message

@pdf_create_inavlid_tenantid_08  @coreServices @regression @negative  @pdfservice
Scenario: "Verify generating PDF without tenant id and check for errors(all the modules)"
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfWithoutTenantIdError')
  
  * def pdfCreate = pdfCreateResponseBody.message
  * assert pdfCreate == pdfCreateConstant.errorMessages.invalidTenantId

        @pdf_create_invalid_key_09  @coreServices @regression @negative  @pdfservice
        Scenario: "Verify generating PDF invalid/nonexistant or by not passing key and check for errors(all the modules)"
  * def key = ranString(5)
  # calling create pdf pretest
  * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfError')
  * def pdfCreateSecond = pdfCreateResponseBody.message
  * assert pdfCreateSecond == pdfCreateConstant.errorMessages.invalidKey + key

@pdf_createnosave_PT_01  @coreServices @regression @positive  @pdfservice
Scenario: Generate PDF config for PT module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForPt
  # calling create pdf nosave pretest
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@createPdfNosaveSuccessfully')
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_createnosave_TL_02  @coreServices @regression @positive  @pdfservice
Scenario: Generate PDF config for TL module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForTl
  # calling create pdf nosave pretest
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@createPdfNosaveSuccessfully')
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_createnosave_WS_03  @coreServices @regression @positive  @pdfservice
Scenario: Generate PDF config for WS module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForWs
  # calling create pdf nosave pretest
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@createPdfNosaveForWsSuccessfully')
  
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_createnosave_FireNOC_04  @coreServices @regression @positive  @pdfservice
Scenario: Generate PDF config for FireNOC module for a given key and tenantid
  * def key = pdfCreateConstant.parameters.valid.keyForFireNoc
  # calling create pdf nosave pretest
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@createPdfNosaveSuccessfully')
  
  * match pdfCreateNoSaveResponseBody == '#present'

@pdf_noqueryparams_FireNOC_05  @coreServices @regression @negative  @pdfservice
Scenario: Generate PDF config wihtout passing key or tenantid
  # calling create pdf nosave pretest
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@createPdfNosaveWithoutParamsError')
  
  * pdfCreateNoSaveResponseBody.message == pdfCreateConstant.errorMessages.withoutParam

@pdf_invalidKey_06  @coreServices @regression @negative  @pdfservice
Scenario: Generate PDF config by passing invalid key
  * def key = randomString(6)
  # calling create pdf nosave pretest
  * call read('../../core-services/pretests/pdfServiceCreateNoSave.feature@createPdfNosaveError')
  
  * pdfCreateNoSaveResponseBody.message == pdfCreateConstant.errorMessages.invalidWsKey 
  
  


