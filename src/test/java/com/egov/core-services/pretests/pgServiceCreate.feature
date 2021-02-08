Feature: Initiates a new payment transaction, on successful validation, a redirect is issued to the payment gateway.

        Background:
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def jsUtils = read('classpath:jsUtils.js')
  * def pgServicesCreatePayload = read('../../core-services/requestPayload/pgServices/pgServicesCreate.json')

        @createPgTransactionSuccessfully
        Scenario: Create Payment Gateway Transaction Successfully
            Given url pgServices
              And request pgServicesCreatePayload
             When method post
             Then status 200
              And def pgServicesCreateResponseHeader = responseHeaders
              And def pgServicesCreateResponseBody = response
              And def txnId = pgServicesCreateResponseBody.Transaction.txnId
     * print pgServicesCreateResponseBody

        @createPgTransactionError
        Scenario: Create Payment Gateway Transaction Error
            Given url pgServices
     * print pgServices  
              And request pgServicesCreatePayload
     * print pgServicesCreatePayload
             When method post
             Then status 400
              And def pgServicesCreateResponseHeader = responseHeaders
              And def pgServicesCreateResponseBody = response
     * print pgServicesCreateResponseBody