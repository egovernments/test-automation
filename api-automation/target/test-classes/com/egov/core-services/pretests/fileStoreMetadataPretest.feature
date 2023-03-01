Feature: Filestore Metadata API call 
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

    @getFilestoreMetadataSuccessfully
    Scenario: get the filestore metadata successfully
    * def getFileIdParam = 
    """
    {
        tenantId: '#(tenantId)',
        fileStoreIds: '#(fileStoreId)'
    }
    
    """
    Given url fileStoreMetadata 
    And params getFileIdParam
    When method get
    Then status 200
    And def fileStoreMetadataResponseHeader = responseHeaders
    And def fileStoreMetadataResponseBody = response

    @getFilestoreMetadataInvalidTenantId
    Scenario: get the filestore metadata error
    * def getFileIdParam = 
    """
    {
        tenantId: '#(tenantId)',
        fileStoreIds: '#(getFileIds)'
    }
    """
    Given url fileStoreMetadata 
    And params getFileIdParam
    When method get
    Then status 400
    And def fileStoreMetadataResponseHeader = responseHeaders
    And def fileStoreMetadataResponseBody = response