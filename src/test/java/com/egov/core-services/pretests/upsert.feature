Feature: Localization Messages API call 

Background:
	* def jsUtils = read('classpath:jsUtils.js')
  
  
	
@Success_Upsert 
Scenario: Upsert with Success call
	
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
  * def module = module_value
	# calling localization Json
  * def upsertRequest = read('../requestPayload/localization/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest
  
  Given url upsertUrl
  And request upsertRequest
  When method post
  Then status 200
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response


@Error_Upsert
Scenario: Upsert with Error call
   # calling localization Json
  * def upsertRequest = read('../requestPayload/localization/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest
  
  Given url upsertUrl
  And request upsertRequest
  When method post
  Then status 400
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response


  @Error_accessingResource_upsert
  Scenario: Upsert with Error call
   # calling localization Json
  * def upsertRequest = read('../requestPayload/localization/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print upsertRequest

  Given url upsertUrl
  And request upsertRequest
  When method post
  Then status 403
  And def upsertResponseHeader = responseHeaders
  And def upsertResponseBody = response
	