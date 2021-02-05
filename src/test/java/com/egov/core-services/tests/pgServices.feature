Feature: Pg services
Background:
  * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
  * def jsUtils = read('classpath:jsUtils.js')
  #* call read('../../business-services/tests/billingServicesDemand.feature@create_01')
  * call read('../../business-services/preTests/billingServicePretest.feature@fetchBill')
  * def txnAmount = fetchBillResponse.Bill[0].totalAmount
  * def name = fetchBillResponse.Bill[0].payerName
  * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
  * def pgSericesConstant = read('../../core-services/constants/pgServices.yaml')
  * def envConstant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * def envCommon = read('file:envYaml/common/common.yaml')
  * def callbackUrl = envConstant.host + envCommon.endPoints.pgServices.payload
  * print callbackUrl
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def gateway = commonConstants.parameters.gateway
  * def pgServicesCreatePayload = read('../../core-services/requestPayload/pgServices/pgServicesCreate.json')

@PGCreate_01  @positive  @pgservices
Scenario: Verify creating a payment transaction
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicesuccess')
  * print pgServicesCreateResponseBody
  * match pgServicesCreateResponseBody == '#present'

@PGCreate_InvalidTxnAmt_03  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent or null value for "TxnAmt" in the request body and check for erros
   * def txnAmount = commonConstants.invalidParameters.invalidValue
   * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
   * print pgServicesCreateResponseBody
   * assert pgServicesCreateResponseBody.Errors[0].message == pgSericesConstant.errorMessages.invalidTxnAmount

@PGCreate_InvalidTenant_04  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "tenatid" in the request body and check for errors
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidGateway_05  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "gateway" in the request body and check for errors
  * def gateway = commonConstants.invalidParameters.invalidValue
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_NulValues_06
Scenario: Verify creating a payment transaction by passing null values
  * def callbackUrl = commonConstants.invalidParameters.passValusAsNull
  * def consumerCode = commonConstants.invalidParameters.passValusAsNull
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  * def billId = commonConstants.invalidParameters.passValusAsNull
  * def gateway = commonConstants.invalidParameters.passValusAsNull
  * def productInfo = commonConstants.invalidParameters.passValusAsNull
  * def module = commonConstants.invalidParameters.passValusAsNull
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_AmtVal_07  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a txn amount which is not equal to the amount paid
  * def txnAmount = txnAmount+100
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_ExpBill_08  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a bill id which is expired
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_AmtValDue_09  @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a amount which is greater than amount due 
  * def txnAmount = txnAmount+'0'
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_InvalidBillID_10  @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "bill id" in the request body and check for errors
  * def billId = commonConstants.invalidParameters.invalidValue
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PGCreate_DupicatePay_11  @negative  @pgservices
Scenario: Verify creating a payment transaction with a bill id for which payment is already done
  * call read('../../business-services/preTests/collectionServicesPretest.feature@createPayment')
  * call read('../../core-services/pretests/pgServiceCreate.feature@createpgservicefail')
  * print pgServicesCreateResponseBody

@PG_Update_01  @positive  @pgservices
Scenario: Update a payment transaction
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatepgservicesuccess')
  * print pgServicesUpdateResponseBody

@PGUpdate_InvalidTxnId_02  @negative  @pgservices
Scenario: Verify updating a payment transaction with invalid/non existent value for "transaction id" in the request body
  * def transactionId = pgSericesConstant.parameters.invalid.invalidTransactionId
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatepgservicefail')
  * print pgServicesUpdateResponseBody 

@PGUpdate_NoTxnId_03  @negative  @pgservices
Scenario: Verify updating a payment transaction by not passing transaction id
  * call read('../../core-services/pretests/pgServiceUpdate.feature@withouttransactionidpgservicefail')
  * print pgServicesUpdateResponseBody

@PGUpdate_BillVal_05  @negative  @pgservices
Scenario: Verify updating by passing a transaction id which has 
1. expired bill 
2. bill which is already paid
  * call read('../../business-services/preTests/collectionServicesPretest.feature@createPayment')
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatepgservicefail')
  * print pgServicesUpdateResponseBody

@PGSearch_Txn_01  @negative  @pgservices
Scenario: Verify searching transaction details using txn id
  * call read('../../core-services/pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody

@PGSearch_InvalidTxn_02  @negative  @pgservices
Scenario: Verify searching transaction details using null/ invalid/non existent  value for "transaction id"
  * def txnId = commonConstants.invalidParameters.passValusAsNull
  * call read('../../core-services/pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody

#@PGSearch_MultipleTxn_03  @negative  @pgservices
Scenario: Verfiy searching transaction details using multiple txn id's
  * def mobileNumber = pgSericesConstant.parameters.valid.pgServiceSearchMobileNumber
  * call read('../../core-services/pretests/pgServiceUpdate.feature@searchpgservicesuccess')
  * print pgServicesSearchResponseBody


   




