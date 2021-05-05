Feature: Localization Messages API call

        Background:
		# calling localization Json
  * def localizationSearchRequest = read('../../core-services/requestPayload/localization/localizationMsg.json')
  * def localizationV2SearchRequest = read('../../core-services/requestPayload/localization/v2SearchMsg.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  
        @searchLocalizationMessageSuccessfully
        Scenario: Search Localization Message Successfully
  
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
     module: '#(module)'
    }
    """

            Given url localizationMessagesUrl
              And params parameters
              And request localizationSearchRequest
             When method post
             Then status 200
              And def localizationMessageResponseHeader = responseHeaders
              And def localizationMessageResponseBody = response


        @searchLocalizationMessageError
        Scenario: Search Localization Message Error

            Given url localizationMessagesUrl
              And request localizationSearchRequest
             When method post
             Then status 400
              And def localizationMessageResponseHeader = responseHeaders
              And def localizationMessageResponseBody = response


        @searchLocalizationMessageWithoutTenantIdError
        Scenario: Search Localization Message without tenantId Error
 
            Given url localizationMessagesUrl
              And param locale = '#(locale)'
              And request localizationSearchRequest
             When method post
             Then status 400
              And def localizationMessageResponseHeader = responseHeaders
              And def localizationMessageResponseBody = response

        @searchLocalizationMessageWithoutModuleError
        Scenario: Search Localization Message without module Error

  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
     codes: '#(code)'
    }
    """
            Given url localizationMessagesUrl
              And request localizationSearchRequest
              And params parameters
             When method post
             Then status 400
              And def localizationMessageResponseHeader = responseHeaders
              And def localizationMessageResponseBody = response



        @searchLocalizationMessageWithMutipleModuleSuccessfully
        Scenario: Search Localization Message with multiple modules Successfully
  
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)',
     module: '#(module)',
     codes: '#(code)'
    }
    """
            Given url localizationMessagesUrl
              And params parameters
              And request localizationSearchRequest
             When method post
             Then status 200
              And def localizationMessageResponseHeader = responseHeaders
              And def localizationMessageResponseBody = response
  
        @searchLocalizationV2Successfully
        Scenario: Search Localization V2 Message Successfully
 
            Given url localizationSearchV2Url
              And request localizationV2SearchRequest
             When method post
             Then status 200
              And def localizationV2SearchResponseHeader = responseHeaders
              And def localizationV2SearchResponseBody = response


        @searchLocalizationV1Error
        Scenario: Search Localization V1 Message Error
 
            Given url localizationMessagesUrl
              And request localizationV2SearchRequest
             When method post
             Then status 400
              And def localizationV2SearchResponseHeader = responseHeaders
              And def localizationV2SearchResponseBody = response


        @searchLocalizationV2Error
        Scenario: Search Localization V2 Message Error
 
            Given url localizationSearchV2Url
              And request localizationV2SearchRequest
             When method post
             Then status 403
              And def localizationV2SearchResponseHeader = responseHeaders
              And def localizationV2SearchResponseBody = response

        @searchLocalizationSuccessfully
        Scenario: Search Localization Message Successfully
  
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     locale: '#(locale)'
    }
    """

            Given url localizationMessagesUrl
              And params parameters
              And request localizationSearchRequest
             When method post
             Then status 200
              And def localizationMessageResponseHeader = responseHeaders
              And def localizationMessageResponseBody = response
