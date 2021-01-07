Feature: FileStore get API call 
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')

@getfileidsuccess
Scenario: get the uploaded document id
  * def uploadfile = call read('../pretests/fileStoreCreate.feature@uploadsuccess')
  * print uploadfile.filecreateResponseBody
  * def getFileId = uploadfile.filecreateResponseBody.files[0].fileStoreId
  * print getFileId
  * def getFileIdParam = 
    """
    {
       tenantId: '#(tenantId)',
       fileStoreIds: '#(getFileId)'
    }
    """
     Given url fileStoreGet
     * print fileStoreGet
     And params getFileIdParam
     * print getFileIdParam
     When method get
     Then status 200
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody

@getmultifileidsuccess
Scenario: get the uploaded document id
  * def uploadMultifile = call read('../pretests/fileStoreCreate.feature@uploaddocssuccess')
  * print uploadMultifile.filecreateResponseBody.files[0].fileStoreId, uploadMultifile.filecreateResponseBody.files[1].fileStoreId
  * def getFileIdsFirst = uploadMultifile.filecreateResponseBody.files[0].fileStoreId
  * def getFileIdsSecond = uploadMultifile.filecreateResponseBody.files[1].fileStoreId
  * print getFileIdsFirst
  * print getFileIdsSecond
  * def getMultiFileIdParam = 
    """
    {
       tenantId: '#(tenantId)',
       fileStoreIds: '#(getFileIdsFirst , getFileIdsSecond )'
    }
    """
     Given url fileStoreGet
     * print fileStoreGet
     And params getMultiFileIdParam
     * print getMultiFileIdParam
     When method get
     Then status 200
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody


@getfileidfail
Scenario: get the uploaded document id
  * def uploadfile = call read('../pretests/fileStoreCreate.feature@uploadsuccess')
  * print uploadfile.filecreateResponseBody
  * def getFileId = uploadfile.filecreateResponseBody.files[0].fileStoreId
  * print getFileId
  * def getFileIdParam = 
    """
    {
       fileStoreIds: '#(getFileId)'
    }
    """
     Given url fileStoreGet
     And params getFileIdParam
     When method get
     Then status 400
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody

@nofileid
Scenario: get the uploaded document id
  * def uploadfile = call read('../pretests/fileStoreCreate.feature@uploadsuccess')
  * print uploadfile.filecreateResponseBody
  * def getFileId = uploadfile.filecreateResponseBody.files[0].fileStoreId
  * print getFileId
  * def getFileIdParam = 
    """
    {
       tenantId: '#(tenantId)'
    }
    """
     Given url fileStoreGet
     And params getFileIdParam
     When method get
     Then status 400
     And def fileStoreGetResponseHeader = responseHeaders
     And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody
