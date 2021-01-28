Feature: IDGenerate API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def idGenerateRequest = read('../requestPayload/idGenerate/idgenerate.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def expectedMessage1 = read('../constants/idGenerate.yaml')
  * def validFormat = expectedMessage1.parameters.format2
  * def validIdName = expectedMessage1.parameters.idName
  * def invalidTenantId = 'notenant'
  * print tenantId
  * print idGenerateRequest

@success
Scenario: IDGenerate success call

  * set idGenerateRequest.idRequests[0].format = validFormat

  Given url idGenerateUrl 
  And request idGenerateRequest
  When method post
  Then status 200
  And def idGenerateResponseHeader = responseHeaders
  And def idGenerateResponseBody = response


@successWithDifferentIDName
Scenario: IDGenerate success call

  * set idGenerateRequest.idRequests[0].format = validFormat
  * set idGenerateRequest.idRequests[0].idName = validIdName

  Given url idGenerateUrl 
  And request idGenerateRequest
  When method post
  Then status 200
  And def idGenerateResponseHeader = responseHeaders
  And def idGenerateResponseBody = response


@forbidden
Scenario: IDGenerate forbidden call

  * set idGenerateRequest.idRequests[0].format = validFormat
  * set idGenerateRequest.idRequests[0].tenantId = invalidTenantId

  Given url idGenerateUrl 
  And request idGenerateRequest
  When method post
  Then status 403
  And def idGenerateResponseHeader = responseHeaders
  And def idGenerateResponseBody = response


@failed
Scenario: IDGenerate failed call

  Given url idGenerateUrl 
  And request idGenerateRequest
  When method post
  Then status 200
  And def idGenerateResponseHeader = responseHeaders
  And def idGenerateResponseBody = response
