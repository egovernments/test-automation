Feature: WS Calculator Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../municipal-services/tests/waterConnection.feature@createActiveWaterConnection')
    * def wsCalculatorConstants = read('../../municipal-services/constants/wsCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def assessmentYear = "2019-20"
    * def meterStatus = "Working"
    * def currentReading = 200
    * def billingPeriod = getDate1(1) + " - " + getDate1(6)
    * def currentReadingDate = getCurrentEpochTime()
    * def lastReading = 100
    * def lastReadingDate = getPastEpochDate(7)
    * def adhocrebate = 50
    * def adhocpenalty = 100

@estimate_ValidPropertyID_01 @positive @regression @wsCalculatorEstimate @wsCalculator
Scenario: Estimate WS Calculator with valid payload
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successEstimateWsCalculator')
    * match wsCalculatorResponseBody.Calculation[0].totalAmount == "#present"
    * match wsCalculatorResponseBody.Calculation[0].charge == "#present"
    * match wsCalculatorResponseBody.Calculation[0].taxAmount == "#present"

@Calculate_01 @positive @regression @wsCalculatorCalculate @wsCalculator
Scenario: Calculate WS Calculator with valid payload
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successCalculateWsCalculator')
    * match wsCalculatorResponseBody.Calculation[0].totalAmount == "#present"
    * match wsCalculatorResponseBody.Calculation[0].charge == "#present"
    * match wsCalculatorResponseBody.Calculation[0].taxAmount == "#present"

@create_01 @positive @regression @wsMeterConnection @wsMeterConnectionCreate @wsCalculator
Scenario: Create Meter Connection with valid payload
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successCreateMeterConnection')
    * match wsCalculatorResponseBody.meterReadings[0].id == "#present"
    * match wsCalculatorResponseBody.meterReadings[0].billingPeriod == billingPeriod
    * match wsCalculatorResponseBody.meterReadings[0].meterStatus == meterStatus
    * match wsCalculatorResponseBody.meterReadings[0].connectionNo == connectionNo

@Search_ValidConnectionNumber_01 @positive @regression @wsMeterConnection @wsMeterConnectionSearch @wsCalculator
Scenario: Search Meter Connection successfully
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successCreateMeterConnection')
    * def searchMeterConnectionParams = {"tenantId": "#(tenantId)", "connectionNos": "#(connectionNo)"}
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successSearchMeterConnection')
    * print wsCalculatorResponseBody
    * match wsCalculatorResponseBody.meterReadings[0].id == "#present"
    * match wsCalculatorResponseBody.meterReadings[0].billingPeriod == billingPeriod
    * match wsCalculatorResponseBody.meterReadings[0].meterStatus == meterStatus
    * match wsCalculatorResponseBody.meterReadings[0].connectionNo == connectionNo

@ApplyAdhocTax_01 @positive @regression @wsApplyAdhocTax @wsCalculator
Scenario: Search Meter Connection successfully
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successCreateMeterConnection')
    * def searchDemandParams = {tenantId: '#(tenantId)',consumerCode: '#(connectionNo)'}
    * call read('../../business-services/pretest/billingServiceDemandPretest.feature@searchDemandGenericParam')
    * call read('../../municipal-services/pretests/wsCalculatorPretest.feature@successAddAdhocTax')
    * match wsCalculatorResponseBody.Calculation[0].taxHeadEstimates.size() == 2


