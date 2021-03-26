Feature: Auth token Creation for Employee

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:oauthTokenHeader.js')
  * print authTokenUrl
  * print tenantId
  
  @authTokenSuperuser
  Scenario: Auth token Creation scenario 
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
   * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'

@authTokenCitizen
Scenario: Auth token Creation for citizen
        Given url authTokenUrl
        And form field username = citizenUsername
		And form field password = citizenPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = citizenType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'

@authTokenOfAltCitizen
Scenario: Auth token Creation for alternative citizen
        Given url authTokenUrl
        And form field username = altCitizenUsername
		And form field password = altCitizenPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = altCitizenType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'

@authTokenApprover
Scenario: Auth token Creation for approver
        Given url authTokenUrl
        And form field username = approverUsername
		And form field password = approverPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = approverType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'


