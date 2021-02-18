Feature: eGovWorkflow process search
Background:
 # read the javascript utils file for using generic methods
  * def jsUtils = read('classpath:jsUtils.js')
 # calling property creation test which is required for workflow process
  * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
  * def workFlowProcessSearchPayload = read('../../core-services/requestPayload/eGovWorkFlow/process/processSearch.json')
  * def processSearchConstant = read('../../core-services/constants/eGovWorkFlowProcessSearch.yaml')
  # initializing request payload objects
  * def history = 'true'
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def invalidHistory = commonConstants.invalidParameters.invalidValue
  * def businessIds = acknowldgementNumber

@Search_01  @regression @positive @egovWorkflowProcess
Scenario: Perform search using business id, tenant and history
 # calling search workflow pretest
 * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
 * match processSearchResponseBody == '#present'

@Search_withoutBusId_02  @regression @positive  @egovWorkflowProcess
Scenario: Perform search using only tenant and history
  # calling search workflow pretest
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessWithoutBusinessid')
  * match processSearchResponseBody == '#present'

@Search_onlyTenant_03  @regression @positive  @egovWorkflowProcess
Scenario: Perform search using only tenant
 # calling search workflow pretest
 * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessWithOnlyTenantid')
 * match processSearchResponseBody == '#present'

@Search_NoInputParams_04  @regression @positive  @egovWorkflowProcess
Scenario: Perform search by not passing any input params
 # calling search workflow pretest
 * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchProcessWithNoParameter')
 * match processSearchResponseBody == '#present'

@Search_Invaid_tenant_05  @regression @negative  @egovWorkflowProcess
Scenario: Perform search by passing invalid/non existent or null value for tenant id and check for errors
 #setting invalid tenantId for negative scenario
 * def tenantId = invalidTenantId
 # calling search workflow pretest
 * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchProcessWithInvalidTenantid')
 * match processSearchResponseBody == '#present'

@Search_Invaid_history_06  @regression @negative  @egovWorkflowProcess
Scenario: Perform search by passing invalid/non existent or null value for histroy and check for errors
 #setting invalid history for negative scenario
 * def history = invalidHistory
 # calling search workflow pretest
 * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchProcessError')
 * match processSearchResponseBody == '#present'

@Search_MultipleTenant_07 @regression @negative  @egovWorkflowProcess
Scenario: Perform search by passing multple values for tenantId
 #setting multiple tenantIds
 * def tenantId = mdmsCityTenant.tenants[1].code + ',' + mdmsCityTenant.tenants[3].code
 # calling search workflow pretest
 * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
 * match processSearchResponseBody == '#present'

@Search_MultipleBusIds_09  @regression @negative  @egovWorkflowProcess
Scenario: Perform search by passing multple values for Business Id
  * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
  #setting multiple businessIds for negative scenario
  * def multipleBusinessId = businessIds + ',' + acknowldgementNumber
  * eval businessIds = multipleBusinessId
  # calling search workflow pretest
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
  * match processSearchResponseBody == '#present'

@Search_OffsetLimit_10  @regression @positive  @egovWorkflowProcess
Scenario: Perform search by passing offset and limit
  #setting valid offset limit
  * def start = '1'
  * def end = '10'
  # calling search workflow pretest
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessOffsetAndLimit')
  * match processSearchResponseBody == '#present'

@Search_Assignee_11  @regression @positive  @egovworkflowprocess
Scenario: Perform Search by passing assignee param and check the sorting order (created time DESC). 
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchAssigneeSuccess')
  * match processSearchResponseBody == '#present'

@Search_NextAction_12  @regression @positive  @egovworkflowprocess
Scenario: Perform search and verify that the nextActions in search response is populated based on the role of user making search call
  * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * match processSearchResponseBody == '#present'

@Process_count  @regression @positive  @egovWorkflowProcess
Scenario: Perform search to get the count of process
  # calling search workflow process count pretest
  * call read('../../core-services/pretests/eGovWorkFlowProcessCount.feature@searchWorkflowProcessCountSuccessfully')
  * print processCountResponseBody
