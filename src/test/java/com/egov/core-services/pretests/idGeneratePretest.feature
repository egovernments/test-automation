Feature: IDGenerate API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def idGenerateRequest = read('../requestPayload/idGenerate/idgenerate.json')
  * configure headers = read('classpath:websCommonHeaders.js')


@success
Scenario: IDGenerate success call

  Given url idGenerateUrl 
  And request idGenerateRequest
  When method post
  Then status 200
  And def idGenerateResponseHeader = responseHeaders
  And def idGenerateResponseBody = response


@error
Scenario: IDGenerate error call

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
