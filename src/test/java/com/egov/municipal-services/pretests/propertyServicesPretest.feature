Feature: Property Service

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def financialYear = commonConstants.parameters.financialYear
    * def assessmentDate = getCurrentEpochTime()
    * def source = commonConstants.parameters.source
    * def channel = commonConstants.parameters.channel
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * configure headers = read('classpath:websCommonHeaders.js')
    * def cityName = karate.jsonPath(tenant, "$.tenants[?(@.code=='" + tenantId + "')].name")[0]
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
    * def createPropertyRequest = read('../../municipal-services/requestPayload/property-services/create.json')
    * def businessId = commonConstants.parameters.businessId
    * def businessService = mdmsStatePropertyTax.PTWorkflow[1].businessService
    * def updatePropertyRequest = read('../../municipal-services/requestPayload/property-services/update.json')
    * def assessmentRequest = read('../../municipal-services/requestPayload/property-services/assessment.json')
    * def searchPropertyRequest = read('../../common-services/requestPayload/common/search.json')


@successCreateProperty
Scenario: Create a property
    Given url createpropertyUrl
    And request createPropertyRequest
    When method post
    Then status 201
    And def propertyServiceResponseHeaders = responseHeaders
    And def propertyServiceResponseBody = response
    And def Property = propertyServiceResponseBody.Properties[0]
    And def propertyId = Property.propertyId
    And def consumerCode = propertyId
    And def acknowldgementNumber = Property.acknowldgementNumber

@successSearchProperty
Scenario: Search a property
    * def searchPropertyParams =
    """
        {
            tenantId: '#(tenantId)',
            propertyIds: '#(propertyId)'
        }
    """
    Given url searchPropertyUrl
    And params searchPropertyParams
    And request searchPropertyRequest
    When method post
    Then status 200
    And def propertyServiceResponseHeaders = responseHeaders
    And def propertyServiceResponseBody = response
    And def Property = propertyServiceResponseBody.Properties[0]
    And def propertyId = Property.propertyId
    And def consumerCode = propertyId

@successVerifyProperty
Scenario: Verify a property
    * def workflow = updatePropertyRequest.Property.workflow
    * eval Property = karate.merge(Property, {'0': {'comment': '', 'assignee': []}})
    * eval updatePropertyRequest.Property = Property
    * eval updatePropertyRequest.Property.workflow = workflow
    # Since the action is specifically 'verify', it is hardcoded
    * eval updatePropertyRequest.Property.workflow.action = 'VERIFY'
    Given url updatePropertyUrl
    And request updatePropertyRequest
    When method post
    Then status 200
    And def propertyServiceResponseHeaders = responseHeaders
    And def propertyServiceResponseBody = response
    And def Property = propertyServiceResponseBody.Properties[0]
    And def propertyId = Property.propertyId
    And def consumerCode = propertyId

@successForwardProperty
Scenario: Forward a property
    * def workflow = updatePropertyRequest.Property.workflow
    * eval updatePropertyRequest.Property = Property
    * eval updatePropertyRequest.Property.workflow = workflow
    * eval updatePropertyRequest.Property.workflow.action = 'FORWARD'
    Given url updatePropertyUrl
    And request updatePropertyRequest
    When method post
    Then status 200
    And def propertyServiceResponseHeaders = responseHeaders
    And def propertyServiceResponseBody = response
    And def Property = propertyServiceResponseBody.Properties[0]
    And def propertyId = Property.propertyId
    And def consumerCode = propertyId

@successApproveProperty
Scenario: Approve a property
    * def workflow = updatePropertyRequest.Property.workflow
    * eval updatePropertyRequest.Property = Property
    * eval updatePropertyRequest.Property.workflow = workflow
    * eval updatePropertyRequest.Property.workflow.action = 'APPROVE'
    Given url updatePropertyUrl
    And request updatePropertyRequest
    When method post
    Then status 200
    And def propertyServiceResponseHeaders = responseHeaders
    And def propertyServiceResponseBody = response
    And def Property = propertyServiceResponseBody.Properties[0]
    And def propertyId = Property.propertyId
    And def consumerCode = propertyId

@successAssessProperty
Scenario: Create assessment
  * def assessmentParams =
    """
    {
       tenantId: '#(tenantId)'
    }
    """
  Given url createAssessment
  And params assessmentParams
  And request assessmentRequest
  When method post
  Then status 201
  And  print response