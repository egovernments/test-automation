Feature: MDMS Service

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def searchCityRequest = read('../../common-services/requestPayload/egov-mdms/searchCity.json')
  * def searchStateRequest = read('../../common-services/requestPayload/egov-mdms/searchState.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@successSearchState
Scenario: Search MDMS by State success Call
  Given url searchMdmsUrl
  And request searchStateRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsStateRes = mdmsServiceResponseBody.MdmsRes
  And def PropertyTax = MdmsStateRes.PropertyTax
  And def tenant = MdmsStateRes.tenant
  And def BillingService = MdmsStateRes.BillingService
  And def commonMasters = MdmsStateRes['common-masters']
  And def accessControlRoles = MdmsStateRes['ACCESSCONTROL-ROLES']
  And def egovHrms = MdmsStateRes['egov-hrms']

@successSearchCity
Scenario: Search MDMS by State and city success Call
  Given url searchMdmsUrl
  And request searchCityRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsCityRes = mdmsServiceResponseBody.MdmsRes
  And def egovLocation = MdmsCityRes['egov-location']