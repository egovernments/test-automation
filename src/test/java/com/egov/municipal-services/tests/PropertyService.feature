Feature: Property Services Create

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Collections = Java.type('java.util.Collections')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    # Searching Location for locality and areaCode
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def localityName = searchLocationResponseBody.TenantBoundary[0].boundary[0].name + ', ' + cityCode
    # initialising request payload variables
    * def financialYear = commonConstants.parameters.financialYear
    * def assessmentDate = getPastEpochDate(1)
    * def source = commonConstants.parameters.source
    * def channel = commonConstants.parameters.channel
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * configure headers = read('classpath:websCommonHeaders.js')
    * def cityName = karate.jsonPath(mdmsStatetenant, "$.tenants[?(@.code=='" + tenantId + "')].name")[0]
    * def OccupancyType = mdmsStatePropertyTax.OccupancyType[1].code
    * def UsageCategory = mdmsStatePropertyTax.UsageCategory[0].code
    * def builtUpArea = 2000
    * def UsageCategoryMajor = mdmsStatePropertyTax.UsageCategoryMajor[0].code
    * def landArea = 800
    * def PropertyType = mdmsStatePropertyTax.PropertyType[3].code
    * def noOfFloors = 1
    * def OwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[3].code
    * def name = randomString(10)
    * def mobileNumber = '78' + randomMobileNumGen(8)
    * def fatherOrHusbandName = randomString(10)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def OwnerType = mdmsStatePropertyTax.OwnerType[5].code
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def isCorrespondenceAddress = true
    * def source = commonConstants.parameters.source
    * def channel = commonConstants.parameters.channel
    * def addressProofDocumentType0 = mdmsStatePropertyTax.Documents[0].dropdownData[0].code
    * def addressProofDocumentType1 = mdmsStatePropertyTax.Documents[1].dropdownData[0].code
    * def addressProofDocumentType2 = mdmsStatePropertyTax.Documents[2].dropdownData[0].code
    * def addressProofDocumentType3 = mdmsStatePropertyTax.Documents[3].dropdownData[0].code
    * def addressProofDocumentType4 = mdmsStatePropertyTax.Documents[4].dropdownData[0].code
    * def creationReason = commonConstants.parameters.creationReason
    * def businessService = mdmsStatePropertyTax.PTWorkflow[1].businessService
    * def propertyServicesConstants = read('../../municipal-services/constants/propertyServices.yaml')


@Property_create_01 @createProperty @propertyServiceCreate @positive @regression @propertyServices @municipalServices
Scenario: Create Property with valid payload
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Validate response body
    * match propertyServiceResponseBody.Properties[0].id == "#present"
    * match propertyServiceResponseBody.Properties[0].propertyId == "#present"
    * match propertyServiceResponseBody.Properties[0].status == "INWORKFLOW"
    * match propertyServiceResponseBody.Properties[0].tenantId == tenantId

@Property_create_InvalidTenant_02 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property invalid tenantId
    # Set request payload variable values
    * def tenantId = 'invalid-tenant-' + randomString(10)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

@Property_create_NoLocality_03 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property without passing locality
    # Set request payload variable values
    * def removeFieldPath = '$.Property.address.locality'
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreatePropertyRemoveField')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.noLocality

@Property_create_BoundaryData_04 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid locality code and area
    # Set request payload variable values
    * def localityCode = 'invalid-code-' + randomString(10)
    * def areaCode = 'invalid-area-' + randomString(10)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.boundaryDataNotFound

@Property_create_INValidPropertyType_05 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid property type
    # Set request payload variable values
    * def PropertyType = 'invalid-property-type-' + randomString(5)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage =  propertyServicesConstants.errorMessages.propertyTypeNotFound
    * replace expectedMessage.PropertyType = PropertyType
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_create_LandArea_06 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with empty landArea for VACANT property type
    # Set request payload variable values
    * def PropertyType = 'VACANT'
    * def landArea = ''
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.landAreaNotNull
    * replace expectedMessage.PropertyType = PropertyType
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_create_IndependentProperty_07 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with empty landArea for BUILTUP.INDEPENDENTPROPERTY property type
    # Set request payload variable values
    * def PropertyType = 'BUILTUP.INDEPENDENTPROPERTY'
    * def landArea = ''
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.landAreaNotNull
    * replace expectedMessage.PropertyType = PropertyType
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_create_InvalidOwnership_08 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid ownershipCategory
    # Set request payload variable values
    * def OwnerShipCategory = 'invalid-ownership-category-' + randomString(5)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.ownershipCategoryNotExist
    * replace expectedMessage.OwnerShipCategory = OwnerShipCategory
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_create_BuiltupSharedFloors_09 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid no of floors for BUILTUP property type
    # Set request payload variable values
    * def PropertyType = 'BUILTUP'
    * def noOfFloors = ''
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.noOfFloorsNotNull
    * replace expectedMessage.PropertyType = PropertyType
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_create_InvalidUsage_10 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid usage category
    # Set request payload variable values
    * def UsageCategory = 'invalid-usage-category-' + randomString(5)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.usageCategoryNotExist
    * replace expectedMessage.UsageCategory = UsageCategory
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_create_InvalidMobileNUmber_11 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid usage category
    # Set request payload variable values
    * def mobileNumber = 'invalid-mobile-number-' + randomString(5)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.invalidMobileNumber

@Property_create_NullName_12 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with name as null
    # Set request payload variable values
    * def name = null
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == commonConstants.errorMessages.nullParameterError

@Property_create_InvalidName_13 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid name and empty gender
    # Set request payload variable values
    * def name = '123'
    * def gender = ''
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@Property_create_InvalidGender_14 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid name and empty gender
    # Set request payload variable values
    * def gender = 'abc'
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == commonConstants.errorMessages.unhandledException

@Property_create_InvalidValues_15 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid source and channel
    # Set request payload variable values
    * def source = ''
    * def channel = ''
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def errorMessages = $propertyServiceResponseBody.Errors[*].message
    * Collections.sort(errorMessages, java.lang.String.CASE_INSENSITIVE_ORDER)
    * match errorMessages[0] == propertyServicesConstants.errorMessages.channelNotNull
    * match errorMessages[1] == propertyServicesConstants.errorMessages.sourceNotNull

@Property_create_InvalidValues_16 @propertyServiceCreate @negative @regression @propertyServices @municipalServices
Scenario: Create Property with invalid name and empty gender
    # Set request payload variable values
    * def OwnerType = 'invalud-owner-type-' + randomString(10)
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInCreateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.ownerTypeNotExist
    * replace expectedMessage.OwnerType = OwnerType
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_search_01 @Property_search_PropertyIds_07 @positive @propertyServiceSearch @regression @propertyServices @municipalServices
Scenario: Search Property with valid query parameters
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    # Search a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Validate response body
    * match propertyServiceResponseBody.Properties[0].id == "#present"
    * match propertyServiceResponseBody.Properties[0].propertyId == "#present"
    * match propertyServiceResponseBody.Properties[0].status == "INWORKFLOW"
    * match propertyServiceResponseBody.Properties[0].tenantId == tenantId

@Property_search_NoTenant_02 @negative @propertyServiceSearch @regression @propertyServices @municipalServices
Scenario: Search Property with no tenantId
    # Initializing search query params
    * def searchPropertyParams = { propertyIds: '#(propertyId)'}
    # Search a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInSearchProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.tenantIdMandatory

@Property_search_OnlyTenant_03 @negative @propertyServiceSearch @regression @propertyServices @municipalServices
Scenario: Search Property with only tenantId
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)'}
    # Search a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInSearchProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.noSearchCriteria

@Property_search_Multiple_04 @positive @propertyServiceSearch @regression @propertyServices @municipalServices
Scenario: Search Property with multiple valid query parameters
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)', mobileNumber: '#(mobileNumber)'}
    # Search a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Validate response body
    * match propertyServiceResponseBody.Properties[0].id == "#present"
    * match propertyServiceResponseBody.Properties[0].propertyId == "#present"
    * match propertyServiceResponseBody.Properties[0].status == "INWORKFLOW"
    * match propertyServiceResponseBody.Properties[0].tenantId == tenantId

@Property_search_Invalid_05 @positive @propertyServiceSearch @regression @propertyServices @municipalServices
Scenario: Search Property with invalid query parameters
    # Initializing search query params
    * def searchPropertyParams = { tenantId: 'abc', propertyIds: 'abc', mobileNumber: '1827767885'}
    # Search a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertyForEmptyResult')
    # Validate response body
    * match propertyServiceResponseBody.Properties.size() == 0

@Property_search_AckNum_06 @positive @propertyServiceSearch @regression @propertyServices @municipalServices
Scenario: Search Property with valid acknowledgementId
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', acknowledgementIds: '#(acknowldgementNumber)'}
    # Search a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Validate response body
    * match propertyServiceResponseBody.Properties[0].id == "#present"
    * match propertyServiceResponseBody.Properties[0].propertyId == "#present"
    * match propertyServiceResponseBody.Properties[0].status == "INWORKFLOW"
    * match propertyServiceResponseBody.Properties[0].tenantId == tenantId

@Property_Update_01 @positive @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with valid request payload
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * eval Property.name = name + 'Updated'
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@updatePropertySuccessfully')
    # Validate response body
    * match propertyServiceResponseBody.Properties[0].id == "#present"
    * match propertyServiceResponseBody.Properties[0].propertyId == "#present"
    * match propertyServiceResponseBody.Properties[0].status == "INWORKFLOW"
    * match propertyServiceResponseBody.Properties[0].tenantId == tenantId

@Property_Update_AckError_02 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with invalid acknowledgement number
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * eval Property.acknowldgementNumber = 'invalid-acknowledgement-' + randomString(10)
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.invalidAcknowledgementNumber

@Property_Update_NOPropertyID_03 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with propertyId as null
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * eval Property.propertyId = null
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.cannotUpdate

@Property_Update_InValidTenant_04 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with invalid tenantId
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * eval Property.tenantId = 'invalid-tenant-' + randomString(10)
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantId

@Property_Update_WF_Error_05 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property without passing workflow
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * def removeFieldPath = '$.Property.workflow'
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdatePropertyRemoveField')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.workflowMandatory

@Property_Update_InValidPropertyType_06 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with invalid property type
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * def invalidPropertyType = 'invalid-property-type-' + randomString(10)
    * eval Property.propertyType = invalidPropertyType
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.propertyTypeNotFound
    * replace expectedMessage.PropertyType = invalidPropertyType
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_Update_InValidOwnership_07 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with invalid ownership category
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * def invalidOwnershipCategory = 'invalid-owner-category-' + randomString(10)
    * eval Property.ownershipCategory = invalidOwnershipCategory
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.ownershipCategoryNotExist
    * replace expectedMessage.OwnerShipCategory = invalidOwnershipCategory
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_Update_InValidUsage_08 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with invalid usage category
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * def invalidUsageCategory = 'invalid-owner-category-' + randomString(10)
    * eval Property.usageCategory = invalidUsageCategory
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * def expectedMessage = propertyServicesConstants.errorMessages.usageCategoryNotExist2
    * replace expectedMessage.UsageCategory = invalidUsageCategory
    * match propertyServiceResponseBody.Errors[0].message == expectedMessage

@Property_Update_WFVal_09 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property by changing landarea floor
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * eval Property.landArea = 1200
    * eval Property.noOfFloors = 2
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.cannotUpdate

@Property_Update_WFAction_10 @negative @propertyServiceUpdate @regression @propertyServices @municipalServices
Scenario: Update Property with duplicate worflow action
    # Create a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    # Initializing search query params
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds:'#(propertyId)'} 
    # Search a property
	* call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    # Set request payload variable values
    * eval Property.name = name + 'Updated'
    # Update a property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@updatePropertySuccessfully')
    # Update a property again
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@errorInUpdateProperty')
    # Validate response body
    * match propertyServiceResponseBody.Errors[0].message == propertyServicesConstants.errorMessages.cannotUpdate

@createActiveProperty
Scenario: Create Active Property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@verifyPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@forwardPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@approvePropertySuccessfully')

@verifyProperty
Scenario: Verify the create property and procceed for the next steps
    * print "Verifing property"
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@verifyPropertySuccessfully')

@forwardProperty
Scenario: Forward the property to the respective approver for further approval
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@forwardPropertySuccessfully')

@approveProperty
Scenario: Approve the property as an Approver
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@approvePropertySuccessfully')

@assessProperty
Scenario: Assess the property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createAssessmentSuccessfully')


@createPropertyAndAssess
Scenario: Create Active Property
    * def searchPropertyParams = { tenantId: '#(tenantId)', propertyIds: '#(propertyId)'}
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@verifyPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@forwardPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@approvePropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@searchPropertySuccessfully')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@createAssessmentSuccessfully')

