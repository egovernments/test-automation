Feature: Verify Using API call, shorten the given url

Background:
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def jsUtils = read('classpath:jsUtils.js')
  * def urlShortenPayload = read('../../core-services/requestPayload/urlShorten/urlShorten.json')

@urlShortenFail
Scenario: Verify Send a invalid url in the API call
     Given url shortenUrl  
     And request urlShortenPayload
     When method post
     Then status 400
     And def urlShortenResponseHeader = responseHeaders
     And def urlShortenResponseBody = response