Feature: MDMS Service

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def searchCityRequest = read('../../common-services/requestPayload/egov-mdms/searchCity.json')
  * def searchStateRequest = read('../../common-services/requestPayload/egov-mdms/searchState.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@successSearchState
Scenario: Search MDMS by State success Call
  Given url searchMdmsUrl
  * print searchMdmsUrl
  And request searchStateRequest
  * print searchStateRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsRes = mdmsServiceResponseBody.MdmsRes
  And def PropertyTax = MdmsRes.PropertyTax
  And def tenant = MdmsRes.tenant
  And def BillingService = MdmsRes.BillingService
  And def commonMasters = MdmsRes['common-masters']
  And def accessControlRoles = MdmsRes['ACCESSCONTROL-ROLES']

@successSearchCity
Scenario: Search MDMS by State and city success Call
  Given url searchMdmsUrl
  * print searchMdmsUrl
  And request searchCityRequest
  * print searchCityRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsRes = mdmsServiceResponseBody.MdmsRes
  And def PropertyTax = MdmsRes.PropertyTax
  And def tenant = MdmsRes.tenant
  And def BillingService = MdmsRes.BillingService
  And def commonMasters = MdmsRes['common-masters']
  And def accessControlRoles = MdmsRes['ACCESSCONTROL-ROLES']
  And def tenantBoundary = MdmsRes.MdmsRes['egov-location'].TenantBoundary
  * print tenantBoundary
