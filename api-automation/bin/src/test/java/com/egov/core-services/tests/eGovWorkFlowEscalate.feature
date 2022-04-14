Feature: eGov egovWorkflowBusinessService service with create, search & update endpoints.

# This script is under development or piece of code is missing

Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
        * def workFlowConstants = read('../../core-services/constants/egovWorkflowBusinessService.yaml')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')

@autoescalate_PGR_01 @coreServices
Scenario: To verify the escalate API for the PGR complaints
        * call read('../../core-services/pretests/workFlowEscalatePretest.feature@autoEscalate')
        * match workFlowEscalateProcessInstance == '#present'
        * match workFlowEscalateProcessInstance == '#notnull'
                * print workFlowEscalateProcessInstance
        * match workFlowEscalateAction == '#present'
        * match workFlowEscalateAction == '#notnull'
        * match workFlowEscalateModuleName == '#present'
        * match workFlowEscalateModuleName == 'pgr-services'
                * print workFlowEscalateModuleName
        * match workFlowEscalateSLA == '#present'
        * match workFlowEscalateSLA == '300000'
        * match workFlowEscalateState == '#present'
        * match workFlowEscalateState == 'PENDINGATSUPERVISOR'
                * print workFlowEscalateState
        * match workFlowEscalateAppStatus == '#present'
        * match workFlowEscalateAppStatus == 'PENDINGATSUPERVISOR'
                * print workFlowEscalateAppStatus