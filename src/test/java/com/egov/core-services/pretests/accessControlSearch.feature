Feature: Access Control Feature

Background:
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
  * set searchAccessControlRequest.tenantId = accessControlConstants.parameters.invalidTenantId
  * print searchAccessControlRequest
  Given url accessControlSearchUrl 
  And request searchAccessControlRequest
  When method post
  Then status 400
  And def accessControlResponseHeader = responseHeaders
  And def accessControlResponseBody = response