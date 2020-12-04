Feature: MDMS data fetching PreTest

Background: 
	* def jsUtils = read('classpath:jsUtils.js')
		
Scenario: MDMS data fetching PreTest
  * configure headers = read('classpath:websCommonHeaders.js')
  
  Given url mdmsUrl
  And request mdmsRequestBody
  When method post
  Then assert responseStatus == 200
  And def mdmsResponseHeader = responseHeaders
  And def mdmsResponseBody = response
	* eval if (karate.get('mdmsResponseBody') == true) JavaUtils.printResponse("mdmsResponseBody", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)