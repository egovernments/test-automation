Feature: Searcher API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def searcherRequest = read('../requestPayload/searcher/searcher.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print searcherRequest


@success
Scenario: Searcher success call

  Given url searcherUrl 
  And request searcherRequest
  When method post
  Then status 200
  And def searcherResponseHeader = responseHeaders
  And def searcherResponseBody = response

@error
Scenario: Searcher error call

  Given url searcherUrl 
  And request searcherRequest
  When method post
  Then status 403
  And def searcherResponseHeader = responseHeaders
  And def searcherResponseBody = response

@error_invalidSearcher
Scenario: Searcher error call

  Given url invalidSearcher 
  And request searcherRequest
  When method post
  Then status 403
  And def searcherResponseHeader = responseHeaders
  And def searcherResponseBody = response
  


@error_notenant
Scenario: Searcher Tenanterror call

  Given url searcherWSUrl 
  And request searcherRequest
  When method post
  Then status 400
  And def searcherResponseHeader = responseHeaders
  And def searcherResponseBody = response