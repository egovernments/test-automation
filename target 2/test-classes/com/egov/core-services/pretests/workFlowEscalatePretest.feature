Feature: Work Flow Pre Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
    #* def workFlowConstants = read('../../core-services/constants/workFlow.yaml')
    * def escalateWorkFlowRequest = read('../../core-services/requestPayload/egov-workflow/businessService/workFlowEscalate.json')

@autoEscalate
Scenario: To test the autoescalate feature
    Given url workFlowEscalateURL
        * print workFlowEscalateURL
      And request escalateWorkFlowRequest
    When method post
    Then status 200
      And def workFlowEscalateResponseHeader = responseHeaders
      And def workFlowEscalateResponseBody = response
      And def workFlowEscalateProcessInstance = response.ProcessInstances
        * print workFlowEscalateProcessInstance
      And def workFlowEscalateAction = response.action
      And def workFlowEscalateModuleName = response.moduleName
      And def workFlowEscalateSLA = response.state.sla
      And def workFlowEscalateState = response.state.state
      And def workFlowEscalateAppStatus = response.state.applicationStatus