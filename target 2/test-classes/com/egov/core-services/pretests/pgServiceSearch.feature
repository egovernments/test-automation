Feature: Verify searching transaction details using txn id

        Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * def pgServicesSearchPayload = read('../../core-services/requestPayload/pg-service/pgServicesSearch.json')

        @searchPgTransactionSuccessfully
        Scenario: Search a payment gateway transaction successfully
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  * def pgServicesSearchParam = 
    """
    {
     txnId: '#(txnId)'
    }
    """ 
            Given url pgServicesSearch
     
              And params pgServicesSearchParam
              And request pgServicesSearchPayload
     
             When method post
             Then status 200
              And def pgServicesSearchResponseHeader = responseHeaders
              And def pgServicesSearchResponseBody = response
     

        @searchPgTransactionError
        Scenario: Search a payment gateway transaction error
  * def pgServicesSearchParam = 
    """
    {
     txnId: '#(txnId)'
    }
    """ 
            Given url pgServicesSearch
     
              And params pgServicesSearchParam
              And request pgServicesSearchPayload
     
             When method post
             Then status 400
              And def pgServicesSearchResponseHeader = responseHeaders
              And def pgServicesSearchResponseBody = response
     