Feature: Localization Messages API call 

Background:
	* def jsUtils = read('classpath:jsUtils.js')
  
  
	
@upsert_200  
Scenario: Upsert with 200
	
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
	
	# calling localization Json
  * def upsertRequest = read('classpath:requestJson/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest
  
  Given url upsertUrl
  And request upsertRequest[0]
  When method post
  Then status 200
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("upsertResponseBody", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
	* def upsertedMessage = karate.jsonPath(upsertResponseBody,"$..code")[0]
	* match karate.jsonPath(upsertResponseBody,"$.messages[*].locale") ==  '#present'
	* match upsertResponseBody.messages ==  upsertRequest.messages

@upsert_500
Scenario: Upsert with 500

	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
	
	# calling localization Json
  * def upsertRequest = read('classpath:requestJson/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest
  
  Given url upsertUrl
  And request upsertRequest[0]
  When method post
  Then status 500
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("upsertResponseBody", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
	
@upsert_400
Scenario: Upsert with 400
  
   # calling localization Json
  * def upsertRequest = read('classpath:requestJson/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest
  
  Given url upsertUrl
  And request upsertRequest[index]
  When method post
  Then status 400
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("upsertResponseBody", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)

  * def upsertRequest = read('classpath:requestJson/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest
  

  @upsert_403
  Scenario: Upsert with 403
  
   # calling localization Json
  * def upsertRequest = read('classpath:requestJson/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest

  Given url upsertUrl
  And request upsertRequest[index]
  When method post
  Then status 403
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("upsertResponseBody", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)