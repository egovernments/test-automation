Feature: Property Tax Page Feature

Background:
    * def propertyTaxPage = read('../../ui-services/page-objects/propertyTax.yaml')
    * def pTPO = propertyTaxPage.objects

    * def jsUtils = read('classpath:jsUtils.js')
	* def pTTestData = propertyTaxPage.data
   
@makeFullPayment
Scenario: Search property tax by unique id and make full payment
	* waitFor(pTPO.propertyTaxModule).click()
	* waitFor(pTPO.payPropertyTax).click()
	* waitFor(pTPO.selectCity).click()
	* input(pTPO.selectCity, [stateCode, Key.ENTER], 100)
	* input(pTPO.uniquePropertyIdField, propertyId)
	* click(pTPO.searchPropertyButton)
	* def selectPropertyId = pTPO.selectPropertyId
	* replace selectPropertyId.propertyId = propertyId
	* waitFor(selectPropertyId).click()
	* delay(3000)
	* waitFor(pTPO.assessPropertyButton).click()
	* waitFor(pTPO.financialYearRadioButton).click()
	* click(pTPO.financialOkButton)
	* waitFor(pTPO.iAgreeCheckbox).click()
	* waitFor(pTPO.assessPropertyButton).click()
	* waitFor(pTPO.proceedToPaymentButton).click()
	* delay(3000)
	* retry(3, 5000).waitFor(pTPO.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPO.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPO.paymentReceiptNumber)
	* print paymentReceiptNumber
 
@makePartialPayment
Scenario: Search property tax by unique id and make partial payment
	* waitFor(pTPO.propertyTaxModule).click()
	* waitFor(pTPO.payPropertyTax).click()
	* waitFor(pTPO.selectCity).click()
	* input(pTPO.selectCity, [stateCode, Key.ENTER], 100)
	* input(pTPO.uniquePropertyIdField, propertyId)
	* click(pTPO.searchPropertyButton)
	* def selectPropertyId = pTPO.selectPropertyId
	* replace selectPropertyId.propertyId = propertyId
	* waitFor(selectPropertyId).click()
	* delay(3000)
	* waitFor(pTPO.assessPropertyButton).click()
	* waitFor(pTPO.financialYearRadioButton).click()
	* click(pTPO.financialOkButton)
	* waitFor(pTPO.iAgreeCheckbox).click()
	* waitFor(pTPO.assessPropertyButton).click()
	* waitFor(pTPO.proceedToPaymentButton).click()
	* delay(3000)
	* waitFor(pTPO.partialAmountRadioButton).click()
	* waitFor(pTPO.amountToPayField)
	* input(pTPO.amountToPayField, [Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, amountToPay], 100)
	* retry(3, 5000).waitFor(pTPO.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPO.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPO.paymentReceiptNumber)
	* print paymentReceiptNumber

@makeMutationPayment
Scenario: Search property tax by unique id and make full payment
	* waitFor(pTPO.propertyTaxModule).click()
	* waitFor(pTPO.payPropertyTax).click()
	* waitFor(pTPO.searchApplication).click()
	* waitFor(pTPO.applicationNumberField).input(acknowldgementNumber)
	* click(pTPO.searchPropertyButton)
	* def selectApplicationNumber = pTPO.selectApplicationNumber
	* replace selectApplicationNumber.acknowldgementNumber = acknowldgementNumber
	* waitFor(selectApplicationNumber).click()
	* waitFor(pTPO.takeActionButton).click()
	* waitFor(pTPO.citizenPayActionButton).click()
	* delay(3000)
	* retry(3, 5000).waitFor(pTPO.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPO.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPO.paymentReceiptNumber)
	* print paymentReceiptNumber

@createProperty
Scenario: Create a new  Property as Citizen
    * clickElement(pTPO.propertyTaxModule)
    * clickElement(pTPO.payPropertyTax)
    * clickElement(pTPO.propertyCreateLink)
	* clickElement(pTPO.propertyApplyButton)
	#Property Address
	* customSelectFromDropdown(pTPO.propertyCitySelectDropdown, pTTestData.propertyCitySelectDropdown)
	* def houseNumber = ranInteger(2)
	* print "House Number"
	* print houseNumber
	* sendKeys(pTPO.propertyHouseNumber, pTTestData.propertyHouseNumber)
	* def colony = randomString(10)
	* print "colony"
	* print colony
	* sendKeys(pTPO.propertyColony, pTTestData.propertyColony)
	* def street = randomString(10)
	* print "street"
	* print street
	* sendKeys(pTPO.propertyStreet, pTTestData.propertyStreet)
	* customSelectFromDropdown(pTPO.propertyLocality, pTTestData.propertyLocality)
	* sendKeys(pTPO.propertyPinCode , pTTestData.propertyPinCode)
	* clickElement(pTPO.propertyNextButton)
	#Property Details
	* customSelectFromDropdownContainingLocalization(pTPO.propertyUsageType, pTTestData.Residential)
	* customSelectFromDropdownContainingLocalization(pTPO.propertyTypeOfBuilding , pTTestData.propertyTypeOfBuilding)
	* clickElement(pTPO.noRainWaterHarvesting)
	* customSelectFromDropdown(pTPO.assessmentOccupancy, pTTestData.assessmentOccupancy)
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPO.assessmentSuperArea , pTTestData.assessmentSuperArea)
	* customSelectFromDropdown(pTPO.selectFloor , pTTestData.selectFloor)
	* clickElement(pTPO.propertyNextButton)
	#Owner Details
	#* customSelectFromDropdown(pTPO.ownershipType2 , 'Individual / Single owner')
	#* clickElement(pTPO.ownershipType2)
	#* clickElement(pTPO.singleOwnerDropdown)
	* def ownerName = randomString(10)
	* print 'ownerName'
	* print ownerName
	* sendKeys(pTPO.ownerName, pTTestData.ownerName)
	* sendKeys(pTPO.ownerMobile,pTTestData.ownerMobile)
	* def ownerGuardian = randomString(10)
	* print "owner Guardian"
	* print ownerGuardian
	* sendKeys(pTPO.ownerGuardian, pTTestData.ownerGuardian)
	* customSelectFromDropdown(pTPO.specialCategory , pTTestData.specialCategory)
	* clickElement(pTPO.propertyNextButton)
	#Document Info
	#* customSelectFromDropdown(pTPO.addressProofInputDocumentType,"Electricity Bill")
	#* customSelectFromDropdown(pTPO.identityProofInputDocumentType,"Aadhar Card")
	#* customSelectFromDropdown(pTPO.registrationProofInputDocumentType,"Gift Deed")
	#* customSelectFromDropdown(pTPO.usageProofInputDocumentType,"Electricity Bill")
	#* customSelectFromDropdown(pTPO.constructionProofInputDocumentType,"BPA Certificate")
	#* customInputFile(pTPO.addressProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.identityProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.registrationProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.usageProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.constructionProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* clickElement(pTPO.propertyNextButton)
	#Summary
	* clickElement(pTPO.acceptanceCheckbox)
	* clickElement(pTPO.addPropertyBtn)
	* def appNumber = getElementText(pTPO.generatedApplicationNumber).trim()	
	* print appNumber
	* print pTPO.headerMessageCreateProperty


@createPropertyAsSuperUser
Scenario: Create a new  Property as SuperUser
    * clickElement(pTPO.propertyTaxModule)
    * clickElement(pTPO.propertyCreateLink)
	* clickElement(pTPO.propertyApplyButton)
	#Property Address
	* def houseNumber = ranInteger(2)
	* print "House Number"
	* print houseNumber
	* sendKeys(pTPO.propertyHouseNumber, pTTestData.propertyHouseNumber)
	* def colony = randomString(10)
	* print "colony"
	* print colony
	* sendKeys(pTPO.propertyColony, pTTestData.propertyColony)
	* def street = randomString(10)
	* print "street"
	* print street
	* sendKeys(pTPO.propertyStreet, pTTestData.propertyStreet)
	* customSelectFromDropdown(pTPO.propertyLocality, pTTestData.propertyLocality)
	* sendKeys(pTPO.propertyPinCode , pTTestData.propertyPinCode)
	* clickElement(pTPO.propertyNextButton)
	#Property Details
	* customSelectFromDropdownContainingLocalization(pTPO.propertyUsageType, pTTestData.propertyUsageType)
	* customSelectFromDropdownContainingLocalization(pTPO.propertyTypeOfBuilding , pTTestData.propertyTypeOfBuilding)
	* clickElement(pTPO.noRainWaterHarvesting)
	* customSelectFromDropdown(pTPO.assessmentOccupancy, pTTestData.assessmentOccupancy)
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPO.assessmentSuperArea , pTTestData.assessmentSuperArea)
	* customSelectFromDropdown(pTPO.selectFloor , pTTestData.selectFloor)
	* clickElement(pTPO.propertyNextButton)
	#Owner Details
	#* customSelectFromDropdown(pTPO.ownershipType2 , 'Individual / Single owner')
	#* clickElement(pTPO.ownershipType2)
	#* clickElement(pTPO.singleOwnerDropdown)
	* def ownerName = randomString(10)
	* print 'ownerName'
	* print ownerName
	* sendKeys(pTPO.ownerName, pTTestData.ownerName)
	* sendKeys(pTPO.ownerMobile,pTTestData.ownerMobile)
	* def ownerGuardian = randomString(10)
	* print "owner Guardian"
	* print ownerGuardian
	* sendKeys(pTPO.ownerGuardian, pTTestData.ownerGuardian)
	* customSelectFromDropdown(pTPO.specialCategory , pTTestData.specialCategory)
	* clickElement(pTPO.propertyNextButton)
	#Document Info
	# * customSelectFromDropdown(pTPO.addressProofInputDocumentType,"Electricity Bill")
	# * customSelectFromDropdown(pTPO.identityProofInputDocumentType,"Aadhar Card")
	# * customSelectFromDropdown(pTPO.registrationProofInputDocumentType,"Gift Deed")
	# * customSelectFromDropdown(pTPO.usageProofInputDocumentType,"Electricity Bill")
	# * customSelectFromDropdown(pTPO.constructionProofInputDocumentType,"BPA Certificate")
	#* customInputFile(pTPO.addressProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.identityProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.registrationProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.usageProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* customInputFile(pTPO.constructionProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	#* clickElement(pTPO.addressProofInputDocumentInput)
#	* driver.inputFile(pTPO.addressProofInputDocumentInput, "/Users/Lenovo/Pictures/Screenshots/Screenshot (1).png")
	#* delay(4000)
   # * input(pTPO.identityProofInputDocumentInput, "Screenshot.png")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")
	# * inputFileUsingJavascript("test","test")

	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")
	* input("//input[@id='contained-button-file'][1]", "C:\\Users\\Lenovo\\egovernemtns\\test-automation\\src\\test\\java\\com\\egov\\Screenshot.png")

#	* input("Test","test")
	* print "FILE UPLOADED"
	#* delay(1000000000)
    #* driver.inputFile(pTPO.registrationProofInputDocumentInput, "C:\Users\Lenovo\Pictures\Screenshots\Screenshot (1).png")
    #* driver.inputFile(pTPO.usageProofInputDocumentInput, "C:\Users\Lenovo\Pictures\Screenshots\Screenshot (1).png")
    #* driver.inputFile(pTPO.constructionProofInputDocumentInput, "C:\Users\Lenovo\Pictures\Screenshots\Screenshot (1).png")
	* delay(5000)
	* clickElement(pTPO.propertyNextButton)
	#Summary
	* clickElement(pTPO.addPropertyBtn)
	* print appNumber
	* def appNumber =  getElementText(pTPO.generatedApplicationNumber).trim()	
	* def uniquePropertyIDFullString = getElementText(pTPO.generatedUniquePropertyID)
	* print uniquePropertyIDFullString
	* def splitArrayPropertyId= uniquePropertyIDFullString.split(":")
	* print splitArrayPropertyId
	* def propertyID = splitArrayPropertyId[1]
	* print propertyID
	* def trimmedPropertyId = propertyID.trim()
	* print trimmedPropertyId
	* print  UniquePropertyID
	* print pTPO.headerMessageCreateProperty
	

 @approveProperty
 Scenario: search property by application number and verify and forward and approveProperty
	#* clickElement(pTPO.homeButton)
 	* clickElement(pTPO.propertyTaxModule)
	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
	* clickElement(pTPO.searchApplicationButton)
 	* clickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)
	* clickElement(pTPO.verifyDropdown)
	* clickElement(pTPO.assigneeName)
	#* clickElement(pTPO.selectAssigneeEmpAuto)
	* sendKeys(pTPO.commentsInput)
	* clickElement(pTPO.verifyAssigneeButton)
 	* clickElement(pTPO.forwardGoToHomeButton)
	* clickElement(pTPO.searchApplicationTab)
	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
	* clickElement(pTPO.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPO.takeActionButton)
	* clickElement(pTPO.forwardDropdown)
	* clickElement(pTPO.assigneeName)
	#* clickElement(pTPO.selectAssigneeEmpAuto)
	* clickElement(pTPO.forwardButton)
	* clickElement(pTPO.forwardGoToHomeButton)
	* clickElement(pTPO.searchApplicationTab)
	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
	* clickElement(pTPO.searchApplicationButton)
	* clickValueInSearchResults(appNumber)
	* clickElement(pTPO.takeActionButton)
	* clickElement(pTPO.approveDropdown)
 	* sendKeys(pTPO.commentsInput)
	* clickElement(pTPO.approveButton)
    * print pTPO.headerMessageApproveProperty

 @payPropertyTax
 Scenario:  pay for the property tax fees
	* call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
	* clickElement(pTPO.propertyTaxModule)
 	* clickElement(pTPO.payPropertyTax)  
	#* clickElement(pTPO.selectCity)
	#* clickElement(pTPO.amritsarDropdown)
    * customSelectFromDropdown(pTPO.selectCity, pTTestData.selectCity)
	* customSelectFromDropdown(pTPO.selectLocality, pTTestData.propertyLocality)
	* sendKeys(pTPO.uniquePropertyId , uniquePropertyID)
	* clickElement(pTPO.searchPropertyButton)
	* clickValueInSearchResults(uniquePropertyID)
	* delay(3000)
	* clickElement(pTPO.assessProperty)
	* delay(3000)
	* clickElement(pTPO.selectPropertyTaxYear)
	* clickElement(pTPO.okButton)
    * clickElement(pTPO.checkBox)
	* clickElement(pTPO.assessProperty)
	* delay(3000)
	* clickElement(pTPO.proceedPaymentButton)
	* print "proceed to payment"
	* clickElement(pTPO.payerDetails)
	* clear(pTPO.payerDetails)
	* sendKeys(pTPO.payerDetails, pTTestData.payerDetails)
	* clickElement(pTPO.payerName)
	* clear(pTPO.payerName)
	#* sendKeys(pTPO.payerName, pTTestData.payerName)
    * clickElement(pTPO.payerMobile)
	* clear(pTPO.payerMobile)
	#* sendKeys(pTPO.payerMobile, pTTestData.payerMobile)
	* delay(10000)
	* clickElement(pTPO.makePaymentButton2)
	* print "make payment"
	* delay(3000)
    * call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* delay(8000)
	* print "payment gateway success"
	* def paymentReceiptNumber = getElementText(pTPO.generatedpaymentReceiptNumber).trim()	
	* print paymentReceiptNumber
	* print pTPO.headerMessagePayProperty
    
	
 @rejectPropertyVerification
 Scenario: Search property by application number and reject property Verification
    * clickElement(pTPO.propertyTaxModule)
 	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* clickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)
 	* clickElement(pTPO.rejectDropdown)
	* sendKeys(pTPO.commentsInput)
 	* clickElement(pTPO.rejectButton)
	* print pTPO.headerMessageRejectVerification


 @rejectPropertyApproval
 Scenario: Search Property by application and reject property Approval
    * clickElement(pTPO.propertyTaxModule)
	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* clickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)
	* clickElement(pTPO.verifyDropdown)
 	* clickElement(pTPO.assigneeName)
 	* clickElement(pTPO.selectAssigneeEmpAuto)
 	* sendKeys(pTPO.commentsInput)
 	* clickElement(pTPO.verifyAssigneeButton)
 	* clickElement(pTPO.goToHomeButton)
	* clickElement(pTPO.searchApplicationTab)
	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* clickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)
 	* clickElement(pTPO.forwardDropdown)
 	* clickElement(pTPO.assigneeName)
 	* clickElement(pTPO.selectAssigneeEmpAuto)
 	* clickElement(pTPO.forwardButton)
 	* clickElement(pTPO.goToHomeButton)
 	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* clickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)
 	* clickElement(pTPO.rejectDropdown)
    * clickElement(pTPO.rejectButton)
    * print pTPO.headerMessageRejectApproval
	
 @sendBackToCitizen
 Scenario: Search property by application number and send back to citizenPayActionButton
    * clickElement(pTPO.propertyTaxModule)
	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* clickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)	
 	* clickElement(pTPO.sendBackDropdown)
 	* clickElement(pTPO.sendBackToCitizenButton)
	* print pTPO.headerMessageSendBack 

