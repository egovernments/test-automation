Feature: File Store Tests

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')

  # Calling access token
	* def authUsername = counterEmployeeUserName
	* def authPassword = counterEmployeePassword
	* def authUserType = 'EMPLOYEE'
	* call read('classpath:com/egov/demo/pretests/authenticationToken.feature')
	
@fileStore
Scenario: File store Tests
	# Calling create file Api
	#* call read('classpath:com/egov/demo/pretests/fileStoreCreate.feature')
	
	* def fileStoreId = '97c3db90-e5b2-4775-9804-39fda5cdfd71'
	
	# Calling getFilestore Apis
	* call read('classpath:com/egov/demo/pretests/fileStoreGetApiCall.feature')
	
	# Verify fileId
	* match karate.jsonPath(fileStoreGetResponseBody, "$.fileStoreIds[?(@.id=='"+ fileStoreId +"')]") == '#present'
	
