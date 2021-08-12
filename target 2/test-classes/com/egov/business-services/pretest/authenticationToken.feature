Feature: Auth token Creation for Employee

Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  # * print authTokenUrl
  
  Scenario: Auth token Creation scenario
  * configure headers = read('classpath:com/egov/utils/oauthTokenHeader.js') 
        Given url authTokenUrl
        And form field username = authUsername
		And form field password = authPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = authUserType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   # * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'