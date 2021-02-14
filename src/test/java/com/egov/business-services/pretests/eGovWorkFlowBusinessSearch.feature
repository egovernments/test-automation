Feature: eGovWorkFlowBusiness Feature

    Background:
    * def jsUtils = read('classpath:jsUtils.js')
    
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../../business-services/pretests/authenticationToken.feature')
    * def workFlowConstants = read('../../business-services/constants/eGovWorkFlowBusiness.yaml')
    * def businessServices = workFlowConstants.inputData.businessServices
    * def searchWorkFlowRequest = read('../../business-services/requestPayload/eGovWorkFlow/business/workFlowSearch.json')
    
@SuccessSearchWorkFlow
Scenario: Search Work Flow
* configure headers = read('classpath:websCommonHeaders.js')
    * def parameters =
      """
      {
      tenantId: '#(tenantId)',
      businessServices: '#(businessServices)'
      }
      """
            Given url businessSearch
              And params parameters
              * print parameters
              And request searchWorkFlowRequest
              * print searchWorkFlowRequest
             When method post
             Then status 200
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response
              * print searchWorkFlowResponseBody
              And def businessService = searchWorkFlowResponseBody.BusinessServices[0].businessService
              * print businessService
              And def states = searchWorkFlowResponseBody.BusinessServices[0].states
              * print states
              