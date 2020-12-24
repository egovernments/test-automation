Feature: Location

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def locconst = read('../constants/location.yaml')

@locationsuccess
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locparam
     And request location
     When method post
     Then status 200
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationsuccesswithtenantid
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locparam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locparam
     And request location
     When method post
     Then status 200
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationwithnotenantid
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)'
    }
    """
     Given url searchloc
     And params locparam
     And request location
     When method post
     Then status 400
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationerror
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locparam
     And request location
     When method post
     Then status 400
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationerrorinvldendpoint
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
* def invalidEndpoint = locconst.parameters.invldEndpoint
    
      * def locparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url invalidEndpoint
     And params locparam
     And request location
     When method post
     Then status 403
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody