Feature: File store
        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')

        @FileStore_GenerateId_01  @Positive  @fileStore
        Scenario: Upload a document
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')
      * print filecreateResponseBody
      * match filecreateResponseBody == '#present'
        @FileStore_MandatoryCheck_POST_02  @Negative  @fileStore
        Scenario: Test uplaoding without passing tenantid / Module in the form data
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadWithoutTenantIdError')
      * print filecreateResponseBody
      * assert filecreateResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid

        @FileStore_invalidFiles_03  @Negative  @fileStore
        Scenario: Test uploading invalid file format
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadInvalidDocumentError')
      * print filecreateResponseBody
      * print fileStoreConst.errorMessages.invalidFileFormat

        @FileStore_FetchDocPath_05   @Positive  @fileStore
        Scenario: Test to get the documents path
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileIdSuccessfully')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'

        @FileStore_multipledocuments_06  @Positive  @fileStore
        Scenario: Test to fetch path of multiple uploaded document from filestore
      * call read('../../core-services/pretests/fileStoreGet.feature@getMultiFileIdSuccessfully')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'

        @FileStore_NoTenantID_07  @Negative  @fileStore
        Scenario: Test by not passing the tenant Id in the url
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileIdFail')
      * print fileStoreGetResponseBody
      * assert fileStoreGetResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid

        @FileStore_NoFilestoreID_08   @Negative  @fileStore
        Scenario: Test by not passing the filestore Id in the url
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileWithoutFileId')
      * print fileStoreGetResponseBody
      * print fileStoreConst.errorMessages.noFilestoreId
      * print fileStoreGetResponseBody.Errors[0].message
      * assert fileStoreGetResponseBody.Errors[0].message == fileStoreConst.errorMessages.noFilestoreId

        @FileStore_E2E_09   @Positive  @fileStore
        Scenario: Test uplaoding a file and retriving it
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileIdSuccessfully')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'

        @FileStore_noTenantModule_10  @Positive  @fileStore
        Scenario: Test with blank/non-existent tenant/module
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadWithInvalidTenantIdError')
      * print filecreateResponseBody
      * match filecreateResponseBody == '#present'

        @FileStores_MultipleFiles_11  @Positive  @fileStore
        Scenario: Test by uplaoding multiple files at once
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadMultipleDocumentsSuccessfully')
      * print filecreateResponseBody

        @FileStores_LargeFile_12  @Negative  @fileStore_broken_pipe
        Scenario: Test by uploading a large file
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentWithLargeFileError')
      * print filecreateResponseBody