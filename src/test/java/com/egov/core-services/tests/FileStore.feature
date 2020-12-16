Feature: File store
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def expectedMsg = read('../constants/fileStore.yaml')

@FileStore_GenerateId_01  @positive
Scenario: Upload a document
      * call read('../pretests/fileStoreCreate.feature@uploadsuccess')
      * print filecreateResponseBody
      * match karate.jsonPath(filecreateResponseBody, "$.fileStoreIds[?(@.id=='"+ fileStoreId +"')]") == '#present' 

@FileStore_MandatoryCheck_POST_02  @negative
Scenario: Test uplaoding without passing tenantid / Module in the form data
      * call read('../pretests/fileStoreCreate.feature@uploadnotenantidfail')
      * print filecreateResponseBody
      * assert filecreateResponseBody.Errors[0].message == expectedMsg.errorMessages.noTenantid

@FileStore_invalidFiles_03   @negative
Scenario: Test uploading invalid file format
      * call read('../pretests/fileStoreCreate.feature@uploadinvlddocfail
      * print filecreateResponseBody
      * assert filecreateResponseBody.Errors[0].message == expectedMsg.errorMessages.invalidFileFormat




@FileStore_WithoutUploading_04   @negative
Scenario: Test without uplaoding any file when 'file' is selected


@FileStore_FetchDocPath_05   @positive
Scenario: Test to get the documents pat
      * call read('../pretests/fileStoreGet.feature@getfileidsuccess')
      * print fileStoreGetResponseBody
      * match fileStoreGetResponseBody == '#present'



@FileStore_multipledocuments_06   @positive
Scenario: Test to fetch path of multiple uploaded document from filestore


@FileStore_NoTenantID_07   @negative
Scenario: Test by not passing the tenant Id in the url
      * call read('../pretests/fileStoreGet.feature@getfileidfail')
      * print fileStoreGetResponseBody
      * assert fileStoreGetResponseBody.Errors[0].message == expectedMsg.errorMessages.noTenantid

@FileStore_NoFilestoreID_08   @negative
Scenario: Test by not passing the filestore Id in the url
      * call read('../pretests/fileStoreGet.feature@getfileidfail')
      * print fileStoreGetResponseBody
      * assert fileStoreGetResponseBody.Errors[0].message == expectedMsg.errorMessages.noTenantid


@FileStore_E2E_09   @positive
Scenario: Test uplaoding a file and retriving it
     * call read('../pretests/fileStoreGet.feature@getfileidsuccess')
     * match fileStoreGetResponseBody == '#present'


@FileStore_noTenantModule_10  @positive
Scenario: Test with blank/non-existent tenant/module
      * call read('../pretests/fileStoreCreate.feature@uploadnotenantidfail')
      * print filecreateResponseBody
      * assert filecreateResponseBody.Errors[0].message == expectedMsg.errorMessages.noTenantid

@FileStores_MultipleFiles_11   @positive
Scenario: Test by uplaoding multiple files at once


@FileStores_LargeFile_12   @negative
Scenario: Test by uploading a large file
      * call read('../pretests/fileStoreCreate.feature@largefile')
      * print filecreateResponseBody