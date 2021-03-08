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
    * def fromFloor = ranInteger(1)+'.0'
    * def toFloor = ranInteger(1)+'.0'
    * def areaType = 'AREA3'
    * def fromPlotSize = ranInteger(1)+'.0'
    * def toPlotSize = ranInteger(3)+'.0'
    * def unBuiltUnitRate = null
    * def arvPercent = null
    * def unitRate = 0
    * def billingSlabCreatePayload = read('../../municipal-services/requestPayload/property-calculator/billingSlab/create.json')
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
    * match errorResponse.Errors[*].code contains ['#(errorAreaType)','#(errorToFloor)','#(errorFromPlotSize)','#(errorUsageCategoryMinor)','#(errorFromFloor)','#(errorUsageCategoryDetail)','#(errorToPlotSize)','#(errorSubOwnerShipCategory)','#(errorPropertyType)','#(errorUsageCategorySubMinor)','#(errorIsPropertyMultiFloored)','#(errorOwnerShipCategory)','#(errorUsageCategoryMajor)','#(errorPropertySubType)','#(errorOccupancyType)']

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