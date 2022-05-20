Feature: eGov escalate service.

# This script is under development or piece of code is missing

Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def escalateConstants = read('../../core-services/constants/escalate.yaml')
        * def state = escalateConstants.parameters.input.state
        * def sla = escalateConstants.parameters.input.sla
        * def applicationStatus = escalateConstants.parameters.input.applicationStatus
        * def moduleName = escalateConstants.parameters.input.moduleName


@autoEscalate_PGR_01 @positive @escalateScenarios @coreServices
Scenario: To verify the escalate API for the PGR complaints
        * call read('../../core-services/pretests/escalatePretest.feature@autoEscalate')
        * match escalateAction == '#present'
        * match escalateAction == '#notnull'
        * match escalateModuleName == '#present'
        * match escalateModuleName == '#(moduleName)'
                * print escalateModuleName
        
@autoEscalate_PGR_02 @positive @escalateScenarios @coreServices
Scenario: To verify the escalate API with sla, state, applicationStatus
        * call read('../../core-services/pretests/escalatePretest.feature@autoEscalate')
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
        * call read('../../core-services/pretests/escalatePretest.feature@autoEscalate')
        * match escalateProcessInstance == '#notpresent'
        #* assert escalateProcessInstance == 

@autoEscalate_PGR_04 @negative @escalateScenarios @coreServices
Scenario: To verify the escalate API without tenantId
        * call read('../../core-services/pretests/escalatePretest.feature@autoEscalate')
        * match escalateErrorCode == '#notpresent'
        #* assert escalateProcessInstance == 

@autoEscalate_count1 @positive @escalateScenarios @coreServices @r2dot6updated @r2dot6
Scenario: To verify the escalate count API
        * call read('../../core-services/pretests/escalatePretest.feature@autoEscalateCount')
        * match escalateCount == '#present'


 