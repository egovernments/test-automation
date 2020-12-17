Feature: FileStore create API call 
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')


@uploadsuccess
Scenario: Upload a document
   #* def field = 
   # """
   # {
   # }
   # """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/sample.pdf', filename: 'sample.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = '#(tenantId)'
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 201
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody
   * def filestoreid = filecreateResponseBody.files[0].fileStoreId
   * print filestoreid
   

@uploadnotenantidfail
Scenario: Upload a document 
   
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/sample.pdf', filename: 'sample.pdf', contentType: 'application/pdf'}
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 400
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response

@uploadinvlddocfail
Scenario: Upload a document 
   
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/TestData.rtf', filename: 'sample.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = '#(tenantId)'
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 400
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   
@uploadinvlddocfail
Scenario: Upload a document 
   
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/TestData.rtf', filename: 'sample.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = '#(tenantId)'
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 400
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response

@largefile
Scenario: Upload a document
   #* def field = 
   # """
   # {
   # }
   # """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/Landes - The Wealth and the Poverty of Nations.pdf', filename: 'Landes - The Wealth and the Poverty of Nations.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = '#(tenantId)'
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 201
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody
   * def filestoreid = filecreateResponseBody.files[0].fileStoreId
   * print filestoreid

@invldtenantid
Scenario: Upload a document
   #* def field = 
   # """
   # {
   # }
   # """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/sample.pdf', filename: 'sample.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = '123'
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 201
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody
   * def filestoreid = filecreateResponseBody.files[0].fileStoreId
   * print filestoreid
