Feature: Billing Services cancel bill tests

Background:
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    *  def billingServiceConstants = read('../constants/billing-service.yaml')
    * def apportionServiceConstants = read('../../business-services/constants/apportionService.yaml')
    *  def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    *  def cancelBillSuccessMessage = apportionServiceConstants.successMessages.cancelBillSuccess.message
    *  def cancelBillErrorMessage = apportionServiceConstants.errorMessages.cancelBillError.message
    
@cancelBillSuccess_01 @businessServices @positive @cancelBill 
Scenario: Test to cancelling an active bill successfully
    # Steps to search bill
    * call read('../../business-services/pretest/billingServicePretest.feature@successCancelBill')
    * assert cancelBillResponse.Message == cancelBillSuccessMessage

@cancelBillError_01 @businessServices @negative @cancelBill 
Scenario: Test to verify no active bills are available for cancelling
    # Steps to search bill
    * call read('../../business-services/pretest/billingServicePretest.feature@errorCancelBill')
    * assert cancelBillMessage == cancelBillErrorMessage
        * print cancelBillMessage

@cancelBillError_02 @businessServices @negative @cancelBill 
Scenario: Test to verify paid bills available for respective consumer code
    # Steps to search bill
    * call read('../../business-services/pretest/billingServicePretest.feature@errorCancelBill')
    * assert cancelPaidBillMessage == cancelBillErrorMessage
        * print cancelPaidBillMessage

@cancelBillError_03 @businessServices @negative @cancelBill 
Scenario: Test to verify partially paid bills available for respective consumer code
    # Steps to search bill
    * call read('../../business-services/pretest/billingServicePretest.feature@errorCancelBill')
    * assert cancelPartiallyPaidBillMessage == cancelBillErrorMessage
        * print cancelPartiallyPaidBillMessage

@cancelBillError_04 @businessServices @negative @cancelBill 
Scenario: Test to verify cancelled paid bills available for respective consumer code
    # Steps to search bill
    * call read('../../business-services/pretest/billingServicePretest.feature@errorCancelBill')
    * assert cancelPartiallyPaidBillMessage == cancelBillErrorMessage
        * print cancelPartiallyPaidBillMessage