Feature: eGov Demo Tests

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')

  # Calling access token
	* def authUsername = counterEmployeeUserName
	* def authPassword = counterEmployeePassword
	* def authUserType = 'EMPLOYEE'
	* call read('classpath:com/egov/demo/pretests/authenticationToken.feature')
	
	# MDMS call
	* call read('classpath:com/egov/demo/pretests/mdmsRequest.feature')
	
@PT-Creation
Scenario: Creating the eGov Demo Tests

	# Calling request Json
	
	# calling request Json 'karate.read('C:/Users/Toshiba/Documents/Requests/propertyPB.json')' from out side the classpath
	#* eval if(karate.get('tenantId') == 'pb') karate.set('units', karate.read('classpath:propertyJson/units.json')), karate.set('noOfFloors', units.length), karate.set('owners', karate.read('classpath:propertyJson/owners.json')), karate.set('documents', karate.read('classpath:propertyJson/documents.json')), karate.set('propertyCreationRequest', karate.read('C:/Users/Toshiba/Documents/Requests/propertyPB.json'))
	* eval if(karate.get('tenantId') == 'pb') karate.set('units', karate.read('classpath:propertyJson/units.json')), karate.set('noOfFloors', units.length), karate.set('owners', karate.read('classpath:propertyJson/owners.json')), karate.set('documents', karate.read('classpath:propertyJson/documents.json')), karate.set('propertyCreationRequest', karate.read('classpath:requestJson/propertyPB.json'))
	* eval if(karate.get('tenantId') == 'uk') karate.set('units', karate.read('classpath:propertyJson/unitsUK.json')), karate.set('noOfFloors', units.length), karate.set('owners', karate.read('classpath:propertyJson/ownersUK.json')), karate.set('propertyCreationRequest', karate.read('classpath:requestJson/propertyUK.json'))
  
  # Property creation API call   
  * call read('classpath:com/egov/demo/pretests/propertyCreationPretest.feature')
  
  # Calling response validation feature
  * eval if(karate.get('tenantId') == 'pb') karate.call('classpath:com/egov/demo/pretests/responseValidationPB.feature')
  * eval if(karate.get('tenantId') == 'uk') karate.call('classpath:com/egov/demo/pretests/responseValidationUK.feature')