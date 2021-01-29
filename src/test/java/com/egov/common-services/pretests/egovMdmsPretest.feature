Feature: MDMS Service

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def searchCityRequest = read('../../common-services/requestPayload/egov-mdms/searchCity.json')
  * def searchStateRequest = read('../../common-services/requestPayload/egov-mdms/searchState.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@successSearchState
Scenario: Search MDMS by State success Call
  * print searchStateRequest
  Given url searchMdmsUrl
  # And param tenantId = tenantId
  And request searchStateRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsRes = mdmsServiceResponseBody.MdmsRes
  And def PropertyTax = MdmsRes.PropertyTax
  And def tenant = MdmsRes.tenant
  And def BillingService = MdmsRes.BillingService
  And def commonMasters = MdmsRes['common-masters']

@successSearchCity
Scenario: Search MDMS by State and city success Call
  * print searchCityRequest
  Given url searchMdmsUrl
  And request searchCityRequest
  When method post
  Then status 201
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response