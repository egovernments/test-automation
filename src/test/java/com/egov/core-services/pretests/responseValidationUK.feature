Feature: Property creation Response validation UK
 
 Background: 
  * def jsUtils = read('classpath:jsUtils.js')
	* def javaUtils = Java.type('com.egov.base.EGovTest')

Scenario: Property creation Response validation
  * print '*****************Calling resoponse Validation for UK*********************'
    
  # Property validations	
  * match propertyCreationResponseBody.ResponseInfo.status == 'successful'
  * match karate.jsonPath(propertyCreationRequest,"$.Properties[*].tenantId") == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].tenantId")
  
  
  # Address Validation
  * match karate.jsonPath(propertyCreationRequest,"$.Properties[*].address.city") == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.city")
  * match karate.jsonPath(propertyCreationRequest,"$.Properties[*].address.doorNo") == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.doorNo")
  * match karate.jsonPath(propertyCreationRequest,"$.Properties[*].address.code") == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.code")
  * match karate.jsonPath(propertyCreationRequest,"$.Properties[*].address.area") == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.area")