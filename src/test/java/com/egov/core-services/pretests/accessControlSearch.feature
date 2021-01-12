Feature: Access Control Feature

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def accessControlConstants = read('../constants/accessControl.yaml')
  * def searchAccessControlRequest = read('../requestPayload/accessControl/search.json')
  
@success_search
Scenario: Access Control search success call
  * print searchAccessControlRequest
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 200
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response

@error_search
Scenario: Access Control search error call
  * print searchAccessControlRequest
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 400
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response

@error_search_invalid_tenant
Scenario: Access Control search error call with invalid tenantId
  * set searchAccessControlRequest.tenantId = "abc"
  * print searchAccessControlRequest
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 400
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response

@error_search_invalid_authToken
Scenario: Access Control search error call with invalid authToken
  * set searchAccessControlRequest.RequestInfo.authToken = "abc"
  * print searchAccessControlRequest
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 500
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response

@error_search_invalid_method
Scenario: Access Control search error call with invalid search method
  * print searchAccessControlRequest
  Given url accessControlInvalidSearchMethodUrl
  And request searchAccessControlRequest
  When method post
  Then status 403
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response
