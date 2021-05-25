Feature: NOC Service Pretest

Background:
    * def createNocRequest = read('../../municipal-services/requestpayload/noc/create.json')
    * def updateNOCRequest = read('../../municipal-services/requestpayload/noc/update.json')
    * def searchNOCRequest = read('../../municipal-services/requestpayload/noc/search.json')

@successCreateNOCRequest
Scenario: Create NOC Request successfully
    Given url createNOCUrl
    And request createNocRequest 
    * print createNocRequest
    When method post 
    Then status 200
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    * print nocResponseBody
    And def nocDetail = nocResponseBody.Noc[0]
    And def nocId = nocDetail.id
    And def nocApplicationNo = nocDetail.applicationNo

@failCreateNOCRequest
Scenario: Create Failed NOC Request
    Given url createNOCUrl
    And request createNocRequest 
    When method post 
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    * print nocResponseBody

@searchNOCWithValidData
Scenario: Search NOC With Valid Data
    Given url searchNOCUrl
    And params searchNOCParams
    * print searchNOCParams
    And request searchNOCRequest 
    When method post 
    Then status 200
    * print response
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    And def nocDetail = nocResponseBody.Noc[0]
    And def nocId = nocDetail.id
    And def nocApplicationNo = nocDetail.applicationNo
    * print nocResponseBody

@searchNOCWithInvalidData
Scenario: Search NOC With Valid Data
    Given url searchNOCUrl
    And params searchNOCParams
    * print searchNOCParams
    And request searchNOCRequest 
    When method post 
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    * print nocResponseBody

@updateNOCWithValidData
Scenario: Update NOC With Valid Data
    Given url updateNOCUrl
    And request updateNOCRequest 
    * print "NOC REQUEST"
    * print updateNOCRequest
    When method post
    Then status 200
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    * print "NOC RESPONSE BODY"
    * print nocResponseBody

@updateNOCWithInValidData
Scenario: Update NOC With InValid Data
    Given url updateNOCUrl
    And request updateNOCRequest 
    When method post
    * print response
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    * print nocResponseBody

@searchNOCWithValidDataForBPA
Scenario: Search NOC With Valid Data For BPA
    Given url searchNOCUrl
    And params searchNOCParams
    * print searchNOCParams
    And request searchNOCRequest 
    When method post 
    Then status 200
    * print response
    And def nocResponseHeaders = responseHeaders 
    And def nocResponseBody = response
    And def nocDetail = nocResponseBody.Noc[0]
    And def nocId = nocDetail.id
    And def nocApplicationNo = nocDetail.applicationNo
    * print nocResponseBody
