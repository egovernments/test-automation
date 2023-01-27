Feature: Filestore Tag API call 
     Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def fileContentTypeHeader = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'
  * def fileContentType = 'application/pdf'
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def module = commonConstants.parameters.module[0]
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')
  
  # calling upload single document file pretest
  * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')
  
  * def getFileId = filecreateResponseBody.files[0].fileStoreId

  @getFilestoreTagSuccessfully
  Scenario: get the filestore tag successfull
  * def getFileIdParam = 
  """
  
  {
    tenantId: '#(tenantId)',
    tag: '#(tag)'
  }
  
  """
        Given url fileStoreTag
        And param getFileIdParam
        When method get
        Then status 200
        And def fileStoreTagResponseHeader = responseHeaders
        And def fileStoreTagResponseBody = response

  @getFilestoreIncorrectTag
  Scenario: get the filestore incorrect tag
  * def getFileIdParam = 
  """
  
  {
    tenantId: '#(tenantId)',
    tag: '#(tag)'
  }
  
  """
        Given url fileStoreTag
        And param getFileIdParam
        When method get
        Then status 400
        And def fileStoreTagResponseHeader = responseHeaders
        And def fileStoreTagResponseBody = response      