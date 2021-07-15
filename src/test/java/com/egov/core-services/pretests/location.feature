Feature: Location

        Background:
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def locationconstant = read('../../core-services/constants/location.yaml')
  * def locationPayload = read('../../core-services/requestPayload/location/searchLocation.json')

        @searchLocationSuccessfully
        Scenario: search for location detail successfully
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
              And request locationPayload
             When method post
             Then status 200
              And def searchLocationResponseHeader = responseHeaders
              And def searchLocationResponseBody = response

        @searchLocationSuccessfulyWithOnlyTenantId
        Scenario: search for location detail with only tenantId successfully
   * def locationParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
            Given url searchloc
              And params locationParam
              And request locationPayload
             When method post
             Then status 200
              And def searchLocationResponseHeader = responseHeaders
              And def searchLocationResponseBody = response
     

        @searchLocationWithoutTenantIdError
        Scenario: search for location detail without tenantId error
  * def locationParam = 
    """
    {
     hierarchyTypeCode: '#(hierarchyTypeCode)',
     boundaryType: '#(boundaryType)'
    }
    """
            Given url searchloc
              And params locationParam
              And request locationPayload
             When method post
             Then status 400
              And def searchLocationResponseHeader = responseHeaders
              And def searchLocationResponseBody = response
     

        @searchLocationError
        Scenario: search for location detail error
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
              And request locationPayload
             When method post
             Then status 400
              And def searchLocationResponseHeader = responseHeaders
              And def searchLocationResponseBody = response
     