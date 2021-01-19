Feature: FileStore create API call 
Background:
  * def jsUtils = read('classpath:jsUtils.js')

@uploadsuccess
Scenario: Upload a document
   * def filestoreparam = 
    """
    {
       tenantId: '#(tenantId)',
       module: '#(module)'
    }
    """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/dummyTestData3.pdf', filename: 'dummyTestData3.pdf', contentType: 'application/pdf'}
   And params filestoreparam
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 201
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody

 @uploaddocssuccess
Scenario: Upload a document
   
   Given url fileStoreCreate   
   And multipart file file = { read: '../testData/dummyTestData3.pdf', filename: 'dummyTestData3.pdf', contentType: 'application/pdf' }
   And multipart file file = { read: '../testData/dummyTestData2.pdf', filename: 'dummyTestData2.pdf', contentType: 'application/pdf' }
   And multipart field tenantId = tenantId
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 201
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody

@uploadnotenantidfail
Scenario: Upload a document 
   * def filestoreparam = 
    """
    {
       module: '#(module)'
    }
    """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/dummyTestData3.pdf', filename: 'dummyTestData3.pdf', contentType: 'application/pdf'}
   And params filestoreparam
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 400
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response

@uploadinvlddocfail
Scenario: Upload a document 
   * def filestoreparam = 
   
   """
    {
       tenantId: '#(tenantId)',
       module: '#(module)'
    }
    """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/dummyTestData.rtf', filename: 'dummyTestData.rtf', contentType: 'application/pdf'}
   And params filestoreparam
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 400
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   
@uploadinvldtenantidfail
Scenario: Upload a document 
    """
    {
       tenantId: '#(tenantId)',
       module: '#(module)'
    }
    """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/dummyTestData3.pdf', filename: 'dummyTestData3.pdf', contentType: 'application/pdf'}
   And params filestoreparam
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 400
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response

@largefile
Scenario: Upload a document
   
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/dummyTestData1.pdf', filename: 'dummyTestData1.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = tenantId
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 413
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody
   

@invldtenantid
Scenario: Upload a document
   #* def field = 
   # """
   # {
   # }
   # """
   Given url fileStoreCreate   
   And multipart file file = {read: '../testData/dummyTestData3.pdf', filename: 'dummyTestData3.pdf', contentType: 'application/pdf'}
   And multipart field tenantId = '123'
   And multipart field module = 'fire-noc'
   And header Content-Type = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'   
   When method post
   Then status 201
   And def filecreateResponseHeader = responseHeaders
   And def filecreateResponseBody = response
   * print filecreateResponseBody
