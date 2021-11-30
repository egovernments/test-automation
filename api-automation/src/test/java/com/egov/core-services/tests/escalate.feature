Feature: eGov escalate service.

# This script is under development or piece of code is missing

Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def escalateConstants = read('../../core-services/constants/escalate.yaml')
        * call read('../../core-services/pretests/escalatePretest.feature@autoEscalate')
        * def state = escalateConstants.parameters.input.state
        * def sla = escalateConstants.parameters.input.sla
        * def applicationStatus = escalateConstants.parameters.input.applicationStatus
        * def moduleName = escalateConstants.parameters.input.moduleName
@autoEscalate_PGR_01 @positive @escalateScenarios @coreServices
Scenario: To verify the escalate API for the PGR complaints
        * match escalateAction == '#present'
        * match escalateAction == '#notnull'

        * match escalateModuleName == '#present'
        * match escalateModuleName == '#(moduleName)'
                * print escalateModuleName
        
@autoEscalate_PGR_02 @positive @escalateScenarios @coreServices
Scenario: To verify the escalate API with sla, state, applicationStatus
        * match escalateSLA == '#present'
        * match escalateSLA == '#(sla)'

        * match escalateState == '#present'
        * match escalateState == '#(state)'
                * print escalateState
        * match escalateAppStatus == '#present'
        * match escalateAppStatus == '#(applicationStatus)'
                * print escalateAppStatus
@autoEscalate_PGR_03 @negative @escalateScenarios @coreServices
Scenario: To verify the escalate API with ProcessInstances
        * match escalateProcessInstance == '#notpresent'
        #* assert escalateProcessInstance == 
 