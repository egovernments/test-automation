Feature: File store
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def fileStoreConst = read('../constants/fileStore.yaml')

@FileStore_GenerateId_01  @Positive  @Filestore
Scenario: Upload a document
      * def module = fileStoreConst.parameters.module
      * call read('../pretests/fileStoreCreate.feature@uploadsuccess')
      * print filecreateResponseBody
      * match filecreateResponseBody == '#present'

      
@FileStore_MandatoryCheck_POST_02  @Negative  @Filestore
Scenario: Test uplaoding without passing tenantid / Module in the form data
      * call read('../pretests/fileStoreCreate.feature@uploadnotenantidfail')
      * print filecreateResponseBody
      * assert filecreateResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid

@FileStore_invalidFiles_03  @Negative  @Filestore
Scenario: Test uploading invalid file format
      * call read('../pretests/fileStoreCreate.feature@uploadinvlddocfail')
      * print filecreateResponseBody
     # * assert filecreateResponseBody.Errors[0].message == fileStoreConst.errorMessages.invalidFileFormat

@FileStore_WithoutUploading_04  @500
Scenario: Test without uplaoding any file when 'file' is selected
      * call read('../pretests/fileStoreCreate.feature')

@FileStore_FetchDocPath_05   @Positive  @Filestore
Scenario: Test to get the documents pat
      * call read('../pretests/fileStoreGet.feature@getfileidsuccess')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'

@FileStore_multipledocuments_06  @Positive  @Filestore  
Scenario: Test to fetch path of multiple uploaded document from filestore
      * call read('../pretests/fileStoreCreate.feature@getmultifileidsuccess')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'

@FileStore_NoTenantID_07   @Negative  @Filestore
Scenario: Test by not passing the tenant Id in the url
      * call read('../pretests/fileStoreGet.feature@getfileidfail')
      * print fileStoreGetResponseBody
      * assert fileStoreGetResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid

@FileStore_NoFilestoreID_08   @Negative  @Filestore
Scenario: Test by not passing the filestore Id in the url
      * call read('../pretests/fileStoreGet.feature@getfileidfail')
      * print fileStoreGetResponseBody
      * assert fileStoreGetResponseBody.Errors[0].message == fileStoreConst.errorMessages.noFilestoreId


@FileStore_E2E_09   @Positive @Filestore
Scenario: Test uplaoding a file and retriving it
      * call read('../pretests/fileStoreGet.feature@getfileidsuccess')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'


@FileStore_noTenantModule_10  @Positive  @Filestore
Scenario: Test with blank/non-existent tenant/module
      * call read('../pretests/fileStoreCreate.feature@invldtenantid')
      * print filecreateResponseBody
      * match filecreateResponseBody == '#present'

@FileStores_MultipleFiles_11  @Positive  @Filestore
Scenario: Test by uplaoding multiple files at once
      * call read('../pretests/fileStoreCreate.feature@uploaddocssuccess')
      * print filecreateResponseBody

@FileStores_LargeFile_12  @Negative  @Filestore
Scenario: Test by uploading a large file
      * call read('../pretests/fileStoreCreate.feature@largefile')
      * print filecreateResponseBody