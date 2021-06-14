Feature: Property Tax Page Feature

Background:
    * def propertyTaxPage = read('../../ui-services/page-objects/propertyTax.yaml')
    * def pTPageObjects = propertyTaxPage.objects
    * def jsUtils = read('classpath:jsUtils.js')

@makeFullPayment
Scenario: Search property tax by unique id and make full payment
	* waitFor(pTPageObjects.propertyTaxModule).click()
	* waitFor(pTPageObjects.payPropertyTax).click()
	* waitFor(pTPageObjects.selectCity).click()
	* input(pTPageObjects.selectCity, [stateCode, Key.ENTER], 100)
	* input(pTPageObjects.uniquePropertyIdField, propertyId)
	* click(pTPageObjects.searchPropertyButton)
	* def selectPropertyId = pTPageObjects.selectPropertyId
	* replace selectPropertyId.propertyId = propertyId
	* waitFor(selectPropertyId).click()
	* delay(3000)
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.financialYearRadioButton).click()
	* click(pTPageObjects.financialOkButton)
	* waitFor(pTPageObjects.iAgreeCheckbox).click()
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.proceedToPaymentButton).click()
	* delay(3000)
	* retry(3, 5000).waitFor(pTPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	* print paymentReceiptNumber
 
@makePartialPayment
Scenario: Search property tax by unique id and make partial payment
	* waitFor(pTPageObjects.propertyTaxModule).click()
	* waitFor(pTPageObjects.payPropertyTax).click()
	* waitFor(pTPageObjects.selectCity).click()
	* input(pTPageObjects.selectCity, [stateCode, Key.ENTER], 100)
	* input(pTPageObjects.uniquePropertyIdField, propertyId)
	* click(pTPageObjects.searchPropertyButton)
	* def selectPropertyId = pTPageObjects.selectPropertyId
	* replace selectPropertyId.propertyId = propertyId
	* waitFor(selectPropertyId).click()
	* delay(3000)
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.financialYearRadioButton).click()
	* click(pTPageObjects.financialOkButton)
	* waitFor(pTPageObjects.iAgreeCheckbox).click()
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.proceedToPaymentButton).click()
	* delay(3000)
	* waitFor(pTPageObjects.partialAmountRadioButton).click()
	* waitFor(pTPageObjects.amountToPayField)
	* input(pTPageObjects.amountToPayField, [Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, amountToPay], 100)
	* retry(3, 5000).waitFor(pTPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	* print paymentReceiptNumber

@makeMutationPayment
Scenario: Search property tax by unique id and make full payment
	* waitFor(pTPageObjects.propertyTaxModule).click()
	* waitFor(pTPageObjects.payPropertyTax).click()
	* waitFor(pTPageObjects.searchApplication).click()
	* waitFor(pTPageObjects.applicationNumberField).input(acknowldgementNumber)
	* click(pTPageObjects.searchPropertyButton)
	* def selectApplicationNumber = pTPageObjects.selectApplicationNumber
	* replace selectApplicationNumber.acknowldgementNumber = acknowldgementNumber
	* waitFor(selectApplicationNumber).click()
	* waitFor(pTPageObjects.takeActionButton).click()
	* waitFor(pTPageObjects.citizenPayActionButton).click()
	* delay(3000)
	* retry(3, 5000).waitFor(pTPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	* print paymentReceiptNumber

@createProperty
Scenario: Create a new  Property as Citizen
    * clickElement(pTPageObjects.propertyTaxModule)
    * clickElement(pTPageObjects.payPropertyTax)
    * clickElement(pTPageObjects.propertyCreateLink)
	* clickElement(pTPageObjects.propertyApplyButton)
	#Property Address
	* customSelectFromDropdown(pTPageObjects.propertyCitySelectDropdown, 'Amritsar')
	* def houseNumber = ranInteger(2)
	* print "House Number"
	* print houseNumber
	* sendKeys(pTPageObjects.propertyHouseNumber, '4')
	* def colony = randomString(10)
	* print "colony"
	* print colony
	* sendKeys(pTPageObjects.propertyColony, 'colony')
	* def street = randomString(10)
	* print "street"
	* print street
	* sendKeys(pTPageObjects.propertyStreet, 'street')
	* customSelectFromDropdown(pTPageObjects.propertyLocality, 'Ajit Nagar - Area1')
	* sendKeys(pTPageObjects.propertyPinCode , '480004')
	* clickElement(pTPageObjects.propertyNextButton)
	#Property Details
	* customSelectFromDropdownContainingLocalization(pTPageObjects.propertyUsageType, 'Residential')
	* customSelectFromDropdownContainingLocalization(pTPageObjects.propertyTypeOfBuilding , 'Flat/Part of the building')
	* clickElement(pTPageObjects.noRainWaterHarvesting)
	* customSelectFromDropdown(pTPageObjects.assessmentOccupancy, 'Self-Occupied')
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPageObjects.assessmentSuperArea , '234')
	* customSelectFromDropdown(pTPageObjects.selectFloor , 'Ground Floor')
	* clickElement(pTPageObjects.propertyNextButton)
	#Owner Details
	#* customSelectFromDropdown(pTPageObjects.ownershipType2 , 'Individual / Single owner')
	#* clickElement(pTPageObjects.ownershipType2)
	#* clickElement(pTPageObjects.singleOwnerDropdown)
	* def ownerName = randomString(10)
	* print 'ownerName'
	* print ownerName
	* sendKeys(pTPageObjects.ownerName, 'jane')
	* sendKeys(pTPageObjects.ownerMobile,'9818807742')
	* def ownerGuardian = randomString(10)
	* print "owner Guardian"
	* print ownerGuardian
	* sendKeys(pTPageObjects.ownerGuardian, 'jill')
	* customSelectFromDropdown(pTPageObjects.specialCatergory , 'None of the above')
	* clickElement(pTPageObjects.propertyNextButton)
	#Document Info
	#* customSelectFromDropdown(pTPageObjects.addressProofInputDocumentType,"Electricity Bill")
	#* customSelectFromDropdown(pTPageObjects.identityProofInputDocumentType,"Aadhar Card")
	#* customSelectFromDropdown(pTPageObjects.registrationProofInputDocumentType,"Gift Deed")
	#* customSelectFromDropdown(pTPageObjects.usageProofInputDocumentType,"Electricity Bill")
	#* customSelectFromDropdown(pTPageObjects.constructionProofInputDocumentType,"BPA Certificate")
	#* customInputFile(pTPageObjects.addressProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPageObjects.identityProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPageObjects.registrationProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPageObjects.usageProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPageObjects.constructionProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* clickElement(pTPageObjects.propertyNextButton)
	#Summary
	* clickElement(pTPageObjects.acceptanceCheckbox)
	* clickElement(pTPageObjects.addPropertyBtn)
	* def appNumber = getElementText(pTPageObjects.generatedApplicationNumber).trim()	
	* print appNumber


@createPropertyAsSuperUser
Scenario: Create a new  Property as SuperUser
    * clickElement(pTPageObjects.propertyTaxModule)
    * clickElement(pTPageObjects.propertyCreateLink)
	* clickElement(pTPageObjects.propertyApplyButton)
	#Property Address
	* def houseNumber = ranInteger(2)
	* print "House Number"
	* print houseNumber
	* sendKeys(pTPageObjects.propertyHouseNumber, '4')
	* def colony = randomString(10)
	* print "colony"
	* print colony
	* sendKeys(pTPageObjects.propertyColony, 'colony')
	* def street = randomString(10)
	* print "street"
	* print street
	* sendKeys(pTPageObjects.propertyStreet, 'street')
	* customSelectFromDropdown(pTPageObjects.propertyLocality, 'Ajit Nagar - Area1')
	* sendKeys(pTPageObjects.propertyPinCode , '480004')
	* clickElement(pTPageObjects.propertyNextButton)
	#Property Details
	* customSelectFromDropdownContainingLocalization(pTPageObjects.propertyUsageType, 'Residential')
	* customSelectFromDropdownContainingLocalization(pTPageObjects.propertyTypeOfBuilding , 'Flat/Part of the building')
	* clickElement(pTPageObjects.noRainWaterHarvesting)
	* customSelectFromDropdown(pTPageObjects.assessmentOccupancy, 'Self-Occupied')
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPageObjects.assessmentSuperArea , '10')
	* customSelectFromDropdown(pTPageObjects.selectFloor , 'Ground Floor')
	* clickElement(pTPageObjects.propertyNextButton)
	#Owner Details
	#* customSelectFromDropdown(pTPageObjects.ownershipType2 , 'Individual / Single owner')
	#* clickElement(pTPageObjects.ownershipType2)
	#* clickElement(pTPageObjects.singleOwnerDropdown)
	* def ownerName = randomString(10)
	* print 'ownerName'
	* print ownerName
	* sendKeys(pTPageObjects.ownerName, 'jane')
	* sendKeys(pTPageObjects.ownerMobile,'9818807742')
	* def ownerGuardian = randomString(10)
	* print "owner Guardian"
	* print ownerGuardian
	* sendKeys(pTPageObjects.ownerGuardian, 'jill')
	* customSelectFromDropdown(pTPageObjects.specialCatergory , 'None of the above')
	* clickElement(pTPageObjects.propertyNextButton)
	#Document Info
	* customSelectFromDropdown(pTPageObjects.addressProofInputDocumentType,"Electricity Bill")
	* customSelectFromDropdown(pTPageObjects.identityProofInputDocumentType,"Aadhar Card")
	* customSelectFromDropdown(pTPageObjects.registrationProofInputDocumentType,"Gift Deed")
	* customSelectFromDropdown(pTPageObjects.usageProofInputDocumentType,"Electricity Bill")
	* customSelectFromDropdown(pTPageObjects.constructionProofInputDocumentType,"BPA Certificate")
	* print "ADDDING FILESS"
	* customInputFile(pTPageObjects.addressProofInputDocumentInput,"file:src/test/java/com/screenshot.png")
	# * customInputFile(pTPageObjects.identityProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	# * customInputFile(pTPageObjects.registrationProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	# * customInputFile(pTPageObjects.usageProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	# * customInputFile(pTPageObjects.constructionProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
#	* clickElement(pTPageObjects.addressProofInputDocumentInput)
#	* driver.inputFile(pTPageObjects.addressProofInputDocumentInput, "/Users/Lenovo/Pictures/Screenshots/Screenshot (1).png")
	* delay(10000000)
   # * input(pTPageObjects.identityProofInputDocumentInput, "Screenshot.png")
#	* inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")

 #	* input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")
	# * input("//input[@id='contained-button-file'][1]", "/Users/macbookair/Downloads/test-automation/src/test/java/com/egov/Screenshot.png")

#	* input("Test","test")
	#* print "FILE UPLOADED"
	#* delay(1)
    #* driver.inputFile(pTPageObjects.registrationProofInputDocumentInput, "C:\Users\Lenovo\Pictures\Screenshots\Screenshot (1).png")
    #* driver.inputFile(pTPageObjects.usageProofInputDocumentInput, "C:\Users\Lenovo\Pictures\Screenshots\Screenshot (1).png")
    #* driver.inputFile(pTPageObjects.constructionProofInputDocumentInput, "C:\Users\Lenovo\Pictures\Screenshots\Screenshot (1).png")
	#* delay(1)
	* clickElement(pTPageObjects.propertyNextButton)
	#Summary
	* clickElement(pTPageObjects.addPropertyBtn)	

	* def appNumber =  getElementText(pTPageObjects.generatedApplicationNumber).trim()	
	* print appNumber
	* def uniquePropertyIDFullString = getElementText(pTPageObjects.generatedUniquePropertyID)
	* print uniquePropertyIDFullString
	* def splitArrayPropertyId= uniquePropertyIDFullString.split(":")
	* print splitArrayPropertyId

	* def propertyID = splitArrayPropertyId[1]
	* print propertyID

	* def trimmedPropertyId = propertyID.trim()
	* print trimmedPropertyId

	* print  UniquePropertyID



@approvePropertyFromDocVerifier
Scenario: Approve Property From Doc Verifier
	* clickElement(pTPageObjects.propertyTaxModule)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.verifyDropdown)
	* sendKeys(pTPageObjects.commentsInput,"Test")
	* clickElement(pTPageObjects.verifyAssigneeButton)


@approvePropertyFromFieldInspector
Scenario: Approve Property From Field Inspector
	* clickElement(pTPageObjects.goToHomeButton)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.forwardDropdown)
	* clickElement(pTPageObjects.forwardButton)

@approvePropertyFromApprover
Scenario: Approve Property From Approver
	* clickElement(pTPageObjects.goToHomeButton)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.approveDropdown)
	* sendKeys(pTPageObjects.commentsInput,randomString(10))
	* clickElement(pTPageObjects.approveButton)

@rejectPropertyFromDocVerifier
Scenario: Search property by application number and reject property Doc Verification
    * clickElement(pTPageObjects.propertyTaxModule)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.rejectDropdown)
	* sendKeys(pTPageObjects.commentsInput)
	* clickElement(pTPageObjects.rejectButton)


@sendBackToCitizenFromDocVerifier
Scenario: Search property by application number and reject property Doc Verification
    * clickElement(pTPageObjects.propertyTaxModule)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
 	* clickElement(pTPageObjects.sendBackDropdown)
	* sendKeys(pTPageObjects.commentsInput)
 	* clickElement(pTPageObjects.sendBackToCitizenButton)

@rejectPropertyFromApprover
Scenario: Search property by application number and reject property from approver
	* softRefreshPage()
    * clickElement(pTPageObjects.propertyTaxFromLeftNav)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.rejectDropdown)
	* sendKeys(pTPageObjects.commentsInput)
	* clickElement(pTPageObjects.rejectButton)



@approvePropertyFULL
Scenario: search property by application number and verify and forward and approveProperty
 #   * clickElement(pTPageObjects.homeButton)
	* clickElement(pTPageObjects.propertyTaxModule)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.verifyDropdown)
	# * clickElement(pTPageObjects.assigneeName)
	# * clickElement(pTPageObjects.selectAssigneeEmpAuto)
	* sendKeys(pTPageObjects.commentsInput,"Test")
	* clickElement(pTPageObjects.verifyAssigneeButton)
	* clickElement(pTPageObjects.goToHomeButton)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.forwardDropdown)
	# * clickElement(pTPageObjects.assigneeName)	
	# * clickElement(pTPageObjects.selectAssigneeEmpAuto)
	* clickElement(pTPageObjects.forwardButton)
	* clickElement(pTPageObjects.goToHomeButton)
	* clickElement(pTPageObjects.searchApplicationTab)
	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
	* clickElement(pTPageObjects.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPageObjects.takeActionButton)
	* clickElement(pTPageObjects.approveDropdown)
	* sendKeys(pTPageObjects.commentsInput)
	* clickElement(pTPageObjects.approveButton)

# @payPropertyTax
# Scenario:  pay for the property tax fees
#     #* def appNumber =  'PB-AC-2021-06-08-016994'
#     #* def uniquePropertyID = 'PB-PT-2021-06-08-017166'
#     * clickElement(pTPageObjects.propertyTaxModule)
# 	* clickElement(pTPageObjects.searchApplicationTab)
# 	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
# 	* clickElement(pTPageObjects.searchApplicationButton)
# 	* clickValueInSearchResults(uniquePropertyID)
#     #* clickElement(pTPageObjects.goToHomeButton)
# 	#* clickElement(pTPageObjects.searchApplicationTab)
# 	#* sendKeys(pTPageObjects.searchByApplicationNumber, UniquePropertyID)
#     #* clickValueInSearchResults(UniquePropertyID)
# 	* print "CLICKING ON ACCESS BUTTON"
# 	* delay(10000)
#     * clickElement(pTPageObjects.assessProperty)
# 	* delay(10000)
# 	* print "Assess property"
# 	* clickElement(pTPageObjects.selectPropertyTaxYear)
# 	* delay(10000)
# 	* clickElement(pTPageObjects.okButton)
# 	* print("OK button clickced")
# 	* delay(10000)
# 	* print "Assess property2"
# 	* clickElement(pTPageObjects.assessProperty)
# 	* clickElement(pTPageObjects.proceedPaymentButton)
# 	* clickElement(pTPageObjects.generateReceiptButton)
# 	* def paymentReceiptNumber = getElementText(pTPageObjects.generatedpaymentReceiptNumber).trim()	
# 	* print paymentReceiptNumber
# 	* call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
# # 	* clickElement(pTPageObjects.propertyTaxModule)
# # 	* clickElement(pTPageObjects.payPropertyTax)
#     * 
#     * clickElement(pTPageObjects.goToHomeButton)
# 	* 

	
# @rejectPropertyApproval
# Scenario: Search Property by application and reject property Approval
#     * clickElement(pTPageObjects.propertyTaxModule)
# 	* clickElement(pTPageObjects.searchApplicationTab)
# 	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
# 	* clickElement(pTPageObjects.searchApplicationButton)
# 	* clickValueInSearchResults(appNumber)
# 	* clickElement(pTPageObjects.takeActionButton)
# 	* clickElement(pTPageObjects.verifyDropdown)
# 	* clickElement(pTPageObjects.assigneeName)
# 	* clickElement(pTPageObjects.selectAssigneeEmpAuto)
# 	* sendKeys(pTPageObjects.commentsInput)
# 	* clickElement(pTPageObjects.verifyAssigneeButton)
# 	* clickElement(pTPageObjects.goToHomeButton)
# 	* clickElement(pTPageObjects.searchApplicationTab)
# 	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
# 	* clickElement(pTPageObjects.searchApplicationButton)
# 	* clickValueInSearchResults(appNumber)
# 	* clickElement(pTPageObjects.takeActionButton)
# 	* clickElement(pTPageObjects.forwardDropdown)
# 	* clickElement(pTPageObjects.assigneeName)
# 	* clickElement(pTPageObjects.selectAssigneeEmpAuto)
# 	* clickElement(pTPageObjects.forwardButton)
# 	* clickElement(pTPageObjects.goToHomeButton)
# 	* clickElement(pTPageObjects.searchApplicationTab)
# 	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
# 	* clickElement(pTPageObjects.searchApplicationButton)
# 	* clickValueInSearchResults(appNumber)
# 	* clickElement(pTPageObjects.takeActionButton)
# 	* clickElement(pTPageObjects.rejectDropdown)
#     * clickElement(pTPageObjects.rejectButton)
	
# @sendBackToCitizen
# Scenario: Search property by application number and send back to citizenPayActionButton
#     * clickElement(pTPageObjects.propertyTaxModule)
# 	* clickElement(pTPageObjects.searchApplicationTab)
# 	* sendKeys(pTPageObjects.searchByApplicationNumber, appNumber)
# 	* clickElement(pTPageObjects.searchApplicationButton)
# 	* clickValueInSearchResults(appNumber)
# 	* clickElement(pTPageObjects.takeActionButton)	
# 	* clickElement(pTPageObjects.sendBackDropdown)
# 	* clickElement(pTPageObjects.sendBackToCitizenButton)
