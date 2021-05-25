Feature: Fire NOC Billing Slab Feature

Background:
    * def createFireNOCBillingSlabRequest = read('../../municipal-services/requestpayload/firenoc-calculator/billingSlab/create.json')
#    * def createFireNOCBillingSlabRequest = read('../../municipal-services/requestpayload/firenoc-calculator/billingSlab/create2.json')

    * def searchFireNOCBillingLabRequest = read('../../municipal-services/requestpayload/firenoc-calculator/billingSlab/search.json')
    * def calculateFireNOCBillingSlabRequest = read('../../municipal-services/requestpayload/firenoc-calculator/billingSlab/calculate.json')
    * def calculateFireNOCBillingSlabRequestMandatoryParams = read('../../municipal-services/requestpayload/firenoc-calculator/billingSlab/calculateMandatory.json')

@searchFireNOCBIllingSlabFeature
Scenario: Search Fire NOC Billing Slab Feature
    Given url searchFireNOCBillingSlabUrl
    And params searchFireNOCBillingSlabParams
    * print searchFireNOCBillingSlabParams
    And request searchFireNOCBillingLabRequest 
    When method post 
    Then status 200
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 

@failSearchFireNOCBIllingSlabFeature
Scenario: Invalid Search Fire NOC Billing Slab Feature
    Given url searchFireNOCBillingSlabUrl
    And params searchFireNOCBillingSlabParams
    * print searchFireNOCBillingSlabParams
    And request searchFireNOCBillingLabRequest 
    * print searchFireNOCBillingLabRequest
    When method post 
    Then assert responseStatus >= 400 && responseStatus <= 403
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 

@searchFireNOCBIllingSlabFeatureAllRecords
Scenario: Search Fire NOC Billing Slab Feature - all records
    Given url searchFireNOCBillingSlabUrl
    And params searchFireNOCBillingSlabParams
    * print searchFireNOCBillingSlabParams
    And request searchFireNOCBillingLabRequest
    * print searchFireNOCBillingLabRequest
    When method post 
    Then status 200
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 
    And assert fireNOCBillingSlabResponse.BillingSlabs.length > 1

@searchFireNOCBIllingSlabNoRecords
Scenario: Search Fire NOC Billing Slab Feature - No Records
    Given url searchFireNOCBillingSlabUrl
    And params searchFireNOCBillingSlabParams
    * print searchFireNOCBillingSlabParams
    And request searchFireNOCBillingLabRequest 
    When method post 
    Then status 200
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 
    And assert fireNOCBillingSlabResponse.BillingSlabs.length == 0

@createFireNOCBIllingSlabNoRecords
Scenario: Create Fire NOC Billing Slab Feature
    Given url createFireNOCBillingSlabUrl
    And request createFireNOCBillingSlabRequest 
    When method post 
    Then status 200
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 
    And def fireNOCBillingSlabId = fireNOCBillingSlabResponse.BillingSlabs[0].id

@createFireNOCBIllingSlabNoRecords
Scenario: Create Fire NOC Billing Slab Feature
    Given url createFireNOCBillingSlabUrl
    And request createFireNOCBillingSlabRequest 
    * print createFireNOCBillingSlabRequest
    When method post 
    Then status 200
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 
    And def fireNOCBillingSlabId = fireNOCBillingSlabResponse.BillingSlabs[0].id

@failCreateFireNOCBIllingSlabNoRecords
Scenario: Create Fire NOC Billing Slab Feature
    Given url createFireNOCBillingSlabUrl
    And request createFireNOCBillingSlabRequest 
    * print createFireNOCBillingSlabRequest
    When method post 
    Then assert responseStatus >= 400 && responseStatus <= 403
    * print response
    And def fireNOCBillingSlabResponseHeaders = responseHeaders
    And def fireNOCBillingSlabResponse = response 

@successCalculateFireNOCBIllingSlab
Scenario: Calculate Fire NOC Billing Slab Feature
    Given url calculateFireNOCBillingSlabUrl
    And request calculateFireNOCBillingSlabRequest 
    When method post 
    Then status 200
    * print response
    And def calculateFireNOCBillingSlabResponseHeaders = responseHeaders
    And def calculateFireNOCBillingSlabResponse = response 
@failCalculateFireNOCBIllingSlab
Scenario: Calculate Fire NOC Billing Slab Feature with Invalid Data
    Given url calculateFireNOCBillingSlabUrl
    And request calculateFireNOCBillingSlabRequest 
    * print calculateFireNOCBillingSlabRequest
    When method post 
    * print response
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def calculateFireNOCBillingSlabResponseHeaders = responseHeaders
    And def calculateFireNOCBillingSlabResponse = response 

@failCalculateFireNOCBIllingSlabMandatoryParams
Scenario: Calculate Fire NOC Billing Slab Feature with Invalid Data
    Given url calculateFireNOCBillingSlabUrl
    And request calculateFireNOCBillingSlabRequestMandatoryParams 
    * print calculateFireNOCBillingSlabRequest
    When method post 
    * print response
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def calculateFireNOCBillingSlabResponseHeaders = responseHeaders
    And def calculateFireNOCBillingSlabResponse = response 
    