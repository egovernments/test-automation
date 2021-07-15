Feature: Trade License Page Feature

Background:
    * def tlPage = read('../../ui-services/page-objects/tradeLicense.yaml')
	* def tLPO: tlPage.objects

@makeFullPayment
Scenario: Search water and sewerage by unique id and make full payment
	* waitFor(tLPO.tradeLicenseModule).click()
	* waitFor(tLPO.myApplications).click()
	* def tlApplicationDetails = tLPO.viewDetails
	* replace tlApplicationDetails.consumerCode = consumerCode
	* waitFor(tlApplicationDetails).click()
	* delay(3000)
	* waitFor(tLPO.takeActionButton).click()
	* waitFor(tLPO.citizenRenewalPayActionButton).click()
	* delay(3000)
    * retry(3, 5000).waitFor(tLPO.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(tlPageObjects.paymentReceiptNo)
	* def paymentReceiptNumber = text(tlPageObjects.paymentReceiptNo)
	# * print paymentReceiptNumber
