Feature: Billing Service
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def billingServiceConstant = read('../constants/billingService.yaml')
  * def consumerCode = billingServiceConstant.parameters.fetchBill.consumerCode
  * def businessService = billingServiceConstant.parameters.fetchBill.businessService

@fetchbill_01  @positive @billService
Scenario: Test to fetchbill by passing valid consumer code and business service
  * call read('../pretests/fetchBill.feature@fetchbillsuccess')
  * print fetchBillResponseBody
  * def billId = fetchBillResponseBody.Bill[0].id
  * print billId