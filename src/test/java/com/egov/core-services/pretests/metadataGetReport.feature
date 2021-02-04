Feature: Metadata get reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def reportPayload = read('../../core-services/requestPayload/reports/metadataGetReport.json')

@reportSuccess
Scenario: Test to fetch the details of a report
* configure headers = read('classpath:websCommonHeaders.js')
* def reportParam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url metadataGetReport
     * print metadataGetReport
     And params reportParam
     * print reportParam
     And request reportPayload
     * print reportPayload
     When method post
     Then status 200
     And def reportsResponseHeader = responseHeaders
     And def reportsResponseBody = response

@reportFail
Scenario: Test to fetch the details of a report
* configure headers = read('classpath:websCommonHeaders.js')
* def reportParam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url metadataGetReport
     * print metadataGetReport
     And params reportParam
     * print reportParam
     And request reportPayload
     * print reportPayload
     When method post
     Then status 400
     And def reportsResponseHeader = responseHeaders
     And def reportsResponseBody = response

@reportForbidden
Scenario: Test to fetch the details of a report
* configure headers = read('classpath:websCommonHeaders.js')
* def reportParam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url metadataGetReport
     * print metadataGetReport
     And params reportParam
     * print reportParam
     And request reportPayload
     * print reportPayload
     When method post
     Then status 403
     And def reportsResponseHeader = responseHeaders
     And def reportsResponseBody = response