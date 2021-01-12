Feature: Get reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def getReportPayload = read('../requestPayload/reports/getReport.json')
  * def reportConst = read('../constants/reports.yaml')

@getreportsuccess
Scenario: Test to search for report data with different
* configure headers = read('classpath:websCommonHeaders.js')
* def reportparam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url getReport
     * print getReport
     And params reportparam
     * print reportparam
     And request getReportPayload
     * print getReportPayload
     When method post
     Then status 200
     And def getReportsResponseHeader = responseHeaders
     And def getReportsResponseBody = response

@getreportfail
Scenario: Test to search for report data with different
* configure headers = read('classpath:websCommonHeaders.js')
* def reportparam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url getReport
     * print getReport
     And params reportparam
     * print reportparam
     And request getReportPayload
     * print getReportPayload
     When method post
     Then status 400
     And def getReportsResponseHeader = responseHeaders
     And def getReportsResponseBody = response

@getreportforbidden
Scenario: Test to search for report data with different
* configure headers = read('classpath:websCommonHeaders.js')
* def reportparam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url getReport
     * print getReport
     And params reportparam
     * print reportparam
     And request getReportPayload
     * print getReportPayload
     When method post
     Then status 403
     And def getReportsResponseHeader = responseHeaders
     And def getReportsResponseBody = response