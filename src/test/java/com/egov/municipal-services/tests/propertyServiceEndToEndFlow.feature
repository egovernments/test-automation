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
    * def propertyTaxEstimatePayload = read('../../municipal-services/requestPayload/property-calculator/propertyTax/estimate.json')
     
@ceatePropertAndPayFullTaxAsCitizen @propertyTaxEndToEnd
Scenario: Login as a citizen and pay propety tax (Full Payment)
    # Steps to valid error messages of login attempt with invalid mobile number
    * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidMobileNo')
    * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
    * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to verify the PT application as a Doc Verifier
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    # Steps to forward the PT application as a Field Inspector
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    # Steps to approve the property application as an approver
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    # Steps to re-login as Cityzen type of user
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    # Steps to Assess the property
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty') 
    * print propertyId
    * def consumerCode = propertyId
    # Calculate Property Tax estimate
    * def financialYear = Assessment.financialYear
    * def source = Assessment.source
    * def channel = Assessment.channel
    * set propertyTaxEstimatePayload['Assessment'].financialYear = financialYear
    * set propertyTaxEstimatePayload['Assessment'].propertyId = propertyId
    * set propertyTaxEstimatePayload['Assessment'].source = source
    * set propertyTaxEstimatePayload['Assessment'].channel = channel
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    * def taxAmount = propertyTaxEstimateResponse.Calculation[0].taxAmount
    * def businessService = businessService.split(".")[0]
    # Creating Bill Demand with taxamount
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to Fetach bill
    * def consumerCode = propertyId
    * def fetchBillParams = {tenantId: '#(tenantId)',consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    # Steps to fetch the bill details
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    # Steps to initiate Payment
    * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
    #TODO: Need to add Property Tax Payment steps through Third party payment gateway
    # Steps to update the Payment
    * call read('../../core-services/pretests/pgServiceUpdate.feature@updateTransactionOnly')
    * match pgServicesUpdateResponseBody.Transaction[0].txnStatusMsg != propertyServicesConstants.errorMessages.transactionGatewayFailed
    
@ceatePropertAndPayPartialTaxAsCitizen @propertyTaxEndToEnd
Scenario: Login as a citizen and pay propety tax (Partial Payment)
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to verify the PT application as a Doc Verifier
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    # Steps to forward the PT application as a Field Inspector
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    # Steps to approve the property application as an approver
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    # Steps to re-login as Cityzen type of user
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    # Steps to Assess the property
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
    # Steps to fetch the bill details
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    # Re defining amount to make partial or customised payment.  
    * def txnAmount = '200'
    * def amountPaid = '200'
    # Steps to initiate Payment
    * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
    #TODO: Need to add Property Tax Payment steps through Third party payment gateway
    # Steps to update the Payment
    * call read('../../core-services/pretests/pgServiceUpdate.feature@updateTransactionOnly')
    * match pgServicesUpdateResponseBody.Transaction[0].txnStatusMsg != propertyServicesConstants.errorMessages.transactionGatewayFailed
    
@searchReceiptAndCancel @propertyTaxEndToEnd 
Scenario: Receipt search and cancellation
    # Steps to create an property
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    # Preparing search parameters
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to ACTIVE the created property and assess
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # Steps to fetch the bill details
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a Payment based upon the bill id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')  
    * def receiptNumber = collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber
    * def parameters = {tenantId: '#(tenantId)',receiptNumber: '#(receiptNumber)'}
    # Steps to search payment with specified parameters
    * call read('../../business-services/pretest/collectionServicesPretest.feature@searchPaymentWithParams')
    * assert searchResponseBody.Payments[0].paymentDetails.length != 0
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Steps to Cancel the reciept 
    * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')
    * print collectionServicesResponseBody
    # Validate the receipt number and payment status which should be `CANCELLED` now
    * match collectionServicesResponseBody.Payments[0].paymentDetails[0].receiptNumber == receiptNumber
    * match collectionServicesResponseBody.Payments[0].paymentStatus == 'CANCELLED'

@sendBackByDocVerifierAndReopen @propertyTaxEndToEnd
Scenario: PT- Doc- Verifier- Send Back to Citizen -Citizen Reopen
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to `Send back the property to Cititzen by a Doc Verifier`
    * call read('../../municipal-services/tests/PropertyService.feature@sendBackProperty')
    * def businessIds = sendBackResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the property status which should be `SENDBACKTOCITIZEN`
    * match processSearchResponseBody.ProcessInstances[0].action == 'SENDBACKTOCITIZEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'CORRECTIONPENDING'
    # Re-login as a Citizen
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    # Steps to Reopen the property
    * call read('../../municipal-services/tests/PropertyService.feature@reopenProperty')
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the property status which should be `REOPEN`
    * match processSearchResponseBody.ProcessInstances[0].action == 'REOPEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'OPEN'

@sendBackByDocVerifierAndEdit @propertyTaxEndToEnd
Scenario: PT- Doc- Verifier- Send Back to Citizen - Citizen Edit
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to `Send back the property to Cititzen by a Doc Verifier`
    * call read('../../municipal-services/tests/PropertyService.feature@sendBackProperty')
    * print propertyId
    * def businessIds = sendBackResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the property status which should be `SENDBACKTOCITIZEN`
    * match processSearchResponseBody.ProcessInstances[0].action == 'SENDBACKTOCITIZEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'CORRECTIONPENDING'
    # Re-login as a Citizen
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    # Steps to edit the property and again submit it
    * call read('../../municipal-services/tests/PropertyService.feature@reopenProperty')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Validate the property status which should be `INWORKFLOW`
    * match propertyServiceResponseBody.Properties[0].status == 'INWORKFLOW'
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the property state which should be `OPEN`
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'OPEN'

@sendBackAndRejectByCitizen @propertyTaxEndToEnd
Scenario: PT- Doc- Verifier- Send Back to Citizen -Citizen Rejects
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to `Send back the property to Cititzen by a Doc Verifier`
    * call read('../../municipal-services/tests/PropertyService.feature@sendBackProperty')
    * print propertyId
    * def businessIds = sendBackResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the property status which should be `SENDBACKTOCITIZEN`
    * match processSearchResponseBody.ProcessInstances[0].action == 'SENDBACKTOCITIZEN'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'CORRECTIONPENDING'
    # Re-login as Citizen 
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    # Steps to Reject the property by Citizen
    * call read('../../municipal-services/tests/PropertyService.feature@rejectProperty')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Validate the status which should be `INACTIVE`
    * match propertyServiceResponseBody.Properties[0].status == 'INACTIVE'
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the state which should be `REJECTED`
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'REJECTED'

@rejectByDocVerifier @propertyTaxEndToEnd
Scenario: PT- Doc-Verifier- Reject
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to `Reject ` the property application as a Doc Verifier
    * call read('../../municipal-services/tests/PropertyService.feature@rejectProperty')
    * print propertyId
    * def businessIds = rejectResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the action and state which should be `REJECT` and `REJECTED`
    * match processSearchResponseBody.ProcessInstances[0].action == 'REJECT'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'REJECTED'

@rejectByApprover @propertyTaxEndToEnd
Scenario: PT-Approver-Reject
    # Steps to login as Citizen and Create a Property with `INWORKFLOW` status
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    # Steps to `Reject ` the property application as a Approver
    * call read('../../municipal-services/tests/PropertyService.feature@rejectProperty')
    * print propertyId
    * def businessIds = rejectResponseBody.Properties[0].acknowldgementNumber
    * def history = true
    * call read('../../core-services/pretests/eGovWorkFlowProcessSearch.feature@searchWorkflowProcessSuccessfully')
    # Validate the action and state which should be `REJECT` and `REJECTED`
    * match processSearchResponseBody.ProcessInstances[0].action == 'REJECT'
    * match processSearchResponseBody.ProcessInstances[0]['state'].state == 'REJECTED'

#TODO: Need to revisit again. Once Tax payment module is fixed
@transferOwnerShip @propertyTaxEndToEnd
Scenario: PT- Transfer Of Ownership- Citizen
    # Steps to create an Active property and Pay full tax 
    * call read('../../municipal-services/tests/propertyServiceEndToEndFlow.feature@ceatePropertAndPayFullTaxAsCitizen')
    * print propertyId
    * def mobileNumber = '9999999999'
    * def altContactNumber = '78' + randomMobileNumGen(8)
    * def OwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[2].code
	* set transferOwnershipRequest.Property['ownersTemp'][0].permanentAddress = permanentAddress
    * def transferParameters = {tenantId:'#(tenantId)',propertyIds:'#(propertyId)'}
    # Steps to transfer the owner ship to another citizen
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@transferOwnership')
    # TODO: Need to fetch acknowldgementNumber, which is only possible once Property tax paid successfully
    # Steps to Re-login with alternate Citzen user
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
    # Defining another ownership category
    * def OwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[2].code
    # Steps to login as a Citizen and create a Property
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Steps to search the property details
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Validate the status as `INWORKFLOW`
    * match propertyServiceResponseBody.Properties[0].status == 'INWORKFLOW'

@propertyCreateAsCounterEmployee @propertyTaxEndToEnd
Scenario: Login as a counter employee and pay propety tax
    # Create an Active Property as a Counter Employee
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenApprover')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * print propertyId
    # Steps to Estimate the property tax
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    * def taxAmount = propertyTaxEstimateResponse.Calculation[0].taxAmount
    * def businessService = businessService.split(".")[0]
    # Creating Bill Demand with taxamount
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
    # Steps to Fetach bill
    * def consumerCode = propertyId
    * def fetchBillParams = {tenantId: '#(tenantId)',consumerCode: '#(consumerCode)', businessService: '#(businessService)'}
    # Steps to fetch the bill id
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * print billId
    * def name = fetchBillResponse.Bill[0].payerName
    * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
    # Steps to create a payment based on the bill id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * match collectionServicesResponseBody.Payments[0].totalAmountPaid == taxAmount
    * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForPtSuccessfully')
    # Validate the response message and length of role array 
    * match pdfCreateResponseBody.message == pdfCreateConstant.expectedMessages.message
    * match pdfCreateResponseBody.ResponseInfo.userInfo.roles.length == '##[_ > 0]'
    
@mCollect @propertyTaxEndToEnd
Scenario: mCollect- Universal Collection  
    # Steps to create Billing service demand
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    # Steps to fetch the bill id
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    # Steps to create a payment based on the bill id
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
    # Steps to create PDF
    * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfSuccessfully')