Feature: FileStore get API call 
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def uploadfile = call read('../pretests/fileStoreCreate.feature@uploadsuccess')
  * print uploadfile.filecreateResponseBody
  * print uploadfile.filestoreid
  * def uploadMultifile = call read('../pretests/fileStoreCreate.feature@uploaddocssuccess')
  * print uploadMultifile.filecreateResponseBody
  * def getFileIds = uploadMultifile.filecreateResponseBody

@getfileidsuccess
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param tenantId = tenantId
     And param fileStoreIds = uploadfile.filestoreid
     When method get
     Then status 200
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody

@getmultifileidsuccess
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param tenantId = tenantId
     And param fileStoreIds = getFileIds.files[0].fileStoreId,getFileIds.files[1].fileStoreId
     When method get
     Then status 200
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody


@getfileidfail
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param fileStoreIds = uploadfile.filestoreid
     When method get
     Then status 400
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody

@nofileid
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param tenantId = tenantId
     When method get
     Then status 400
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody
