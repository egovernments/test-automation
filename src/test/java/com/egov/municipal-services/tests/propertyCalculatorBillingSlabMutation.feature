Feature: To test property-calculator-billingSlabs-mutation service endpoints

Background: 
    * def jsUtils = read('classpath:jsUtils.js')
    * def propertyCalculatorConstants = read('../../municipal-services/constants/propertyCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def propertyType = mdmsStatePropertyTax.PropertyType[0].code
    * def propertySubType = mdmsStatePropertyTax.PropertySubType[0].code
    * def usageCategoryMajor = mdmsStatePropertyTax.UsageCategoryMajor[0].code
    * def usageCategoryMinor = mdmsStatePropertyTax.UsageCategoryMinor[0].code
    * def usageCategorySubMinor = mdmsStatePropertyTax.UsageCategorySubMinor[0].code
    * def usageCategoryDetail = mdmsStatePropertyTax.UsageCategoryDetail[0].code
    * def ownerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code
    * def subOwnerShipCategory = mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def minMarketValue = ranInteger(1)+.0
    * def maxMarketValue = ranInteger(3)+.0
    * def fixedAmount = ranInteger(4)+.0
    * def rate = ranInteger(2)+.0
    * def type = "FLAT"
    # Updated values
    * def updatedPropertyType = mdmsStatePropertyTax.PropertyType[1].code
    * def updatedPropertySubType = mdmsStatePropertyTax.PropertySubType[1].code
    * def updatedUsageCategoryMajor = mdmsStatePropertyTax.UsageCategoryMajor[1].code
    * def updatedUsageCategoryMinor = mdmsStatePropertyTax.UsageCategoryMinor[1].code
    * def updatedUsageCategorySubMinor = mdmsStatePropertyTax.UsageCategorySubMinor[1].code
    * def updatedUsageCategoryDetail = mdmsStatePropertyTax.UsageCategoryDetail[1].code
    * def updatedOwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[1].code
    * def updatedSubOwnerShipCategory = mdmsStatePropertyTax.SubOwnerShipCategory[1].code
    * def updatedMinMarketValue = ranInteger(1)+.0
    * def updatedMaxMarketValue = ranInteger(3)+.0
    * def updatedFixedAmount = ranInteger(4)+.0
    * def updatedRate = ranInteger(2)+.0
    * def updatedType = "True"
    * def invalidIdToUpdate = generateUUID()

    * def invalidTenaniId = 'invalid'+randomString(3)
    * def invalidId = 'id_'+randomNumber(3)
    * def nullFixedAmountError =  propertyCalculatorConstants.errorMessage.nullFixedAmount
    * def nullRateError =  propertyCalculatorConstants.errorMessage.nullRate
    * def createBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/create.json')
    * def searchBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/search.json')
    * def updateBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/update.json')

@BillingSlabMutation_Create_01 @billingSlabMutationCreate @propertyCalculator
Scenario: Verify creating a mutation billing slab for property tax through API call
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * match mutationCreateResponse.ResponseInfo.status == commonConstants.expectedStatus.success
    * match mutationCreateResponse.MutationBillingSlab[0].propertyType == propertyType
    * match mutationCreateResponse.MutationBillingSlab[0].propertySubType == propertySubType
    * match mutationCreateResponse.MutationBillingSlab[0].usageCategoryMajor == usageCategoryMajor
    * match mutationCreateResponse.MutationBillingSlab[0].usageCategoryMinor == usageCategoryMinor
    * match mutationCreateResponse.MutationBillingSlab[0].usageCategorySubMinor == usageCategorySubMinor
    * match mutationCreateResponse.MutationBillingSlab[0].usageCategoryDetail == usageCategoryDetail
    * match mutationCreateResponse.MutationBillingSlab[0].ownerShipCategory == ownerShipCategory
    * match mutationCreateResponse.MutationBillingSlab[0].subOwnerShipCategory == subOwnerShipCategory
    * match mutationCreateResponse.MutationBillingSlab[0].minMarketValue == minMarketValue
    * match mutationCreateResponse.MutationBillingSlab[0].maxMarketValue == maxMarketValue
    * match mutationCreateResponse.MutationBillingSlab[0].fixedAmount == fixedAmount
    * match mutationCreateResponse.MutationBillingSlab[0].rate == rate
    * match mutationCreateResponse.MutationBillingSlab[0].type == type

@BillingSlabMutation_create_InValidTenant_02 @billingSlabMutationCreate @propertyCalculator
Scenario: Verify creating a mutation billing slab for property tax through API call by passing an invalid or non existant tenant id and check for error
    * set createBillingSlabMutationPayload.MutationBillingSlab[0].tenantId = invalidTenaniId
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCreateBillingSlabMutation')
    * match mutationCreateResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@BillingSlabMutation_Create_nullValues_03 @billingSlabMutationCreate @propertyCalculator
Scenario: Verify creating a mutation billing slab for property tax by passing null values in the request
    * set createBillingSlabMutationPayload.MutationBillingSlab[0].fixedAmount = null
    * set createBillingSlabMutationPayload.MutationBillingSlab[0].rate = null
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCreateBillingSlabMutation')
    * match mutationCreateResponse.Errors[*].code contains ['#(nullFixedAmountError)', '#(nullRateError)']

# Search Billing Slab mutation

@BillingSlabMutation_Search_01 @positive @billingSlabMutationSearch @propertyCalculator
Scenario: Verify Searching for billing slab mutation details through api call
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * def searchParams = {tenantId: '#(tenantId)', propertyType: '#(propertyType)', usageCategoryMajor:'#(usageCategoryMajor)', usageCategoryMinor: '#(usageCategoryMinor)', ownerShipCategory: '#(ownerShipCategory)', subOwnerShipCategory:'#(subOwnerShipCategory)', id: '#(id)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.ResponseInfo.status == commonConstants.expectedStatus.success
    * match mutationSearchResponse.MutationBillingSlab[0].propertyType == propertyType
    * match mutationSearchResponse.MutationBillingSlab[0].propertySubType == propertySubType
    * match mutationSearchResponse.MutationBillingSlab[0].usageCategoryMajor == usageCategoryMajor
    * match mutationSearchResponse.MutationBillingSlab[0].usageCategoryMinor == usageCategoryMinor
    * match mutationSearchResponse.MutationBillingSlab[0].usageCategorySubMinor == usageCategorySubMinor
    * match mutationSearchResponse.MutationBillingSlab[0].usageCategoryDetail == usageCategoryDetail
    * match mutationSearchResponse.MutationBillingSlab[0].ownerShipCategory == ownerShipCategory
    * match mutationSearchResponse.MutationBillingSlab[0].subOwnerShipCategory == subOwnerShipCategory
    * match mutationSearchResponse.MutationBillingSlab[0].minMarketValue == minMarketValue
    * match mutationSearchResponse.MutationBillingSlab[0].maxMarketValue == maxMarketValue
    * match mutationSearchResponse.MutationBillingSlab[0].fixedAmount == fixedAmount
    * match mutationSearchResponse.MutationBillingSlab[0].rate == rate
    * match mutationSearchResponse.MutationBillingSlab[0].type == type

@BillingSlabMutation_Search_AllRecords_02 @positive @billingSlabMutationSearch @propertyCalculator
Scenario: Verify Searching for billing slab details for a particular tenant id through api call 
    * def searchParams = {tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.MutationBillingSlab.size() != 0


@BillingSlabMutation_Search_NoTenant_03 @negative @billingSlabMutationSearch @propertyCalculator
Scenario: Verify Searching for mutation billing slab details by not passing tenant id and check for errors 
    * def searchParams = {}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInSearchBillingSlabMutation')
    * match mutationSearchResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.notNullTenantId

@BillingSlabMutation_Search_InValidTenant_04 @negative @billingSlabMutationSearch @propertyCalculator
Scenario: Verify searching mutation billing slab for a invalid or non existant tenant id and check for errors 
    * def searchParams = {tenantId: '#(invalidTenantId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInSearchBillingSlabMutation')
    * match mutationSearchResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError


@BillingSlabMutation_Search_EmptyResponse_05 @positive @billingSlabMutationSearch @propertyCalculator
Scenario: Verify searching mutation billing slab by passing null for billing slab id
    * def searchParams = {tenantId: '#(tenantId)', id: '#(invalidId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.MutationBillingSlab.size() == 0

@BillingSlabMutation_Search_Multiple_06 @positive @billingSlabMutationSearch @propertyCalculator
Scenario: Verify searching billing slab by passing multiple mutation billing slab ids
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * def firstId = id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * def secondId = id
    * def searchParams = {tenantId: '#(tenantId)', id: ['#(firstId)', '#(secondId)']}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.MutationBillingSlab.size() == 2
    * match mutationSearchResponse.MutationBillingSlab[*].id contains ['#(firstId)', '#(secondId)']

# Update Billing slabs mutation

@BillingSlabMutation_Update_01 @positive @billingSlabMutationUpdate @propertyCalculator
Scenario: Verify creating a mutation billing slab for property tax through API call
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].id = id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@updateBillingSlabMutation')
    * print mutationUpdateResponse
    * match mutationUpdateResponse.MutationBillingSlab[0].id == id
    * match mutationUpdateResponse.MutationBillingSlab[0].propertyType == updatedPropertyType
    * match mutationUpdateResponse.MutationBillingSlab[0].propertySubType == updatedPropertySubType
    * match mutationUpdateResponse.MutationBillingSlab[0].usageCategoryMajor == updatedUsageCategoryMajor
    * match mutationUpdateResponse.MutationBillingSlab[0].usageCategoryMinor == updatedUsageCategoryMinor
    * match mutationUpdateResponse.MutationBillingSlab[0].usageCategorySubMinor == updatedUsageCategorySubMinor
    * match mutationUpdateResponse.MutationBillingSlab[0].usageCategoryDetail == updatedUsageCategoryDetail
    * match mutationUpdateResponse.MutationBillingSlab[0].ownerShipCategory == updatedOwnerShipCategory
    * match mutationUpdateResponse.MutationBillingSlab[0].subOwnerShipCategory == updatedSubOwnerShipCategory
    * match mutationUpdateResponse.MutationBillingSlab[0].minMarketValue == updatedMinMarketValue
    * match mutationUpdateResponse.MutationBillingSlab[0].maxMarketValue == updatedMaxMarketValue
    * match mutationUpdateResponse.MutationBillingSlab[0].fixedAmount == updatedFixedAmount
    * match mutationUpdateResponse.MutationBillingSlab[0].rate == updatedRate

@BillingSlabMutation_update_InValidTenant_02 @negative @billingSlabMutationUpdate @propertyCalculator
Scenario: Verify updating a mutation billing slab for property tax through API call by passing an invalid or non existant tenant id and check for error
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].tenantId = invalidTenaniId
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].id = id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlabMutation')
    * match mutationUpdateResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@BillingSlabMutation_update_InValidId_03 @negative @billingSlabMutationUpdate @propertyCalculator
Scenario: Verify updating a mutation billing slab for property tax through API call by passing an invalid or non existant id and check for error
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].id = invalidIdToUpdate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlabMutation')
    * def errorForInvalidId = 'Following records are unavailable, IDs: ['+invalidIdToUpdate+']'
    * match mutationUpdateResponse.Errors[0].message == errorForInvalidId
    * match mutationUpdateResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.invalidIdCode

@BillingSlabMutation_update_nullValues_04 @negative @billingSlabMutationUpdate @propertyCalculator
Scenario: Verify updating a mutation billing slab for property tax by passing null values in the request
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].id = mutationCreateResponse.MutationBillingSlab[0].id
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].fixedAmount = null
    * set updateBillingSlabMutationPayload.MutationBillingSlab[0].rate = null
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlabMutation')
    * match mutationUpdateResponse.Errors[*].code contains ['#(propertyCalculatorConstants.errorMessage.nullFixedAmount)', '#(propertyCalculatorConstants.errorMessage.nullRate)']