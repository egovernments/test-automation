Feature: Water and Sewerage End to End test flow

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def waterConnectionConstants = read('../../municipal-services/constants/waterConnection.yaml')

@payWaterServiceTaxFullAsCitizen
Scenario: Login as a citizen and pay Water service tax-Metered (Full)
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
    # * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    # Steps to Assess the property
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * call read('../../common-services/pretests/authenticationToken.feature@superUser')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    #* print collectionServicesResponseBody
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * print propertyId
    * print waterConnectionApplicationNo
    * print connectionNo

@payWaterServiceTaxPartialAsCitizen
Scenario: Login as a citizen and pay Water service tax-Metered (Partial)
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
    # * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    # Steps to Assess the property
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * call read('../../common-services/pretests/authenticationToken.feature@superUser')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
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
    # * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    # Steps to Assess the property
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * call read('../../common-services/pretests/authenticationToken.feature@superUser')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../municipal-services/tests/waterConnection.feature@sendsBack')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForCitizenAction
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../municipal-services/tests/waterConnection.feature@sendsBack')
    * match waterConnectionApplicationStatus == waterConnectionConstants.parameters.applicationStatus.pendingForDocVerification

@troubleShoot
Scenario: Login as a citizen and pay Water service tax-Metered (Full)
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
    # * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen') 
    # Steps to Assess the property
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizen')
    * call read('../../municipal-services/tests/waterConnection.feature@createWaterServiceConnection')
    * call read('../../municipal-services/tests/waterConnection.feature@submitApplication')
    * call read('../../common-services/pretests/authenticationToken.feature@superUser')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    * def waterConnectionParams = { tenantId: '#(tenantId)', applicationNumber: '#(waterConnectionApplicationNo)'}
    * call read('../../municipal-services/tests/waterConnection.feature@verify')
    * call read('../../municipal-services/tests/waterConnection.feature@forward')
    * call read('../../municipal-services/tests/waterConnection.feature@approve')
    * call read('../../municipal-services/tests/waterConnection.feature@payWaterServiceTax')
    #* print collectionServicesResponseBody
    * call read('../../municipal-services/tests/waterConnection.feature@connectionActive')
    * print propertyId
    * print waterConnectionApplicationNo
    * print connectionNo