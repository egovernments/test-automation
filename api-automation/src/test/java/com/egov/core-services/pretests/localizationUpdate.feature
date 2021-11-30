Feature: Localization Update Messages API call

        Background:
	
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  	# calling localization Update Json
  * def localizationUpdateRequest = read('../../core-services/requestPayload/localization/update.json')
    # calling localization Ceate Json
  * def localizationCreateRequest = read('../../core-services/requestPayload/localization/create.json')
  # calling localization MultiMessageCeate Json
  * def localizationMultiMessageCreateRequest = read('../../core-services/requestPayload/localization/multiMessageCreate.json')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')


        @updateLocalizationMessageSuccessfully
        Scenario: Update localization message Successfully

            Given url localizationUpdateMessagesUrl
              And request localizationUpdateRequest
             When method post
             Then status 200
              And def updateResponseHeader = responseHeaders
              And def updateResponseBody = response


        @updateLocalizationMessageError
        Scenario: Update localization message Error

            Given url localizationUpdateMessagesUrl
              And request localizationUpdateRequest
             When method post
             Then status 400
              And def updateResponseHeader = responseHeaders
              And def updateResponseBody = response


        @updateLocalizationMessageWithInvalidTenantIdError
        Scenario: Update localization message wit invalid tenantId Error
  
            Given url localizationUpdateMessagesUrl
              And request localizationUpdateRequest
             When method post
             Then status 403
              And def updateResponseHeader = responseHeaders
              And def updateResponseBody = response

        @deleteLocalizationMessageSuccessfully
        Scenario: Delete Localization message successfully

  * def deleteRequest = read('../requestPayload/localization/upsert.json')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  
            Given url localizationDeleteMessagesUrl
              And request deleteRequest
             When method post
             Then status 403
              And def deleteResponseHeader = responseHeaders
              And def deleteResponseBody = response

        @createLocalizationMessageSuccessfully
        Scenario: Create Localization message Successfully

            Given url localizationCreateMessagesUrl
              And request localizationCreateRequest
             When method post
             Then status 200
              And def createResponseHeader = responseHeaders
              And def createResponseBody = response

        @createMultipleLocalizationMessageSuccessfully
        Scenario: Create Multiple Localization message Successfully

            Given url localizationCreateMessagesUrl
              And request localizationMultiMessageCreateRequest
             When method post
             Then status 200
              And def createResponseHeader = responseHeaders
              And def createResponseBody = response
  