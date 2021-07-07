Feature: To test propertyTax-Estimate service endpoints

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * callonce read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * def financialYear = Assessment.financialYear
    * def source = Assessment.source
    * def channel = Assessment.channel
    * def invalidTenantId = 'pb.'+randomString(3)
    * def invalidFinancialYear = ranInteger(2)+'-'+ranInteger(2)
    * def invalidPropertyId = 'PB-'+randomString(10)
    * def propertyTaxEstimatePayload = read('../../municipal-services/requestPayload/property-calculator/propertyTax/estimate.json')

@property_estimate_01 @positive @propertyEstimate @regression @municipalServices @propertyCalculator
Scenario: Verify the property tax esimate thorugh API call for a given property id
    # Steps to Calculate Tax Estimate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxEstimate')
    # Determine estimate amount 
    * def estimateAmount = karate.jsonPath(propertyTaxEstimateResponse, '$.Calculation[*].taxHeadEstimates[*].estimateAmount')
    * def result = 0
    # Customized function to fetch sum of tax head estimate ammount
    * def fun = function(x){ var temp = karate.get('result'); karate.set('result', temp + x )}
    * karate.forEach(estimateAmount, fun)
    # Validate the values
    * match propertyTaxEstimateResponse.Calculation[0].taxHeadEstimates.size() != 0
    * match propertyTaxEstimateResponse.Calculation[0].taxAmount == '#present'
    * match result == propertyTaxEstimateResponse.Calculation[0].taxAmount

@property_estimate_invalidTenant_02 @negative @propertyEstimate @regression @municipalServices @propertyCalculator
Scenario: Verify the property tax esimate thorugh API call for a given property id for a invalid or non existant tenant id and check for errors
    # Set tenantId value as invalid
    * set propertyTaxEstimatePayload['Assessment'].tenantId = invalidTenantId
    # Steps to generate error message due to invalid tenant id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTaxEstimateUnAuthorized')
    # Validate the error message
    * match propertyTaxEstimateErrorResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@property_estimate_invalidFY_03 @negative @propertyEstimate @regression @municipalServices @propertyCalculator
Scenario: Verify the property tax esimate thorugh API call for a given property id for a invalid or non existant financial year and check for errors
    # Set financialYear value as invalid
    * set propertyTaxEstimatePayload['Assessment'].financialYear = invalidFinancialYear
    # Defining customized error
    * def financialYearError = 'No Financial Year data is available for the given year value of : '+invalidFinancialYear+''
    # Steps to generate error message due to invalid financial year
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTaxEstimate')
    # Steps to generate error message due to invalid tenant id
    * match propertyTaxEstimateErrorResponse.Errors[0].message == financialYearError

@property_estimate_invalidPID_04 @negative @propertyEstimate @regression @municipalServices @propertyCalculator
Scenario: Verify the property tax esimate thorugh API call for a given property id for a invalid or non existant property id and  check for errors
    # Set propertyId value as invalid
    * set propertyTaxEstimatePayload['Assessment'].propertyId = invalidPropertyId
    # Defining customized error
    * def propertyIdError = 'The propertyId: '+invalidPropertyId+' is not found in the system'
    # Steps to generate error message due to invalid property id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTaxEstimate')
    # Steps to generate error message due to invalid propertyId
    * match propertyTaxEstimateErrorResponse.Errors[0].message == propertyIdError

@property_estimate_NoFY_05 @negative @propertyEstimate @regression @municipalServices @propertyCalculator
Scenario: Verify the property tax esimate thorugh API call for a given property id by not passing financial year and check for errors
    # Remove financialYear from the request payload
    * remove propertyTaxEstimatePayload['Assessment'].financialYear
    # Steps to generate error message as financialYear field is missing
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTaxEstimate')
    # Steps to generate error message due to missing finincialYear
    * match propertyTaxEstimateErrorResponse.Errors[0].message == commonConstants.errorMessages.unhandledException