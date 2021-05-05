Feature: Work Flow Pre Tests

        Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def workFlowConstants = read('../../core-services/constants/workFlow.yaml')
    * def createWorkFlowRequest = read('../../core-services/requestPayload/eGovWorkFlow/businessService/workFlowCreate.json')
    * def searchWorkFlowRequest = read('../../core-services/requestPayload/eGovWorkFlow/businessService/workFlowUpdate.json')
    * def updateWorkFlowRequest = read('../../core-services/requestPayload/eGovWorkFlow/businessService/workFlowSearch.json')

        @createWorkFlowSuccessfully
        Scenario: Create Work Flow successfully
    * eval createWorkFlowRequest.BusinessServices[0] = BusinessServices
            Given url workFlowCreateURL
              And request createWorkFlowRequest
             When method post
             Then status 200
              And def workFlowCreateResponseHeader = responseHeaders
              And def workFlowCreateResponseBody = response

        @updateWorkFlowSuccessfully
        Scenario: Update Work Flow successfully
    * eval updateWorkFlowRequest.BusinessServices[0] = BusinessServices
            Given url workFlowUpdateURL
              And request updateWorkFlowRequest
             When method post
             Then status 200
              And def workFlowUpdateResponseHeader = responseHeaders
              And def workFlowUpdateResponseBody = response

        @createWorkflowWithInvalidTenantId
        Scenario: Create Workflow with invalid tenantId
    * set createWorkFlowRequest.tenantId = workFlowConstants.inputData.invalidTenantId
            Given url workFlowCreateURL
              And request createWorkFlowRequest
             When method post
             Then status 403
              And def createWorkFlowResponseHeader = responseHeaders
              And def createWorkFlowResponseBody = response

        @createWorkflowWithWithoutParameters
        Scenario: Create Workflow wihtout parameters
            Given url workFlowCreateURL
              And request createWorkFlowRequest
             When method post
             Then status 400
              And def createWorkFlowResponseHeader = responseHeaders
              And def createWorkFlowResponseBody = response

        @createWorkflowWithWithoutParameters
        Scenario: Create Workflow with invalid next state value
    * set createWorkFlowRequest.BusinessServices[0].states[0].actions[0].nextState = workFlowConstants.inputData.nextState
            Given url workFlowCreateURL
              And request createWorkFlowRequest
             When method post
             Then status 400
              And def createWorkFlowResponseHeader = responseHeaders
              And def createWorkFlowResponseBody = response

        @SuccessSearchWorkFlow
        Scenario: Search Work Flow
    * def parameters =
      """
      {
      tenantId: '#(tenantId)',
      businessServices: '#(businessServices)'
      }
      """
            Given url workFlowSearchURL
              And params parameters
              And request searchWorkFlowRequest
             When method post
             Then status 200
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response

        @ErrorPathSearchTestWithInvalidTenantId
        Scenario: Search Work Flow
    * def parameters =
      """
      {
      tenantId: '#(tenantId)',
      businessServices: '#(businessServices)'
      }
      """
            Given url workFlowSearchURL
              And params parameters
              And request searchWorkFlowRequest
             When method post
             Then status 403
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response

        @ErrorPathSearchWorkFlowWithMultipleDatSet
        Scenario: Search Work Flow
    * def parameters =
      """
      {
      tenantId: '#(tenantId)',
      businessServices: '#(businessServices)'
      }
      """
    
            Given url workFlowSearchURL
              And params parameters
    
              And request searchWorkFlowRequest
             When method post
             Then status 200
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response
  
  

        @updateWorkFlowSuccessfully_Test
        Scenario: Happy Path : Update Work Flow
    * eval updateWorkFlowRequest.BusinessServices[0] = BusinessServices
    
            Given url workFlowUpdateURL
              And request updateWorkFlowRequest
             When method post
             Then status 200
              And def workFlowUpdateResponseHeader = responseHeaders
              And def workFlowUpdateResponseBody = response
    
        @ErrorPathUpdateTestWithInvalidTenantId
        Scenario: Error Path : Update workflow with invalid tenantId value
    * set updateWorkFlowRequest.tenantId = workFlowConstants.inputData.invalidTenantId
            Given url workFlowUpdateURL
              And request updateWorkFlowRequest
             When method post
             Then status 403
              And def workFlowUpdateResponseHeader = responseHeaders
              And def workFlowUpdateResponseBody = response

        @ErrorPathUpdateTestWithInvalidNextState
        Scenario: Error Path : Update workflow with invalid next state value
    * set updateWorkFlowRequest.BusinessServices[0].states[0].actions[0].nextState = workFlowConstants.inputData.nextState
            Given url workFlowUpdateURL
              And request updateWorkFlowRequest
             When method post
             Then status 400
              And def workFlowUpdateResponseHeader = responseHeaders
              And def workFlowUpdateResponseBody = response

        @ErrorPathUpdateTestWithRemoveParameters
        Scenario: Error Path : Update Workflow with remove parameters
            Given url workFlowUpdateURL
              And request updateWorkFlowRequest
             When method post
             Then status 400
              And def updateWorkFlowResponseHeader = responseHeaders
              And def updateWorkFlowResponseBody = response

        @SuccessSearchWorkFlowGeneric
        Scenario: Search Work Flow
            Given url workFlowSearchURL
              And param tenantId = tenantId
              And request searchWorkFlowRequest
             When method post
             Then status 200
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response
              And def BusinessServices = searchWorkFlowResponseBody.BusinessServices[0]