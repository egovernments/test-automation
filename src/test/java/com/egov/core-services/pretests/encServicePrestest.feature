Feature: enc-Service API call

        Background:

  * def jsUtils = read('classpath:jsUtils.js')
  * def encryptRequest = read('../requestPayload/encService/encrypt.json')
  * def rotateKeyRequest = read('../requestPayload/encService/rotate.json')
  * def signRequest = read('../requestPayload/encService/sign.json')
  * def verifyRequest = read('../requestPayload/encService/verify.json')
  * configure headers = read('classpath:websCommonHeaders.js')

        @EncryptSuccessfully
        Scenario: encrypt successfully

            Given url encryptUrl
              And request encryptRequest
             When method post
             Then status 200
              And def encryptResponseHeader = responseHeaders
              And def encryptResponseBody = response
              And def decryptRequest = response

        @EncryptError
        Scenario: encrypt error

            Given url encryptUrl
              And request encryptRequest
             When method post
             Then assert responseStatus >= 400
              And def encryptResponseHeader = responseHeaders
              And def encryptResponseBody = response

        @decryptsuccessfully
        Scenario: decrypt successfully

            Given url decryptUrl
              And request decryptRequest
             When method post
             Then status 200
              And def decryptResponseHeader = responseHeaders
              And def decryptResponseBody = response

        @rotateSuccessfully
        Scenario: rotate successfully

            Given url rotateKeyUrl
              And request rotateKeyRequest
             When method post
             Then status 200
              And def rotateResponseHeader = responseHeaders
              And def rotateResponseBody = response

        @signSuccessfully
        Scenario: sign successfully

            Given url signUrl
              And request signRequest
             When method post
             Then status 200
              And def signResponseHeader = responseHeaders
              And def signResponseBody = response

        @verifySuccessfully
        Scenario: verify successfully

            Given url verifyUrl
              And request verifyRequest
             When method post
             Then status 200
              And def verifyResponseHeader = responseHeaders
              And def verifyResponseBody = response

        @verifyError
        Scenario: verify error

            Given url verifyUrl
              And request verifyRequest
             When method post
             Then status 400
              And def verifyResponseHeader = responseHeaders
              And def verifyResponseBody = response