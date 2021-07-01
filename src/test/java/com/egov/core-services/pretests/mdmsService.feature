Feature: Searchmdms

        Background:
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def searchMdmsPayload = read('../../core-services/requestPayload/mdms-service/searchMdms.json')
  * def searchMdmsConstant = read('../../core-services/constants/searchMdms.yaml')
  * def getMdmsRequest = read('../../core-services/requestPayload/mdms-service/getMdms.json')
  
        @searchMdmsSuccessfully
        Scenario: Search Mdms Successfully
* def mdmsParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
            Given url searchMdmsUrl
              And params mdmsParam
              And request searchMdmsPayload
     
             When method post
             Then status 200
              And def searchMdmsResponseHeader = responseHeaders
              And def searchMdmsResponseBody = response

        @searchMdmsWithInvalidtenantIdError
        Scenario: Search Mdms with invalid tenantId error
* def mdmsParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
            Given url searchMdmsUrl
              And params mdmsParam
              And request searchMdmsPayload
     
             When method post
             Then status 400
              And def searchMdmsResponseHeader = responseHeaders
              And def searchMdmsResponseBody = response

        @searchMdmsWithoutMasterDetailsError
        Scenario: Search Mdms without master details error
* set searchMdmsPayload.MdmsCriteria.moduleDetails[0].masterDetails = null
* def mdmsParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
            Given url searchMdmsUrl
              And params mdmsParam
              And request searchMdmsPayload
     
             When method post
             Then status 400
              And def searchMdmsResponseHeader = responseHeaders
              And def searchMdmsResponseBody = response

        @getMdmsSuccessfully
        Scenario: Get mdms Successfully
            Given url getMdmsUrl
              And params mdmsParam
              And request getMdmsRequest
             When method post
             And  def getMdmsResponseBody = response
             Then status 200

@ErrorInGetMdms
        Scenario: Error In Get mdms
            Given url getMdmsUrl
              And params mdmsParam
              And request getMdmsRequest
             When method post
             And  def getMdmsResponseBody = response
             Then status 400