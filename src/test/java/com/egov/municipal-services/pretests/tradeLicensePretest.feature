Feature: TL-Service pretest scenarios

Background:
    * def createTradeLicenseRequest = read('../../municipal-services/requestpayload/tradeLicense/create.json')
    # TODO: Need to add request payloads for below. 
    # * def updateWaterConnectionRequest = read('../../municipal-services/requestpayload/tradeLicense/update.json')
    # * def searchWaterConnectionRequest = read('../../municipal-services/requestpayload/tradeLicense/search.json')


@successCreateTradeLicense
Scenario: To create Trade License successfully
    Given url createTradeLicense
    And request createTradeLicenseRequest 
    When method post 
    Then status 200
    And def tradeLicenseResponseHeaders = responseHeaders 
    And def tradeLicenseResponseBody = response
    And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
    And def tradeLicenseId = tradeLicense.id
    And def tradeLicenseApplicationNumber = tradeLicense.applicationNumber
