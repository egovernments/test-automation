Feature: Water and Sewerage End to End test flow

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def waterConnectionConstants = read('../../municipal-services/constants/waterConnection.yaml')


# WS Metered Connection
@payWaterServiceTaxFullAsCitizen
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

@payWaterServiceTaxPartialAsCitizen
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


@WSsendsBackByDocVerifierAndResubmit
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

@WSsendsBackByDocVerifierAndEdit
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

@WSRejectedByDocVerifier
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

@fieldInspectorSendBackAndReverifyByDocVerifer
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

@rejectByFieldInspector
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

@sendBackToFieldInspectorByApprover
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

@rejectedByApprover
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
    
@clerkEditAndActivate
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
@payWaterServiceTaxNonMeteredFullAsCitizen
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

@payWaterServiceTaxNonMeteredPartialAsCitizen
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
    
# SW - Metered Connection