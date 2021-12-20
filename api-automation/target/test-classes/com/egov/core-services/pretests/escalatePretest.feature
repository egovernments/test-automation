Feature: Auto Escalate Pre Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
    * def escalateRequest = read('../../core-services/requestPayload/escalate/escalate.json')
    * def escalateConstants = read('../../core-services/constants/escalate.yaml')
@autoEscalate 
Scenario: To test the autoescalate feature
* def autoEscalateParam = 
    """
    {
     tenantId: #(tenantId)
    }
    """
    Given url escalateURL
        * print escalateURL
    And params autoEscalateParam
    And request escalateRequest
    When method post
    Then status 200
      And def escalateResponseHeader = responseHeaders
      And def escalateResponseBody = response
      And def escalateProcessInstance = response.ProcessInstances[0]
      And def escalateAction = escalateProcessInstance.action
      And def escalateModuleName = escalateProcessInstance.moduleName
     # And def escalateSLA = stringToInteger(escalateProcessInstance.state.sla)
      And def escalateSLA = escalateProcessInstance.state.sla
      And def escalateState = escalateProcessInstance.state.state
      And def escalateAppStatus = escalateProcessInstance.state.applicationStatus

@autoEscalateError 
Scenario: To test the autoescalate api without tenantId
    Given url escalateURL
        * print escalateURL
    And request escalateRequest
    When method post
    Then status 200
      And def escalateErrorResponseHeader = responseHeaders
      And def escalateErrorResponseBody = response
      And def escalateErrorCode = response.Errors[].code
      And def escalateErrorMessage = response.Errors[].message

@autoEscalateCount 
Scenario: To test the autoescalate count feature
* def autoEscalateParam = 
    """
    {
     tenantId: #(tenantId)
    }
    """
    Given url escalateCountURL
        * print escalateCountURL
    And params autoEscalateParam
    And request escalateRequest
    When method post
    Then status 200
      And def escalateResponseHeader = responseHeaders
      And def escalateResponseBody = response
      And def escalateCount = response