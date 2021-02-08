Feature: eGovWorkflow process search
        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * call read('../../municipal-services/tests/propertyService.feature@createProperty')
  * def workFlowProcessSearchPayload = read('../../core-services/requestPayload/eGovWorkFlow/process/processSearch.json')
  * def processSearchConstant = read('../../core-services/constants/eGovWorkFlowProcessSearch.yaml')
  * def history = 'true'
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def invalidHistory = commonConstants.invalidParameters.invalidValue
  * def businessIds = acknowldgementNumber

        @Search_01  @positive @egovWorkflowProcess
        Scenario: Perform search using business id, tenant and history
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
  * print processSearchResponseBody

        @Search_withoutBusId_02  @positive  @egovWorkflowProcess
        Scenario: Perform search using only tenant and history
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessWithoutBusinessid')
  * print processSearchResponseBody

        @Search_onlyTenant_03  @positive  @egovWorkflowProcess
        Scenario: Perform search using only tenant
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessWithOnlyTenantid')
  * print processSearchResponseBody

        @Search_NoInputParams_04  @positive  @egovWorkflowProcess
        Scenario: Perform search by not passing any input params
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchProcessWithNoParameter')
  * print processSearchResponseBody

        @Search_Invaid_tenant_05  @negative  @egovWorkflowProcess
        Scenario: Perform search by passing invalid/non existent or null value for tenant id and check for errors
  * def tenantId = invalidTenantId
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchProcessWithInvalidTenantid')
  * print processSearchResponseBody

        @Search_Invaid_history_06  @negative  @egovWorkflowProcess
        Scenario: Perform search by passing invalid/non existent or null value for histroy and check for errors
  * def history = invalidHistory
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchProcessError')
  * print processSearchResponseBody 

        @Search_MultipleTenant_07 @negative  @egovWorkflowProcess
        Scenario: Perform search by passing multple values for tenantId
  * def tenantId = mdmsCityTenant.tenants[1].code + ',' + mdmsCityTenant.tenants[3].code
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
  * print processSearchResponseBody

        @Search_MultipleBusIds_09  @negative  @egovWorkflowProcess
        Scenario: Perform search by passing multple values for Business Id
  * call read('../../municipal-services/tests/propertyService.feature@createProperty')
  * def multipleBusinessId = businessIds + ',' + acknowldgementNumber
  * eval businessIds = multipleBusinessId
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
  * print processSearchResponseBody

        @Search_OffsetLimit_10  @positive  @egovWorkflowProcess
        Scenario: Perform search by passing offset and limit
  * def start = '1'
  * def end = '10'
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessOffsetAndLimit')
  * print processSearchResponseBody

        @Process_count  @positive  @egovWorkflowProcess
        Scenario: Perform search to get the count of process
  * call read('../../core-services/pretests/eGovWorkFlowProcessCount.feature@searchWorkflowProcessCountSuccessfully')
  * print processCountResponseBody
