Feature: Filestore Tag API call 
     Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def module = commonConstants.parameters.module[0]
  * def tag = commonConstants.parameters.tag[0]
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')
  
  # calling upload single document file pretest
  * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')


  @getFilestoreTagSuccessfully
  Scenario: get the filestore tag successfull
    * def getFileTagParam = 
    """
      {
        tenantId: '#(tenantId)',
        tag: '#(tag)'
      }
    """
        Given url fileStoreTag
        And params getFileTagParam
        When method get
        Then status 200
        And def fileStoreTagResponseHeader = responseHeaders
        And def fileStoreTagResponseBody = response

  @getFilestoreIncorrectTag
  Scenario: get the filestore incorrect tenantId
  * def getFileTagParam = 
    """
      {
        tag: '#(tag)'
      }
    """
        Given url fileStoreTag
        And params getFileTagParam
        When method get
        Then status 400
        And def fileStoreTagResponseHeader = responseHeaders
        And def fileStoreTagResponseBody = response  

  @getFilestoreIncorrectTagError
  Scenario: get the filestore incorrect tag
  * def getFileTagParam = 
    """
      {
        tenantId: '#(tenantId)'
      }
    """
        Given url fileStoreTag
        And params getFileTagParam
        When method get
        Then status 400
        And def fileStoreTagResponseHeader = responseHeaders
        And def fileStoreTagResponseBody = response    