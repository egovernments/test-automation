Feature: Pg services
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../pretests/authenticationToken.feature')
  * def fetchbillid = call read('../tests/billingService.feature')
  * def billId = fetchbillid.billId
  * def pgServicesCreatePayload = read('../requestPayload/pgServices/pgServicesCreate.json')
  * def pgSericesConstant = read('../constants/pgServices.yaml')
  * def txnAmount = pgSericesConstant.parameters.valid.txnAmount
  * def gateway = pgSericesConstant.parameters.valid.gateway
  * def consumerCode = pgSericesConstant.parameters.valid.consumerCode
  * def envConstant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * def envCommon = read('file:envYaml/common/common.yaml')
  * def callbackUrl = envConstant.host + envCommon.endPoints.pgServices.payload
  * print callbackUrl
  * def commonConstants = read('../constants/commonConstants.yaml')

@PGCreate_01
Scenario: Verify creating a payment transaction
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * call read('../pretests/pgServiceCreate.feature@createpgservicesuccess')
  * print pgServicesCreateResponseBody
  * match pgServicesCreateResponseBody == '#present'

@PGCreate_InvalidTxnAmt_03  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent or null value for "TxnAmt" in the request body and check for erros
   * def txnAmount = pgSericesConstant.parameters.invalid.invalidTxnAmount
   * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
   * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
   * print pgServicesCreateResponseBody
   * assert pgServicesCreateResponseBody.Errors[0].message == pgSericesConstant.errorMessages.invalidTxnAmount

@PGCreate_InvalidTenant_04  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "tenatid" in the request body and check for errors
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidGateway_05  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "gateway" in the request body and check for errors
  * def gateway = pgSericesConstant.parameters.invalid.invalidGateway
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_NulValues_06
Scenario: Verify creating a payment transaction by passing null values
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_AmtVal_07  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a txn amount which is not equal to the amount paid
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * def txnAmount = pgSericesConstant.parameters.valid.paidAmount
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_ExpBill_08  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a bill id which is expired
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * def billId = pgSericesConstant.parameters.valid.expiredBillId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_AmtValDue_09  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a amount which is greater than amount due 
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * def txnAmount = pgSericesConstant.parameters.valid.amountGreterThanDue
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidBillID_10  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "bill id" in the request body and check for errors
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * def billId = pgSericesConstant.parameters.valid.nonExistentBillId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_DupicatePay_11  @negative  @pgservices
Scenario: Verify creating a payment transaction with a bill id for which payment is already done
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceCreateMobileNumber
  * def billId = pgSericesConstant.parameters.valid.paidBillId
  * call read('../pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PG_Update_01  @positive  @pgservices
Scenario: Update a payment transaction
  * def transactionId = pgSericesConstant.parameters.valid.validTransactionId
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicesuccess')
  * print pgServicesUpdateResponseBody

@PGUpdate_InvalidTxnId_02  @negative  @pgservices
Scenario: Verify updating a payment transaction with invalid/non existent value for "transaction id" in the request body
  * def transactionId = pgSericesConstant.parameters.invalid.invalidTransactionId
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicefail')
  * print pgServicesUpdateResponseBody 

@PGUpdate_NoTxnId_03  @negative  @pgservices
Scenario: Verify updating a payment transaction by not passing transaction id
  * call read('../pretests/pgServiceUpdate.feature@withouttransactionidpgservicefail')
  * print pgServicesUpdateResponseBody

@PGUpdate_InvalidAuth_04  @500
Scenario: Verify by updating invalid/non existent or null value for auth Token
  * def authToken = commonConstants.invalidParameters.invalidAuthToken
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicesuccess')
  * print pgServicesUpdateResponseBody 

@PGUpdate_BillVal_05  @negative  @pgservices
Scenario: Verify updating by passing a transaction id which has 
1. expired bill 
2. bill which is already paid
  * def transactionId = pgSericesConstant.parameters.valid.trasanctioIdWhichBillExpired
  * call read('../pretests/pgServiceUpdate.feature@updatepgservicefail')
  * print pgServicesUpdateResponseBody

@PGSearch_Txn_01  @negative  @pgservices
Scenario: Verify searching transaction details using txn id
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceSearchMobileNumber
  * call read('../pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody

@PGSearch_InvalidTxn_02  @negative  @pgservices
Scenario: Verify searching transaction details using null/ invalid/non existent  value for "transaction id"
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceSearchMobileNumber
  * def txnId = pgSericesConstant.parameters.invalid.invalidTxnId
  * call read('../pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody

@PGSearch_MultipleTxn_03  @negative  @pgservices
Scenario: Verfiy searching transaction details using multiple txn id's
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceSearchMobileNumber
  * call read('../pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody
  

@PGSearch_InvalidAuth_04  @500
Scenario: Verify passing invalid/non existent or null value for auth Token and check for error
* def authToken = commonConstants.invalidParameters.invalidAuthToken
* call read('../pretests/pgServiceUpdate.feature@searchpgservicefail')
* print pgServicesSearchResponseBody



   




