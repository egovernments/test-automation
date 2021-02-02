Feature: eGovWorkflow process search
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * call read('../../common-services/pretests/eGovMdmsPretest.feature@successSearchCity')
  * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
  * def workFlowProcessSearchPayload = read('../../core-services/requestPayload/eGovWorkFlow/process/processSearch.json')
  * def processSearchConstant = read('../../core-services/constants/eGovWorkFlowProcessSearch.yaml')
  * def history = 'true'
#  * def businessIds = processSearchConstant.parameters.businessId
  * def commonConstants = read('../../common-services/constants/genericConstants')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def invalidHistory = commonConstants.invalidParameters.invalidValue

@Search_01  @positive @egovworkflowprocess
Scenario: Perform search using business id, tenant and history 
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_withoutBusId_02  @positive  @egovworkflowprocess
Scenario: Perform search using only tenant and history 
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchwithoutbusinessid')
  * print processSearchResponseBody

@Search_onlyTenant_03  @positive  @egovworkflowprocess
Scenario: Perform search using only tenant 
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchonlytenantid')
  * print processSearchResponseBody

@Search_NoInputParams_04  @positive  @egovworkflowprocess
Scenario: Perform search by not passing any input params
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchnoparameter')
  * print processSearchResponseBody

@Search_Invaid_tenant_05  @negative  @egovworkflowprocess
Scenario: Perform search by passing invalid/non existent or null value for tenant id and check for errors
  * def tenantId = invalidTenantId
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchinvalidtenantid')
  * print processSearchResponseBody

@Search_Invaid_history_06  @negative  @egovworkflowprocess
Scenario: Perform search by passing invalid/non existent or null value for histroy and check for errors
  * def history = invalidHistory
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchfail')
  * print processSearchResponseBody 

@Search_MultipleTenant_07 @negative  @egovworkflowprocess
Scenario: Perform search by passing multple values for tenantId
  * def tenantId = tenant.tenants[1].code + ',' + tenant.tenants[3].code
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_MultipleBusIds_09  @negative  @egovworkflowprocess
Scenario: Perform search by passing multple values for Business Id
  * def businessIds = processSearchConstant.parameters.multipleBusinessId
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_OffsetLimit_10  @positive  @egovworkflowprocess
Scenario: Perform search by passing offset and limit
  * def start = '1'
  * def end = '10'
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchoffset&limit')
  * print processSearchResponseBody

@Process_count  @positive  @egovworkflowprocess
Scenario: Perform search to get the count of process
  * call read('.././core-services/pretests/eGovWorkFlowProcessCount.feature@processcountsuccess')
  * print processCountResponseBody

@Process_Transition_01  @positive  @eGovWorkFlowProcess
Scenario: Verify the API call to move the workflow from one state to another
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionSuccess')
  * print processTransitionResponseBody

@Process_Transition_ActionError_02  @negative  @eGovWorkFlowProcess
Scenario: Verify by passing the action which is not relevant or invalid action for that business id and check for errors
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionFail')  
  * print processTransitionResponseBody

@Process_Transition_NoModName_03  @negative  @eGovWorkFlowProcess
Scenario: Verify by not passing module name and check for errors
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionWithoutModuleName')
  * print processTransitionResponseBody

@Process_Transition_InValidTenanId_04  @negative  @eGovWorkFlowProcess
Scenario: Verify by passing a invalid/non existant /null tenant id and check for errors
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionWithoutTenantId') 
  * print processTransitionResponseBody

@Process_Transition_BusSerError_05  @negative  @eGovWorkFlowProcess
Scenario: Verify by passing a invalid/non existant /null Business Service and check for errors
  * def businessService = 
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionFail') 
  * print processTransitionResponseBody 

#@Process_Transition_InvalidBusId_06  @negative  @eGovWorkFlowProcess
#Scenario: Verify by passing a invalid/non existant /null Business Service and check for errors

#@Process_Transition_NotAuthorised_07  @negative  @eGovWorkFlowProcess
#Scenario: Verify if the user taking the action i.e calling the API has appropriate role as defined in workflow config. If he doesn't have the role API should throw an error

  

  
  
  