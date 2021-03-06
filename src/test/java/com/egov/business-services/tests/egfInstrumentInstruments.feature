Feature: To test egf-Instrument-Instruments service tests

Background: 
  * def jsUtils = read('classpath:jsUtils.js')
  #egf-Instruments Constants file
  * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
  * def transactionType = egfInstrumentConstants.parameters.creditTransactionType
  * def name = egfInstrumentConstants.parameters.instrumentTypeNameCash
  * def active = egfInstrumentConstants.parameters.activeTrue
  * def transactionNumber = 'transactionNumber' + randomMobileNumGen(5)
  * def transactionDate = currentDate()
  * def amount = randomMobileNumGen(4)
  * def payee = 'PayeeName_' + ranString(4)
  * def bank = 'Bank_'+randomMobileNumGen(4)
  * def bankAccount = 'BankAccount_'+randomMobileNumGen(4)
  * def branchName = 'BranchName_'+randomMobileNumGen(4)
  * def ifscCode = 'IFSCCode_'+randomMobileNumGen(4)
  * def serialNo = 'SerialNo_'+randomMobileNumGen(2)
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')

#Create Instruments TCs

@egf-instrument_create_Debit_01 @positive @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with Debit
  * def transactionType = egfInstrumentConstants.parameters.debitTransactionType
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  # Validating response body
  * match instrumentCreateResponseBody.instruments[0].transactionNumber == transactionNumber
  * match instrumentCreateResponseBody.instruments[0].branchName == branchName
  * match instrumentCreateResponseBody.instruments[0].transactionType == transactionType


@egf-instrument_create_Credit_02 @positive @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with Credit
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  # Validating response body
  * match instrumentCreateResponseBody.instruments[0].transactionNumber == transactionNumber
  * match instrumentCreateResponseBody.instruments[0].branchName == branchName
  * match instrumentCreateResponseBody.instruments[0].transactionType == transactionType


@egf-instrument_create_NoTransactionNumber_03 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with No Transaction Number
  * def transactionNumber = null
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.message == egfInstrumentConstants.errorMessages.transactionNumberError


@egf-instrument_create_NoDate_04 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with NoDate
  * def transactionDate = null
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentCreateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.nullError
  * match instrumentCreateResponseBody.error.fields[0].field == 'transactionDate'


@egf-instrument_create_NoAmount_05 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with NoAmount
  * def amount = null
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentCreateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.nullError
  * match instrumentCreateResponseBody.error.fields[0].field == 'amount'


@egf-instrument_create_ZeroAmount_06 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with Zero Amount
  * def amount = egfInstrumentConstants.parameters.zeroAmount
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentCreateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.minimumSizeError
  * match instrumentCreateResponseBody.error.fields[0].field == 'amount'


@egf-instrument_create_AmountWithMorethan9Digits_07 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument Amount with More than 9 digits
  * def amount = randomMobileNumGen(10)
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentCreateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.maximumSizeError
  * match instrumentCreateResponseBody.error.fields[0].field == 'amount'

  
@egf-instrument_create_MaxAmount_08 @positive @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with Max Amount
  * def amount = egfInstrumentConstants.parameters.maxAmount
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  # Validating response body
  * match instrumentCreateResponseBody.instruments[0].transactionNumber == transactionNumber
  * match instrumentCreateResponseBody.instruments[0].branchName == branchName
  * match instrumentCreateResponseBody.instruments[0].transactionType == transactionType
  * match instrumentCreateResponseBody.instruments[0].amount == amount


@egf-instrument_create_InvalidInstrumentTypeName_09 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with Invalid Instrument type
  * def name = commonConstants.invalidParameters.invalidValue
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.message == 'instrumentType'
  * match instrumentCreateResponseBody.error.fields == commonConstants.invalidParameters.nullValue 


@egf-instrument_create_TransactionNumberWithMorethan50Characters_10 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with transaction number more than 50 characters
  * def transactionNumber = 'transactionNumber' +randomString(40)
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateInstruments')
  # Validating response body
  * match instrumentCreateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentCreateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.sizeError
  * match instrumentCreateResponseBody.error.fields[0].field == 'transactionNumber' 

  
@egf-instrument_create_TransactionNumberWith49Characters_11 @positive @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with transaction number 49 characters
  * def transactionNumber = 'transactionNumber' +randomString(32)
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  # Validating response body
  * match instrumentCreateResponseBody.instruments[0].transactionNumber == transactionNumber
  * match instrumentCreateResponseBody.instruments[0].branchName == branchName
  * match instrumentCreateResponseBody.instruments[0].transactionType == transactionType


@egf-instrument_create_InvalidTenantID_12 @negative @instrumentCreate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Create instrument with Invalid tenantId
  * def tenantId = commonConstants.invalidParameters.invalidValue
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@unauthorizedaccessError')
  # Validating response body
  * match instrumentCreateResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

#Update Instruments TCs
@egf-instrument_update_TransactionNumber_01 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Transaction Number
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionNumber = 'UpdatedTransactionNumber' + randomMobileNumGen(3)
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  # Validating response body
  * match instrumentUpdateResponseBody.instruments[0].transactionNumber == transactionNumber
  * match instrumentUpdateResponseBody.instruments[0].amount == amount

@egf-instrument_update_TransactionNumberWithMorethan50Characters_02 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Transaction Number more than 50 characters
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionNumber = 'UpdatedTransactionNumber' + randomString(40) +randomMobileNumGen(3)
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstruments')
  # Validating response body
  * match instrumentUpdateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentUpdateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.sizeError
  * match instrumentUpdateResponseBody.error.fields[0].field == 'transactionNumber'

@egf-instrument_update_TransactionDate_03 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Transaction Date
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionDate = yesterdayDate()
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  # Validating response body
  * match instrumentUpdateResponseBody.instruments[0].transactionDate == transactionDate
 
 @egf-instrument_update_NullTransactionDate_04 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Null Transaction Date
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionDate = null
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstruments')
  # Validating response body
  * match instrumentUpdateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentUpdateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.nullError
  * match instrumentUpdateResponseBody.error.fields[0].field == 'transactionDate'

@egf-instrument_update_Amount_05 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Amount
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def amount = randomNumber(5)
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  # Validating response body
  * match instrumentUpdateResponseBody.instruments[0].amount == amount
  * match instrumentUpdateResponseBody.instruments[0].transactionNumber == transactionNumber


@egf-instrument_update_MaxAmount_06 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Max Amount
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def amount = egfInstrumentConstants.parameters.maxAmount
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  * match instrumentUpdateResponseBody.instruments[0].amount == amount
  * match instrumentUpdateResponseBody.instruments[0].transactionNumber == transactionNumber


@egf-instrument_update_MoreThanMaxAmount_07 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument withMore than Max Amount
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def amount = randomMobileNumGen(10)
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstruments')
   # Validating response body
  * match instrumentUpdateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentUpdateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.maximumSizeError
  * match instrumentUpdateResponseBody.error.fields[0].field == 'amount'


@egf-instrument_update_PayeeName_08 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update PayeeName
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def payee = 'Updated_PayeeName_' + ranString(5)
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  # Validating response body
  * match instrumentUpdateResponseBody.instruments[0].payee == payee
  * match instrumentUpdateResponseBody.instruments[0].transactionNumber == transactionNumber


@egf-instrument_update_PayeeWithMorethan50Characters_09 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update PayeeName with more than 50 characters
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def payee = randomString(55)
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstruments')
  # Validating response body
  * match instrumentUpdateResponseBody.error.description == egfInstrumentConstants.errorMessages.errorDescription
  * match instrumentUpdateResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.sizeError
  * match instrumentUpdateResponseBody.error.fields[0].field == 'payee'


@egf-instrument_update_TransactionType_10 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Transaction Type
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionType = egfInstrumentConstants.parameters.debitTransactionType
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  # Validating response body
  * match instrumentUpdateResponseBody.instruments[0].transactionType == transactionType
  * match instrumentUpdateResponseBody.instruments[0].transactionNumber == transactionNumber

@egf-instrument_update_InvalidTransactionType_11 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with Transaction Type
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionType = commonConstants.invalidParameters.invalidValue
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstruments')
  # Validating response body
  * match instrumentUpdateResponseBody.responseInfo.status == commonConstants.expectedStatus.serverError


@egf-instrument_update_InstrumentType_12 @positive @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with instrument type
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def name = egfInstrumentConstants.parameters.instrumentTypeNameOnline
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateInstrumentsSuccessfully')
  # Validating response body
  * match instrumentUpdateResponseBody.instruments[0].instrumentType.name == name
  * match instrumentUpdateResponseBody.instruments[0].transactionNumber == transactionNumber


@egf-instrument_update_InvalidInstrumentType_13 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with invalid instrument type
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def name = commonConstants.invalidParameters.invalidValue
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateInstruments')
  # Validating response body
  * match instrumentUpdateResponseBody.error.message == 'instrumentType'
  * match instrumentUpdateResponseBody.error.description == null


@egf-instrument_update_InvalidTenantId_14 @negative @instrumentUpdate @egfInstrument_Instruments @egfInstrument @regression
Scenario: Update instrument with invalid tenantId
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def tenantId = commonConstants.invalidParameters.invalidValue
  # Updating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@unauthorizedaccessError_Update')
  # Validating response body
  * match instrumentUpdateResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

#Search TCs

@egf-instrument_search_TransactionNumber_01 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Transaction Number
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def transactionNumber = instrumentCreateResponseBody.instruments[0].transactionNumber
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchTransactionNumberSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[0].transactionNumber == transactionNumber

@egf-instrument_search_InvalidTransactionNumber_02 @negative @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Invalid Transaction Number
  * def transactionNumber = commonConstants.invalidParameters.invalidValue
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchTransactionNumberSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments == []
  * assert instrumentSearchResponseBody.instruments.length == 0

@egf-instrument_search_AllDebitTransactionType_03 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Debit Transaction type
  * def transactionType = egfInstrumentConstants.parameters.debitTransactionType
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchTransactionTypeSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].transactionType contains transactionType

@egf-instrument_search_AllCreditTransactionType_04 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Credit Transaction type
 
  * def transactionType = egfInstrumentConstants.parameters.creditTransactionType
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchTransactionTypeSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].transactionType contains transactionType

@egf-instrument_search_InvalidTransactionType_05 @negative @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with invalid Transaction type
 
  * def transactionType = commonConstants.invalidParameters.invalidValue
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInsearchTransactionTypeSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.responseInfo.status == commonConstants.expectedStatus.serverError

@egf-instrument_search_CashInstrumentType_06 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Cash instrument type
 
  * def instrumentType = egfInstrumentConstants.parameters.instrumentTypeNameCash
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypesSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentType

@egf-instrument_search_ChequeInstrumentType_07 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Cheque instrument type
  
  * def instrumentType = egfInstrumentConstants.parameters.instrumentTypeNameCheque
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypesSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentType

@egf-instrument_search_InstrumentId_08 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with instrumentId
  # Creating an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@createInstrumentsSuccessfully')
  * def id = instrumentCreateResponseBody.instruments[0].id
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentIdSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[0].id == id

@egf-instrument_search_InvalidInstrumentId_09 @negative @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Invalid instrumentId

  * def id = commonConstants.invalidParameters.invalidValue
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentIdSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments == []
  * assert instrumentSearchResponseBody.instruments.length == 0

@egf-instrument_search_AllInstruments_10 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search All instrument details

  * def instrumentTypeCheque = egfInstrumentConstants.parameters.instrumentTypeNameCheque
  * def instrumentTypeCash = egfInstrumentConstants.parameters.instrumentTypeNameCash
  * def instrumentTypeOnline = egfInstrumentConstants.parameters.instrumentTypeNameOnline
  * def transactionTypeCredit = egfInstrumentConstants.parameters.creditTransactionType
  * def transactionTypeDebit = egfInstrumentConstants.parameters.debitTransactionType
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchAllInstrumentsSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentTypeCheque
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentTypeCash
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentTypeOnline
  * match instrumentSearchResponseBody.instruments[*].transactionType contains transactionTypeCredit
  * match instrumentSearchResponseBody.instruments[*].transactionType contains transactionTypeDebit

@egf-instrument_search_OnlineInstrumentType_11 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with Online instrument type
 
  * def instrumentType = egfInstrumentConstants.parameters.instrumentTypeNameOnline
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypesSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentType

@egf-instrument_search_InvalidInstrumentType_12 @negative @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with invalid instrument type

  * def instrumentType = commonConstants.invalidParameters.invalidValue
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypesSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments == []
  * assert instrumentSearchResponseBody.instruments.length == 0

@egf-instrument_search_ValidInstrumentTypeAndTransactionType_13 @positive @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with valid instrument type and transaction type

  * def instrumentType = egfInstrumentConstants.parameters.instrumentTypeNameCash
  * def transactionType = egfInstrumentConstants.parameters.debitTransactionType
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchInstrumentTypesAndTransactionTypeSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.instruments[*].instrumentType.name contains instrumentType
  * match instrumentSearchResponseBody.instruments[*].transactionType contains transactionType

@egf-instrument_search_InvalidTenantId_14 @negative @instrumentSearch @egfInstrument_Instruments @egfInstrument @regression
Scenario: Search instrument details with invalid tenantId

  * def tenantId = commonConstants.invalidParameters.invalidValue
  # Searching an instruments
  * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInsearchAllInstrumentsSuccessfully')
  # Validating response body
  * match instrumentSearchResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError