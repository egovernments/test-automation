Feature: Access Control Feature

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def accessControlConstants = read('../../core-services/constants/accessControl.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def searchAccessControlRequest = read('../../core-services/requestPayload/accessControl/search.json')
  
@successSearch
Scenario: Access Control search success call
  * print searchAccessControlRequest
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 200
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response

@errorSearch
Scenario: Access Control search error call
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 400
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response

@errorSearchInvalidTenant
Scenario: Access Control search error call with invalid tenantId
  * eval searchAccessControlRequest.tenantId = 'INVALID-' + ranString(10)
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 400
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response