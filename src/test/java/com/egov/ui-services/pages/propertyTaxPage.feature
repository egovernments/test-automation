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
Scenario: Create a new  Property
    * clickElement(pTPageObjects.propertyTaxModule)
    * clickElement(pTPageObjects.payPropertyTax)
    * clickElement(pTPageObjects.propertyCreateLink)
	* clickElement(pTPageObjects.propertyApplyButton)
	#Property Address
	* customSelectFromDropdown(pTPageObjects.propertyCitySelectDropdown, 'Amritsar')
	* sendKeys(pTPageObjects.propertyHouseNumber, randomString(2))
	* sendKeys(pTPageObjects.propertyColony, randomString(10))
	* sendKeys(pTPageObjects.propertyStreet, randomString(10))
	* customSelectFromDropdown(pTPageObjects.propertyLocality, 'Ajit Nagar - Area1')
	* sendKeys(pTPageObjects.propertyPinCode , '48'+ranInteger(4))
	* clickElement(pTPageObjects.propertyNextButton)
	#Property Details
	* customSelectFromDropdownContainingLocalization(pTPageObjects.propertyUsageType, 'Residential')
	* customSelectFromDropdownContainingLocalization(pTPageObjects.propertyTypeOfBuilding , 'Flat/Part of the building')
	* clickElement(pTPageObjects.noRainWaterHarvesting)
	* customSelectFromDropdown(pTPageObjects.assessmentOccupancy, 'Self-Occupied')
	* sendKeys(pTPageObjects.assessmentSuperArea , ranInteger(4))
	* customSelectFromDropdown(pTPageObjects.selectFloor , 'Ground Floor')
	* clickElement(pTPageObjects.propertyNextButton)
	#Owner Details
	* sendKeys(pTPageObjects.ownerName,randomString(10))
	* sendKeys(pTPageObjects.ownerMobile,citizenUsername)
	* sendKeys(pTPageObjects.ownerGuardian,randomString(10))
	* customSelectFromDropdown(pTPageObjects.specialCatergory , 'None of the above')
	* clickElement(pTPageObjects.propertyNextButton)
	#Document Info
	* customSelectFromDropdown(pTPageObjects.addressProofInputDocumentType,"Electricity Bill")
	* customSelectFromDropdown(pTPageObjects.identityProofInputDocumentType,"Aadhar Card")
	* customSelectFromDropdown(pTPageObjects.registrationProofInputDocumentType,"Gift Deed")
	* customSelectFromDropdown(pTPageObjects.usageProofInputDocumentType,"Electricity Bill")
	* customSelectFromDropdown(pTPageObjects.constructionProofInputDocumentType,"BPA Certificate")
	* customInputFile(pTPageObjects.addressProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* customInputFile(pTPageObjects.identityProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* customInputFile(pTPageObjects.registrationProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* customInputFile(pTPageObjects.usageProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* customInputFile(pTPageObjects.constructionProofInputDocumentInput,"/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/src/test/java/com/egov/common-services/testData/testData4.png")
	* clickElement(pTPageObjects.propertyNextButton)
	#Summary
	* clickElement(pTPageObjects.acceptanceCheckbox)
	* clickElement(pTPageObjects.addPropertyBtn)
	* def appNumber = getElementText(pTPageObjects.generatedApplicationNumber)	
	* print appNumber
	* delay(10000000)