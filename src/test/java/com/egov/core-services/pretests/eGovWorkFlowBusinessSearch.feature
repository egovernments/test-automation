Feature: eGovWorkFlowBusiness Feature

    Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def workFlowConstants = read('../constants/workFlow.yaml')
    * def commonConstants = read('../constants/commonConstants.yaml')
    * def searchWorkFlowRequest = read('../requestPayload/workFlow/workFlowSearch.json')

@SuccessSearchWorkFlow
        Scenario: Search Work Flow
    * def parameters =
      """
      {
      tenantId: '#(tenantId)',
      businessServices: '#(businessServices)'
      }
      """
    * print searchWorkFlowRequest
            Given url workFlowSearchURL
              And params parameters
    * print parameters
              And request searchWorkFlowRequest
             When method post
             Then status 200
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response
    * print workFlowSearchURL
    * print searchWorkFlowResponseBody