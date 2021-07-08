Feature: MDMS Service

Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def searchCityRequest = read('../../common-services/requestPayload/egov-mdms/searchCity.json')
  * def searchStateRequest = read('../../common-services/requestPayload/egov-mdms/searchState.json')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

@searchMdmsSuccessfullyByState
Scenario: Search MDMS by State success Call
  Given url searchMdmsUrl
  And request searchStateRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsStateRes = mdmsServiceResponseBody.MdmsRes

@searchMdmsSuccessfullyByCity
Scenario: Search MDMS by State and city success Call
  Given url searchMdmsUrl
  And request searchCityRequest
  When method post
  Then status 200
  And def mdmsServiceResponseHeader = responseHeaders
  And def mdmsServiceResponseBody = response
  And def MdmsCityRes = mdmsServiceResponseBody.MdmsRes
