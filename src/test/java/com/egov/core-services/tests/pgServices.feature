Feature: Pg services
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def pgServicesCreatePayload = read('../requestPayload/pgServices/pgServicesCreate.json')
  * def pgSericesConstant = read('../constants/pgServices.yaml')
  * def txnAmount = pgSericesConstant.parameters.txnAmount
  * def gateway = pgSericesConstant.parameters.gateway

@PGCreate_01  @positive
Scenario: Verify creating a payment transaction
  * call read('../pretests/pgServiceCreate.feature@createpgservicesuccess')
  * print pgServicesCreateResponseBody

#@PGCreate_AbruptlyDiscarded_02  @negative
#Scenario: Verify creating a payment transaction and check for errors

@PGCreate_InvalidTxnAmt_03  @negative
Scenario: Verify creating a payment transaction with invalid/non existent or null value for "TxnAmt" in the request body and check for erros
   * def txnAmount = pgSericesConstant.parameters.invalidTxnAmount
   * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
   * print pgServicesCreateResponseBody

@PGCreate_InvalidTenant_04  @negative
Scenario: Verify creating a payment transaction with invalid/non existent value for "tenatid" in the request body and check for errors
  * def tenantId = pgSericesConstant.parameters.invalidTenantId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidGateway_05  @negative
Scenario: Verify creating a payment transaction with invalid/non existent value for "gateway" in the request body and check for errors
  * def gateway = pgSericesConstant.parameters.invalidGateway
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

<<<<<<< HEAD
=======
@PGCreate_NulValues_06  @negative
>>>>>>> 8556270... pgservices changes
