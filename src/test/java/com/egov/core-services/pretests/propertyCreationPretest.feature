Feature: Property creation Pre-test

Background: 
	* def jsUtils = read('classpath:jsUtils.js')
		
Scenario: Property creation 
  * configure headers = read('classpath:websCommonHeaders.js')
  
  Given url propertyCreationUrl
  And request propertyCreationRequest
  When method post
  Then assert responseStatus == 200 || responseStatus == 201
  And def propertyCreationResponseHeader = responseHeaders
  And def propertyCreationResponseBody = response
  * def acknowldgementNumber = propertyCreationResponseBody.Properties[0].acknowldgementNumber
  * print '*************** acknowldgementNumber - ' + acknowldgementNumber
	* eval if (karate.get('printRequestResponse') == true) JavaUtils.printResponse("propertyCreation", karate.prevRequest.uri, karate.prevRequest.method, karate.prevRequest.headers, new java.lang.String(karate.prevRequest.body, 'utf-8'), responseHeaders, response)