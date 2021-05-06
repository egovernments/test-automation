Feature: Egov Pdf Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * configure headers = read('classpath:websCommonHeaders.js')
    * def businessService = mdmsStatePropertyTax.PTWorkflow[1].businessService
    * def tenantId = mdmsStateFireNocService.FireStations[0].baseTenantId
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def eGovPdfConstants = read('../../core-services/constants/eGovPdf.yaml')
    * def UserId = eGovPdfConstants.users.UUID


    @ptmutationcertificate_01 @positive @regression @coreServices @eGovPdf @ptmutationcertificateSearch
    Scenario: Verify ptmutationcertificate application through API
    * def ptmutationcertificateSearchParam = {"uuid":'#(UserId)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptMutationCertificateSuccessfully')
    * match ptmutationcertificateResponseBody == '#present'

    @ptmutationcertificate_InvalidTenant_02 @negative @regression @coreServices @eGovPdf @ptmutationcertificateSearch
    Scenario: Verify ptmutationcertificate application through API with invalid tenantID
    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * def ptmutationcertificateSearchParam = {"uuid":'#(UserId)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptMutationCertificateError')
    * match ptmutationcertificateResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @ptmutationcertificate_InvalidUUID_03 @negative @regression @coreServices @eGovPdf @ptmutationcertificateSearch
    Scenario: Verify ptmutationcertificate application through API with invalid UUID
    * def UserId = randomString(8)
    * def ptmutationcertificateSearchParam = {"uuid":'#(UserId)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptMutationCertificateError1')
    * match ptmutationcertificateResponseBody.Errors[0].message == eGovPdfConstants.errorMessages.invalidUser

    @ptmutationcertificate_StatusError_04 @negative @regression @coreServices @eGovPdf @ptmutationcertificateSearch
    Scenario: Verify ptmutationcertificate application through API with invalid status
    * def UserId = eGovPdfConstants.users.UUID1
    * def ptmutationcertificateSearchParam = {"uuid":'#(UserId)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptMutationCertificateError2')
    * match ptmutationcertificateResponseBody.errorMessage == eGovPdfConstants.errorMessages.invalidstatus

    @ptmutationcertificate_MutationError_05 @negative @regression @coreServices @eGovPdf @ptmutationcertificateSearch
    Scenario: Verify ptmutationcertificate application through API with invalid mutations
    * def UserId = eGovPdfConstants.users.UUID2
    * def ptmutationcertificateSearchParam = {"uuid":'#(UserId)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptMutationCertificateError2')
    * match ptmutationcertificateResponseBody.errorMessage == eGovPdfConstants.errorMessages.invalidMutation

    @ptmutationcertificate_Mandatory_06 @negative @regression @coreServices @eGovPdf @ptmutationcertificateSearch
    Scenario: Verify ptmutationcertificate application through API without UUID
    * def ptmutationcertificateSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptMutationCertificateError2')
    * match ptmutationcertificateResponseBody.errorMessage == eGovPdfConstants.errorMessages.withoutUUID

    @consolidatedreceipt_01 @positive @regression @coreServices @eGovPdf @consolidatedreceiptSearch
    Scenario: Verify Consolidated Receipt application
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@propertyCreateAsCounterEmployee')
    * def businessService = businessService.split(".")[0]
    * def consolidatedReceiptSearchParam = {"consumerCode":'#(consumerCode)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@consolidatedreceiptSuccessfully')
    * match consolidatedReceiptResponseBody == '#present'

    @consolidatedreceipt_InvalidConsumerCode_02 @negative @regression @coreServices @eGovPdf @consolidatedreceiptSearch
    Scenario: Verify Consolidated Receipt application with invalid consumer code
    * def businessService = businessService.split(".")[0]
    * def consumerCode = randomString(8)
    * def consolidatedReceiptSearchParam = {"consumerCode":'#(consumerCode)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@consolidatedreceiptError')
    * match consolidatedReceiptResponseBody.Errors[0].message == eGovPdfConstants.errorMessages.invalidConsumerNo
    
    @consolidatedreceipt_InvalidTenant_03 @negative @regression @coreServices @eGovPdf @consolidatedreceiptSearch
    Scenario: Verify Consolidated Receipt application with invalid tenantID
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@propertyCreateAsCounterEmployee')
    * def businessService = businessService.split(".")[0]
    * def tenantId = randomString(8)
    * def consolidatedReceiptSearchParam = {"consumerCode":'#(consumerCode)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@consolidatedreceiptError1')
    * match consolidatedReceiptResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @consolidatedreceipt_BusSer_04 @negative @regression @coreServices @eGovPdf @consolidatedreceiptSearch
    Scenario: Verify Consolidated Receipt application with invalid bussiness Service code
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@propertyCreateAsCounterEmployee')
    * def businessService = randomString(8)
    * def consolidatedReceiptSearchParam = {"consumerCode":'#(consumerCode)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@consolidatedreceiptError')
    * match consolidatedReceiptResponseBody.Errors[0].message == eGovPdfConstants.errorMessages.invalidConsumerNo

    @consolidatedreceipt_TenantMandate_05 @negative @regression @coreServices @eGovPdf @consolidatedreceiptSearch
    Scenario: Verify Consolidated Receipt application withoout tenantID and consumer code
    * def consolidatedReceiptSearchParam = {"bussinessService": '#(businessService)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@consolidatedreceiptError2')
    * match consolidatedReceiptResponseBody.errorMessage == eGovPdfConstants.errorMessages.withoutTenantAndConsu

    @tlrenewalcertificate_01 @positive @regression @coreServices @eGovPdf @tlrenewalcertificateSearch
    Scenario: Verify tl renewal certification Application
    * call read('../../municipal-services/tests/tradeLicenseEndToEndFlow.feature@createTradeLicenseAndSubmitForRenewalCounterEmployee')
    * def applicationNumber = consumerCode
    * def tlrenewalcertificateSearchParam = {"applicationNumber":'#(applicationNumber)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlrenewalcertificateSuccessfully')
    * match tlrenewalcertificateResponseBody == '#present'

    @tlrenewalcertificate_Mandate_02 @positive @regression @coreServices @eGovPdf @tlrenewalcertificateSearch
    Scenario: Verify tl renewal certification Application without application number
    * def tlrenewalcertificateSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlrenewalcertificateError')
    * match tlrenewalcertificateResponseBody.errorMessage == eGovPdfConstants.errorMessages.withoutConsumerTenant

    @tlrenewalcertificate_Invalid_AppNo_03 @positive @regression @coreServices @eGovPdf @tlrenewalcertificateSearch
    Scenario: Verify tl renewal certification Application with invalid application number
    * def applicationNumber = randomString(8)
    * def tlrenewalcertificateSearchParam = {"applicationNumber":'#(applicationNumber)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlrenewalcertificateError1')
    * match tlrenewalcertificateResponseBody.Errors[0].message == eGovPdfConstants.errorMessages.invalidApplication

    @tlrenewalcertificate_AppNo_renewal_04 @positive @regression @coreServices @eGovPdf @tlrenewalcertificateSearch
    Scenario: Verify tl renewal certification Application without renewal application number
    * call read('../../municipal-services/tests/tradeLicenseEndToEndFlow.feature@createTradeLicenseAndApproveCounterEmployee')
    * def applicationNumber = consumerCode
    * def tlrenewalcertificateSearchParam = {"applicationNumber":'#(applicationNumber)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlrenewalcertificateError')
    * match tlrenewalcertificateResponseBody.errorMessage == eGovPdfConstants.errorMessages.withoutRenewalNumber

    @tlrenewalcertificate_InvalidTenant_05 @positive @regression @coreServices @eGovPdf @tlrenewalcertificateSearch
    Scenario: Verify tl renewal certification Application without renewal application number
    * call read('../../municipal-services/tests/tradeLicenseEndToEndFlow.feature@createTradeLicenseAndApproveCounterEmployee')
    * def applicationNumber = consumerCode
    * def tenantId = randomString(8)
    * def tlrenewalcertificateSearchParam = {"applicationNumber":'#(applicationNumber)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlrenewalcertificateError')
    * match tlrenewalcertificateResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @tlreceipt_01 @positive @regression @coreServices @eGovPdf @tlreceiptSearch
    Scenario: Verify tl Receipt Application
    * call read('../../municipal-services/tests/tradeLicenseEndToEndFlow.feature@createTradeLicenseAndApproveCounterEmployee')
    * def applicationNumber = consumerCode
    * def tlreceiptSearchParam = {"applicationNumber":'#(applicationNumber)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlreceiptSuccessfully')
    * match tlreceiptResponseBody == '#present'

    @tlreceipt_mandatory_02 @positive @regression @coreServices @eGovPdf @tlreceiptSearch
    Scenario: Verify tl Receipt Application
    * def tlreceiptSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@tlreceiptError')
    * match tlreceiptResponseBody.errorMessage == eGovPdfConstants.errorMessages.invalidTlReceipt

    @ptreceipt_01 @positive @regression @coreServices @eGovPdf @ptreceiptSearch
    Scenario: Verify tl Receipt Application
    * def businessService = businessService.split(".")[0]
    * def uuid = eGovPdfConstants.users.UUID
    * def ptreceiptSearchParam = {"uuid":'#(uuid)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptreceiptSuccessfully')
    * match ptreceiptResponseBody == '#present'

    @ptreceipt_mandatory_02 @negative @regression @coreServices @eGovPdf @ptreceiptSearch
    Scenario: Verify tl Receipt Application without UUID
    * def businessService = businessService.split(".")[0]
    * def ptreceiptSearchParam = {"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptreceiptError')
    * match ptreceiptResponseBody.errorMessage == eGovPdfConstants.errorMessages.notMadForPT

    @ptreceipt_InvalidTenant_03 @negative @regression @coreServices @eGovPdf @ptreceiptSearch
    Scenario: Verify tl Receipt Application with invalid tenantID
    * def businessService = businessService.split(".")[0]
    * def uuid = eGovPdfConstants.users.UUID
    * def tenantId = randomString(8)
    * def ptreceiptSearchParam = {"uuid":'#(uuid)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptreceiptError1')
    * match ptreceiptResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @ptreceipt_InvalidUUID_04 @negative @regression @coreServices @eGovPdf @ptreceiptSearch
    Scenario: Verify tl Receipt Application with invalid UUID
    * def businessService = businessService.split(".")[0]
    * def uuid = randomString(8)
    * def ptreceiptSearchParam = {"uuid":'#(uuid)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptreceiptError2')
    * match ptreceiptResponseBody.Errors[0].message == eGovPdfConstants.errorMessages.invalidUUID

    @ptbill_01 @positive @regression @coreServices @eGovPdf @ptbillSearch
    Scenario: Verify PTBill application
    * def businessService = businessService.split(".")[0]
    * def uuid = eGovPdfConstants.users.UUID
    * def ptbillSearchParam = {"uuid":'#(uuid)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptBillSuccessfully')
    * match ptBillResponseBody == '#present'

    @ptbill_mandatory_02 @negative @regression @coreServices @eGovPdf @ptbillSearch
    Scenario: Verify PTBill application without passing UUID and tenantID
    * def businessService = businessService.split(".")[0]
    * def ptbillSearchParam = {"bussinessService": '#(businessService)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptBillError')
    * match ptBillResponseBody.errorMessage == eGovPdfConstants.errorMessages.withoutTenantAndUUID

    @ptbill_invalidTenant_03 @negative @regression @coreServices @eGovPdf @ptbillSearch
    Scenario: Verify PTBill application without passing UUID and tenantID
    * def businessService = businessService.split(".")[0]
    * def uuid = eGovPdfConstants.users.UUID
    * def tenantId = randomString(8)
    * def ptbillSearchParam = {"uuid":'#(uuid)',"bussinessService": '#(businessService)',"tenantId": '#(tenantId)'}
    * call read('../../core-services/pretests/eGovPdfPreTest.feature@ptBillError1')
    * match ptBillResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    