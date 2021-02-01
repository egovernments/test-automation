Feature: eGov workflow service with create, search & update endpoints.

        Background:

        * def jsUtils = read('classpath:jsUtils.js')
        * configure headers = read('classpath:websCommonHeaders.js')
        * def createWorkFlowRequest = read('../requestPayload/workflow/workFlowCreate.json')
        * def workFlowConstants = read('../constants/workFlow.yaml')
        * def commonConstants = read('../constants/commonConstants.yaml')
        # Calling access token
        * def authUsername = counterEmployeeUserName
        * def authPassword = counterEmployeePassword
        * def authUserType = 'EMPLOYEE'
        * call read('../pretests/authenticationToken.feature')

        @Bus_Search_01 @positive @workflow
        Scenario: Happy path: Perform search using business id, tenant
        * def businessServices = workFlowConstants.inputData.businessServices
        * call read('../pretests/workFlowPretest.feature@SuccessSearchWorkFlow')
        * assert searchWorkFlowResponseBody.ResponseInfo.status == 'successful'
        * match searchWorkFlowResponseBody.BusinessServices == '#notnull'