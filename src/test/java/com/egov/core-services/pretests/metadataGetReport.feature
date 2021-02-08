Feature: Metadata get reports

        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def reportPayload = read('../../core-services/requestPayload/reports/metadataGetReport.json')
  * configure headers = read('classpath:websCommonHeaders.js')


        @getReportMetadataSuccessfully
        Scenario: Get Report Metadata Successfully
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

        @getReportMetadataError
        Scenario: Get Report Metadata Error
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

        @getReportMetadata403Error
        Scenario: Get Report Metadata 403 Forbidden Error
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