Feature: Verify searching transaction details using txn id

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def pgServicesSearchPayload = read('../requestPayload/pgServices/pgServicesSearch.json')

@searchpgservicesuccess
Scenario: Update a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesSearchParam = 
    """
    {
     txnId: '#(txnId)'
    }
    """ 
     Given url pgServicesSearch 
     * print pgServicesSearch 
     And params pgServicesSearchParam 
     And request pgServicesSearchPayload
     * print pgServicesSearchPayload
     When method post
     Then status 200
     And def pgServicesSearchResponseHeader = responseHeaders
     And def pgServicesSearchResponseBody = response
     * print pgServicesSearchResponseBody

@searchpgservicefail
Scenario: Update a payment transaction
  * configure headers = read('classpath:websCommonHeaders.js')
  * def pgServicesSearchParam = 
    """
    {
     txnId: '#(txnId)'
    }
    """ 
     Given url pgServicesSearch 
     * print pgServicesSearch 
     And params pgServicesSearchParam 
     And request pgServicesSearchPayload
     * print pgServicesSearchPayload
     When method post
     Then status 400
     And def pgServicesSearchResponseHeader = responseHeaders
     And def pgServicesSearchResponseBody = response
     * print pgServicesSearchResponseBody