Feature: eGovWorkflow process transition
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  
  # This feature testing was blocked. Need to update
  * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
  * def businessId = acknowldgementNumber
  * call read('../../business-services/pretests/eGovWorkFlowBusinessSearch@SuccessSearchWorkFlow')

@Process_Transition_01  @regression @positive  @eGovWorkFlowProcess
Scenario: Verify the API call to move the workflow from one state to another
 # * def statesAction=
 # """
 #   for()
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionSuccess')
  * print processTransitionResponseBody

@Process_Transition_ActionError_02  @regression @negative  @eGovWorkFlowProcess
Scenario: Verify by passing the action which is not relevant or invalid action for that business id and check for errors
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionFail')  
  * print processTransitionResponseBody

@Process_Transition_NoModName_03  @regression @negative  @eGovWorkFlowProcess
Scenario: Verify by not passing module name and check for errors
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionWithoutModuleName')
  * print processTransitionResponseBody

@Process_Transition_InValidTenanId_04  @regression @negative  @eGovWorkFlowProcess
Scenario: Verify by passing a invalid/non existant /null tenant id and check for errors
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionWithoutTenantId') 
  * print processTransitionResponseBody

@Process_Transition_BusSerError_05  @regression @negative  @eGovWorkFlowProcess
Scenario: Verify by passing a invalid/non existant /null Business Service and check for errors
  * def businessService = 
  * call read('.././core-services/pretests/eGovWorkFlowProcessTransition.feature@processTransitionFail') 
  * print processTransitionResponseBody 

#@Process_Transition_InvalidBusId_06  @regression @negative  @eGovWorkFlowProcess
#Scenario: Verify by passing a invalid/non existant /null Business Service and check for errors

#@Process_Transition_NotAuthorised_07  @regression @negative  @eGovWorkFlowProcess
#Scenario: Verify if the user taking the action i.e calling the API has appropriate role as defined in workflow config. If he doesn't have the role API should throw an error
