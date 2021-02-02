Feature: Reports

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authtoken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * def reportConstant = read('../../core-services/constants/reports.yaml')
  * def reportName = reportConstant.parameters.reportName
  * def pageSize = 'false'
  * def offset = '0'
  * def ts = getCurrentEpochTime()
  * def secondReportName = reportConstant.parameters.secondReportName
  * def searchParams = reportConstant.parameters.searchparams
  * eval searchParams[0].input = getPastEpochDate(7)
  * eval searchParams[1].input = getCurrentEpochTime()
  * eval searchParams[2].input = reportConstant.parameters.input[env]
  * def invalidReportName = 'INVALID-report-' + randomString(2)
  * def withoutSearchParams = []
  * def invalidSearchParams = 'INVALID' + randomString(2)
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId

@MetadataGet_01  @positive  @reports
Scenario: Test to fetch the details of a report for a particular module
      * call read('../../core-services/pretests/metadataGetReport.feature@reportSuccess')
      * print reportsResponseBody
      * match reportsResponseBody == '#present'

@MetadataGet_InvalidReportName_02  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def reportName = invalidReportName
      * call read('../../core-services/pretests/metadataGetReport.feature@reportFail')
      * print reportsResponseBody
      * assert reportsResponseBody.Errors[0].message == reportConstant.errormessages.withoutReportName

@MetadataGet_InvalidTenant_03  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def tenantId = invalidTenantId
      * call read('../../core-services/pretests/metadataGetReport.feature@reportForbidden')
      * print reportsResponseBody
      * assert reportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidTenantId

@Report_Get_01  @positive  @reports
Scenario: Test to search for report data with different combinations of search inputs
      * call read('../../core-services/pretests/getReport.feature@getreportSuccess')
      * print getReportsResponseBody
      * match getReportsResponseBody == '#present'

@Report_InvalidTenant_02  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def tenantId = invalidTenantId
      * call read('../../core-services/pretests/getReport.feature@getreportForbidden')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidTenantId

@Report_InvalidReportName_03  @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def secondReportName = invalidReportName
      * call read('../../core-services/pretests/getReport.feature@getreportFail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].code == reportConstant.errormessages.noReportName

@Report_NoSeacrhParama_04  @positive  @reports
Scenario: Test by removing search params
      * def searchParams = withoutSearchParams
      * call read('../../core-services/pretests/getReport.feature@getreportSuccess')
      * print getReportsResponseBody
      * match getReportsResponseBody == '#present'

  @Report_InvalidSearchParams_05  @negative  @reports
 Scenario: Test by adding a invalid search param value
      * def searchParams = commonConstants.invalidParameters.invalidValue
      * call read('../../core-services/pretests/getReport.feature@getreportFail')
      * print getReportsResponseBody
      * assert getReportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidSearchparam

#@Report_InvalidSearchParamsNames_06  @negative  @reports
#Scenario: Test by seding a invalid search param names
     # * def searchParams = reportConstant.parameters.searchparams
     # * eval searchParams[0].name = ranString(4)
     # * eval searchParams[1].name = ''
     # * call read('../../core-services/pretests/getReport.feature@getreportFail')
     # * print getReportsResponseBody
     # * assert getReportsResponseBody.Errors[0].code == reportConstant.errormessages.invalidSearchParamsNames