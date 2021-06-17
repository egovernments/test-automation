Feature: FileStore create API call
        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # initializing the headers, form-data and other variables required for file upload
  * def fileContentTypeHeader = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'
  * def fileContentType = 'application/pdf'
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def module = commonConstants.parameters.module[0]
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')
  * def testData = '../../common-services/testData/dummyTestData.rtf'
  * def testData1 = '../../common-services/testData/dummyTestData1.pdf'
  * def testData2 = '../../common-services/testData/dummyTestData2.pdf'
  * def testData3 = '../../common-services/testData/dummyTestData3.pdf'
  * def filetestData = 'dummyTestData.rtf'
  * def filetestData1 = 'dummyTestData1.pdf'
  * def filetestData2 = 'dummyTestData2.pdf'
  * configure ssl = false

        @uploadDocumentsSuccessfully
        Scenario: Upload document successfully
            Given url fileStoreCreate
              And multipart file file = {read: '#(testData3)' , filename: '#(filetestData3)', contentType: '#(fileContentType)'}
              And multipart field tenantId = tenantId
              And multipart field module = module
              And header Content-Type = fileContentTypeHeader
             When method post
             Then status 201
              And def filecreateResponseHeader = responseHeaders
              And def filecreateResponseBody = response

        @uploadMultipleDocumentsSuccessfully
        Scenario: Upload multiple documents successfully
   
            Given url fileStoreCreate
              And multipart file file = { read: '#(testData3)', filename: '#(filetestData3)', contentType: '#(fileContentType)' }
              And multipart file file = { read: '#(testData2)', filename: '#(filetestData2)', contentType: '#(fileContentType)' }
              And multipart field tenantId = tenantId
              And multipart field module = module
              And header Content-Type = fileContentTypeHeader
             When method post
             Then status 201
              And def filecreateResponseHeader = responseHeaders
              And def filecreateResponseBody = response
   

        @uploadWithoutTenantIdError
        Scenario: Upload a document without tenantId
            Given url fileStoreCreate
              And multipart file file = {read: '#(testData3)', filename: '#(filetestData3)', contentType: '#(fileContentType)'}
              And multipart field module = module
              And header Content-Type = fileContentTypeHeader
             When method post
             Then status 400
              And def filecreateResponseHeader = responseHeaders
              And def filecreateResponseBody = response

        @uploadInvalidDocumentError
        Scenario: Upload invalid document
            Given url fileStoreCreate
              And multipart file file = {read: '#(testData)', filename: '#(filetestData)', contentType: '#(fileContentType)'}
              And multipart field tenantId = tenantId
              And multipart field module = module
              And header Content-Type = fileContentTypeHeader
             When method post
             Then status 400
              And def filecreateResponseHeader = responseHeaders
              And def filecreateResponseBody = response
   
        @uploadDocumentWithLargeFileError
        Scenario: Upload a document with large file
            Given url fileStoreCreate
              And multipart file file = {read: '#(testData1)', filename: '#(filetestData1)', contentType: '#(fileContentType)'}
              And multipart field tenantId = tenantId
              And multipart field module = module
              And header Content-Type = fileContentTypeHeader
             When method post
             Then status 413
              And def filecreateResponseHeader = responseHeaders
              And def filecreateResponseBody = response
   
   

        @uploadWithInvalidTenantIdError
        Scenario: Upload a document
            Given url fileStoreCreate
              And multipart file file = {read: '#(testData3)', filename: '#(filetestData3)', contentType: '#(fileContentType)'}
              And multipart field tenantId = invalidTenantId
              And multipart field module = module
              And header Content-Type = fileContentTypeHeader
             When method post
             Then status 201
              And def filecreateResponseHeader = responseHeaders
              And def filecreateResponseBody = response
   
