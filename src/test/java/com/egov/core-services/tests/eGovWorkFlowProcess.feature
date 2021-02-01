Feature: eGovWorkflow process search
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../pretests/authenticationToken.feature')
  * def workFlowProcessSearchPayload = read('../requestPayload/eGovWorkFlow/process/processSearch.json')
  * def processSearchConstant = read('../constants/eGovWorkFlowProcessSearch.yaml')
  * def history = processSearchConstant.parameters.history
  * def businessIds = processSearchConstant.parameters.businessId
  * def commonConstants = read('../../common-services/constants/genericConstants')

@Search_01  @positive @egovworkflowprocess
Scenario: Perform search using business id, tenant and history 
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_withoutBusId_02  @positive  @egovworkflowprocess
Scenario: Perform search using only tenant and history 
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchwithoutbusinessid')
  * print processSearchResponseBody

@Search_onlyTenant_03  @positive  @egovworkflowprocess
Scenario: Perform search using only tenant 
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchonlytenantid')
  * print processSearchResponseBody

@Search_NoInputParams_04  @positive  @egovworkflowprocess
Scenario: Perform search by not passing any input params
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchnoparameter')
  * print processSearchResponseBody

@Search_Invaid_tenant_05  @negative  @egovworkflowprocess
Scenario: Perform search by passing invalid/non existent or null value for tenant id and check for errors
  * def tenantId = commonConstants.'Invalid-tenantId-' + ranString(5)
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchinvalidtenantid')
  * print processSearchResponseBody

@Search_Invaid_history_06  @negative  @egovworkflowprocess
Scenario: Perform search by passing invalid/non existent or null value for histroy and check for errors
  * def history = processSearchConstant.parameters.invalidHistory
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchfail')
  * print processSearchResponseBody 

@Search_MultipleTenant_07 @negative  @egovworkflowprocess
Scenario: Perform search by passing multple values for tenantId
  * def tenantId = processSearchConstant.parameters.multipleTenantId
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_MultipleBusIds_09  @negative  @egovworkflowprocess
Scenario: Perform search by passing multple values for Business Id
  * def businessIds = processSearchConstant.parameters.multipleBusinessId
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_OffsetLimit_10  @positive  @egovworkflowprocess
Scenario: Perform search by passing offset and limit
  * def start = processSearchConstant.parameters.start
  * def end = processSearchConstant.parameters.end 
  * call read('../pretests/eGovWorkFlowProcessSearch.feature@processsearchoffset&limit')
  * print processSearchResponseBody

  
  
  