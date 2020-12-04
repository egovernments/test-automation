Feature: File store get API call

Background:
	* def jsUtils = read('classpath:jsUtils.js')
	
Scenario:
	
  * configure headers = read('classpath:websCommonHeaders.js')
  
  Given url getFileUrl
	And param fileStoreIds = fileStoreId
  When method get
  Then status 200
  And def fileStoreGetResponseHeader = responseHeaders
  And def fileStoreGetResponseBody = response
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("fileStoreGetResponseBody", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)