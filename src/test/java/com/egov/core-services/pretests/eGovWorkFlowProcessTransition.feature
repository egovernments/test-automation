Feature: Verify the API call to move the workflow from one state to another

Background:
* call read('../../municipal-services/tests/PropertyService.feature@createProperty')
* def businessId = acknowldgementNumber
* def processTransitionPayload = read('../../core-services/requestPayload/egov-workflow/process/processtransition.json')
* def processTransiionPayloadValid = processTransitionPayload.valid
* def processTransiionPayloadInvalid = processTransitionPayload.valid

@processTransitionSuccess
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js') 
     Given url workflowTransition 
     
     And request processTransiionPayloadValid
     
     When method post
     Then status 200
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     

@processTransitionFail
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js') 
     Given url workflowTransition 
     
     And request processTransiionPayloadValid
     
     When method post
     Then status 400
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     

@processTransitionWithoutModuleName
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js') 
     Given url workflowTransition 
     
     And request processTransiionPayloadInvalid
     When method post
     Then status 400
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     

@processTransitionWithoutTenantId
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js') 
     Given url workflowTransition 
     
     And request processTransiionPayloadValid
     
     When method post
     Then status 403
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     