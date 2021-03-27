Feature: Trade License service pretests

Background:
    * def createTradeLicenseRequest = read('../../municipal-services/requestpayload/tradeLicense/create.json')
    * def updateTradeLicenseRequest = read('../../municipal-services/requestpayload/tradeLicense/update.json')
    * def searchTradeLicenseRequest = read('../../municipal-services/requestpayload/tradeLicense/search.json')

@successCreateTradeLicense
Scenario: Create Trade License successfully
    Given url createTradeLicense
    And request createTradeLicenseRequest 
    When method post 
    Then status 200
    * print response
    And def tradeLicenseResponseHeaders = responseHeaders 
    And def tradeLicenseResponseBody = response
    And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
    And def tradeLicenseId = tradeLicense.id
    And def tradeLicenseApplicationNumber = tradeLicense.applicationNumber
    And def tradeLicenseStatus = tradeLicense.status
    And def tradeLicenseFromDate = tradeLicense.validFrom
    And def tradeLicenseToDate = tradeLicense.validTo

@errorCreateTradeLicense
Scenario: Create Trade License with Error
    Given url createTradeLicense
    And request createTradeLicenseRequest 
    When method post 
	Then  assert responseStatus >=400 && responseStatus <=403 
    * print response
    And def tradeLicenseResponseHeaders = responseHeaders 
    And def tradeLicenseResponseBody = response
@searchTradeLicenseSuccessfully
Scenario: Search a Trade License with Valid Parameters
	Given url searchTradeLicense 
	And params searchTradeLicenseParams
	And request searchTradeLicenseRequest
	When method post
	Then status 200 
  	* print response
	And def tradeLicenseResponseHeaders = responseHeaders 
	And def tradeLicenseResponseBody = response
  And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
  And def tradeLicenseNumber = tradeLicense.connectionNo


@searchTradeLicenseError
Scenario: Search a Trade License with InValid Parameters
	Given url searchTradeLicense 
	And params searchTradeLicenseParams
	And request searchTradeLicenseRequest
	When method post
	Then  assert responseStatus >=400 && responseStatus <=403 
  * print response
	And def tradeLicenseResponseHeaders = responseHeaders 
	And def tradeLicenseResponseBody = response

@searchTradeLicenseSuccessfullyWithInvalidData
Scenario: Search a Trade License with invalid data
	Given url searchTradeLicense 
	And params searchTradeLicenseParams
	And request searchTradeLicenseRequest
	When method post
	Then status 200 
  * print response
	And def tradeLicenseResponseHeaders = responseHeaders 
	And def tradeLicenseResponseBody = response
  

@updateTradeLicenseSuccessfully
Scenario: Update Trade License With Valid Data
	Given url updateTradeLicense 
	And request updateTradeLicenseRequest
	When method post
	Then status 200 
  * print response
	And def tradeLicenseResponseHeaders = responseHeaders 
	And def tradeLicenseResponseBody = response
  And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
@updateTradeLicenseError
Scenario: Update Trade License With Invalid Data
	Given url updateTradeLicense 
	And request updateTradeLicenseRequest
	When method post
	Then  assert responseStatus >=400 && responseStatus <=403 
  * print response
	And def tradeLicenseResponseHeaders = responseHeaders 
	And def tradeLicenseResponseBody = response
