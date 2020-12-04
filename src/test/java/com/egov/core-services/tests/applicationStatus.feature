Feature: Check application status of the property creation

        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  
	* call read('classpath:com/egov/demo/tests/PropertyCreation.feature')
	
	* def applicationStatus = read('classpath:requestJson/applicationStatus.json')
	
        @Application=Status
        Scenario: Checking the application status

            Given url applicationStatusUrl
              And param acknowledgementIds = acknowldgementNumber
              And request applicationStatus
             When method post
             Then status 200
              And def applicationStatusResponseHeader = responseHeaders
              And def applicationStatusResponseBody = response
  
  * def status = applicationStatusResponseBody.Properties[0].status
  * print '*************** status: - ' + status
  * match status == 'INWORKFLOW'
  * match status == 'INWORKFLOW'