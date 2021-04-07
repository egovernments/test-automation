Feature: BPA Calculator Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def bpaConstants = read('../../municipal-services/constants/bpaServices.yaml')
    * def index = randomNumber(mdmsStateBPA.CalculationType.length)
    * def feeType = mdmsStateBPA.CalculationType[index].feeType

@bpa_calculate_01 @positive @regression @bpaCalculator
Scenario: Verfiy caluclation of tax estimates for a bpa through API call
    # Create and Update BPA Application
    * call read('../../municipal-services/tests/bpaService.feature@bpa_update_01')
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPASuccessfully')
    * match bpaResponseBody.Calculations[0].feeType == feeType

@bpa_calculateNullAppNo_02 @negative @regression @bpaCalculator
Scenario: Verify by passing 'null' for the BPA application number and check for errors
    # Create and Update BPA Application
    * call read('../../municipal-services/tests/bpaService.feature@bpa_update_01')
    * def applicationNo = null
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPAError')
    * match bpaResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@bpa_caculate_InvalidEDCR_03 @negative @regression @bpaCalculator
Scenario: Verify by passing invalid EDCR number and check for errors
    # Create and Update BPA Application
    * call read('../../municipal-services/tests/bpaService.feature@bpa_update_01')
    * def invalidNumber = randomMobileNumGen(6)
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPA_EDCRError')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.calculateError

@bpa_caculate_InvalidTeant_04 @negative @regression @bpaCalculator
Scenario: Verify by passing 'invalid tenant id under calculation criteria and check for errors
    # Create and Update BPA Application
    * call read('../../municipal-services/tests/bpaService.feature@bpa_update_01')
    * def tenantId = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPA_EDCRError')
    * match bpaResponseBody.Errors[0].message == bpaConstants.errorMessages.tenantError
   