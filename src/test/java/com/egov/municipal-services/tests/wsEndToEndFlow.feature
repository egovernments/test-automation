Feature: Water and Sewerage End to End test flow

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def waterConnectionConstants = read('../../municipal-services/constants/waterConnection.yaml')


###########################
#    TODO: Need to revisit the below tests where Payment needs to be made through third party payment gateway
#        @payWaterServiceTaxFullAsCitizen
#        @payWaterServiceTaxPartialAsCitizen
#        @payWaterServiceTaxNonMeteredFullAsCitizen
#        @payWaterServiceTaxNonMeteredPartialAsCitizen
#        @paySewerageServiceTaxFullAsCitizen
#        @paySewerageServiceTaxPartialAsCitizen
###########################


# WS Metered Connection
@payWaterServiceTaxFullAsCitizen @wsConnection @wsEndToEnd @regression
Scenario: Login as a citizen and pay Water service tax-Metered (Full)
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@generateBill')
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * print propertyId
    * print waterConnectionApplicationNo
    * print connectionNo
    #TODO: Need to add payment steps as a Citizen

@payWaterServiceTaxPartialAsCitizen @wsConnection @wsEndToEnd @regression
Scenario: Login as a citizen and pay Water service tax-Metered (Partial)
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@generateBill')
    * print totalAmount
    * def totalAmountPaid = '150'
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    * print collectionServicesResponseBody
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * print propertyId
    * print waterConnectionApplicationNo
    * print connectionNo
    #TODO: Need to add payment steps as a Citizen

@WSsendsBackByDocVerifierAndResubmit @wsConnection @wsEndToEnd @regression
Scenario: WS- Doc- Verifier- Send Back to Citizen -Citizen ReSubmit
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@sendsBack')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForCitizenAction
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@resubmit')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@WSsendsBackByDocVerifierAndEdit @wsConnection @wsEndToEnd @regression
Scenario: WS- Doc- Verifier- Send Back to Citizen -Citizen Edit
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@sendsBack')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForCitizenAction
    * def authToken = citizenAuthToken
    * set WaterConnection.proposedPipeSize = 2.5
    * def processInstanceAction = waterConnectionConstants.parameters.processInstanceActions.resubmitApplication
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successUpdateWaterConnection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@WSRejectedByDocVerifier @wsConnection @wsEndToEnd @regression
Scenario: WS- Doc- Verifier- Reject
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@reject')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.rejected

@fieldInspectorSendBackAndReverifyByDocVerifer @wsConnection @wsEndToEnd @regression
Scenario: WS- Field Inspector- Send Back to DocumentVerifier -DV ReVerifyAndForward
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForFieldInspection
    * call read('../../municipal-services/tests/waterConnection.feature@sendBackToDocVerifier')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForDocVerification
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')

@rejectByFieldInspector @wsConnection @wsEndToEnd @regression
Scenario: WS- FieldInspector- Reject
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForFieldInspection
    * call read('../../municipal-services/tests/waterConnection.feature@reject')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.rejected

@sendBackToFieldInspectorByApprover @wsConnection @wsEndToEnd @regression
Scenario: WS- Approver- Send Back to FieldInspector -FI ReVerifyAndForward
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@sendBackForInspection')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForFieldInspection
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingApprovalForConnection

@rejectedByApprover @wsConnection @wsEndToEnd @regression
Scenario: WS- Approver- Reject
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@reject')
    * call read('../../municipal-services/pretests/waterConnectionPretest.feature@successSearchWaterConnection')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.rejected
    
@clerkEditAndActivate @wsConnection @wsEndToEnd @regression
Scenario: WS- Clerk- Edit & Activate
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@generateBill')
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.connectionActivated

# WS Non-Metered Connection
@payWaterServiceTaxNonMeteredFullAsCitizen @wsConnection @wsEndToEnd @regression
Scenario: Login as a citizen and pay Water service tax-NonMetered (Full)
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplicationForNonMetered')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@generateBill')
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * match connectionType == 'Non Metered'
    * print propertyId
    * print waterConnectionApplicationNo
    * print connectionNo
    #TODO: Need to add payment steps as a Citizen

@payWaterServiceTaxNonMeteredPartialAsCitizen @wsConnection @wsEndToEnd @regression
Scenario: Login as a citizen and pay Water service tax-NonMetered (Partial)
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # WS Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplicationForNonMetered')
    * def authToken = superUserAuthToken
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@generateBill')
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * match connectionType == 'Non Metered'
    * print propertyId
    * print waterConnectionApplicationNo
    * print connectionNo
    #TODO: Need to add partial payment steps as a Citizen
    
# SW - Non-Metered Connection

@paySewerageServiceTaxFullAsCitizen @swConnection @wsEndToEnd @regression
Scenario: Login as a citizen and pay Sewerage service tax-NonMetered (Full)
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * print sewerageConnectionApplicationNumber
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')
    * call read('../../municipal-services/tests/sewerageConnection.feature@approve')
    * call read('../../municipal-services/tests/sewerageConnection.feature@generateBill')
    * call read('../../municipal-services/tests/sewerageConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/sewerageConnection.feature@connectionActive')
    * print propertyId
    * print sewerageConnectionApplicationNumber
    * print connectionNo
    #TODO: Need to add payment steps as a Citizen

@paySewerageServiceTaxPartialAsCitizen @swConnection @wsEndToEnd @regression
Scenario: Login as a citizen and pay Sewerage service tax-NonMetered (Partial)
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')
    * call read('../../municipal-services/tests/sewerageConnection.feature@approve')
    * call read('../../municipal-services/tests/sewerageConnection.feature@generateBill')
    * call read('../../municipal-services/tests/sewerageConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/sewerageConnection.feature@connectionActive')
    * print propertyId
    * print sewerageConnectionApplicationNumber
    * print connectionNo
    #TODO: Need to add partial payment steps as a Citizen

@SWsendsBackByDocVerifierAndResubmit @swConnection @wsEndToEnd @regression
Scenario: SW - Doc- Verifier- Send Back to Citizen -Citizen ReSubmit
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@sendsBack')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForCitizenAction
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@resubmit')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@SWsendsBackByDocVerifierAndEdit @swConnection @wsEndToEnd @regression
Scenario: SW - Doc- Verifier- Send Back to Citizen -Citizen Edit
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@sendsBack')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForCitizenAction
    * def authToken = citizenAuthToken
    * set sewerageConnection.proposedWaterClosets = 5
    * set sewerageConnection.proposedToilets = 10
    * def processInstanceAction = sewerageConnectionConstants.parameters.processInstanceActions.resubmitApplication
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@UpdateSewerageConnectionSuccessfully')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@SWRejectedByDocVerifier @swConnection @wsEndToEnd @regression
Scenario: SW - Doc- Verifier- Reject
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@reject')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.rejected

@SWfieldInspectorSendBackAndReverifyByDocVerifer @swConnection @wsEndToEnd @regression
Scenario: SW - Field Inspector- Send Back to DocumentVerifier -DV ReVerifyAndForward
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForFieldInspection
    * call read('../../municipal-services/tests/sewerageConnection.feature@sendBackToDocVerifier')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForDocVerification
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')

@SWrejectByFieldInspector @swConnection @wsEndToEnd @regression
Scenario: SW - FieldInspector- Reject
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForFieldInspection
    * call read('../../municipal-services/tests/sewerageConnection.feature@reject')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.rejected

@SWsendBackToFieldInspectorByApprover @swConnection @wsEndToEnd @regression
Scenario: SW - Approver- Send Back to FieldInspector -FI ReVerifyAndForward
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')
    * call read('../../municipal-services/tests/sewerageConnection.feature@sendBackForInspection')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingForFieldInspection
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.pendingApprovalForConnection

@SWrejectedByApprover @swConnection @wsEndToEnd @regression
Scenario: SW - Approver- Reject
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')
    * call read('../../municipal-services/tests/sewerageConnection.feature@reject')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.rejected
    
@SWclerkEditAndActivate @swConnection @wsEndToEnd @regression
Scenario: SW- Clerk- Edit & Activate
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    * print propertyServiceResponseBody
    * def authToken = superUserAuthToken
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/tests/PropertyService.feature@verifyProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@forwardProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@approveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # SW Steps
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/sewerageConnection.feature@createSewerageServiceConnection')
    * call read('../../municipal-services/tests/sewerageConnection.feature@submitApplication')
    * def authToken = superUserAuthToken
    * def searchSewerageConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(sewerageConnectionApplicationNumber)'}
    * call read('../../municipal-services/tests/sewerageConnection.feature@verify')
    * call read('../../municipal-services/tests/sewerageConnection.feature@forward')
    * call read('../../municipal-services/tests/sewerageConnection.feature@approve')
    * call read('../../municipal-services/tests/sewerageConnection.feature@generateBill')
    * call read('../../municipal-services/tests/sewerageConnection.feature@payWaterServiceTax')
    * call read('../../municipal-services/tests/sewerageConnection.feature@connectionActive')
    * call read('../../municipal-services/pretests/sewerageConnectionPretest.feature@searchSewerageConnectionSuccessfully')
    * match sewerageConnectionApplicationStatus == sewerageConnectionConstants.parameters.applicationStatus.connectionActivated