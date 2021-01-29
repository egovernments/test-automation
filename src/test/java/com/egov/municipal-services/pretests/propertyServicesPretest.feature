Feature: Property Service

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def propertyServiceConstants = read('../../municipal-services/constants/propertyServiceConstants.yaml')
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * configure headers = read('classpath:websCommonHeaders.js')
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../../common-services/preTests/authenticationToken.feature')
    * def cityName = karate.jsonPath(tenant, "$.tenants[?(@.code=='" + tenantId + "')].name")[0]
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@locationsuccess')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def localityName = searchLocationResponseBody.TenantBoundary[0].boundary[0].name + ', ' + cityCode
    * def OccupancyType = PropertyTax.OccupancyType[randomNumber(PropertyTax.OccupancyType.length)].code
    * def UsageCategory = PropertyTax.UsageCategory[randomNumber(PropertyTax.UsageCategory.length)].code
    * def builtUpArea = 2000
    * def UsageCategoryMajor = PropertyTax.UsageCategoryMajor[randomNumber(PropertyTax.UsageCategoryMajor.length)].code
    * def landArea = 800
    * def PropertyType = PropertyTax.PropertyType[randomNumber(PropertyTax.PropertyType.length)].code
    * def noOfFloors = 1
    * def OwnerShipCategory = PropertyTax.OwnerShipCategory[randomNumber(PropertyTax.OwnerShipCategory.length)].code
    * def name = ranString(10)
    * def mobileNumber = '78' + randomMobileNumGen(8)
    * def fatherOrHusbandName = ranString(10)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def OwnerType = PropertyTax.OwnerType[randomNumber(PropertyTax.OwnerType.length)].code
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def isCorrespondenceAddress = true
    * def source = commonConstants.parameters.source
    * def channel = commonConstants.parameters.channel
    * def addressProofDocuments1 = karate.jsonPath(PropertyTax, "$.Documents[?(@.code=='" + commonConstants.parameters.documentTypes[0] + "')]")[0]
    * def addressProofDocumentType1 = addressProofDocuments1.dropdownData[randomNumber(addressProofDocuments1.dropdownData.length)].code
    * def addressProofDocuments2 = karate.jsonPath(PropertyTax, "$.Documents[?(@.code=='" + commonConstants.parameters.documentTypes[1] + "')]")[0]
    * def addressProofDocumentType2 = addressProofDocuments1.dropdownData[randomNumber(addressProofDocuments2.dropdownData.length)].code
    * def addressProofDocuments3 = karate.jsonPath(PropertyTax, "$.Documents[?(@.code=='" + commonConstants.parameters.documentTypes[2] + "')]")[0]
    * def addressProofDocumentType3 = addressProofDocuments1.dropdownData[randomNumber(addressProofDocuments3.dropdownData.length)].code
    * def addressProofDocuments4 = karate.jsonPath(PropertyTax, "$.Documents[?(@.code=='" + commonConstants.parameters.documentTypes[3] + "')]")[0]
    * def addressProofDocumentType4 = addressProofDocuments1.dropdownData[randomNumber(addressProofDocuments4.dropdownData.length)].code
    * def addressProofDocuments5 = karate.jsonPath(PropertyTax, "$.Documents[?(@.code=='" + commonConstants.parameters.documentTypes[4] + "')]")[0]
    * def addressProofDocumentType5 = addressProofDocuments1.dropdownData[randomNumber(addressProofDocuments5.dropdownData.length)].code
    * def UsageCategory = PropertyTax.UsageCategory[randomNumber(PropertyTax.UsageCategory.length)].code
    * def creationReason = commonConstants.parameters.creationReason
    * def createPropertyRequest = read('../../municipal-services/requestPayload/property-services/create.json')
  

@successCreateProperty
Scenario: Create a property
    * print createPropertyRequest
    Given url createpropertyUrl
    And request createPropertyRequest
    When method post
    Then status 201
    And def propertyServiceResponseHeaders = responseHeaders
    And def propertyServiceResponseBody = response
    * karate.log(propertyServiceResponseBody)