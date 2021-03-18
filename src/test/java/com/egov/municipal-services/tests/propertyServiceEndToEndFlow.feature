Feature: Property Service - End to End Flow

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def propertyServicesConstants = read('../../municipal-services/constants/propertyServices.yaml')
    * def businessService = mdmsStateBillingService.BusinessService[0].code
    * def envCommon = read('file:envYaml/common/common.yaml')
    * def gateway = commonConstants.parameters.gateway
    * def callbackUrl = envHost + envCommon.endPoints.pgServices.payload
    * def pgServicesCreatePayload = read('../../core-services/requestPayload/pgServices/pgServicesCreate.json')
    # Create Demand details
    * def consumerType = mdmsStateBillingService.BusinessService[0].businessService
   # * def businessService = mdmsStateBillingService.BusinessService[0].code
    * def taxPeriodFrom = getCurrentEpochTime()
    * def taxPeriodTo = getEpochDate(2)
    * def taxHeadMasterCodes = karate.jsonPath(mdmsStateBillingService, "$.TaxHeadMaster[?(@.service=='" + businessService + "')].code")
    * def taxHeadMasterCode = taxHeadMasterCodes[randomNumber(taxHeadMasterCodes.length)]
    * def collectionAmount = 0
    * def minimumAmountPayable = 1
    * def createDemandRequest = read('../../business-services/requestPayload/billing-service-demand/create.json')
    * def apportionServiceData = read('../../business-services/constants/apportionService.yaml')
    * def userOtpConstant = read('../../core-services/constants/userOtp.yaml')
    * def isAdvanceAllowed = apportionServiceData.parameters.isAdvanceAllowed
    * def expiryDate = getTomorrowEpochTime()
    * def fromPeriod = getCurrentEpochTime()
    * def toPeriod = getCurrentEpochTime()
    * def billAmount1 = randomNumber(3)
    * def billAmount2 = randomNumber(3)
    * def billAmount3 = randomNumber(3)
    * def billAmount4 = randomNumber(3)
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def pdfCreateConstant = read('../../core-services/constants/pdfService.yaml')
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def nameOfAuthorizedPerson = randomString(5)
    * def designation = 'Automation-'+randomString(3)
    * def type = 'CENTRALGOVERNMENT'
    * def institutionName = nameOfAuthorizedPerson
    * def institutionType = type
    * def landlineNumber = '03357527334'
    * def correspondenceAddress = randomString(5)
    * def permanentAddress = randomString(10)
    * def previousPropertyUuid = null
    * def caseDetails = randomString(5)
    * def isMutationInCourt = 'NO'
    * def govtAcquisitionDetails = ''
    * def isPropertyUnderGovtPossession = 'NO'
    * def reasonForTransfer = mdmsStatePropertyTax.ReasonForTransfer[0].code
    * def marketValue = ranInteger(3)
    * def documentNumber = randomString(5)
    * def documentDate = getCurrentEpochTime()
    * def documentValue = ranInteger(3)
    * def key = pdfCreateConstant.parameters.valid.keyForPt
    * def invalidReceipt = 'invalid_'+randomNumber(5)
     
@ceatePropertAndPayFullTaxAsCitizen @propertyTaxEndToEnd
Scenario: Login as a citizen and pay propety tax (Full Payment)
    # Steps to valid error messages of login attempt with invalid mobile number
    * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidMobileNo')
    * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
    * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')  
    * print propertyId
    * def consumerCode = propertyId
    # Calculate Property Tax estimate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    * def taxAmount = propertyTaxEstimateResponse.Calculation[0].taxAmount
    * def businessService = businessService.split(".")[0]
    # Creating Bill Demand with taxamount
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to Fetach bill
    * def consumerCode = propertyId
    * def fetchBillParams = {tenantId: '#(tenantId)',consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    # Steps to initiate Payment
    * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
    # Steps to update the Payment
    * call read('../../core-services/pretests/pgServiceUpdate.feature@updateTransactionOnly')
    * match pgServicesUpdateResponseBody.Transaction[0].txnStatusMsg != propertyServicesConstants.errorMessages.transactionGatewayFailed
    # Payment is blocked for automation. It cannot be automate due to 3rd party payment gatway dependencies
    

@ceatePropertAndPayPartialTaxAsCitizen @propertyTaxEndToEnd
Scenario: Login as a citizen and pay propety tax (Partial Payment)
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')  
    * print propertyId
    * def consumerCode = propertyId
    # Calculate Property Tax estimate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    * def taxAmount = propertyTaxEstimateResponse.Calculation[0].taxAmount
    * def businessService = businessService.split(".")[0]
    # Creating Bill Demand with taxamount
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to Fetach bill
    * def consumerCode = propertyId
    * def fetchBillParams = {tenantId: '#(tenantId)',consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    * def txnAmount = '200'
    * def amountPaid = '200'
    # Steps to initiate Payment
    * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
    # Steps to update the Payment
    * call read('../../core-services/pretests/pgServiceUpdate.feature@updateTransactionOnly')
    * match pgServicesUpdateResponseBody.Transaction[0].txnStatusMsg != propertyServicesConstants.errorMessages.transactionGatewayFailed
    # Payment is blocked for automation. It cannot be automate due to 3rd party payment gatway dependencies
    

@searchReceiptAndCancel @propertyTaxEndToEnd 
Scenario: Receipt search and cancellation
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    #* call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')  
    * def receiptNumber = collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber
    * def parameters = {tenantId: '#(tenantId)',receiptNumber: '#(receiptNumber)'}
    # Steps to search payment with specified parameters
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')
    * print collectionServicesResponseBody
    * match collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber
    * match collectionServicesResponseBody.Payments[0].paymentStatus == 'CANCELLED'

@sendBackByDocVerifierAndReopen @propertyTaxEndToEnd
Scenario: PT- Doc- Verifier- Send Back to Citizen -Citizen Reopen
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@sendBackProperty')
    #* print sendBackResponseBody
    * def businessIds = sendBackResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0].action == 'SENDBACKTOCITIZEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'CORRECTIONPENDING'
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@reopenProperty')
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0].action == 'REOPEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'OPEN'

@sendBackByDocVerifierAndEdit @propertyTaxEndToEnd
Scenario: PT- Doc- Verifier- Send Back to Citizen - Citizen Edit
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@sendBackProperty')
    * print propertyId
    * def businessIds = sendBackResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0].action == 'SENDBACKTOCITIZEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'CORRECTIONPENDING'
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@reopenProperty')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * match propertyServiceResponseBody.Properties[0].status == 'INWORKFLOW'
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'OPEN'


@sendBackAndRejectByCitizen @propertyTaxEndToEnd
Scenario: PT- Doc- Verifier- Send Back to Citizen -Citizen Rejects
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@sendBackProperty')
    * print propertyId
    * def businessIds = sendBackResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0].action == 'SENDBACKTOCITIZEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'CORRECTIONPENDING'
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@rejectProperty')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * match propertyServiceResponseBody.Properties[0].status == 'INACTIVE'
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'REJECTED'

@rejectByDocVerifier @propertyTaxEndToEnd
Scenario: PT- Doc-Verifier- Reject
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@rejectProperty')
    * print propertyId
    * def businessIds = rejectResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0].action == 'REJECT'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'REJECTED'

@rejectByApprover @propertyTaxEndToEnd
Scenario: PT-Approver-Reject
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@rejectProperty')
    * print propertyId
    * def businessIds = rejectResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    * match processSearchResponseBody.ProcessInstances[0].action == 'REJECT'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'REJECTED'

#TODO: Need to revisit again. Once Tax payment module is fixed
@transferOwnerShip @propertyTaxEndToEnd
Scenario: PT- Transfer Of Ownership- Citizen
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@ceatePropertAndPayFullTaxAsCitizen')
    * print propertyId
    * def mobileNumber = '9999999999'
    * def altContactNumber = '78' + randomMobileNumGen(8)
    * def OwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[2].code
	* set transferOwnershipRequest.Property['ownersTemp'][0].permanentAddress = permanentAddress
    * def transferParameters = {tenantId:'#(tenantId)',propertyIds:'#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@transferOwnership')
    # TODO: Need to fetch acknowldgementNumber, which is only possible once Property tax paid successfully
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenOfAltCitizen')
    * def searchPropertyParams = { acknowledgementIds: '#(acknowldgementNumber)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenOfAltCitizen') 
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * def consumerCode = propertyId
    # Calculate Property Tax estimate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    * def taxAmount = propertyTaxEstimateResponse.Calculation[0].taxAmount
    * def businessService = businessService.split(".")[0]
    # Creating Bill Demand with taxamount
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to Fetach bill
    * def consumerCode = propertyId
    * def fetchBillParams = {tenantId: '#(tenantId)',consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    # Steps to initiate Payment
    * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
    # Steps to update the Payment
    * call read('../../core-services/pretests/pgServiceUpdate.feature@updateTransactionOnly') 
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxMutation')

@differentOwnershipCategory @propertyTaxEndToEnd
Scenario: PT- Create for different ownership category 
    * def OwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[2].code
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * match propertyServiceResponseBody.Properties[0].status == 'INWORKFLOW'

@propertyCreateAsCounterEmployee @propertyTaxEndToEnd
Scenario: Login as a counter employee and pay propety tax
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCounterEmployee')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../common-services/pretests/authenticationToken.feature') 
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * print propertyId
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    * def taxAmount = propertyTaxEstimateResponse.Calculation[0].taxAmount
    * def businessService = businessService.split(".")[0]
    # Creating Bill Demand with taxamount
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to Fetach bill
    * def consumerCode = propertyId
    * def fetchBillParams = {tenantId: '#(tenantId)',consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * match collectionServicesResponseBody.Payments[0].totalAmountPaid == taxAmount
    * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForPtSuccessfully')
    * match pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
    * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'
    
@mCollect @propertyTaxEndToEnd
Scenario: mCollect- Universal Collection  
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def receiptNumber = collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber
    * def parameters = {tenantId: '#(tenantId)',receiptNumber: '#(receiptNumber)'}
    # Steps to search payment with specified parameters
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * def parameters = {tenantId: '#(tenantId)',receiptNumbers: '#(invalidReceipt)'}
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments.length == 0
    # Validate that Payment details should not present in the response body as receipt number is invalid
    * match searchResponseBody.Payments[0] == '#notpresent'
    * def key = pdfCreateConstant.parameters.valid.keyForTl
    * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfSuccessfully')