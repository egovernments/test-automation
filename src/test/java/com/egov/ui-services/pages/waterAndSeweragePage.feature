Feature: Water And Sewerage Page Feature

Background:
    * def wsPage = read('../../ui-services/page-objects/waterAndSewerage.yaml')
    * def wsPageObjects = wsPage.objects

@makeFullPayment
Scenario: Search water and sewerage by unique id and make full payment
	* waitFor(wsPageObjects.waterAndSewerageModule).click()
	* waitFor(wsPageObjects.payWaterAndSewerageBill).click()
	* waitFor(wsPageObjects.selectCity).click()
	* input(wsPageObjects.selectCity, [stateCode, Key.ENTER], 100)
	* input(wsPageObjects.consumerNumberField, connectionNo)
	* click(wsPageObjects.searchWsButton)
	* def payBillForConsumer = wsPageObjects.payBillForConsumer
	* replace payBillForConsumer.connectionNo = connectionNo
	* waitFor(payBillForConsumer).click()
    * waitFor(wsPageObjects.payButton).click()
	* delay(3000)
    * retry(3, 5000).waitFor(wsPageObjects.payernameField).input(name)
    * waitFor(wsPageObjects.payerMobileNoField).input(mobileNumber)
	* retry(3, 5000).waitFor(wsPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(wsPageObjects.paymentReceiptNo)
	* def paymentReceiptNumber = text(wsPageObjects.paymentReceiptNo)
	* print paymentReceiptNumber

@makePartialPayment
Scenario: Search water and sewerage by unique id and make partial payment
	* waitFor(wsPageObjects.waterAndSewerageModule).click()
	* waitFor(wsPageObjects.payWaterAndSewerageBill).click()
	* waitFor(wsPageObjects.selectCity).click()
	* input(wsPageObjects.selectCity, [stateCode, Key.ENTER], 100)
	* input(wsPageObjects.consumerNumberField, connectionNo)
	* click(wsPageObjects.searchWsButton)
	* def payBillForConsumer = wsPageObjects.payBillForConsumer
	* replace payBillForConsumer.connectionNo = connectionNo
	* waitFor(payBillForConsumer).click()
    * waitFor(wsPageObjects.payButton).click()
	* delay(3000)
    * retry(3, 5000).waitFor(wsPageObjects.payernameField).input(name)
    * waitFor(wsPageObjects.payerMobileNoField).input(mobileNumber)
	* waitFor(wsPageObjects.partialAmountRadioButton).click()
	* waitFor(wsPageObjects.amountToPayField)
	* input(wsPageObjects.amountToPayField, [Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, amountToPay], 100)
	* waitFor(wsPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(wsPageObjects.paymentReceiptNo)
	* def paymentReceiptNumber = text(wsPageObjects.paymentReceiptNo)
	* print paymentReceiptNumber