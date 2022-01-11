Feature: surveys pretests
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def searchSurveysRequest = read('../../municipal-services/requestPayload/surveys/search.json')


    @searchSurveysSuccessfully
    Scenario: Search Surveys Successfully

        Given url searchEgovSurveys
        And params getSurveysSearchParam
        And request searchSurveysRequest
        When method post
        Then status 200
        And def surveysResponseHeaders = responseHeaders
        And def surveysResponseBody = response
        