Feature: Reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def reportConst = read('../constants/reports.yaml')
  * def pageSize = reportConst.parameters.pageSize
  * def offset = reportConst.parameters.offset
  * def apiId = reportConst.parameters.apiId
  * def ver = reportConst.parameters.ver
  * def ts = reportConst.parameters.ts
  * def action = reportConst.parameters.action
  * def did = reportConst.parameters.did
  * def key = reportConst.parameters.key
  * def msgId = reportConst.parameters.msgId
  * def requesterId = reportConst.parameters.requesterId

@MetadataGet_01  @positive  @reports
Scenario: Test to fetch the details of a report for a particular module
      * def reportName = reportConst.parameters.reportName
      * call read('../pretests/metadataGetReport.feature@reportsuccess')
      * print reportsResponseBody
      * match reportsResponseBody == '#present'

@MetadataGet_InvalidReportName_02  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def reportName = reportConst.parameters.withoutReportName
      * call read('../pretests/metadataGetReport.feature@reportfail')
      * print reportsResponseBody
      * assert reportsResponseBody.Errors[0].message == reportConst.errormessages.withoutReportName

@MetadataGet_InvalidTenant_03  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def reportName = reportConst.parameters.reportName
      * def tenantId = reportConst.parameters.invalidTenantId
      * call read('../pretests/metadataGetReport.feature@reportforbidden')
      * print reportsResponseBody
      * assert reportsResponseBody.Errors[0].message == reportConst.errormessages.invalidTenantId

@MetadataGet_InvalidAuth_04  @500
Scenario: Test by passing invalid/non existent or null value for auth Token
      * def reportName = reportConst.parameters.reportName
      * def authToken = reportConst.parameters.invalidAuthToken
      * call read('../pretests/metadataGetReport.feature@reportfail')
      * print reportsResponseBody


@Report_Get_01  @positive  @reports
Scenario: Test to search for report data with different combinations of search inputs
      * def secondReportName = reportConst.parameters.secondReportName
      * def searchParams = reportConst.parameters.searchparams
      * call read('../pretests/getReport.feature@getreportsuccess')
      * print getReportsResponseBody
      * match getReportsResponseBody == '#present'

@Report_InvalidTenant_02  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def tenantId = reportConst.parameters.invalidTenantId
      * def secondReportName = reportConst.parameters.secondReportName
      * def searchParams = reportConst.parameters.searchparams
      * call read('../pretests/getReport.feature@getreportforbidden')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].message == reportConst.errormessages.invalidTenantId

@Report_InvalidReportName_03  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def secondReportName = reportConst.parameters.withoutReportName
      * def searchParams = reportConst.parameters.searchparams
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].code == reportConst.errormessages.noReportName

@Report_NoSeacrhParama_04  @positive  @reports
Scenario: Test by removing search params
      * def secondReportName = reportConst.parameters.secondReportName
      * def searchParams = reportConst.parameters.withoutSearchParams
      * call read('../pretests/getReport.feature@getreportsuccess')
      * print getReportsResponseBody
      * match getReportsResponseBody == '#present'

@Report_InvalidSearchParams_05  @negative  @reports
Scenario: Test by adding a invalid search param value
      * def secondReportName = reportConst.parameters.secondReportName
      * def searchParams = reportConst.parameters.invalidSearchParams
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].message == reportConst.errormessages.invalidSearchparam

@Report_InvalidSearchParamsNames_06  @negative  @reports
Scenario: Test by seding a invalid search param names
      * def secondReportName = reportConst.parameters.secondReportName
      * def searchParams = reportConst.parameters.invalidSearchParamName
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].code == reportConst.errormessages.invalidSearchParamsNames


@Report_InvalidAuth_07  @500
Scenario: Test by passing invalid/non existent or null value for auth Token
      * def secondReportName = reportConst.parameters.secondReportName
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      


      

      
      