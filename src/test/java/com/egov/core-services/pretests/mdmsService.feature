Feature: Searchmdms

Background:
  * configure headers = read('classpath:websCommonHeaders.js')
  * def jsUtils = read('classpath:jsUtils.js')
  * def searchMdmsPayload = read('../../core-services/requestPayload/mdmsService/searchMdms.json')
  * def searchMdmsConstant = read('../../core-services/constants/searchMdms.yaml')
  * def getMdmsRequest = read('../../core-services/requestPayload/mdmsService/getMdms.json')
  
@searchmdms
Scenario: Test to search data for a particular module and tenant
* def mdmsParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
     Given url searchMdmsUrl
     * print searchMdmsUrl
     And params mdmsParam
     * print mdmsParam
     And request searchMdmsPayload
     * print searchMdmsPayload
     When method post
     Then status 200
     And def searchMdmsResponseHeader = responseHeaders
     And def searchMdmsResponseBody = response

@searchmdmsinvalidtenant
Scenario: Test to search data for a particular module and tenant
* def mdmsParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
     Given url searchMdmsUrl
     * print searchMdmsUrl
     And params mdmsParam
     * print mdmsParam
     And request searchMdmsPayload
     * print searchMdmsPayload
     When method post
     Then status 400
     And def searchMdmsResponseHeader = responseHeaders
     And def searchMdmsResponseBody = response

@searchmdmswithoutmasterdetails
Scenario: Test to search data for a particular module and tenant
* set searchMdmsPayload.MdmsCriteria.moduleDetails[0].masterDetails = null
* def mdmsParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
     Given url searchMdmsUrl
     * print searchMdmsUrl
     And params mdmsParam
     * print mdmsParam
     And request searchMdmsPayload
     * print searchMdmsPayload
     When method post
     Then status 400
     And def searchMdmsResponseHeader = responseHeaders
     And def searchMdmsResponseBody = response

@getMdmsService
Scenario: Get mdms service details based upon customized parameters
     * def getmdmsUrl = 'https://egov-micro-uat.egovernments.org/egov-mdms-service/v1/_get'
     Given url getmdmsUrl
     * print getmdmsUrl
     And params mdmsParam
     * print mdmsParam
     And request getMdmsRequest
     * karate.log(getMdmsRequest)
     When method post
     Then assert responseStatus == 200 || responseStatus == 400
     And  def getMdmsResponseBody = response