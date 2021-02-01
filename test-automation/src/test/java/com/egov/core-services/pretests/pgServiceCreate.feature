Feature: Initiates a new payment transaction, on successful validation, a redirect is issued to the payment gateway.

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def pgServicesCreatePayload = read('../requestPayload/pgServices/pgServicesCreate.json')

@createpgservicesuccess
Scenario: Verify creating a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url pgServices 
     * print pgServices  
     And request pgServicesCreatePayload
     * print pgServicesCreatePayload
     When method post
     Then status 200
     And def pgServicesCreateResponseHeader = responseHeaders
     And def pgServicesCreateResponseBody = response
     * print pgServicesCreateResponseBody

@createpgservicefail
Scenario: Verify creating a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url pgServices 
     * print pgServices  
     And request pgServicesCreatePayload
     * print pgServicesCreatePayload
     When method post
     Then status 400
     And def pgServicesCreateResponseHeader = responseHeaders
     And def pgServicesCreateResponseBody = response
     * print pgServicesCreateResponseBody