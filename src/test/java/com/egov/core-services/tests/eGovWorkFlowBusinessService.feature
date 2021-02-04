Feature: eGov workflow service with create, search & update endpoints.

        Background:
                * def jsUtils = read('classpath:jsUtils.js')
                * configure headers = read('classpath:websCommonHeaders.js')
                * def createWorkFlowRequest = read('../../core-services/requestPayload/eGovWorkFlow/businessService/workFlowCreate.json')
                * def workFlowConstants = read('../../core-services/constants/workFlow.yaml')
                * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
                
                * def authUsername = authUsername
                * def authPassword = authPassword
                * def authUserType = authUserType
                * call read('../../common-services/pretests/authenticationToken.feature')
                * call read('../../core-services/pretests/workFlowPretest.feature@SuccessSearchWorkFlowGeneric')

        @Bus_Create_01 @positive @workflow
        Scenario: Happy path: Send a POST request to create a business service for a particular module
                * call read('../pretests/workFlowPretest.feature@SuccessCreateWorkFlow')
                * match workFlowCreateResponseBody.ResponseInfo.status == 'successful'
                * match workFlowCreateResponseBody.BusinessServices == '#notnull'

        @Bus_create_InvalidTenant_02 @negative @workflow
        Scenario: Error path : Send a POST request to create a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../pretests/workFlowPretest.feature@ErrorPathTestWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_create_Remove_parameters_03 @negative @workflow
        Scenario: Error path : Send a POST request to update a business service by removing actions, states,roles in between
                * call read('../pretests/workFlowPretest.feature@ErrorPathTestWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_create_InvalidNextState_04 @negative @workflow
        Scenario: Error path : Send a POST request to create a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../pretests/workFlowPretest.feature@ErrorPathTestWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Search_01 @positive @workflow
        Scenario: Happy path: Perform search using business id, tenant
                * def businessServices = workFlowConstants.inputData.businessServices
                * call read('../pretests/workFlowPretest.feature@SuccessSearchWorkFlow')
                * match searchWorkFlowResponseBody.ResponseInfo.status == 'successful'
                * match searchWorkFlowResponseBody.BusinessServices == '#notnull'
       
        @Bus_Search_InvalidTenant_02 @negative @workflow
        Scenario: Error path : Perform search by passing invalid/non existent or null value for tenant id and check for errors
                * def tenantId = 'invalidTenantId' + ranString(5)
                * call read('../pretests/workFlowPretest.feature@ErrorPathSearchTestWithInvalidTenantId')
                * match searchWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match searchWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Search_Multiple_03 @negative @workflow
        Scenario: Error path: Perform search using business id, tenant
                * call read('../pretests/workFlowPretest.feature@ErrorPathTestWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Update_01 @positive @workflow
        Scenario: Happy path: send a POST request to update a business service for a particular module by adding or removing a workflow
                * call read('../pretests/workFlowPretest.feature@SuccessCreateWorkFlow')
                * match workFlowCreateResponseBody.ResponseInfo.status == 'successful'
                * match workFlowCreateResponseBody.BusinessServices == '#notnull'

        @Bus_Update_InvalidTenant_02 @negative @workflow
        Scenario: Error path : send a POST request to update a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../pretests/workFlowPretest.feature@ErrorPathUpdateTestWithInvalidTenantId')
                * print workFlowUpdateResponseBody
                * match workFlowUpdateResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match workFlowUpdateResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Update_Remove_flow_03_Bus_Update_Remove_parameters_04 @negative @workflow
        Scenario: Error path : Send a POST request to update a business service by removing action
                * call read('../pretests/workFlowPretest.feature@ErrorPathTestWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Update_InvalidNextState_05 @negative @workflow
        Scenario: Error path : send a POST request to update a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../pretests/workFlowPretest.feature@ErrorPathTestWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId