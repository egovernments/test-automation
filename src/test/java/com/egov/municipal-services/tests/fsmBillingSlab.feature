Feature: FSM BILLING SLAB FEATURE

Background:    
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * def fsmBillingSlabConstants = read('../../municipal-services/constants/fsmBillingSlab.yaml')
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * def propertyType = mdmsStateFsmService.PropertyType[0].code
    * def slum = fsmBillingSlabConstants.Slum.itisslum
    * def price = randomNumber(3)
    * def status = fsmBillingSlabConstants.status.active
    * def feeType = fsmBillingSlabConstants.feeType.applicationFee
@fsm_billing_slab_create_1 @positive  @fsmBillingSlab
Scenario: Verify creating a FSM Billing Slab
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * match fsmBillingSlabResponseBody.billingSlab[0].status == status
    * match fsmBillingSlabResponseBody.billingSlab[0].propertyType == propertyType
    * match fsmBillingSlabResponseBody.billingSlab[0].tenantId == tenantId
    * match fsmBillingSlabResponseBody.billingSlab[0].capacityTo == capacityTo
    * match fsmBillingSlabResponseBody.billingSlab[0].capacityFrom == capacityFrom

@fsm_billing_slab_create_2 @positive  @fsmBillingSlab
Scenario: Verify creating a FSM Billing Slab keeping Slum as Null
    * def slum = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidBillingSlab
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.nullSlum

@fsm_billing_slab_create_3 @positive  @fsmBillingSlab
Scenario: Verify creating a FSM Billing Slab with invalid price
    * def price = randomString(3)
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidPrice
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.invalidPrice

@fsm_billing_slab_create_4 @positive  @fsmBillingSlab
Scenario: Verify creating a FSM Billing Slab with duplicate billing slab
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidBillingSlab
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.dublicateBillingSlab

@fsm_billing_slab_create_5 @positive @regression @fsmBillingSlab
Scenario: Verify creating a FSM Billing Slab keeping Property Type as Null
    * def propertyType = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidBillingSlab
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.nullPropertyType

@fsm_billing_slab_create_6 @positive @regression @fsmBillingSlab
Scenario: Verify creating a FSM Billing Slab with invalid Property Type
    * def propertyType = randomString(10)
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidPropertyType
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.invalidPropertyType

@fsm_billing_slab_search_1 @positive @regression @fsmBillingSlab
Scenario: Verify searching a FSM Billing Slab
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * def searchFSMBillingSlabParams = {"tenantId": '#(tenantId)',"propertyType": '#(propertyType)',"capacity": "#(capacityFrom)"}
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@searchFSMBillingSlabSuccessfully')
    * match fsmBillingSlabResponseBody.billingSlab[0].status == status
    * match fsmBillingSlabResponseBody.billingSlab[0].propertyType == propertyType
    * match fsmBillingSlabResponseBody.billingSlab[0].tenantId == tenantId
    * match fsmBillingSlabResponseBody.billingSlab[0].capacityTo == capacityTo
    * match fsmBillingSlabResponseBody.billingSlab[0].capacityFrom == capacityFrom

@fsm_billing_slab_search_2 @negative @regression @fsmBillingSlab
Scenario: Verify searching a FSM Billing Slab with invalid property type
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * def propertyType = randomString(10)
    * def searchFSMBillingSlabParams = {"tenantId": '#(tenantId)',"propertyType": '#(propertyType)',"capacity": "#(capacityFrom)"}
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@searchFSMBillingSlabSuccessfully')
    * match fsmBillingSlabResponseBody.billingSlab == '#[0]'

@fsm_billing_slab_search_3 @negative @regression @fsmBillingSlab
Scenario: Verify searching a FSM Billing Slab with no tenant Id
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * def searchFSMBillingSlabParams = {"propertyType": '#(propertyType)',"capacity": "#(capacityFrom)"}
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@searchFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.searchNoTenantId
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.searchNoTenantId

@fsm_billing_slab_search_4 @negative @regression @fsmBillingSlab
Scenario: Verify searching a FSM Billing Slab with invalid Slum
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * def slum = randomString(10)
    * def searchFSMBillingSlabParams = {"tenantId": '#(tenantId)',"propertyType": '#(propertyType)',"capacity": "#(capacityFrom)", "slum": "#(slum)"}
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@searchFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.searchInvalidSlum
    * match fsmBillingSlabResponseBody.Errors[0].message == replaceString(fsmBillingSlabConstants.Errors.errorMessages.searchInvalidSlum,"<<replace_string>>",slum)
@fsm_billing_slab_search_5 @negative @regression @fsmBillingSlab
Scenario: Verify searching a FSM Billing Slab with no tenant Id
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * def tenantId = randomString(10)
    * def searchFSMBillingSlabParams = {"tenantId": '#(tenantId)',"propertyType": '#(propertyType)',"capacity": "#(capacityFrom)"}
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@searchFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.searchInvalidTenantId
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.searchInvalidTenantId



@fsm_billing_slab_update_1 @positive @regression @fsmBillingSlab
Scenario: Verify updating a FSM Billing Slab
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * set fsmBillingSlab.capacityFrom = randomNumber(1000000000)
    * set fsmBillingSlab.capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@updateFSMBillingSlabSuccessfully')
    * match fsmBillingSlabResponseBody.billingSlab[0].status == status
    * match fsmBillingSlabResponseBody.billingSlab[0].propertyType == propertyType
    * match fsmBillingSlabResponseBody.billingSlab[0].tenantId == tenantId


@fsm_billing_slab_update_2 @negativec @regression @fsmBillingSlab
Scenario: Verify updating a FSM Billing Slab with invalid Id
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * set fsmBillingSlab.id = generateUUID()
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@updateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.updateInvalidId
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.updateInvalidId

@fsm_billing_slab_update_3 @negativec @regression @fsmBillingSlab
Scenario: Verify updating a FSM Billing Slab with null tenant Id
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * set fsmBillingSlab.tenantId = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@updateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.updateNullTenantId
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.updateNullTenantId

@fsm_billing_slab_update_4 @negativec @regression @fsmBillingSlab
Scenario: Verify updating a FSM Billing Slab with null capacityfrom
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * set fsmBillingSlab.capacityFrom = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@updateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.updateNullCapacityFrom
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.updateNullCapacityFrom

@fsm_billing_slab_update_5 @negativec @regression @fsmBillingSlab
Scenario: Verify updating a FSM Billing Slab with null slum
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * set fsmBillingSlab.slum = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@updateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidBillingSlab
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.nullSlum
@fsm_billing_slab_update_6 @negativec @regression @fsmBillingSlab
Scenario: Verify updating a FSM Billing Slab with null slum
    * def capacityFrom = randomNumber(1000000000)
    * def capacityTo = capacityFrom + 1
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@createFSMBillingSlabSuccessfully')
    * set fsmBillingSlab.propertyType = randomString(10)
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@updateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.invalidPropertyType
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.invalidPropertyType

#Calculate
@fsm_billing_slab_calculate_1 @positive @regression @fsmBillingSlab
Scenario: Verify calculating a FSM Billing Slab
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * set fsmBody.applicationNo = applicationNo
    * def tenantId = tenantId
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@calculateFSMBillingSlabSuccessfully')
    * match fsmBillingSlabResponseBody.Calculations[0].fsm.applicationStatus == "#present"
    * match fsmBillingSlabResponseBody.Calculations[0].fsm.applicationNo == applicationNo
    * match fsmBillingSlabResponseBody.Calculations[0].fsm.tenantId == tenantId

@fsm_billing_slab_calculate_2 @negative @regression @fsmBillingSlab
Scenario: Verify calculating a FSM Billing Slab With No Fee Type
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * set fsmBody.applicationNo = applicationNo
    * def tenantId = tenantId
    * def feeType = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@calculateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.calculateInvalidFeeType
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.calculateInvalidFeeType

@fsm_billing_slab_calculate_3 @negative @regression @fsmBillingSlab
Scenario: Verify calculating a FSM Billing Slab With No Tenant Type
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * set fsmBody.applicationNo = applicationNo
    * def tenantId = null
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.calculateInvalidTenantId
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.calculateInvalidTenantId
 
@fsm_billing_slab_estimate_1 @positive @regression @fsmBillingSlab
Scenario: Verify calculating a FSM Billing Slab
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * set fsmBody.applicationNo = applicationNo
    * def tenantId = tenantId
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@estimateFSMBillingSlabSuccessfully')
    * match fsmBillingSlabResponseBody.Calculations[0].fsm.applicationStatus == "#present"
    * match fsmBillingSlabResponseBody.Calculations[0].fsm.applicationNo == applicationNo
    * match fsmBillingSlabResponseBody.Calculations[0].fsm.tenantId == tenantId

@fsm_billing_slab_estimate_2 @negative @regression @fsmBillingSlab
Scenario: Verify calculating a FSM Billing Slab With No Fee Type
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * set fsmBody.applicationNo = applicationNo
    * def tenantId = tenantId
    * def feeType = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@estimateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.calculateInvalidFeeType
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.calculateInvalidFeeType

@fsm_billing_slab_estimate_3 @negative @regression @fsmBillingSlab
Scenario: Verify calculating a FSM Billing Slab With No Tenant Type
    * call read('../../municipal-services/tests/fsmService.feature@fsm_create_01')
    * set fsmBody.applicationNo = applicationNo
    * def tenantId = null
    * call read('../../municipal-services/pretests/fsmBillingSlabPretest.feature@estimateFSMBillingSlabUnSuccessfully')
    * match fsmBillingSlabResponseBody.Errors[0].code == fsmBillingSlabConstants.Errors.errorCodes.calculateInvalidTenantId
    * match fsmBillingSlabResponseBody.Errors[0].message == fsmBillingSlabConstants.Errors.errorMessages.calculateInvalidTenantId