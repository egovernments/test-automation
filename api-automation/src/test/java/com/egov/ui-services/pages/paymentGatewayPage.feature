Feature: Payment Gateway Page Feature

Background:
    * def paymentGatewayPage = read('../../ui-services/page-objects/paymentGateway.yaml')
    * def pgObjects = paymentGatewayPage.objects

@makePayment
Scenario: Make Payment Through payment gateway
    * waitFor(pgObjects.cardTypeMastercard).click()
	* retry(5, 5000).waitFor(pgObjects.cardNumberField).input('5457210001000019')
	* waitFor(pgObjects.cardMonthField).input('12')
	* waitFor(pgObjects.cardYearField).input('25')
	* waitFor(pgObjects.payButton).click()
	* retry(5, 5000).waitFor(pgObjects.authResultDropdown)
	* select(pgObjects.authResultDropdown, pgObjects.authenticatedDropDownValue)
	* waitFor(pgObjects.submitButton).click()