Feature: eGovWorkflow process transition
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
  * def businessId = acknowldgementNumber
  * call read('../../business-services/preTests/eGovWorkFlowBusinessSearch@SuccessSearchWorkFlow')

@Process_Transition_01  @positive  @eGovWorkFlowProcess
Scenario: Verify the API call to move the workflow from one state to another
 # * def statesAction=
 # """
 #   for()
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
