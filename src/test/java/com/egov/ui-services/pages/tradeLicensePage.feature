Feature: Trade License Page Feature

Background:
    * def tlPage = read('../../ui-services/page-objects/tradeLicense.yaml')
    * def tlPageObjects = tlPage.objects

@makeFullPayment
Scenario: Search water and sewerage by unique id and make full payment
	* waitFor(tlPageObjects.tradeLicenseModule).click()
	* waitFor(tlPageObjects.myApplications).click()
	* def tlApplicationDetails = tlPageObjects.viewDetails
	* replace tlApplicationDetails.consumerCode = consumerCode
	* waitFor(tlApplicationDetails).click()
	* delay(3000)
	* waitFor(tlPageObjects.takeActionButton).click()
	* waitFor(tlPageObjects.citizenPayActionButton).click()
	* delay(3000)
    * retry(3, 5000).waitFor(tlPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(tlPageObjects.paymentReceiptNo)
	* def paymentReceiptNumber = text(tlPageObjects.paymentReceiptNo)
	* print paymentReceiptNumber