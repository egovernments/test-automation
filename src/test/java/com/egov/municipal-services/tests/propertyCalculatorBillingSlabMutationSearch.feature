Feature: To test property-calculator-billingSlabs-mutation service 'Search' endpoint

Background: 
    * def jsUtils = read('classpath:jsUtils.js')
    * def propertyCalculatorConstants = read('../../municipal-services/constants/propertyCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def createBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/create.json')
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
    * def createBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/create.json')
    * callonce read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * def searchBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/search.json')
    * def invalidTenantId = 'pb.'+randomString(3)
    * def invalidId = 'id_'+randomNumber(3)

@BillingSlabMutation_Search_01 @positive @billingSlabMutationSearch
Scenario: Verify Searching for billing slab mutation details through api call
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

@BillingSlabMutation_Search_AllRecords_02 @positive @billingSlabMutationSearch
Scenario: Verify Searching for billing slab details for a particular tenant id through api call 
    * def searchParams = {tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.MutationBillingSlab.size() != 0


@BillingSlabMutation_Search_NoTenant_03 @negative @billingSlabMutationSearch
Scenario: Verify Searching for mutation billing slab details by not passing tenant id and check for errors 
    * def searchParams = {}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInSearchBillingSlabMutation')
    * match mutationSearchResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.notNullTenantId

@BillingSlabMutation_Search_InValidTenant_04 @negative @billingSlabMutationSearch
Scenario: Verify searching mutation billing slab for a invalid or non existant tenant id and check for errors 
    * def searchParams = {tenantId: '#(invalidTenantId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInSearchBillingSlabMutation')
    * match mutationSearchResponse.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError


@BillingSlabMutation_Search_EmptyResponse_05 @positive @billingSlabMutationSearch
Scenario: Verify searching mutation billing slab by passing null for billing slab id
    * def searchParams = {tenantId: '#(tenantId)', id: '#(invalidId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.MutationBillingSlab.size() == 0

@BillingSlabMutation_Search_Multiple_06 @positive @billingSlabMutationSearch
Scenario: Verify searching billing slab by passing multiple mutation billing slab ids
    * def firstId = id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlabMutation')
    * def secondId = id
    * def searchParams = {tenantId: '#(tenantId)', id: ['#(firstId)', '#(secondId)']}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    * match mutationSearchResponse.MutationBillingSlab.size() == 2
    * match mutationSearchResponse.MutationBillingSlab[*].id contains ['#(firstId)', '#(secondId)']
    