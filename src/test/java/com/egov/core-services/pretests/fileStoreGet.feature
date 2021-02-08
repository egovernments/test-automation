Feature: FileStore get API call
        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')
  * print filecreateResponseBody
  * def getFileId = filecreateResponseBody.files[0].fileStoreId
  * print getFileId
  * call read('../../core-services/pretests/fileStoreCreate.feature@uploadMultipleDocumentsSuccessfully')
  * print filecreateResponseBody.files[0].fileStoreId, filecreateResponseBody.files[1].fileStoreId
  * def getFileIdsFirst = filecreateResponseBody.files[0].fileStoreId
  * print getFileIdsFirst
  * def getFileIdsSecond = filecreateResponseBody.files[1].fileStoreId
  * print getFileIdsSecond
  * def getFileIds = getFileIdsFirst + ',' + getFileIdsSecond
  * print getFileIds

        @getFileIdSuccessfully
        Scenario: get the uploaded document id successfully
  * def getFileIdParam = 
    """
    {
       tenantId: '#(tenantId)',
       fileStoreIds: '#(getFileId)'
    }
    """
            Given url fileStoreGet
              And params getFileIdParam
             When method get
             Then status 200
              And def fileStoreGetResponseHeader = responseHeaders
              And def fileStoreGetResponseBody = response
    * print fileStoreGetResponseBody

        @getMultiFileIdSuccessfully
        Scenario: get the uploaded multiple document ids successfully
  * def getMultiFileIdParam = 
    """
    {
       tenantId: '#(tenantId)',
       fileStoreIds: '#(getFileIds)'
    }
    """
            Given url fileStoreGet
              And params getMultiFileIdParam
             When method get
             Then status 200
              And def fileStoreGetResponseHeader = responseHeaders
              And def fileStoreGetResponseBody = response
     * print fileStoreGetResponseBody


        @getFileIdFail
        Scenario: get document id error
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

        @getFileWithoutFileId
        Scenario: get the document without document id
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
