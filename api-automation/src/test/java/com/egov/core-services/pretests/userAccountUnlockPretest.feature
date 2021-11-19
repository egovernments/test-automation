Feature: User oauth token pretest
Background:
  * configure headers = read('classpath:com/egov/utils/oauthTokenHeader.js')
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')

@invalidPasswordError
Scenario: To test User account
    Given url authTokenUrl
    And form field username = employeeSuperUserUserNme
		And form field password = '#(oauthPassword)'
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = employeeType
		When method post
		Then status 400
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders

@validPasswordError
Scenario: To test User account
    Given url authTokenUrl
    And form field username = employeeSuperUserUserNme
		And form field password = employeeSuperUserPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = employeeType
		When method post
		Then status 400
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders


@acountUnlockSuccess
Scenario: To test User account
    Given url authTokenUrl
    And form field username = employeeSuperUserUserNme
		And form field password = employeeSuperUserPassword
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = employeeType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders

@validPasswordSuccess
Scenario: To test User account
    Given url authTokenUrl
    And form field username = employeeSuperUserUserNme
		And form field password = '#(oauthValidPassword)'
		And form field grant_type = 'password'
		And form field scope = 'read'
		And form field tenantId = tenantId
		And form field userType = employeeType
		When method post
		Then status 200
		And def authResponseBody = response
		And def authResponseHeader = responseHeaders