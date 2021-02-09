Feature: Searcher API call

        Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling searcher Json
  * def searcherRequest = read('../requestPayload/searcher/searcher.json')
  * configure headers = read('classpath:websCommonHeaders.js')


        @searchSuccessfully
        Scenario: Search successfully

            Given url searcherUrl
              And request searcherRequest
             When method post
             Then status 200
              And def searcherResponseHeader = responseHeaders
              And def searcherResponseBody = response

        @searchError
        Scenario: Search error

            Given url searcherUrl
              And request searcherRequest
             When method post
             Then status 403
              And def searcherResponseHeader = responseHeaders
              And def searcherResponseBody = response

        @invalidSearcherError
        Scenario: Invalid Searcher error

            Given url invalidSearcher
              And request searcherRequest
             When method post
             Then status 403
              And def searcherResponseHeader = responseHeaders
              And def searcherResponseBody = response
  


        @searchWithoutTenantIdError
        Scenario: Search without TenantId error
            Given url searcherWSUrl
              And request searcherRequest
             When method post
             Then status 400
              And def searcherResponseHeader = responseHeaders
              And def searcherResponseBody = response