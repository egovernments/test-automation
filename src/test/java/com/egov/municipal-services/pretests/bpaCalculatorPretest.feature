Feature: BPA-Calculator pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def calculateBPARequest = read('../../municipal-services/requestPayload/bpa-calculator/calculate.json')

    @calcuateBPASuccessfully
    Scenario: Calculate BPA successfully
        Given url calculateBPA
        And request calculateBPARequest
        * print calculateBPARequest
        When method post
        Then status 200
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response

    @calcuateBPAError
    Scenario: Calculate BPA Error
        * set BPA.applicationNo = null
        Given url calculateBPA
        And request calculateBPARequest
        When method post
        Then status 400
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response

    @calcuateBPA_EDCRError
    Scenario: Calculate BPA Error
        * set BPA.edcrNumber = '#(invalidNumber)'
        Given url calculateBPA
        And request calculateBPARequest
        When method post
        Then status 400
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response