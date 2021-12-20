Feature: To test property-calculator-PropertyTax service 'Calculate' endpoints

Background: 
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def propertyCalculatorConstants = read('../../municipal-services/constants/propertyCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../municipal-services/tests/PropertyService.feature@createActiveProperty')
    * call read('../../municipal-services/tests/PropertyService.feature@assessProperty')
    # * print propertyId
    * def unitId = generateUUID()
    * def floorNo = 0
    * def usageCategoryMajor = mdmsStatePropertyTax.UsageCategoryMajor[0].code
    * def usageCategoryMinor = mdmsStatePropertyTax.UsageCategoryMinor[0].code
    * def usageCategorySubMinor = mdmsStatePropertyTax.UsageCategorySubMinor[0].code
    * def usageCategoryDetail = mdmsStatePropertyTax.UsageCategoryDetail[1].code
    * def occupancyType = mdmsStatePropertyTax.OccupancyType[1].code
    * def unitArea = 4111.111
    * def propertyType = mdmsStatePropertyTax.PropertyType[1].code
    * def propertySubType = mdmsStatePropertyTax.PropertySubType[1].code
    * def ownerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code
    * def subOwnershipCategory = mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def uuid = null
    * def ownerType = mdmsStatePropertyTax.OwnerType[5].code
    * def mobileNumber = '78' + randomMobileNumGen(8)
    * def fatherOrHusbandName = randomString(10)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def oldPropertyId = randomString(5)
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def city = searchLocationResponseBody.TenantBoundary[0].boundary[0].name + ', ' + cityCode
    * def type = propertyServiceResponseBody.Properties[0].owners[0].type
    * def status = propertyServiceResponseBody.Properties[0].owners[0].status
    * def assessmentYear = Assessment.financialYear
    * def assessmentNumber = Assessment.assessmentNumber
    * def assessmentDate = Assessment.assessmentDate
    * def propertyTaxPayload = read('../../municipal-services/requestPayload/property-calculator/propertyTax/calculate.json')
   
@propertytax_calculate_01 @positive @propertyTax @propertyCalculator @regression
Scenario: Verify the property tax calculation thorugh API call for a given property id
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTax')
    * def estimateAmount = karate.jsonPath(propertyTaxResponse, '$.'+assessmentNumber+'.taxHeadEstimates[*].estimateAmount')
    # * print estimateAmount
    * def result = 0
    # Customized function to fetch sum of tax head estimate ammount
    * def fun = function(x){ var temp = karate.get('result'); karate.set('result', temp + x )}
    * karate.forEach(estimateAmount, fun)
    * match propertyTaxResponse[assessmentNumber].taxHeadEstimates.size() != 0
    * match Math.round(result) == Math.round(propertyTaxResponse[assessmentNumber].taxAmount)
    
@propertytax_calculate_values_02 @positive @propertyTax @propertyCalculator @regression
Scenario: Verify the property tax calculation thorugh API call for a given property id by providing different values for lanareas, floors, etc and check if the total and tax ammount changes, estimates
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTax')
    * def firstTaxAmount = propertyTaxResponse[assessmentNumber].taxAmount
    * set propertyTaxPayload.CalculationCriteria[0].property.propertyDetails[0].noOfFloors = 10
    * set propertyTaxPayload.CalculationCriteria[0].property.propertyDetails[0].landArea = 8000
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTax')
    * def secondTaxAmount = propertyTaxResponse[assessmentNumber].taxAmount
    * match firstTaxAmount != secondTaxAmount

@propertytax_calculate_Invalidvalues_03 @negative @propertyTax @propertyCalculator @regression
Scenario: Verify the property tax calculation thorugh API call for a given property id by passing invalid or non existant values for property type or user category, etc and check for errors
    * set propertyTaxPayload.CalculationCriteria[0].property.propertyDetails[0].propertyType = 'Invalid.'+randomString(3)
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTax')
    * def errorMessage = "No matching slabs has been found for unit on FloorNo : "+floorNo+" of Area : "+unitArea+" with usageCategoryDetail : "+usageCategoryDetail+""
    * match propertyTaxErrorResponse.Errors[0].message == errorMessage

@propertytax_calculate_InvalidUser_04 @negative @propertyTax @propertyCalculator @regression
Scenario: Verify the property tax calculation thorugh API call for a given property id by passing invalid or non existant values for username uuid and check for errors
    * def invalidUUID = generateUUID()
    * set propertyTaxPayload.CalculationCriteria[0].property.propertyDetails[0].owners[0].uuid = invalidUUID
    * def errorMessageForInValidUserUUID = 'No users found for following uuids  ['+invalidUUID+']'
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTax')
    * match propertyTaxErrorResponse.Errors[0].message == errorMessageForInValidUserUUID

@propertytax_calculate_NullTenant_05 @negative @propertyTax @propertyCalculator @regression
Scenario: Verify the property tax calculation thorugh API call for a given property id by passing a null value for tenant id and check for errors
    * def nullTenantId = null
    * set propertyTaxPayload.CalculationCriteria[0].tenantId = nullTenantId
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTax')
    * match propertyTaxErrorResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.nullTenantIdCode