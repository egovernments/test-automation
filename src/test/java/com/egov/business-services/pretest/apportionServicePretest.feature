Feature: Searcher API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling apportion Json
  * def apportionRequest = read('../../business-services/requestPayload/apportion-service/apportion.json')
    # calling apportion Json with No bill details
  * def noBillDetailsApportionRequest = read('../../business-services/requestPayload/apportion-service/noBillDetails.json')
  * configure headers = read('classpath:websCommonHeaders.js')


@successApportion
Scenario: success apportion bill

  Given url apportionUrl 
  And request apportionRequest
  When method post
  Then status 200
  And def apportionResponseHeader = responseHeaders
  And def apportionResponseBody = response


@errorApportion
Scenario: error apportion bill

  Given url apportionUrl 
  And request apportionRequest
  # * print apportionRequest
  When method post
  Then status 400
  And def apportionResponseHeader = responseHeaders
  And def apportionResponseBody = response


@successApportionWithOneTaxHeadCode
Scenario: success apportion bill

  Given url apportionUrl 
  And request noBillDetailsApportionRequest[0]
  When method post
  Then status 200
  And def apportionResponseHeader = responseHeaders
  And def apportionResponseBody = response


@errorApportionWithNoBillDetails
Scenario: error apportion bill

  Given url apportionUrl 
  And request noBillDetailsApportionRequest[1]
  When method post
  Then status 200
  And def apportionResponseHeader = responseHeaders
  And def apportionResponseBody = response