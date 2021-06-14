Feature: Payment Gateway Page Feature

Background:
    * def paymentGatewayPage = read('../../ui-services/page-objects/paymentGateway.yaml')
	* def pgData = paymentGatewayPage.data
	* def pGPO = paymentGatewayPage.objects
	
@makePayment
Scenario: Make Payment Through payment gateway
    * waitFor(pGPO.cardTypeMastercard).click()
	* retry(5, 5000).waitFor(pGPO.cardNumberField).input(pgData.cardNumberField)
	* waitFor(pGPO.cardMonthField).input(pgData.cardMonthField)
	* waitFor(pGPO.cardYearField).input(pgData.cardYearField)
	* waitFor(pGPO.payButton).click()
	* retry(5, 5000).waitFor(pGPO.authResultDropdown)
	* select(pGPO.authResultDropdown, pGPO.authenticatedDropDownValue)
	* waitFor(pGPO.submitButton).click()

