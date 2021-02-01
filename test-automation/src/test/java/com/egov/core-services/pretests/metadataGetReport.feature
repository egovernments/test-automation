Feature: Metadata get reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def reportPayload = read('../requestPayload/reports/metadataGetReport.json')
  * def reportConstant = read('../constants/reports.yaml')

@reportsuccess
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

@reportfail
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

@reportforbidden
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