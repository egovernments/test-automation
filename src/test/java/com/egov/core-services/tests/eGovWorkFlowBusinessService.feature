Feature: eGov egovWorkflowBusniessService service with create, search & update endpoints.

# This script is under development or piece of code is missing

        Background:
                * def jsUtils = read('classpath:jsUtils.js')
                * configure headers = read('classpath:websCommonHeaders.js')
                * def workFlowConstants = read('../../core-services/constants/egovWorkflowBusniessService.yaml')
                * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
                * call read('../../core-services/pretests/workFlowPretest.feature@SuccessSearchWorkFlowGeneric')

        @Bus_Create_01 @positive @egovWorkflowBusniessService
        Scenario: Happy path: Send a POST request to create a business service for a particular module
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkFlowSuccessfully')
                * print workFlowCreateResponseBody
                * match workFlowCreateResponseBody.ResponseInfo.status == 'successful'
                * match workFlowCreateResponseBody.BusinessServices == '#notnull'

        @Bus_create_InvalidTenant_02 @negative @egovWorkflowBusniessService
        Scenario: Error path : Send a POST request to create a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkflowWithInvalidTenantId')
                * print workFlowCreateResponseBody
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_create_Remove_parameters_03 @negative @egovWorkflowBusniessService
        Scenario: Error path : Send a POST request to update a business service by removing actions, states,roles in between
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkflowWithInvalidTenantId')
                * print workFlowCreateResponseBody
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_create_InvalidNextState_04 @negative @egovWorkflowBusniessService
        Scenario: Error path : Send a POST request to create a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkflowWithInvalidTenantId')
                * print workFlowCreateResponseBody
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Search_01 @positive @egovWorkflowBusniessService
        Scenario: Happy path: Perform search using business id, tenant
                * def businessServices = workFlowConstants.inputData.businessServices
                * call read('../../core-services/pretest/workFlowPretest.feature@SuccessSearchWorkFlow')
                * match searchWorkFlowResponseBody.ResponseInfo.status == 'successful'
                * match searchWorkFlowResponseBody.BusinessServices == '#notnull'
       
        @Bus_Search_InvalidTenant_02 @negative @egovWorkflowBusniessService
        Scenario: Error path : Perform search by passing invalid/non existent or null value for tenant id and check for errors
                * def tenantId = 'invalidTenantId' + ranString(5)
                * call read('../../core-services/pretest/workFlowPretest.feature@ErrorPathSearchTestWithInvalidTenantId')
                * print workFlowCreateResponseBody
                * match searchWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match searchWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Search_Multiple_03 @negative @egovWorkflowBusniessService
        Scenario: Error path: Perform search using business id, tenant
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkflowWithInvalidTenantId')
                * print workFlowCreateResponseBody
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Update_01 @positive @egovWorkflowBusniessService
        Scenario: Happy path: send a POST request to update a business service for a particular module by adding or removing a egovWorkflowBusniessService
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkFlowSuccessfully')
                * match workFlowCreateResponseBody.ResponseInfo.status == 'successful'
                * match workFlowCreateResponseBody.BusinessServices == '#notnull'

        @Bus_Update_InvalidTenant_02 @negative @egovWorkflowBusniessService
        Scenario: Error path : send a POST request to update a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../../core-services/pretest/workFlowPretest.feature@ErrorPathUpdateTestWithInvalidTenantId')
                * match workFlowUpdateResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match workFlowUpdateResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Update_Remove_flow_03_Bus_Update_Remove_parameters_04 @negative @egovWorkflowBusniessService
        Scenario: Error path : Send a POST request to update a business service by removing action
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkflowWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId

        @Bus_Update_InvalidNextState_05 @negative @egovWorkflowBusniessService
        Scenario: Error path : send a POST request to update a business service by passing invalid/non existent or null value for tenant id and check for errors
                * call read('../../core-services/pretest/workFlowPretest.feature@createWorkflowWithInvalidTenantId')
                * match createWorkFlowResponseBody.Errors[0].code == workFlowConstants.expectedCodes.invalidTenantId
                * match createWorkFlowResponseBody.Errors[0].description == workFlowConstants.expectedDescriptions.invalidTenantId