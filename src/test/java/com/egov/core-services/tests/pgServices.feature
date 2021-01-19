Feature: Pg services
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def fetchbillid = call read('../tests/billingService.feature')
  * def billId = fetchbillid.billId
  * def pgServicesCreatePayload = read('../requestPayload/pgServices/pgServicesCreate.json')
  * def pgSericesConstant = read('../constants/pgServices.yaml')
  * def txnAmount = pgSericesConstant.parameters.txnAmount
  * def gateway = pgSericesConstant.parameters.gateway
  * def consumerCode = pgSericesConstant.parameters.consumerCode

@PGCreate_01  @positive  @pgservices
Scenario: Verify creating a payment transaction
  * call read('../pretests/pgServiceCreate.feature@createpgservicesuccess')
  * print pgServicesCreateResponseBody
  * match pgServicesCreateResponseBody == '#present'

#@PGCreate_AbruptlyDiscarded_02  @negative
#Scenario: Verify creating a payment transaction and check for errors

@PGCreate_InvalidTxnAmt_03  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent or null value for "TxnAmt" in the request body and check for erros
   * def txnAmount = pgSericesConstant.parameters.invalidTxnAmount
   * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
   * print pgServicesCreateResponseBody
   * assert pgServicesCreateResponseBody.Errors[0].message == pgSericesConstant.errorMessages.invalidTxnAmount

@PGCreate_InvalidTenant_04  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "tenatid" in the request body and check for errors
  * def tenantId = pgSericesConstant.parameters.invalidTenantId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidGateway_05  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "gateway" in the request body and check for errors
  * def gateway = pgSericesConstant.parameters.invalidGateway
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_NulValues_06  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing null values
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_AmtVal_07  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a txn amount which is not equal to the amount paid
  * def txnAmount = pgSericesConstant.parameters.paidAmount
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_ExpBill_08  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a bill id which is expired
  * def billId = pgSericesConstant.parameters.expiredBillId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_AmtValDue_09  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a amount which is greater than amount due 
  * def txnAmount = pgSericesConstant.parameters.amountGreterThanDue
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidBillID_10  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "bill id" in the request body and check for errors
  * def billId = pgSericesConstant.parameters.nonExistentBillId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_DupicatePay_11  @negative  @pgservices
Scenario: Verify creating a payment transaction with a bill id for which payment is already done
  * def billId = pgSericesConstant.parameters.paidBillId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PG_Update_01  @positive  @pgservices
Scenario: Update a payment transaction
  * def transactionId = pgSericesConstant.parameters.validTransactionId
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicesuccess')
  * print pgServicesUpdateResponseBody

@PGUpdate_InvalidTxnId_02  @negative  @pgservices
Scenario: Verify updating a payment transaction with invalid/non existent value for "transaction id" in the request body
  * def transactionId = pgSericesConstant.parameters.invalidTransactionId
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicefail')
  * print pgServicesUpdateResponseBody 

@PGUpdate_NoTxnId_03  @negative  @pgservices
Scenario: Verify updating a payment transaction by not passing transaction id
  * call read('../pretests/pgServiceUpdate.feature@withouttransactionidpgservicefail')
  * print pgServicesUpdateResponseBody

@PGUpdate_InvalidAuth_04  @500
Scenario: Verify by updating invalid/non existent or null value for auth Token
  * def authToken = pgSericesConstant.parameters.invalidAuthToken
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicesuccess')
  * print pgServicesUpdateResponseBody 

@PGUpdate_BillVal_05  @negative  @pgservices
Scenario: Verify updating by passing a transaction id which has 
1. expired bill 
2. bill which is already paid
  * def transactionId = pgSericesConstant.parameters.trasanctioIdWhichBillExpired
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicefail')
  * print pgServicesUpdateResponseBody

@PGSearch_Txn_01  @negative  @pgservices
Scenario: Verify searching transaction details using txn id
  * call read('../pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody

@PGSearch_InvalidTxn_02  @negative  @pgservices
Scenario: Verify searching transaction details using null/ invalid/non existent  value for "transaction id"
  * def txnId = pgSericesConstant.parameters.invalidTxnId
  * call read('../pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody

@PGSearch_MultipleTxn_03  @negative  @pgservices
Scenario: Verfiy searching transaction details using multiple txn id's
  * call read('../pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody
  

@PGSearch_InvalidAuth_04  @500
Scenario: Verify passing invalid/non existent or null value for auth Token and check for error
* def authToken = pgSericesConstant.parameters.invalidSearcAuthToken
* call read('../pretests/pgServiceUpdate.feature@searchpgservicefail')
* print pgServicesSearchResponseBody



   




