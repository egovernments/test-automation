Feature: Pg services
Background:
 # calling create property and assess property
  * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
  * def jsUtils = read('classpath:jsUtils.js')
  * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
  #initializing create pg transaction request payload objects
  * def txnAmount = fetchBillResponse.Bill[0].totalAmount
  * def name = 'User ' + randomString(10)
  * def mobileNumber = '78' + randomMobileNumGen(8)
  * def pgSericesConstant = read('../../core-services/constants/pgServices.yaml')
  * def envCommon = read('file:envYaml/common/common.yaml')
  * def callbackUrl = envHost + envCommon.endPoints.pgServices.payload
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def gateway = commonConstants.parameters.gateway
  * def pgServicesCreatePayload = read('../../core-services/requestPayload/pg-service/pgServicesCreate.json')

@PGCreate_01  @coreServices @regression @positive  @pgservices
Scenario: Verify creating a payment transaction
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  
  * match pgServicesCreateResponseBody == '#present'

@PGCreate_InvalidTxnAmt_03  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent or null value for "TxnAmt" in the request body and check for erros
   * def txnAmount = commonConstants.invalidParameters.invalidValue
   # calling create pg transaction pretest
   * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
   
   * match pgServicesCreateResponseBody.Errors[0].message == pgSericesConstant.errorMessages.jsonException

@PGCreate_InvalidTenant_04  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "tenatid" in the request body and check for errors
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PGCreate_InvalidGateway_05  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "gateway" in the request body and check for errors
  * def gateway = commonConstants.invalidParameters.invalidValue
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PGCreate_NulValues_06
Scenario: Verify creating a payment transaction by passing null values
  # setting all the request payload params to null
  * def callbackUrl = commonConstants.invalidParameters.passValusAsNull
  * def consumerCode = commonConstants.invalidParameters.passValusAsNull
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  * def billId = commonConstants.invalidParameters.passValusAsNull
  * def gateway = commonConstants.invalidParameters.passValusAsNull
  * def productInfo = commonConstants.invalidParameters.passValusAsNull
  * def module = commonConstants.invalidParameters.passValusAsNull
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PGCreate_AmtVal_07  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a txn amount which is not equal to the amount paid
  * def txnAmount = txnAmount+100
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

# need to debug this
@PGCreate_ExpBill_08 @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a bill id which is expired
  # calling create pg transaction pretest
  * def consumerCode = 'PT-Test-' + ranInteger(6)
  * def consumerType = mdmsStateBillingService.BusinessService[0].businessService
  * def businessService = mdmsStateBillingService.BusinessService[0].code
  * def taxPeriodFrom = getPastEpochDate(2)
  * def taxPeriodTo = getPastEpochDate(1)
  * def taxHeadMasterCodes = karate.jsonPath(mdmsStateBillingService, "$.TaxHeadMaster[?(@.service=='" + businessService + "')].code")
  * def taxHeadMasterCode = taxHeadMasterCodes[randomNumber(taxHeadMasterCodes.length)]
  * def taxAmount = 200
  * def collectionAmount = 0
  * def minimumAmountPayable = 1
  * call read('../../business-services/pretest/billingServiceDemandPretest.feature@createBillDemand')
  * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PGCreate_AmtValDue_09  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction by passing a amount which is greater than amount due
  * def txnAmount = txnAmount+'0'
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PGCreate_InvalidBillID_10  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction with invalid/non existent value for "bill id" in the request body and check for errors
  * def billId = commonConstants.invalidParameters.invalidValue
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PGCreate_DupicatePay_11  @coreServices @regression @negative  @pgservices
Scenario: Verify creating a payment transaction with a bill id for which payment is already done
  # calling create pg transaction pretest
  * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  

@PG_Update_01  @coreServices @regression @positive  @pgservices
Scenario: Update a payment transaction
  # calling update pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatePgTransactionSuccessfully')
  

@PGUpdate_InvalidTxnId_02  @coreServices @regression @negative  @pgservices
Scenario: Verify updating a payment transaction with invalid/non existent value for "transaction id" in the request body
  * def transactionId = ranString(10)
  # calling update pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@invalidTransactionIdError')
   

@PGUpdate_NoTxnId_03  @coreServices @regression @negative  @pgservices
Scenario: Verify updating a payment transaction by not passing transaction id
  # calling update pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@withouttransactionidpgservicefail')
  

@PGUpdate_BillVal_05  @coreServices @regression @negative  @pgservices
Scenario: Verify updating by passing a transaction id which has expired bill and bill which is already paid
  # calling collection service create payment pretest
  * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatePgTransactionError')
  

@PGSearch_Txn_01  @coreServices @regression @negative  @pgservices
Scenario: Verify searching transaction details using txn id
  # calling search pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@searchPgTransactionSuccessfully')
  

@PGSearch_InvalidTxn_02  @coreServices @regression @negative  @pgservices
Scenario: Verify searching transaction details using null/ invalid/non existent  value for "transaction id"
  * def txnId = commonConstants.invalidParameters.passValusAsNull
  # calling search pg transaction pretest
  * call read('../../core-services/pretests/pgServiceSearch.feature@searchPgTransactionSuccessfully')
  


  # need to debug this
  @PGSearch_MultipleTxn_03  @coreServices @regression @negative  @pgservices
  Scenario: Verfiy searching transaction details using multiple txn id's
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * def transactionIdFirst = txnId
  * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
  * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * def transactionIdSecond = txnId
  * eval multipleTransactionIds = transactionIdFirst + ',' + transactionIdSecond
  * eval txnId = multipleTransactionIds
  * call read('../../core-services/pretests/pgServiceSearch.feature@searchPgTransactionSuccessfully')
  