Feature: FileStore get API call
        Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  # calling upload single document file pretest
  * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')
  
  * def getFileId = filecreateResponseBody.files[0].fileStoreId
  # calling upload multiple document files pretest
  * call read('../../core-services/pretests/fileStoreCreate.feature@uploadMultipleDocumentsSuccessfully')
  * def getFileIdsFirst = filecreateResponseBody.files[0].fileStoreId
  * def getFileIdsSecond = filecreateResponseBody.files[1].fileStoreId
  * def getFileIds = getFileIdsFirst + ',' + getFileIdsSecond
  
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
