Feature: Auth token Creation for Employee

Background:
  * configure headers = read('classpath:com/egov/utils/oauthTokenHeader.js')
  # * print authTokenUrl
  # * print tenantId
  
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
	   And def id = authResponseBody.UserRequest.uuid
   # * print authResponseBody.access_token 
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
	And def id = authResponseBody.UserRequest.uuid
   # * print authResponseBody.access_token 
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
   # * print authResponseBody.access_token 
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
   # * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'

@authTokenCounterEmployee
Scenario: Auth token Creation for CounterEmpl
        Given url authTokenUrl
        And form field username = counterEmployeeUsername
		And form field password = counterEmployeePassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = counterEmployeeType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   # * print authResponseBody.access_token
   * match authResponseBody.access_token == '#present'

@authTokenDocVerifierTL
Scenario: Auth token Creation for CounterEmpl
        Given url authTokenUrl
        And form field username = TLDocVerifierUsername
		And form field password = TLDocVerifierPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = TLDocVerifierType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   # * print authResponseBody.access_token
   * match authResponseBody.access_token == '#present'

@authTokenFieldInspectorTL
Scenario: Auth token Creation for CounterEmpl
        Given url authTokenUrl
        And form field username = FieldInspectorUsername
		And form field password = FieldInspectorPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = FieldInspectorType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   # * print authResponseBody.access_token
   * match authResponseBody.access_token == '#present'

@authTokenApproverTL
Scenario: Auth token Creation for CounterEmpl
        Given url authTokenUrl
        And form field username = ApproverUsername
		And form field password = ApproverPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = ApproverType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
   # * print authResponseBody.access_token
   * match authResponseBody.access_token == '#present'
   
@authTokenCitizenForBPAStakeholder
Scenario: Auth token Creation for citizen
        Given url authTokenUrl
        And form field username = intergerToString(citizenUsername3)
		# * print intergerToString(citizenUsername3)
		And form field password = citizenPassword3
		# * print citizenPassword3

		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = "CITIZEN"
		# * print tenantId
		# * print citizenType
		When method post
		Then status 200
		# * print authResponseBody
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
	And def id = authResponseBody.UserRequest.uuid
   # * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'


@authTokenCitizenArchitect
Scenario: Auth token Creation for citizen
        Given url authTokenUrl
        And form field username = citizenArchitectUsername
		And form field password = citizenArchitectPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = citizenType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders
   	And def authToken = authResponseBody.access_token
	And def id = authResponseBody.UserRequest.uuid
   # * print authResponseBody.access_token 
   * match authResponseBody.access_token == '#present'

@authTokenForRegistrar
Scenario: Auth token for registrar
	* configure headers = read('classpath:com/egov/utils/oauthTokenHeader.js') 
		  Given url authTokenUrl
		  And form field username = registrarUsername
		  And form field password = registrarPassword
		  And form field grant_type = 'password'
		  And form field scope = 'read'
		  And form field tenantId = registrarTenant
		  And form field userType = registrarUserType
		  When method post
		  Then status 200
		  And def authResponseBody = response
		  And def authResponseHeader = responseHeaders
		 And def authToken = authResponseBody.access_token
	 * print authResponseBody.access_token 
	 * match authResponseBody.access_token == '#present'

@authTokenForDistributor
Scenario: Auth token for distributor
		* configure headers = read('classpath:com/egov/utils/oauthTokenHeader.js') 
			  Given url authTokenUrl
			  And form field username = distributorUsername
			  And form field password = distributorPassword
			  And form field grant_type = 'password'
			  And form field scope = 'read'
			  And form field tenantId = distributorTenant
			  And form field userType = distributorUserType
			  When method post
			  Then status 200
			  And def authResponseBody = response
			  And def authResponseHeader = responseHeaders
			 And def authToken = authResponseBody.access_token
		 * print authResponseBody.access_token 
		 * match authResponseBody.access_token == '#present'