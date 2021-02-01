Feature: Localization Messages API call 

Background:
	* def jsUtils = read('classpath:jsUtils.js')

  	# calling localization Json
  * def localizationSearchRequest = read('../requestPayload/localization/localizationMsg.json')
  * def localizationV2SearchRequest = read('../requestPayload/localization/v2SearchMsg.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print tenantId
  * set localizationSearchRequest.tenantId = tenantId
  * set localizationV2SearchRequest.tenantId = tenantId
  * print localizationSearchRequest
  * print localizationV2SearchRequest
  
@Success_LocalizationMessage
Scenario: Localization Message Success call
  
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
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


@Error_LocalizationMessage
Scenario: Localization Message Error call

  Given url localizationMessagesUrl
  And request localizationSearchRequest
  When method post
  Then status 400
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response


@Error_NoTenant_LocalizationMessage
Scenario: Localization Message Error call
 
   * print localizationMessagesUrl
  Given url localizationMessagesUrl
  And request localizationSearchRequest
  When method post
  Then status 400
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response
  * print localizationMessageResponseBody


@Error_NoModule_LocalizationMessage
Scenario: Localization Message Error call

  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
     codes: '#(code_value)'
    }
    """
  * print localizationMessagesUrl
  Given url localizationMessagesUrl
  And request localizationSearchRequest
  And params parameters
  When method post
  Then status 400
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response



@Success_MultiData_Localization
Scenario: Localization Message Success call
  
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
     module: '#(module_value)',
     codes: '#(code_value)'
    }
    """
  Given url localizationMessagesUrl 
  And params parameters
  And request localizationSearchRequest
  When method post
  Then status 200
  And def localizationMessageResponseHeader = responseHeaders
  And def localizationMessageResponseBody = response 
  

@Success_LocalizationMessageCall
Scenario: Localization Message Success call

  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
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


@SearchV2Call
Scenario: Localization V2 Search Message Success call
 
  Given url localizationSearchV2Url
  And request localizationV2SearchRequest
  When method post
  Then status 200
  And def localizationV2SearchResponseHeader = responseHeaders
  And def localizationV2SearchResponseBody = response


@SearchV1ErrorCall
Scenario: Localization V2 Search Message Error call
 
  Given url localizationMessagesUrl
  And request localizationV2SearchRequest
  When method post
  Then status 400
  And def localizationV2SearchResponseHeader = responseHeaders
  And def localizationV2SearchResponseBody = response


@SearchV2ErrorCall
Scenario: Localization V2 Search Message Error call
 
  Given url localizationSearchV2Url
  And request localizationV2SearchRequest
  When method post
  Then status 403
  And def localizationV2SearchResponseHeader = responseHeaders
  And def localizationV2SearchResponseBody = response



@Invalid_SearchV2ErrorCall
Scenario: Localization V2 Search Message Error call
 
  Given url invalidV2Search
  And request localizationV2SearchRequest
  When method post
  Then status 403
  And def localizationV2SearchResponseHeader = responseHeaders
  And def localizationV2SearchResponseBody = response

