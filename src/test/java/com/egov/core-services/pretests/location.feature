Feature: Location

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def locationconstant = read('../constants/location.yaml')

@locationsuccess
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationParam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locationParam
     And request location
     When method post
     Then status 200
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationsuccesswithtenantid
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locationParam
     And request location
     When method post
     Then status 200
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationwithnotenantid
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationParam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)'
    }
    """
     Given url searchloc
     And params locationParam
     And request location
     When method post
     Then status 400
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody

@locationerror
Scenario: search for location detail
* configure headers = read('classpath:websCommonHeaders.js')
    
      * def locationParam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)',
     tenantId: '#(tenantId)'
    }
    """
     Given url searchloc
     And params locationParam
     And request location
     When method post
     Then status 400
     And def searchLocationResponseHeader = responseHeaders
     And def searchLocationResponseBody = response
     * print searchLocationResponseBody