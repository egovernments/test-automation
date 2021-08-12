Feature: Reports

  Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def reportConstant = read('../../core-services/constants/reports.yaml')
  # initializing get report request payload objects
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
  * def invalidSearchParams = 'INVALID' + randomString(2)
  # Calling common constant
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId

@MetadataGet_01  @coreServices @regression @positive  @reports
Scenario: Test to fetch the details of a report for a particular module
      # calling get report metadata pretest
      * call read('../../core-services/pretests/metadataGetReport.feature@getReportMetadataSuccessfully')
      
      * match reportsResponseBody == '#present'

@MetadataGet_InvalidReportName_02  @coreServices @regression @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def reportName = invalidReportName
      # calling get report metadata pretest
      * call read('../../core-services/pretests/metadataGetReport.feature@getReportMetadataError')
      
      * assert reportsResponseBody.Errors[0].message == reportConstant.errormessages.withoutReportName

@MetadataGet_InvalidTenant_03  @coreServices @regression @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def tenantId = invalidTenantId
      # calling get report metadata pretest
      * call read('../../core-services/pretests/metadataGetReport.feature@getReportMetadata403Error')
      
      * assert reportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidTenantId

@Report_Get_01  @coreServices @regression @positive  @reports
Scenario: Test to search for report data with different combinations of search inputs
      # calling get report pretest
      * call read('../../core-services/pretests/getReport.feature@getReportSuccessfully')
      
      * match getReportsResponseBody == '#present'

@Report_InvalidTenant_02  @coreServices @regression @negative  @reports
Scenario: Test by passing invalid/non existent or null value for tenant id
      * def tenantId = invalidTenantId
      # calling get report pretest
      * call read('../../core-services/pretests/getReport.feature@getReport403Error')
      
      * assert getReportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidTenantId

@Report_InvalidReportName_03  @coreServices @regression @negative  @reports
Scenario: Test by passing invalid/non existent or null value for reportname id
      * def secondReportName = invalidReportName
      # calling get report pretest
      * call read('../../core-services/pretests/getReport.feature@getReportError')
      
      * assert getReportsResponseBody.Errors[0].code == reportConstant.errormessages.noReportName

@Report_NoSeacrhParama_04  @coreServices @regression @positive  @reports
Scenario: Test by removing search params
      * def searchParams = []
      # calling get report pretest
      * call read('../../core-services/pretests/getReport.feature@getReportSuccessfully')
      
      * match getReportsResponseBody == '#present'

@Report_InvalidSearchParams_05  @coreServices @regression @negative  @reports
Scenario: Test by adding a invalid search param value
      * def searchParams = commonConstants.invalidParameters.invalidValue
      # calling get report pretest
      * call read('../../core-services/pretests/getReport.feature@getReportError')
      
      * assert getReportsResponseBody.Errors[0].message == reportConstant.errormessages.invalidSearchparam