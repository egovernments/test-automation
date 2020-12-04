Feature: FileStore create API call 

Background:
	* def jsUtils = read('classpath:jsUtils.js')
	
Scenario:
	
  * configure headers = read('classpath:websCommonHeaders.js')
  
  Given url createFileUrl
  When method post
  Then request fileStoreRequestBody
  Then status 201
  And def fileStoreCreateResponseHeader = responseHeaders
  And def fileStoreCreateResponseBody = response
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("fileStoreCreate", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
	