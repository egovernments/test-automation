Feature: eGov Demo Tests

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')

  # calling access token
	* def authUsername = counterEmployeeUserName
	* def authPassword = counterEmployeePassword
	* def authUserType = 'EMPLOYEE'
	* call read('classpath:com/egov/demo/pretests/authenticationToken.feature')
	
	# MDMS call
	#* call read('classpath:com/egov/demo/pretests/mdmsRequest.feature')
	
@PT-Creation-Test
Scenario: Creating the eGov Demo Tests

	# Calling requestJson
	* eval if(karate.get('tenantId') == 'pb') karate.set('propertyCreationRequest', karate.read('classpath:requestJson/propertyRequestPB.json'))
	* eval if(karate.get('tenantId') == 'uk') karate.set('propertyCreationRequest', karate.read('classpath:requestJson/propertyRequestUK.json'))
	  
  # Property creation API call   
  * call read('classpath:com/egov/demo/pretests/propertyCreationPretest.feature')
  
  # Calling response validation feature
  * eval if(karate.get('tenantId') == 'pb') karate.call('classpath:com/egov/demo/pretests/responseValidationPB.feature')
  * eval if(karate.get('tenantId') == 'uk') karate.call('classpath:com/egov/demo/pretests/responseValidationUK.feature')