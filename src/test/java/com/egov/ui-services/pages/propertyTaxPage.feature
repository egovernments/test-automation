Feature: Property Tax Page Feature

Background:
    * def propertyTaxPage = read('../../ui-services/page-objects/propertyTax.yaml')
	#* def testDataFile = '../../ui-services/testData/dummyTestData1.pdf'
	* def testDataFile = "file:src/test/java/com/screenshot.png"
    * def pTPO = propertyTaxPage.objects
	* def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
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
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	# * print paymentReceiptNumber

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
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	# * print paymentReceiptNumber

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

# @navigateToPropertyTax
# Scenario: Naviagte To Property Web
# 	* 

# 		@fillup1
# 		@fillup2
# 		@fillup3
# 		@fillup4

@createProperty
Scenario: Create a new  Property as Citizen
	# * call read(@fillup1)
	# * call read(@fillup2)
	# * call read(@fillup3)
	# * call read(@fillup4)
	* print pTPO.propertyTaxModule
	* clickElement(pTPO.leftHamburger)
	* clickElement(pTPO.propertyTaxFromLeftNav)
    * clickElement(pTPO.payPropertyTax)
    * clickElement(pTPO.propertyCreateLink)
	* clickElement(pTPO.propertyApplyButton)
	#Property Address
	* digitCustomSelectFromDropdown(pTPO.propertyCitySelectDropdown, pTTestData.propertyCitySelectDropdown)
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
	* clickElement(pTPO.propertyLocality)
	* digitCustomSelectFromDropdown(pTPO.propertyLocality, pTTestData.propertyLocality)
	* sendKeys(pTPO.propertyPinCode , pTTestData.propertyPinCode)
	* clickElement(pTPO.propertyNextButton)
	#Property Details
	* digitCustomSelectFromDropdownContainingLocalization(pTPO.propertyUsageType, pTTestData.propertyUsageType)
	* digitCustomSelectFromDropdownContainingLocalization(pTPO.propertyTypeOfBuilding , pTTestData.propertyTypeOfBuilding)
	* clickElement(pTPO.noRainWaterHarvesting)
	* delay(5000)
	* digitCustomSelectFromDropdown(pTPO.assessmentOccupancy, pTTestData.assessmentOccupancy)
	* delay(5000)
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPO.assessmentSuperArea , pTTestData.assessmentSuperArea)
	* digitCustomSelectFromDropdown(pTPO.selectFloor , pTTestData.selectFloor)
	* clickElement(pTPO.propertyNextButton)
	#Owner Details
	#* digitCustomSelectFromDropdown(pTPO.ownershipType2 , 'Individual / Single owner')
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
	* digitCustomSelectFromDropdown(pTPO.specialCategory , pTTestData.specialCategory)
	* clickElement(pTPO.propertyNextButton)
	#Document Info
	* digitCustomSelectFromDropdown(pTPO.addressProofInputDocumentType,"Electricity Bill")
	* digitCustomInputFile(pTPO.addressProofInputDocumentInput,testDataFile)
	* delay(2000)
	* digitCustomSelectFromDropdown(pTPO.identityProofInputDocumentType,"Aadhar Card")
	* digitCustomInputFile(pTPO.identityProofInputDocumentInput,testDataFile)
	* delay(2000)
	* digitCustomSelectFromDropdown(pTPO.registrationProofInputDocumentType,"Gift Deed")
	* digitCustomInputFile(pTPO.registrationProofInputDocumentInput,testDataFile)
	* delay(2000)
	* digitCustomSelectFromDropdown(pTPO.usageProofInputDocumentType,"Electricity Bill")
	* digitCustomInputFile(pTPO.usageProofInputDocumentInput,testDataFile)
	* delay(2000)
	* digitCustomSelectFromDropdown(pTPO.constructionProofInputDocumentType,"BPA Certificate")
	* digitCustomInputFile(pTPO.constructionProofInputDocumentInput,testDataFile)
	* delay(2000)

	* clickElement(pTPO.propertyNextButton)
	# added delay of 10 seconds to navigate from document upload page to create property page.
	* delay(1000)
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
	#* delay(3000)
	* sendKeys(pTPO.propertyLocality,pTTestData.propertyLocalityData)
	* sendKeys(pTPO.propertyPinCode , pTTestData.propertyPinCode)
	* clickElement(pTPO.propertyNextButton)
	#Property Details
	* digitCustomSelectFromDropdownContainingLocalization(pTPO.propertyUsageType, pTTestData.propertyUsageType)
	* digitCustomSelectFromDropdownContainingLocalization(pTPO.propertyTypeOfBuilding , pTTestData.propertyTypeOfBuilding)
	* clickElement(pTPO.noRainWaterHarvesting)
	* digitCustomSelectFromDropdown(pTPO.assessmentOccupancy, pTTestData.assessmentOccupancy)
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPO.assessmentSuperArea , pTTestData.assessmentSuperArea)
	* digitCustomSelectFromDropdown(pTPO.selectFloor , pTTestData.selectFloor)
	* clickElement(pTPO.propertyNextButton)
	#Owner Details
	#* digitCustomSelectFromDropdown(pTPO.ownershipType2 , 'Individual / Single owner')
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
	* digitCustomSelectFromDropdown(pTPO.specialCategory , pTTestData.specialCategory)
	* clickElement(pTPO.propertyNextButton)
	* delay(100000)
	#Document Info
	# * digitCustomSelectFromDropdown(pTPO.addressProofInputDocumentType,"Electricity Bill")
	# * digitCustomSelectFromDropdown(pTPO.identityProofInputDocumentType,"Aadhar Card")
	# * digitCustomSelectFromDropdown(pTPO.registrationProofInputDocumentType,"Gift Deed")
	# * digitCustomSelectFromDropdown(pTPO.usageProofInputDocumentType,"Electricity Bill")
	# * digitCustomSelectFromDropdown(pTPO.constructionProofInputDocumentType,"BPA Certificate")
	#* digitCustomInputFile(pTPO.addressProofInputDocumentInput,testDataFile)
	#* digitCustomInputFile(pTPO.identityProofInputDocumentInput,testDataFile)
	#* digitCustomInputFile(pTPO.registrationProofInputDocumentInput,testDataFile)
	#* digitCustomInputFile(pTPO.usageProofInputDocumentInput,testDataFile)
	#* digitCustomInputFile(pTPO.constructionProofInputDocumentInput,testDataFile)
	#* clickElement(pTPO.addressProofInputDocumentInput)
#	* driver.inputFile(pTPO.addressProofInputDocumentInput, testDataFile)
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

# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)
# 	* input("//input[@id='contained-button-file'][1]", testDataFile)

  #	* input("Test","test")
  # * print "FILE UPLOADED"
	#* delay(1000000000)
    #* driver.inputFile(pTPO.registrationProofInputDocumentInput, testDataFile)
    #* driver.inputFile(pTPO.usageProofInputDocumentInput, testDataFile)
    #* driver.inputFile(pTPO.constructionProofInputDocumentInput, testDataFile)
#	* delay(5000)
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
 	# * clickElement(pTPO.propertyTaxModule)
	# * clickElement(pTPO.leftHamburger)
	# * clickElement(pTPO.propertyTaxFromLeftNav)
	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
	* clickElement(pTPO.searchApplicationButton)
 	* digitClickValueInSearchResults(appNumber)
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
	* delay(5000)
	* digitClickValueInSearchResults(appNumber)
	* delay(5000)

	* clickElement(pTPO.takeActionButton)
	* clickElement(pTPO.forwardDropdown)
	* clickElement(pTPO.assigneeName)
	#* clickElement(pTPO.selectAssigneeEmpAuto)
	* clickElement(pTPO.forwardButton)
	* clickElement(pTPO.forwardGoToHomeButton)
	* clickElement(pTPO.searchApplicationTab)
	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
	* clickElement(pTPO.searchApplicationButton)
	* digitClickValueInSearchResults(appNumber)
	* clickElement(pTPO.takeActionButton)
	* clickElement(pTPO.approveDropdown)
 	* sendKeys(pTPO.commentsInput)
	* clickElement(pTPO.approveButton)
	* def uniquePropertyIDFullString = getElementText(pTPO.generatedUniquePropertyID)
	* print uniquePropertyIDFullString
	* def splitArrayPropertyId= uniquePropertyIDFullString.split(":")
	* print splitArrayPropertyId
	* def propertyID = splitArrayPropertyId[1]
	* print propertyID
	# * def 



#it worked - 17/06/21
 @payPropertyTax
 Scenario:  pay for the property tax fees
	* call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
	* clickElement(pTPO.propertyTaxModule)
 	* clickElement(pTPO.payPropertyTax)  
	* clickElement(pTPO.searchApplicationTab)
	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
	* clickElement(pTPO.searchPropertyButton)
	* digitClickValueInSearchResults(uniquePropertyID)
	# Delay added to complete network calls
	* delay(2000)
	* clickElement(pTPO.assessProperty)
	# Delay added to complete network calls
	* delay(2000)
	* clickElement(pTPO.selectPropertyTaxYear)
	* clickElement(pTPO.okButton)
    * clickElement(pTPO.checkBox)
	* clickElement(pTPO.assessProperty)
	# Delay added to complete network calls
	* delay(2000)
	* clickElement(pTPO.proceedPaymentButton)
	* print "proceed to payment"
	* clickElement(pTPO.payerDetails)
	* clear(pTPO.payerDetails)
	* sendKeys(pTPO.payerDetails, pTTestData.payerDetails)
	* clickElement(pTPO.payerName)
	* clear(pTPO.payerName)
    * clickElement(pTPO.payerMobile)
	* clear(pTPO.payerMobile)
	# Delay added to complete network calls
	* delay(2000)
	* clickElement(pTPO.makePaymentButton2)
	* print "make payment"
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* print "payment gateway success"  
	* delay(2000)            
	* def payRecnumber = getElementText(pTPO.generatedPaymentReceiptNumber)
	* delay(2000)
	* print   payRecnumber + "payRecnumber"
	* def paymentReceiptNumber = getElementText(pTPO.generatedPaymentReceiptNumber).trim()	
	* delay(2000)
	* print paymentReceiptNumber + "paymentReceiptNumber"
	* print pTPO.headerMessagePayProperty
    
	
 @rejectPropertyVerification
 Scenario: Search property by application number and reject property Verification
    * clickElement(pTPO.propertyTaxModule)
 	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* digitClickValueInSearchResults(appNumber)
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
 	* digitClickValueInSearchResults(appNumber)
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
 	* digitClickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)
 	* clickElement(pTPO.forwardDropdown)
 	* clickElement(pTPO.assigneeName)
 	* clickElement(pTPO.selectAssigneeEmpAuto)
 	* clickElement(pTPO.forwardButton)
 	* clickElement(pTPO.goToHomeButton)
 	* clickElement(pTPO.searchApplicationTab)
 	* sendKeys(pTPO.searchByApplicationNumber, appNumber)
 	* clickElement(pTPO.searchApplicationButton)
 	* digitClickValueInSearchResults(appNumber)
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
 	* digitClickValueInSearchResults(appNumber)
 	* clickElement(pTPO.takeActionButton)	
 	* clickElement(pTPO.sendBackDropdown)
 	* clickElement(pTPO.sendBackToCitizenButton)
	* print pTPO.headerMessageSendBack 


	@createProperty2
Scenario: Create a new  Property as Citizen2
    * clickElement(pTPO.propertyTaxModule)
    * clickElement(pTPO.payPropertyTax)
    * clickElement(pTPO.propertyCreateLink)
	* clickElement(pTPO.propertyApplyButton)
	#Property Address
	# * digitCustomSelectFromDropdown(pTPO.propertyCitySelectDropdown, pTTestData.propertyCitySelectDropdown)
	# * def houseNumber = ranInteger(2)
	# * print "House Number"
	# * print houseNumber
	# * sendKeys(pTPO.propertyHouseNumber, pTTestData.propertyHouseNumber)
	# * def colony = randomString(10)
	# * print "colony"
	# * print colony
	# * sendKeys(pTPO.propertyColony, pTTestData.propertyColony)
	# * def street = randomString(10)
	# * print "street"
	# * print street
	# * sendKeys(pTPO.propertyStreet, pTTestData.propertyStreet)
	# * clickElement(pTPO.propertyLocality)
	# * sendKeys(pTPO.propertyLocality, pTTestData.propertyLocality)
	# * sendKeys(pTPO.propertyPinCode , pTTestData.propertyPinCode)
	# * clickElement(pTPO.propertyNextButton)
	* sendTextToAllElements()

	#Property Details
	* digitCustomSelectFromDropdownContainingLocalization(pTPO.propertyUsageType, pTTestData.Residential)
	* digitCustomSelectFromDropdownContainingLocalization(pTPO.propertyTypeOfBuilding , pTTestData.propertyTypeOfBuilding)
	* clickElement(pTPO.noRainWaterHarvesting)
	* digitCustomSelectFromDropdown(pTPO.assessmentOccupancy, pTTestData.assessmentOccupancy)
	* def assesmentArea = ranInteger(4)
	* print "assesment area"
	* print assesmentArea
	* sendKeys(pTPO.assessmentSuperArea , pTTestData.assessmentSuperArea)
	* digitCustomSelectFromDropdown(pTPO.selectFloor , pTTestData.selectFloor)
	* clickElement(pTPO.propertyNextButton)
	#Owner Details
	#* digitCustomSelectFromDropdown(pTPO.ownershipType2 , 'Individual / Single owner')
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
	* digitCustomSelectFromDropdown(pTPO.specialCategory , pTTestData.specialCategory)
	* clickElement(pTPO.propertyNextButton)
	#Document Info
	#* digitCustomSelectFromDropdown(pTPO.addressProofInputDocumentType,"Electricity Bill")
	#* digitCustomSelectFromDropdown(pTPO.identityProofInputDocumentType,"Aadhar Card")
	#* digitCustomSelectFromDropdown(pTPO.registrationProofInputDocumentType,"Gift Deed")
	#* digitCustomSelectFromDropdown(pTPO.usageProofInputDocumentType,"Electricity Bill")
	#* digitCustomSelectFromDropdown(pTPO.constructionProofInputDocumentType,"BPA Certificate")
	* digitCustomInputFile(pTPO.addressProofInputDocumentInput,testDataFile)
	* digitCustomInputFile(pTPO.identityProofInputDocumentInput,testDataFile)
	* digitCustomInputFile(pTPO.registrationProofInputDocumentInput,testDataFile)
	* digitCustomInputFile(pTPO.usageProofInputDocumentInput,testDataFile)
	* digitCustomInputFile(pTPO.constructionProofInputDocumentInput,testDataFile)
	* clickElement(pTPO.propertyNextButton)
	# added delay of 10 seconds to navigate from document upload page to create property page.
	* delay(1000)
	#Summary
	* clickElement(pTPO.acceptanceCheckbox)
	* clickElement(pTPO.addPropertyBtn)
	* def appNumber = getElementText(pTPO.generatedApplicationNumber).trim()	
	* print appNumber
	* print pTPO.headerMessageCreateProperty

	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	# * print paymentReceiptNumber
