Feature: Water And Sewerage Page Feature

Background:
    * def wsPage = read('../../ui-services/page-objects/waterAndSewerage.yaml')
    * def wSPO = wsPage.objects
@makeFullPayment
Scenario: Search water and sewerage by unique id and make full payment
	* waitFor(wSPO.waterAndSewerageModule).click()
	* waitFor(wSPO.payWaterAndSewerageBill).click()
	* waitFor(wSPO.selectCity).click()
	* input(wSPO.selectCity, [stateCode, Key.ENTER], 100)
	* input(wSPO.consumerNumberField, connectionNo)
	* click(wSPO.searchWsButton)
	* def payBillForConsumer = wSPO.payBillForConsumer
	* replace payBillForConsumer.connectionNo = connectionNo
	* waitFor(payBillForConsumer).click()
    * waitFor(wSPO.payButton).click()
	* delay(3000)
    * retry(3, 5000).waitFor(wSPO.payernameField).input(name)
    * waitFor(wSPO.payerMobileNoField).input(mobileNumber)
	* retry(3, 5000).waitFor(wSPO.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(wsPageObjects.paymentReceiptNo)
	* def paymentReceiptNumber = text(wsPageObjects.paymentReceiptNo)
	# * print paymentReceiptNumber

@makePartialPayment
Scenario: Search water and sewerage by unique id and make partial payment
	* waitFor(wSPO.waterAndSewerageModule).click()
	* waitFor(wSPO.payWaterAndSewerageBill).click()
	* waitFor(wSPO.selectCity).click()
	* input(wSPO.selectCity, [stateCode, Key.ENTER], 100)
	* input(wSPO.consumerNumberField, connectionNo)
	* click(wSPO.searchWsButton)
	* def payBillForConsumer = wSPO.payBillForConsumer
	* replace payBillForConsumer.connectionNo = connectionNo
	* waitFor(payBillForConsumer).click()
    * waitFor(wSPO.payButton).click()
	* delay(3000)
    * retry(3, 5000).waitFor(wSPO.payernameField).input(name)
    * waitFor(wSPO.payerMobileNoField).input(mobileNumber)
	* waitFor(wSPO.partialAmountRadioButton).click()
	* waitFor(wSPO.amountToPayField)
	* input(wSPO.amountToPayField, [Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, amountToPay], 100)
	* waitFor(wSPO.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(wsPageObjects.paymentReceiptNo)
	* def paymentReceiptNumber = text(wsPageObjects.paymentReceiptNo)
	# * print paymentReceiptNumber
