Feature: Reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def reportConstant = read('../constants/reports.yaml')
  * def pageSize = reportConstant.parameters.pageSize
  * def offset = reportConstant.parameters.offset
  * def apiId = reportConstant.parameters.apiId
  * def ver = reportConstant.parameters.ver
  * def ts = reportConstant.parameters.ts
  * def action = reportConstant.parameters.action
  * def did = reportConstant.parameters.did
  * def key = reportConstant.parameters.key
  * def msgId = reportConstant.parameters.msgId
  * def requesterId = reportConstant.parameters.requesterId
  * def commonConstants = read('../constants/commonConstants.yaml')

@MetadataGet_01  @positive  @reports
Scenario: Test to fetch the details of a report for a particular module
      * def reportName = reportConstant.parameters.reportName
      * call read('../pretests/metadataGetReport.feature@reportsuccess')
      * print reportsResponseBody
      * match reportsResponseBody == '#present'

@MetadataGet_InvalidReportName_02  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def reportName = reportConstant.parameters.withoutReportName
      * call read('../pretests/metadataGetReport.feature@reportfail')
      * print reportsResponseBody
      * assert reportsResponseBody.Errors[0].message == reportConstant.errormessages.withoutReportName

@MetadataGet_InvalidTenant_03  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def reportName = reportConstant.parameters.reportName
      * def tenantId = commonConstants.invalidParameters.invalidTenantId
      * call read('../pretests/metadataGetReport.feature@reportforbidden')
      * print reportsResponseBody
      * assert reportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidTenantId

@MetadataGet_InvalidAuth_04  @500
Scenario: Test by passing invalid/non existent or null value for auth Token
      * def reportName = reportConstant.parameters.reportName
      * def authToken = commonConstants.invalidParameters.invalidAuthToken
      * call read('../pretests/metadataGetReport.feature@reportfail')
      * print reportsResponseBody
      * match reportsResponseBody == '#present'


@Report_Get_01  @positive  @reports
Scenario: Test to search for report data with different combinations of search inputs
      * def secondReportName = reportConstant.parameters.secondReportName
      * def searchParams = reportConstant.parameters.searchparams
      * call read('../pretests/getReport.feature@getreportsuccess')
      * print getReportsResponseBody
      * match getReportsResponseBody == '#present'

@Report_InvalidTenant_02  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def tenantId = commonConstants.invalidParameters.invalidTenantId
      * def secondReportName = reportConstant.parameters.secondReportName
      * def searchParams = reportConstant.parameters.searchparams
      * call read('../pretests/getReport.feature@getreportforbidden')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidTenantId

@Report_InvalidReportName_03  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def secondReportName = reportConstant.parameters.withoutReportName
      * def searchParams = reportConstant.parameters.searchparams
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].code == reportConstant.errormessages.noReportName

@Report_NoSeacrhParama_04  @positive  @reports
Scenario: Test by removing search params
      * def secondReportName = reportConstant.parameters.secondReportName
      * def searchParams = reportConstant.parameters.withoutSearchParams
      * call read('../pretests/getReport.feature@getreportsuccess')
      * print getReportsResponseBody
      * match getReportsResponseBody == '#present'

@Report_InvalidSearchParams_05  @negative  @reports
Scenario: Test by adding a invalid search param value
      * def secondReportName = reportConstant.parameters.secondReportName
      * def searchParams = reportConstant.parameters.invalidSearchParams
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidSearchparam

@Report_InvalidSearchParamsNames_06  @negative  @reports
Scenario: Test by seding a invalid search param names
      * def secondReportName = reportConstant.parameters.secondReportName
      * def searchParams = reportConstant.parameters.invalidSearchParamName
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].code == reportConstant.errormessages.invalidSearchParamsNames


@Report_InvalidAuth_07  @500
Scenario: Test by passing invalid/non existent or null value for auth Token
      * def secondReportName = reportConstant.parameters.secondReportName
      * call read('../pretests/getReport.feature@getreportfail')
      * print getReportsResponseBody
      


      

      
      