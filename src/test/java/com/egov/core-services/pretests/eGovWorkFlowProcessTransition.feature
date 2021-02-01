Feature: Verify the API call to move the workflow from one state to another

Background:
* def processTransitionPayload = read('../requestPayload/eGovWorkFlow/process/processtransition.json')
* def processTransiionPayloadValid = processTransitionPayload.valid
* def processTransiionPayloadInvalid = processTransitionPayload.valid
@processTransitionSuccess
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url workFlowProcessTrnsition 
     * print workFlowProcessTrnsition
     And request processTransiionPayloadValid
     * print processTransiionPayloadValid
     When method post
     Then status 200
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     * print processTransitionResponseBody

@processTransitionFail
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url workFlowProcessTrnsition 
     * print workFlowProcessTrnsition
     And request processTransiionPayloadValid
     * print processTransiionPayloadValid
     When method post
     Then status 400
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     * print processTransitionResponseBody

@processTransitionWithoutModuleName
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url workFlowProcessTrnsition 
     * print workFlowProcessTrnsition
     And request processTransiionPayloadInvalid
     * print processTransiionPayloadInvalid
     When method post
     Then status 400
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     * print processTransitionResponseBody

@processTransitionWithoutTenantId
Scenario: Verify the API call to move the workflow from one state to another
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url workFlowProcessTrnsition 
     * print workFlowProcessTrnsition
     And request processTransiionPayloadValid
     * print processTransiionPayloadValid
     When method post
     Then status 403
     And def processTransitionResponseHeader = responseHeaders
     And def processTransitionResponseBody = response
     * print processTransitionResponseBody