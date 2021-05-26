Feature: IDGenerate API call

        Background:
	# reading idgenerate request payload Json
  * def idGenerateRequest = read('../../core-services/requestPayload/id-generate/idgenerate.json')
  * configure headers = read('classpath:websCommonHeaders.js')


        @idGenerateSuccessfully
        Scenario: IDGenerate successfully

            Given url idGenerateUrl
              And request idGenerateRequest
             When method post
             Then status 200
              And def idGenerateResponseHeader = responseHeaders
              And def idGenerateResponseBody = response


        @idGenerateError
        Scenario: IDGenerate error

            Given url idGenerateUrl
              And request idGenerateRequest
             When method post
             Then status 403
              And def idGenerateResponseHeader = responseHeaders
              And def idGenerateResponseBody = response


        @idGenerateFailed
        Scenario: IDGenerate failed

            Given url idGenerateUrl
              And request idGenerateRequest
             When method post
             Then status 200
              And def idGenerateResponseHeader = responseHeaders
              And def idGenerateResponseBody = response
