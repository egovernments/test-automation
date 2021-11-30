Feature: Verify Using API call, shorten the given url
Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def urlShortenConstant = read('../../core-services/constants/urlShortening.yaml')

@url_Shorterning_Invalid @regression @coreServices
Scenario: Verify Send a invalid url in the API call (request body)and check for errors
* call read('../../core-services/pretests/urlShorteningPretest.feature@urlShortenFail')
* assert urlShortenResponseBody.Errors[0].message == urlShortenConstant.errorMessages.forInvalidUrl