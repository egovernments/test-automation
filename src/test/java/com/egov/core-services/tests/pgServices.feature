Feature: Pg services
        Background:
        # calling create property and assess property
  * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
  * def jsUtils = read('classpath:jsUtils.js')
  * call read('../../business-services/preTests/billingServicePretest.feature@fetchBill')
  #initializing create pg transaction request payload objects
  * def txnAmount = fetchBillResponse.Bill[0].totalAmount
  * def name = fetchBillResponse.Bill[0].payerName
  * def mobileNumber = fetchBillResponse.Bill[0].mobileNumber
  * def pgSericesConstant = read('../../core-services/constants/pgServices.yaml')
  * def envConstant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * def envCommon = read('file:envYaml/common/common.yaml')
  * def callbackUrl = envConstant.host + envCommon.endPoints.pgServices.payload
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def gateway = commonConstants.parameters.gateway
  * def pgServicesCreatePayload = read('../../core-services/requestPayload/pgServices/pgServicesCreate.json')

        @PGCreate_01  @positive  @pgservices
        Scenario: Verify creating a payment transaction
        # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * print pgServicesCreateResponseBody
  * match pgServicesCreateResponseBody == '#present'

        @PGCreate_InvalidTxnAmt_03  @negative  @pgservices
        Scenario: Verify creating a payment transaction with invalid/non existent or null value for "TxnAmt" in the request body and check for erros
   * def txnAmount = commonConstants.invalidParameters.invalidValue
   # calling create pg transaction pretest
   * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
   * print pgServicesCreateResponseBody
   * match pgServicesCreateResponseBody.Errors[0].message == pgSericesConstant.errorMessages.jsonException

        @PGCreate_InvalidTenant_04  @negative  @pgservices
        Scenario: Verify creating a payment transaction with invalid/non existent value for "tenatid" in the request body and check for errors
  * def tenantId = commonConstants.invalidParameters.invalidTenantId
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

        @PGCreate_InvalidGateway_05  @negative  @pgservices
        Scenario: Verify creating a payment transaction with invalid/non existent value for "gateway" in the request body and check for errors
  * def gateway = commonConstants.invalidParameters.invalidValue
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

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
  * print pgServicesCreateResponseBody

        @PGCreate_AmtVal_07  @negative  @pgservices
        Scenario: Verify creating a payment transaction by passing a txn amount which is not equal to the amount paid
  * def txnAmount = txnAmount+100
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

        @PGCreate_ExpBill_08  @negative  @pgservices
        Scenario: Verify creating a payment transaction by passing a bill id which is expired
        # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

        @PGCreate_AmtValDue_09  @negative  @pgservices
        Scenario: Verify creating a payment transaction by passing a amount which is greater than amount due
  * def txnAmount = txnAmount+'0'
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

        @PGCreate_InvalidBillID_10  @negative  @pgservices
        Scenario: Verify creating a payment transaction with invalid/non existent value for "bill id" in the request body and check for errors
  * def billId = commonConstants.invalidParameters.invalidValue
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

        @PGCreate_DupicatePay_11  @negative  @pgservices
        Scenario: Verify creating a payment transaction with a bill id for which payment is already done
        # calling create pg transaction pretest
  * call read('../../business-services/preTests/collectionServicesPretest.feature@createPayment')
  # calling create pg transaction pretest
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionError')
  * print pgServicesCreateResponseBody

        @PG_Update_01  @positive  @pgservices
        Scenario: Update a payment transaction
        # calling update pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatePgTransactionSuccessfully')
  * print pgServicesUpdateResponseBody

        @PGUpdate_InvalidTxnId_02  @negative  @pgservices
        Scenario: Verify updating a payment transaction with invalid/non existent value for "transaction id" in the request body
  * def transactionId = ranString(10)
  # calling update pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatePgTransactionError')
  * print pgServicesUpdateResponseBody 

        @PGUpdate_NoTxnId_03  @negative  @pgservices
        Scenario: Verify updating a payment transaction by not passing transaction id
        # calling update pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@withouttransactionidpgservicefail')
  * print pgServicesUpdateResponseBody

        @PGUpdate_BillVal_05  @negative  @pgservices
        Scenario: Verify updating by passing a transaction id which has
1. expired bill 
2. bill which is already paid
      # calling collection service create payment pretest
  * call read('../../business-services/preTests/collectionServicesPretest.feature@createPayment')
  * call read('../../core-services/pretests/pgServiceUpdate.feature@updatePgTransactionError')
  * print pgServicesUpdateResponseBody

        @PGSearch_Txn_01  @negative  @pgservices
        Scenario: Verify searching transaction details using txn id
        # calling search pg transaction pretest
  * call read('../../core-services/pretests/pgServiceUpdate.feature@searchPgTransactionSuccessfully')
  * print pgServicesSearchResponseBody

        @PGSearch_InvalidTxn_02  @negative  @pgservices
        Scenario: Verify searching transaction details using null/ invalid/non existent  value for "transaction id"
  * def txnId = commonConstants.invalidParameters.passValusAsNull
  # calling search pg transaction pretest
  * call read('../../core-services/pretests/pgServiceSearch.feature@searchPgTransactionSuccessfully')
  * print pgServicesSearchResponseBody


        # Need to fix the testcase. so it is commented
        # @PGSearch_MultipleTxn_03  @negative  @pgservices
        Scenario: Verfiy searching transaction details using multiple txn id's
  * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
  * def mobileNumber = searcherResponseBody.Bills[0].mobileNumber
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * def multipleTransactionIds = txnId
  * call read('../../core-services/pretests/pgServiceCreate.feature@createPgTransactionSuccessfully')
  * eval multipleTransactionIds = multipleTransactionIds + ',' + txnId
  * eval txnId = multipleTransactionIds
  * call read('../../core-services/pretests/pgServiceSearch.feature@searchPgTransactionSuccessfully')
  * print pgServicesSearchResponseBody


   




