Feature: Localization Messages API call 

Background:
	* def jsUtils = read('classpath:jsUtils.js')

  	# calling localization Json
  
	#tenantId=pb&locale=
@LocalMsgCall_200
Scenario: Localization Message call
  
  * def localizationSearchRequest = read('classpath:requestJson/localizationMsg.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print tenantIdReq
  * set localizationSearchRequest.tenantId = tenantIdReq
  * print localizationSearchRequest
  * def parameters = 
    """
    {
     locale: '#(locale_value)',
     tenantId: '#(tenant_value)',
     module: '#(module_value)'
    }
    """

  Given url localizationMessagesUrl 
  And params parameters
  And request localizationSearchRequest
  When method post
  Then status 200
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response
#	* eval if (karate.get('printRequestResponse') == true) 
  * eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("eGovRecordCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
 # JavaUtils.printResponse("eGovRecordCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
	* match localizationMessageResponseBody.messages == '#present'


@LocalMsgCall_400
Scenario: Localization Message call 400
  
  * def localizationSearchRequest = read('classpath:requestJson/localizationMsg.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print tenantIdReq
  * set localizationSearchRequest.tenantId = tenantIdReq
  * print localizationSearchRequest

  Given url localizationMessagesUrl + '?' + paramValue
  #And param locale = locale_value
  And request localizationSearchRequest
  When method post
  Then status 400
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response
#	* eval if (karate.get('printRequestResponse') == true) 
 * eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("eGovRecordCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
 # JavaUtils.printResponse("eGovRecordCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
#	* match localizationMessageResponseBody.messages == '#present'


@LocalMsgCall_500
Scenario: Localization Message call 500
  * def authToken = 'invalid_authToken'
  * def localizationSearchRequest = read('classpath:requestJson/localizationMsg.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print tenantIdReq
  * set localizationSearchRequest.tenantId = tenantIdReq
  * print localizationSearchRequest
    * def parameters = 
    """
    {
     locale: '#(locale_value)',
     tenantId: '#(tenant_value)',
     module: '#(module_value)'
    }
    """
  Given url localizationMessagesUrl + 'invalid'
  And params parameters 
  #And request { module: '#(module)'}
  And request localizationSearchRequest
  When method post
  Then status 500
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response
#	* eval if (karate.get('printRequestResponse') == true) 
 * eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("eGovRecordCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
 # JavaUtils.printResponse("eGovRecordCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)
#	* match localizationMessageResponseBody.messages == '#present'



