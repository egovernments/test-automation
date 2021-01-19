Feature: Location

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def locationconstant = read('../constants/location.yaml')

@locationsuccess
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locationparam
     And request location
     When method post
     Then status 200
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationsuccesswithtenantid
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationparam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locationparam
     And request location
     When method post
     Then status 200
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationwithnotenantid
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)'
    }
    """
     Given url searchloc
     And params locationparam
     And request location
     When method post
     Then status 400
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationerror
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationparam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locationparam
     And request location
     When method post
     Then status 400
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody