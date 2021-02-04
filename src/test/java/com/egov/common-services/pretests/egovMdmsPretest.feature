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
  And def mdmsStateStatePropertyTax = MdmsStateRes.PropertyTax
  And def mdmsStateStatetenant = MdmsStateRes.tenant
  And def mdmsStateBillingService = MdmsStateRes.BillingService
  And def mdmsStatecommonMasters = MdmsStateRes['common-masters']
  And def mdmsStateAccessControlRoles = MdmsStateRes['ACCESSCONTROL-ROLES']
  And def mdmsStateEgovHrms = MdmsStateRes['egov-hrms']
  And def mdmsStateDashboard = MdmsStateRes['dss-dashboard']
  And def mdmsStateDashboardConfig = dashboard['dashboard-config'][0].MODULE_LEVEL

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
  And def mdmsCityEgovLocation = MdmsCityRes['egov-location']