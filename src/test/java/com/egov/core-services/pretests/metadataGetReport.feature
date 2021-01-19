Feature: Metadata get reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def reportPayload = read('../requestPayload/reports/metadataGetReport.json')
  * def reportConst = read('../constants/reports.yaml')

@reportsuccess
Scenario: Test to fetch the details of a report
* configure headers = read('classpath:websCommonHeaders.js')
* def reportparam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url metadataGetReport
     * print metadataGetReport
     And params reportparam
     * print reportparam
     And request reportPayload
     * print reportPayload
     When method post
     Then status 200
     And def reportsResponseHeader = responseHeaders
     And def reportsResponseBody = response

@reportfail
Scenario: Test to fetch the details of a report
* configure headers = read('classpath:websCommonHeaders.js')
* def reportparam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url metadataGetReport
     * print metadataGetReport
     And params reportparam
     * print reportparam
     And request reportPayload
     * print reportPayload
     When method post
     Then status 400
     And def reportsResponseHeader = responseHeaders
     And def reportsResponseBody = response

@reportforbidden
Scenario: Test to fetch the details of a report
* configure headers = read('classpath:websCommonHeaders.js')
* def reportparam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
     Given url metadataGetReport
     * print metadataGetReport
     And params reportparam
     * print reportparam
     And request reportPayload
     * print reportPayload
     When method post
     Then status 403
     And def reportsResponseHeader = responseHeaders
     And def reportsResponseBody = response