Feature: Get reports

        Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def getReportPayload = read('../../core-services/requestPayload/reports/getReport.json')
* configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

        @getReportSuccessfully
        Scenario: Get Report Successfully
* def getReportParam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
            Given url getReport
     
              And params getReportParam
     
              And request getReportPayload
     
             When method post
             Then status 200
              And def getReportsResponseHeader = responseHeaders
              And def getReportsResponseBody = response

        @getReportError
        Scenario: Get Report Error
* def getReportParam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
            Given url getReport
     
              And params getReportParam
     
              And request getReportPayload
     
             When method post
             Then status 400
              And def getReportsResponseHeader = responseHeaders
              And def getReportsResponseBody = response

        @getReport403Error
        Scenario: Get Report 403 Forbidden Error
* def getReportParam =
    """
    {
     tenantId: '#(tenantId)',
     pageSize: '#(pageSize)',
     offset: '#(offset)'
    }
    """
            Given url getReport
     
              And params getReportParam
     
              And request getReportPayload
     
             When method post
             Then status 403
              And def getReportsResponseHeader = responseHeaders
              And def getReportsResponseBody = response