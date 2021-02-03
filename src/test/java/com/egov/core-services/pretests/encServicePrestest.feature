Feature: enc-Service API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  * def encryptRequest = read('../requestPayload/encService/encrypt.json')
  * def rotateKeyRequest = read('../requestPayload/encService/rotate.json')
  * def signRequest = read('../requestPayload/encService/sign.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@successEncrypt
Scenario: encrypt success call

  Given url encryptUrl 
  And request encryptRequest
  When method post
  Then status 200
  And def encryptResponseHeader = responseHeaders
  And def encryptResponseBody = response
  And def decryptRequest = response

@errorEncrypt
Scenario: encrypt error call

  Given url encryptUrl 
  And request encryptRequest
  When method post
  Then status 500
  And def encryptResponseHeader = responseHeaders
  And def encryptResponseBody = response

@successDecrypt
Scenario: decrypt success call

  Given url decryptUrl 
  And request decryptRequest
  When method post
  Then status 200
  And def decryptResponseHeader = responseHeaders
  And def decryptResponseBody = response

@successRotate
Scenario: rotate success call

  Given url rotateKeyUrl 
  And request rotateKeyRequest
  When method post
  Then status 200
  And def encryptResponseHeader = responseHeaders
  And def encryptResponseBody = response

@successSign
Scenario: sign success call

  Given url signUrl 
  And request signRequest
  When method post
  Then status 200
  And def encryptResponseHeader = responseHeaders
  And def encryptResponseBody = response
  And def verifyRequest = response

@successVerify
Scenario: verify success call

  Given url verifyUrl 
  And request verifyRequest
  When method post
  Then status 200
  And def encryptResponseHeader = responseHeaders
  And def encryptResponseBody = response

@errorVerify
Scenario: verify error call

  Given url verifyUrl 
  And request verifyRequest
  When method post
  Then status 400
  And def encryptResponseHeader = responseHeaders
  And def encryptResponseBody = response