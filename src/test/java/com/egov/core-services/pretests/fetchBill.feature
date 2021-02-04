Feature: Fetch Bill

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = authUsername
  * def authPassword = authPassword
  * def authUserType = authUserType
  * call read('../pretests/authenticationToken.feature')
  * def fetchBillPayload = read('../requestPayload/billingService/FetchBill.json')

@fetchbillsuccess
Scenario: To fetch the bill id
  * configure headers = read('classpath:websCommonHeaders.js')
  * def fetchBillParam = 
    """
    {
     tenantId: '#(tenantId)',
     consumerCode: '#(consumerCode)',
     businessService: '#(businessService)'
    }

    """  
     Given url fetchBill 
     * print fetchBill  
     And params fetchBillParam
     * print fetchBillParam
     And request fetchBillPayload
     * print fetchBillPayload
     When method post
     Then status 201
     And def fetchBillResponseHeader = responseHeaders
     And def fetchBillResponseBody = response