Feature: To test property-calculator-billingSlabs service endpoints

Background: 
    * def jsUtils = read('classpath:jsUtils.js')
    * def propertyCalculatorConstants = read('../../municipal-services/constants/propertyCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def propertyType = mdmsStatePropertyTax.PropertyType[1].code
    * def propertySubType = mdmsStatePropertyTax.PropertySubType[0].code
    * def usageCategoryMajor = mdmsStatePropertyTax.UsageCategoryMajor[1].code
    * def usageCategoryMinor = mdmsStatePropertyTax.UsageCategoryMinor[0].code
    * def usageCategorySubMinor = mdmsStatePropertyTax.UsageCategorySubMinor[0].code
    * def usageCategoryDetail = mdmsStatePropertyTax.UsageCategoryDetail[0].code
    * def ownerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code
    * def subOwnerShipCategory = mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def occupancyType = mdmsStatePropertyTax.OccupancyType[0].code
    * def isPropertyMultiFloored = true
    * def fromFloor = ranInteger(1)
    * def toFloor = ranInteger(1)
    * def areaType = 'AREA3'
    * def fromPlotSize = ranInteger(1)
    * def toPlotSize = ranInteger(3)
    * def unBuiltUnitRate = null
    * def arvPercent = null
    * def unitRate = 0
    * def billingSlabCreatePayload = read('../../municipal-services/requestPayload/property-calculator/billingSlab/create.json')
    * def searchBillingSlabPayload = read('../../municipal-services/requestPayload/property-calculator/billingSlab/search.json')
    * def errorAreaType = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[0]
    * def errorToFloor = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[1]
    * def errorFromPlotSize = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[2]
    * def errorUsageCategoryMinor = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[3]
    * def errorFromFloor = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[4]
    * def errorUsageCategoryDetail = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[5]
    * def errorToPlotSize = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[6]
    * def errorSubOwnerShipCategory = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[7]
    * def errorPropertyType = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[8]
    * def errorUsageCategorySubMinor = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[9]
    * def errorIsPropertyMultiFloored = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[10]
    * def errorOwnerShipCategory = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[11]
    * def errorUsageCategoryMajor = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[12]
    * def errorPropertySubType = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[13]
    * def errorOccupancyType = propertyCalculatorConstants.errorMessage.nullBillingSlabPropertiesCodes[14]
    * def invalidTenantId = 'pb.'+randomString(3)
    * def updatedFromFloor = ranInteger(2)
    * def updatedToFloor = ranInteger(2)
    * def updatedAreaType = 'AREA3'
    * def updatedFromPlotSize = ranInteger(2)
    * def updatedToPlotSize = ranInteger(3)
    * def updatedUnBuiltUnitRate = ranInteger(2)
    * def updatedArvPercent = ranInteger(2)
    * def updatedUnitRate = ranInteger(2)
    * def updateBillingSlabPayload = read('../../municipal-services/requestPayload/property-calculator/billingSlab/update.json')
@BillingSlab_Create_01 @billingSlabCreate @regression @municipalService @propertyCalculator
Scenario: Verify creating a billing slab for property tax through API call
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * match billingSlabCreateResponse.billingSlab[0].usageCategoryMinor == usageCategoryMinor
    * match billingSlabCreateResponse.billingSlab[0].fromPlotSize == fromPlotSize
    * match billingSlabCreateResponse.billingSlab[0].usageCategorySubMinor == usageCategorySubMinor
    * match billingSlabCreateResponse.billingSlab[0].propertySubType == propertySubType
    * match billingSlabCreateResponse.billingSlab[0].ownerShipCategory == ownerShipCategory
    * match billingSlabCreateResponse.billingSlab[0].fromFloor == fromFloor
    * match billingSlabCreateResponse.billingSlab[0].unitRate == unitRate
    * match billingSlabCreateResponse.billingSlab[0].usageCategoryMajor == usageCategoryMajor
    * match billingSlabCreateResponse.billingSlab[0].isPropertyMultiFloored == isPropertyMultiFloored
    * match billingSlabCreateResponse.billingSlab[0].occupancyType == occupancyType
    * match billingSlabCreateResponse.billingSlab[0].unBuiltUnitRate == unBuiltUnitRate
    * match billingSlabCreateResponse.billingSlab[0].propertyType == propertyType
    * match billingSlabCreateResponse.billingSlab[0].areaType == areaType
    * match billingSlabCreateResponse.billingSlab[0].tenantId == tenantId
    * match billingSlabCreateResponse.billingSlab[0].toFloor == toFloor
    * match billingSlabCreateResponse.billingSlab[0].arvPercent == arvPercent
    * match billingSlabCreateResponse.billingSlab[0].toPlotSize == toPlotSize
    * match billingSlabCreateResponse.billingSlab[0].subOwnerShipCategory == subOwnerShipCategory
    * match billingSlabCreateResponse.billingSlab[0].usageCategoryDetail == usageCategoryDetail


 @BillingSlab_Create_InValidTenant_02 @billingSlabCreate @regression @municipalService @propertyCalculator
 Scenario: Verify creating a billing slab for property tax through API call by passing an invalid or non existant tenant id and check for error
   * set billingSlabCreatePayload.BillingSlab[0].tenantId = 'pb.'+randomString(3)
   * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCreateBillingSlab')
   * match errorResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@BillingSlab_Create_Dup_03 @billingSlabCreate @regression @municipalService @propertyCalculator
Scenario: Verify creating a billing slab for property tax through API call
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCreateBillingSlab') 
    * match errorResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.duplicateBillinfSlabCode
    * match errorResponse.Errors[0].message == propertyCalculatorConstants.errorMessage.duplicateBillinfSlabMessage

@BillingSlab_Create_nullValues_04 @billingSlabCreate @regression @municipalService @propertyCalculator
Scenario: Verify creating a billing slab for property tax by passing null values in the request
    * set billingSlabCreatePayload.BillingSlab[0].usageCategoryMinor = null
    * set billingSlabCreatePayload.BillingSlab[0].fromPlotSize = null
    * set billingSlabCreatePayload.BillingSlab[0].usageCategorySubMinor = null
    * set billingSlabCreatePayload.BillingSlab[0].propertySubType = null
    * set billingSlabCreatePayload.BillingSlab[0].ownerShipCategory = null
    * set billingSlabCreatePayload.BillingSlab[0].fromFloor = null
    * set billingSlabCreatePayload.BillingSlab[0].unitRate = 0
    * set billingSlabCreatePayload.BillingSlab[0].usageCategoryMajor = null
    * set billingSlabCreatePayload.BillingSlab[0].isPropertyMultiFloored = null
    * set billingSlabCreatePayload.BillingSlab[0].occupancyType = null
    * set billingSlabCreatePayload.BillingSlab[0].unBuiltUnitRate = null
    * set billingSlabCreatePayload.BillingSlab[0].propertyType = null
    * set billingSlabCreatePayload.BillingSlab[0].areaType = null
    * set billingSlabCreatePayload.BillingSlab[0].tenantId = null
    * set billingSlabCreatePayload.BillingSlab[0].toFloor = null
    * set billingSlabCreatePayload.BillingSlab[0].arvPercent = null
    * set billingSlabCreatePayload.BillingSlab[0].toPlotSize = null
    * set billingSlabCreatePayload.BillingSlab[0].subOwnerShipCategory = null
    * set billingSlabCreatePayload.BillingSlab[0].usageCategoryDetail = null
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCreateBillingSlab')
    * match errorResponse.Errors[*].code contains ['#(errorAreaType)','#(errorToFloor)','#(errorFromPlotSize)','#(errorUsageCategoryMinor)','#(errorFromFloor)','#(errorUsageCategoryDetail)','#(errorToPlotSize)','#(errorSubOwnerShipCategory)','#(errorPropertyType)','#(errorUsageCategorySubMinor)','#(errorPropertySubType)','#(errorIsPropertyMultiFloored)','#(errorOwnerShipCategory)','#(errorUsageCategoryMajor)']

@Billing_slab_create_invalidValues_05 @billingSlabCreate @regression @municipalService @propertyCalculator
Scenario: Verify creating a billing slab for property tax by passing null values in the request
    * set billingSlabCreatePayload.BillingSlab[0].ownerShipCategory = 'ownerShip'+randomString(3)
    * set billingSlabCreatePayload.BillingSlab[0].usageCategoryMajor = 'usageMajor'+randomString(3)
    * set billingSlabCreatePayload.BillingSlab[0].propertyType = 'propertyType'+randomString(3)
    * set billingSlabCreatePayload.BillingSlab[0].subOwnerShipCategory = 'subOwner'+randomString(3)
    * set billingSlabCreatePayload.BillingSlab[0].occupancyType = 'usageDetails'+randomString(3)
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCreateBillingSlab')
    * match errorResponse.Errors[*].code contains ['#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[0])','#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[1])','#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[2])','#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[3])']
    * match errorResponse.Errors[*].message contains ['#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[0])','#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[1])','#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[2])','#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[3])']

# Search Billing Slab tests

@BillingSlab_Search_01 @billingSlabSearch @regression @municipalService @propertyCalculator
Scenario: Verify Searching for billing slab details through api call for a given billing slab id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * def searchParams = {tenantId: '#(tenantId)', id: '#(id)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlab')
    * match billingSlabSearchResponse.billingSlab[0].usageCategoryMinor == usageCategoryMinor
    * match billingSlabSearchResponse.billingSlab[0].usageCategorySubMinor == usageCategorySubMinor
    * match billingSlabSearchResponse.billingSlab[0].propertySubType == propertySubType
    * match billingSlabSearchResponse.billingSlab[0].ownerShipCategory == ownerShipCategory
    * match billingSlabSearchResponse.billingSlab[0].usageCategoryMajor == usageCategoryMajor
    * match billingSlabSearchResponse.billingSlab[0].isPropertyMultiFloored == isPropertyMultiFloored
    * match billingSlabSearchResponse.billingSlab[0].occupancyType == occupancyType
    * match billingSlabSearchResponse.billingSlab[0].propertyType == propertyType
    * match billingSlabSearchResponse.billingSlab[0].areaType == areaType
    * match billingSlabSearchResponse.billingSlab[0].subOwnerShipCategory == subOwnerShipCategory
    * match billingSlabSearchResponse.billingSlab[0].usageCategoryDetail == usageCategoryDetail   

@BillingSlab_Search_AllRecords_02 @billingSlabSearch @regression @municipalService @propertyCalculator
Scenario: Verify Searching for billing slab details for a particular tenant id through api call 
    * def searchParams = {tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlab')
    * match billingSlabSearchResponse.billingSlab[*].tenantId contains ['#(tenantId)']

@BillingSlab_Search_NoTenant_03 @billingSlabSearch @regression @municipalService @propertyCalculator
Scenario: Verify Searching for billing slab details by not passing tenant id and check for errors
    * def searchParams = {}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInSearchBillingSlab')
    * match billingSlabSearchResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.notNullTenantIdBillingSlab

@BillingSlab_Search_InValidTenant_04 @billingSlabSearch @regression @municipalService @propertyCalculator
Scenario: Verify searching billing slab for a invalid or non existant tenant id and check for errors
    * def searchParams = {tenantId: '#(invalidTenantId)'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInSearchBillingSlab')
    * match billingSlabSearchResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@BillingSlab_Search_EmptyResponse_05 @billingSlabSearch @regression @municipalService @propertyCalculator
Scenario: Verify searching billing slab by passing null for billing slab id
    * def searchParams = {tenantId: '#(tenantId)', id: 'null'}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlab')
    * match billingSlabSearchResponse.billingSlab.size() == 0

@BillingSlab_Search_Multiple_06 @billingSlabSearch @regression @municipalService @propertyCalculator
Scenario: Verify searching billing slab by passing multiple billing slab ids
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * def firstId = id
    * set billingSlabCreatePayload.BillingSlab[0].unitRate = ranInteger(1)+'.0'
    * set billingSlabCreatePayload.BillingSlab[0].fromFloor = ranInteger(1)+'.0'
    * set billingSlabCreatePayload.BillingSlab[0].toFloor = ranInteger(1)+'.0'
    * set billingSlabCreatePayload.BillingSlab[0].fromPlotSize = ranInteger(1)+'.0'
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * def secondId = id
    * def searchParams = {tenantId: '#(tenantId)', id: ['#(firstId)', '#(secondId)']}
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlab')
    * match billingSlabSearchResponse.billingSlab.size() == 2
    * match billingSlabSearchResponse.billingSlab[*].id contains ['#(firstId)', '#(secondId)']

# Update Billing Slab

@BillingSlab_update_01 @billingSlabUpdate @regression @municipalService @propertyCalculator
Scenario: Verify updating a billing slab for property tax through API call
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * set updateBillingSlabPayload.BillingSlab[0].id = id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@updateBillingSlab')
    * print billingSlabUpdateResponse
    * match billingSlabUpdateResponse.billingSlab[0].tenantId == tenantId
    * match billingSlabUpdateResponse.billingSlab[0].fromPlotSize == updatedFromPlotSize
    * match billingSlabUpdateResponse.billingSlab[0].fromFloor == updatedFromFloor
    * match billingSlabUpdateResponse.billingSlab[0].unitRate == updatedUnitRate
    * match billingSlabUpdateResponse.billingSlab[0].unBuiltUnitRate == updatedUnBuiltUnitRate
    * match billingSlabUpdateResponse.billingSlab[0].toFloor == updatedToFloor
    * match billingSlabUpdateResponse.billingSlab[0].arvPercent == updatedArvPercent
    * match billingSlabUpdateResponse.billingSlab[0].toPlotSize == updatedToPlotSize

@BillingSlab_update_InValidTenant_02 @billingSlabUpdate @regression @municipalService @propertyCalculator
Scenario: Verify updating a billing slab for property tax through API call by passing an invalid or non existant tenant id and check for error
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * set updateBillingSlabPayload.BillingSlab[0].id = id
    * set updateBillingSlabPayload.BillingSlab[0].tenantId = 'pb.'+randomString(3)
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlab')
    * match billingSlabUpdateResponse.Errors[0].message == commonConstants.errorMessages.authorizedError

@BillingSlab_update_InvalidId_03 @billingSlabUpdate @regression @municipalService @propertyCalculator
Scenario: Verify updating a billing slab for property tax through API call by passing an invalid or non existant id and check for error
    * def invalidId = generateUUID()
    * set updateBillingSlabPayload.BillingSlab[0].id = invalidId
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlab')
    * print billingSlabUpdateResponse
    * def errorForInvalidId = 'Following records are unavailable, IDs: ['+invalidId+']'
    * match billingSlabUpdateResponse.Errors[0].message == errorForInvalidId
    * match billingSlabUpdateResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.invalidIdCode

@BillingSlab_update_nullValues_04 @billingSlabUpdate @regression @municipalService @propertyCalculator
Scenario: Verify updating a billing slab for property tax by passing null values in the request
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * set updateBillingSlabPayload.BillingSlab[0].id = id
    * set updateBillingSlabPayload.BillingSlab[0].usageCategoryMinor = null
    * set updateBillingSlabPayload.BillingSlab[0].fromPlotSize = null
    * set updateBillingSlabPayload.BillingSlab[0].usageCategorySubMinor = null
    * set updateBillingSlabPayload.BillingSlab[0].propertySubType = null
    * set updateBillingSlabPayload.BillingSlab[0].ownerShipCategory = null
    * set updateBillingSlabPayload.BillingSlab[0].fromFloor = null
    * set updateBillingSlabPayload.BillingSlab[0].unitRate = 0
    * set updateBillingSlabPayload.BillingSlab[0].usageCategoryMajor = null
    * set updateBillingSlabPayload.BillingSlab[0].isPropertyMultiFloored = null
    * set updateBillingSlabPayload.BillingSlab[0].occupancyType = null
    * set updateBillingSlabPayload.BillingSlab[0].unBuiltUnitRate = null
    * set updateBillingSlabPayload.BillingSlab[0].propertyType = null
    * set updateBillingSlabPayload.BillingSlab[0].areaType = null
    * set updateBillingSlabPayload.BillingSlab[0].toFloor = null
    * set updateBillingSlabPayload.BillingSlab[0].arvPercent = null
    * set updateBillingSlabPayload.BillingSlab[0].toPlotSize = null
    * set updateBillingSlabPayload.BillingSlab[0].subOwnerShipCategory = null
    * set updateBillingSlabPayload.BillingSlab[0].usageCategoryDetail = null
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlab')
    * print billingSlabUpdateResponse
    * match billingSlabUpdateResponse.Errors[*].code contains ['#(errorAreaType)','#(errorToFloor)','#(errorFromPlotSize)','#(errorUsageCategoryMinor)','#(errorFromFloor)','#(errorUsageCategoryDetail)','#(errorToPlotSize)','#(errorSubOwnerShipCategory)','#(errorPropertyType)','#(errorUsageCategorySubMinor)','#(errorPropertySubType)','#(errorIsPropertyMultiFloored)','#(errorOwnerShipCategory)','#(errorUsageCategoryMajor)']

@Billing_slab_update_invalidValues_05 @billingSlabUpdate @regression @municipalService @propertyCalculator
Scenario: Verify updating a billing slab for property tax by passing null values in the request
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@createBillingSlab')
    * set updateBillingSlabPayload.BillingSlab[0].id = id
    * set updateBillingSlabPayload.BillingSlab[0].ownerShipCategory = 'ownerShip'+randomString(3)
    * set updateBillingSlabPayload.BillingSlab[0].usageCategoryMajor = 'usageMajor'+randomString(3)
    * set updateBillingSlabPayload.BillingSlab[0].propertyType = 'propertyType'+randomString(3)
    * set updateBillingSlabPayload.BillingSlab[0].subOwnerShipCategory = 'subOwner'+randomString(3)
    * set updateBillingSlabPayload.BillingSlab[0].occupancyType = 'usageDetails'+randomString(3)
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInUpdateBillingSlab')
    * match billingSlabUpdateResponse.Errors[*].code contains ['#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[0])','#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[1])','#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[2])','#(propertyCalculatorConstants.errorMessage.invalidErroCodeBillingSlab[3])']
    * match billingSlabUpdateResponse.Errors[*].message contains ['#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[0])','#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[1])','#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[2])','#(propertyCalculatorConstants.errorMessage.invalidErroMessageBillingSlab[3])']