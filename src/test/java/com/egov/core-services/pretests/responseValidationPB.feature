Feature: Property creation Response validation PB
 
 Background: 
  * def jsUtils = read('classpath:jsUtils.js')
	* def javaUtils = Java.type('com.egov.base.EGovTest')

Scenario: Property creation Response validation
  * print '*****************Calling resoponse Validation for PB*********************'
    
  # Property validations	
  * match propertyCreationResponseBody.ResponseInfo.status == 'successful'
  * match propertyCreationRequest.Property.tenantId == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.tenantId")[0]
 # * match karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address") contains any propertyCreationRequest.Property.address
  
  # Address Validation
  * match validateAddress(propertyCreationRequest,propertyCreationResponseBody) == true
  
 # * match propertyCreationRequest.Property.address.city == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.city")[0]
 # * match propertyCreationRequest.Property.address.doorNo == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address.doorNo")[0]
#  * match propertyCreationRequest.Property.address.locality.code == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address..code")[0]
 # * match propertyCreationRequest.Property.address.locality.area == karate.jsonPath(propertyCreationResponseBody,"$.Properties[*].address..area")[0]