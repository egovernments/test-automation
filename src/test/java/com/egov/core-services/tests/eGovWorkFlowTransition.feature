Feature: eGovWorkflow process transition
Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  
  # This feature testing was blocked. Need to update
  * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
  * def businessId = acknowldgementNumber
  * call read('../../business-services/pretest/eGovWorkFlowBusinessSearch.feature@SuccessSearchWorkFlow')

@Process_Transition_01  @positive  @egovWorkflowBusinessService @coreServices
Scenario: Verify the API call to move the workflow from one state to another
 # * def statesAction=
 # """
 #   for()
  * call read('../../core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionSuccess')
  

@Process_Transition_ActionError_02  @negative  @egovWorkflowBusinessService @coreServices
Scenario: Verify by passing the action which is not relevant or invalid action for that business id and check for errors
  * call read('../../core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionFail')  
  

@Process_Transition_NoModName_03  @negative  @egovWorkflowBusinessService @coreServices
Scenario: Verify by not passing module name and check for errors
  * call read('../../core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionWithoutModuleName')
  

@Process_Transition_InValidTenanId_04  @negative  @egovWorkflowBusinessService @coreServices
Scenario: Verify by passing a invalid/non existant /null tenant id and check for errors
  * call read('../../core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionWithoutTenantId') 
  

@Process_Transition_BusSerError_05  @negative  @egovWorkflowBusinessService @coreServices
Scenario: Verify by passing a invalid/non existant /null Business Service and check for errors
  # * def businessService = 
  * call read('../../core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionFail') 
   

#@Process_Transition_InvalidBusId_06  @negative  @egovWorkflowBusinessService @coreServices
#Scenario: Verify by passing a invalid/non existant /null Business Service and check for errors

#@Process_Transition_NotAuthorised_07  @negative  @egovWorkflowBusinessService @coreServices
#Scenario: Verify if the user taking the action i.e calling the API has appropriate role as defined in workflow config. If he doesn't have the role API should throw an error
