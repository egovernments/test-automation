Feature: File store
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')

  @FileStore_GenerateId_01  @regression @positive  @fileStore
  Scenario: Upload a document
      # Calling upload document pretest
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')
      
      * match filecreateResponseBody == '#present'
  @FileStore_MandatoryCheck_POST_02  @regression @negative  @fileStore
  Scenario: Test uplaoding without passing tenantid / Module in the form data
      # Calling upload document pretest
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadWithoutTenantIdError')
      
      * assert filecreateResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid

  @FileStore_invalidFiles_03  @regression @negative  @fileStore
  Scenario: Test uploading invalid file format
      # Calling upload document pretest
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadInvalidDocumentError')

  @FileStore_FetchDocPath_05   @regression @positive  @fileStore
  Scenario: Test to get the documents path
      # Calling get document file id pretest
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileIdSuccessfully')
      
      * match fileStoreGetResponseBody == '#present'

  @FileStore_multipledocuments_06  @regression @positive  @fileStore
  Scenario: Test to fetch path of multiple uploaded document from filestore
      # Calling get document file id pretest
      * call read('../../core-services/pretests/fileStoreGet.feature@getMultiFileIdSuccessfully')
      
      * match fileStoreGetResponseBody == '#present'

  @FileStore_NoTenantID_07  @regression @negative  @fileStore
  Scenario: Test by not passing the tenant Id in the url
      # Calling get document file id pretest
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileIdFail')
      
      * assert fileStoreGetResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid

  @FileStore_NoFilestoreID_08   @regression @negative  @fileStore
  Scenario: Test by not passing the filestore Id in the url
      # Calling get document file id pretest
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileWithoutFileId')
      * assert fileStoreGetResponseBody.Errors[0].message == fileStoreConst.errorMessages.noFilestoreId

  @FileStore_E2E_09   @regression @positive  @fileStore
  Scenario: Test uplaoding a file and retriving it
      # Calling get document file id pretest
      * call read('../../core-services/pretests/fileStoreGet.feature@getFileIdSuccessfully')
      
      * match fileStoreGetResponseBody == '#present'

  @FileStore_noTenantModule_10  @regression @positive  @fileStore
  Scenario: Test with blank/non-existent tenant/module
      # Calling upload document pretest
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadWithInvalidTenantIdError')
      
      * match filecreateResponseBody == '#present'

  @FileStores_MultipleFiles_11  @regression @positive  @fileStore
  Scenario: Test by uplaoding multiple files at once
      # Calling upload document pretest
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadMultipleDocumentsSuccessfully')
      

  @FileStores_LargeFile_12  @regression @negative  @fileStore_broken_pipe
  Scenario: Test by uploading a large file
      # Calling upload document pretest
      * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentWithLargeFileError')
      