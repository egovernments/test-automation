Feature: FileStore create API call 
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def test = call read('fileStoreCreate.feature@uploadsuccess')
  * print test.filecreateResponseBody
  * print test.filestoreid
@getfileidsuccess
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param tenantId = 'pb'
     And param fileStoreIds = test.filestoreid
     When method get
     Then status 200
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody

@getfileidfail
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param fileStoreIds = test.filestoreid
     When method get
     Then status 400
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody

@nofileid
Scenario: get the uploaded document id
     Given url fileStoreGet
     And param tenantId = 'pb'
     When method get
     Then status 400
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody
