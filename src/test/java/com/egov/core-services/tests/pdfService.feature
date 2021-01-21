Feature: pdf service
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../pretests/authenticationToken.feature')
  * def pdfCreateConstant = read('../constants/pdfService.yaml')
  * def key = pdfCreateConstant.parameters.create.valid.key

@pdf_create_PT_01  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Property Tax  module  
  * call read('../pretests/pdfServiceCreate.feature@pdfcreateforptsuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present'

@pdf_create_PT_FS_02  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the PT API call for PDF generation service
  * call read('../pretests/pdfServiceCreate.feature@pdfcreateforptsuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'

@pdf_create_TL_03  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Trade License  module 
  * call read('../pretests/pdfServiceCreate.feature@pdfcreatesuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present'

@pdf_create_TL_FS_04  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the TL API call for PDF generation service
  * call read('../pretests/pdfServiceCreate.feature@pdfcreatesuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'

@pdf_create_Fire_05  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for Fire NOC module
  * call read('../pretests/pdfServiceCreate.feature@pdfcreateforfirenocsuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present' 

@pdf_create_Fire_FS_06  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the FireNOC API call for PDF generation service
  * call read('../pretests/pdfServiceCreate.feature@pdfcreateforfirenocsuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'

@pdf_create_WS_05  @positive  @pdfservice
Scenario: Verify a pdf is generated successfully for water & Severage module
  * call read('../pretests/pdfServiceCreate.feature@pdfcreateforwssuccess')
  * print pdfCreateResponseBody
  * match pdfCreateResponseBody == '#present'  

@pdf_create_WS_FS_07  @positive  @pdfservice
Scenario: Verify the FileStore ID is created in the Response for the WnS API call for PDF generation service
  * call read('../pretests/pdfServiceCreate.feature@pdfcreateforwssuccess')
  * print pdfCreateResponseBody
  * print pdfCreateResponseBody.filestoreIds[0]
  * match pdfCreateResponseBody.filestoreIds[0] == '#present'

@pdf_create_inavlid_tenantid_08  @negative  @pdfservice
Scenario: "Verify generating PDF without tenant id and check for errors(all the modules)" 
  * call read('../pretests/pdfServiceCreate.feature@pdfcreatewithouttenantid')
  * print pdfCreateResponseBody

@pdf_create_invalid_key_09  @negative  @pdfservice
Scenario: "Verify generating PDF invalid/nonexistant or by not passing key and check for errors(all the modules)"
  * def key = pdfCreateConstant.parameters.create.invalid.key
  * call read('../pretests/pdfServiceCreate.feature@pdfcreatefail')
  * print pdfCreateResponseBody


