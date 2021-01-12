Feature: Searchmdms

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def searchMdmsPayload = read('../requestPayload/mdmsService/searchMdms.json')
  * def searchMdmsConstant = read('../constants/searchMdms.yaml')
  
@searchmdms
Scenario: Test to search data for a particular module and tenant
* configure headers = read('classpath:websCommonHeaders.js')
* def mdmsparam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """

     Given url searchMdmsUrl
     * print searchMdmsUrl
     And params mdmsparam
     * print mdmsparam
     And request searchMdmsPayload
     * print searchMdmsPayload
     When method post
     Then status 200
     And def searchMdmsResponseHeader = responseHeaders
     And def searchMdmsResponseBody = response


@searchmdmsinvalidtenant
Scenario: Test to search data for a particular module and tenant
* configure headers = read('classpath:websCommonHeaders.js')
* def mdmsparam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """

     Given url searchMdmsUrl
     * print searchMdmsUrl
     And params mdmsparam
     * print mdmsparam
     And request searchMdmsPayload
     * print searchMdmsPayload
     When method post
     Then status 400
     And def searchMdmsResponseHeader = responseHeaders
     And def searchMdmsResponseBody = response
     

@mdmsinvalidurl
Scenario: Test to search data for a particular module and tenant
* configure headers = read('classpath:websCommonHeaders.js')
* def mdmsparam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """

     Given url invalidSearchMdms
     * print invalidSearchMdms
     And params mdmsparam
     * print mdmsparam
     And request searchMdmsPayload
     * print searchMdmsPayload
     When method post
     Then status 403
     And def searchMdmsResponseHeader = responseHeaders
     And def searchMdmsResponseBody = response
