Feature: Bill Amendment Service Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    * def billAmendmentConstants = read('../../municipal-services/constants/billAmendment.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    

    @billAmendment_create_01 @positive @regression @municipalServices @billAmendmentService @billAmendmentServiceCreate
    Scenario: Verify creating a bill Amendment service application through API 
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Amendments[0] == '#present'

    @billAmendment_create_InvalidTenantId_02 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceCreate
    Scenario: Verify creating a bill Amendment service application through API with wrong tenantID 
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * def tenantId = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @billAmendment_create_emptyBusinessService_03 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceCreate
    Scenario: Verify creating a fire noc service application through API without business Service
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * def businessService = ""
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Errors[0].message == billAmendmentConstants.errorMessages.withoutBusinessService

    @billAmendment_create_invalid_amendmentReason_04 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceCreate
    Scenario: Verify creating a fire noc service application through API with invalid business amendment Reason
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * def amendmentReason = "invalid" + randomString(10)
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Errors[0].message == billAmendmentConstants.errorMessages.wrongAmendment

    @billAmendment_update_01 @positive @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API 
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@updateBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Amendments[0] == '#present'

    @billAmendment_update_invalid_AmendmentID_02 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API with invalid amendment ID
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * set billAmendmentResponseBody.Amendments[0].amendmentId = "invalid" + randomString(10)
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@updateBillAmendmentError')
    * match billAmendmentResponseBody.Errors[0].message == billAmendmentConstants.errorMessages.wrongAmendment

    @billAmendment_search_01 @positive @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API 
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"amendmentId": '#(amendmentId)', "businessService": '#(businessService)'}
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@searchBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Amendments[0] == '#present'

    @billAmendment_search_InvalidTenant_02 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API with invalid te
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * def tenantId = "invalid-tenant-" + randomString(10)
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"amendmentId": '#(amendmentId)', "businessService": '#(businessService)'}
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@searchBillAmendmentError')
    * match billAmendmentResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @billAmendment_search_InvalidAmendmentId_03 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API with invalid amendment id
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * def amendmentId = "invalid-tenant-" + randomString(10)
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"amendmentId": '#(amendmentId)', "businessService": '#(businessService)'}
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@searchBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Amendments[0] == '#notpresent'

    @billAmendment_search_InvalidBusinessService_04 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API with invalid business service
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * def businessService = "invalid-tenant-" + randomString(10)
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"amendmentId": '#(amendmentId)', "businessService": '#(businessService)'}
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@searchBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Amendments[0] == '#notpresent'

    @billAmendment_search_Without_BusinessService_05 @negative @regression @municipalServices @billAmendmentService @billAmendmentServiceUpdate
    Scenario: Verify creating a bill Amendment service application through API without business service
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@createPropertyAndPayFullTaxAsCitizen')
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@createBillAmendmentSuccessfully')
    * def getBillSearchParam = {"tenantId": '#(tenantId)',"amendmentId": '#(amendmentId)'}
    * call read('../../municipal-services/pretests/billAmendmentPretest.feature@searchBillAmendmentSuccessfully')
    * match billAmendmentResponseBody.Errors[0].message == billAmendmentConstants.errorMessages.wrongAmendment