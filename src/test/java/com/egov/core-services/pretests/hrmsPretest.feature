Feature: HRMS API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def createRequest = read('../requestPayload/hrms/create.json')
  * def searchRequest = read('../requestPayload/hrms/search.json')
  * def updateRequest = read('../requestPayload/hrms/update.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def expectedMessage1 = read('../constants/hrms.yaml')
  * def invalidTenantId = 'notenant'
  * print tenantId
  * print createRequest


@success_Create
Scenario: hrms_Create success call

  Given url hrmsCreateUrl 
  And request createRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@error_Create
Scenario: hrms_Create success call

  Given url hrmsCreateUrl 
  And request createRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorAuth_Create
Scenario: hrms_Create success call

  Given url hrmsCreateUrl 
  And request createRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@success_Search
Scenario: hrms_Search success call


  Given url hrmsSearchUrl 
  And param codes = '#(code)'
  And request searchRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@success_MultiSearch
Scenario: hrms_Search success call

  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     codes: '#(code)'
    }
    """
  Given url hrmsSearchUrl 
  And params parameters
  And request searchRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response



@error_Search
Scenario: hrms_Search error call
  
  Given url hrmsSearchUrl 
  And param names = '#(name)'
  And request searchRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@errorAuth_Search
Scenario: hrms_Search error call
  
  Given url hrmsSearchUrl
  And param tenantId = '#(tenantId)' 
  And request searchRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

