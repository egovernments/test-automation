Feature: Update a payment transaction

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicesuccess')
  * transactionId = pgServicesCreateResponseBody.Transaction.taxAndPayments[0].txnId
  * def pgServicesUpdatePayload = read('../../core-services/requestPayload/pgServices/pgServicesUpdate.json')

@updatepgservicesuccess
Scenario: Update a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesUpdateParam = 
    """
    {
     transactionId: '#(transactionId)'
    }
    """ 
     Given url pgServicesUpdate 
     * print pgServicesUpdate 
     And params pgServicesUpdateParam 
     And request pgServicesUpdatePayload
     * print pgServicesUpdatePayload
     When method post
     Then status 200
     And def pgServicesUpdateResponseHeader = responseHeaders
     And def pgServicesUpdateResponseBody = response
     * print pgServicesUpdateResponseBody

@updatepgservicefail
Scenario: Update a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesUpdateParam = 
    """
    {
     transactionId: '#(transactionId)'
    }
    """ 
     Given url pgServicesUpdate 
     * print pgServicesUpdate 
     And params pgServicesUpdateParam 
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