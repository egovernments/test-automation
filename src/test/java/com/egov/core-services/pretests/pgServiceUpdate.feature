Feature: Update a payment transaction

        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def pgServicesUpdatePayload = read('../../core-services/requestPayload/pgServices/pgServicesUpdate.json')

        @updatePgTransactionSuccessfully
        Scenario: Update Payment Gateway Transaction Successfully
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesUpdateParam = 
    """
    {
     transactionId: '#(txnId)'
    }
    """ 
            Given url pgServicesUpdate
     * print pgServicesUpdate 
              And params pgServicesUpdateParam
     * print pgServicesUpdateParam
              And request pgServicesUpdatePayload
     * print pgServicesUpdatePayload
             When method post
             Then status 200
              And def pgServicesUpdateResponseHeader = responseHeaders
              And def pgServicesUpdateResponseBody = response
     * print pgServicesUpdateResponseBody
        
        @invalidTransactionIdError
        Scenario: Update Payment Gateway Transaction Error
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesUpdateParam = 
    """
    {
     transactionId: '#(txnId)'
    }
    """ 
            Given url pgServicesUpdate
     * print pgServicesUpdate 
              And params pgServicesUpdateParam
     * print pgServicesUpdateParam
              And request pgServicesUpdatePayload
     * print pgServicesUpdatePayload
             When method post
             Then status 400
              And def pgServicesUpdateResponseHeader = responseHeaders
              And def pgServicesUpdateResponseBody = response
     * print pgServicesUpdateResponseBody

        @updatePgTransactionError
        Scenario: Update Payment Gateway Transaction Error
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesUpdateParam = 
    """
    {
     transactionId: '#(txnId)'
    }
    """ 
            Given url pgServicesUpdate
     * print pgServicesUpdate 
              And params pgServicesUpdateParam
     * print pgServicesUpdateParam
              And request pgServicesUpdatePayload
     * print pgServicesUpdatePayload
             When method post
             Then status 400
              And def pgServicesUpdateResponseHeader = responseHeaders
              And def pgServicesUpdateResponseBody = response
     * print pgServicesUpdateResponseBody

        @withouttransactionidpgservicefail
        Scenario: Update a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js')
            Given url pgServicesUpdate
     * print pgServicesUpdate 
              And request pgServicesUpdatePayload
     * print pgServicesUpdatePayload
             When method post
             Then status 400
              And def pgServicesUpdateResponseHeader = responseHeaders
              And def pgServicesUpdateResponseBody = response
     * print pgServicesUpdateResponseBody