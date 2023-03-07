Feature: HCM Household API

    Background:
        * def createHouseholdRequest = read('../../health-services/requestPayload/household-service/create.json')
        * def searchHouseholdRequest = read('../../health-services/requestPayload/household-service/search.json')
        * def updateHouseholdRequest = read('../../health-services/requestPayload/household-service/update.json')
        * def deleteHouseholdRequest = read('../../health-services/requestPayload/household-service/delete.json')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

    @SuccessHouseholdSchemaValidation
    Scenario: Validate success response schema for household API which returns a household object
        # response schema validations
        * match householdResponseBody.Household == '#object'
        * match householdResponseBody.Household.id == '#present'
        * match householdResponseBody.Household.id != null
        * match householdResponseBody.Household.id == '#string'
        * match householdResponseBody.Household.address.id == '#present'
        * match householdResponseBody.Household.address.id != null
        * match householdResponseBody.Household.address.id == '#string'
        * match householdResponseBody.Household.address.clientReferenceId == '#present'
        * match householdResponseBody.Household.address.clientReferenceId != null
        * match householdResponseBody.Household.address.clientReferenceId == '#string'
        * match householdResponseBody.Household.clientReferenceId == '#present'
        * match householdResponseBody.Household.memberCount == '#number'
        * match householdResponseBody.Household.address == '#object'
        * match householdResponseBody.Household.address.id == '#string'
        * match householdResponseBody.Household.address.tenantId == '#string'
        * match householdResponseBody.Household.address.doorNo == '#string'
        * match householdResponseBody.Household.address.type == '#string'
        * match householdResponseBody.Household.address.addressLine1 == '#string'
        * match householdResponseBody.Household.address.addressLine2 == '#string'
        * match householdResponseBody.Household.address.landmark == '#string'
        * match householdResponseBody.Household.address.city == '#string'
        * match householdResponseBody.Household.address.buildingName == '#string'
        * match householdResponseBody.Household.address.street == '#string'
        * match householdResponseBody.Household.address.locality.code == '#present'
        * match householdResponseBody.Household.address.locality.name == '#present'
        * match householdResponseBody.Household.address.locality.label == '#present'
        * match householdResponseBody.Household.address.locality.latitude == '#present'
        * match householdResponseBody.Household.address.locality.longitude == '#present'
        * match householdResponseBody.Household.isDeleted == '#boolean'
        * match householdResponseBody.Household.rowVersion == '#number'
        * match householdResponseBody.Household.auditDetails == '#object'
        * match householdResponseBody.Household.auditDetails.createdBy == '#present'
        * match householdResponseBody.Household.auditDetails.createdBy != null
        * match householdResponseBody.Household.auditDetails.createdBy == '#string'
        * match householdResponseBody.Household.auditDetails.lastModifiedBy == '#present'
        * match householdResponseBody.Household.auditDetails.lastModifiedBy != null
        * match householdResponseBody.Household.auditDetails.lastModifiedBy == '#string'
        * match householdResponseBody.Household.auditDetails.createdTime == '#present'
        * match householdResponseBody.Household.auditDetails.createdTime != null
        * match householdResponseBody.Household.auditDetails.createdTime == '#number'
        * match householdResponseBody.Household.auditDetails.lastModifiedTime == '#present'
        * match householdResponseBody.Household.auditDetails.lastModifiedTime != null
        * match householdResponseBody.Household.auditDetails.lastModifiedTime == '#number'

    @SuccessHouseholdSearchSchemaValidation
    Scenario: Validate success response schema for household API which returns a household array
        # response schema validations
        * match householdResponseBody.Households == '#array'
        * match householdResponseBody.Households[0].id == '#present'
        * match householdResponseBody.Households[0].id != null
        * match householdResponseBody.Households[0].id == '#string'
        * match householdResponseBody.Households[0].address.id == '#present'
        * match householdResponseBody.Households[0].address.id != null
        * match householdResponseBody.Households[0].address.id == '#string'
        * match householdResponseBody.Households[0].clientReferenceId == '#present'
        * match householdResponseBody.Households[0].memberCount == '#number'
        * match householdResponseBody.Households[0].address == '#object'
        * match householdResponseBody.Households[0].address.id == '#string'
        * match householdResponseBody.Households[0].address.tenantId == '#string'
        * match householdResponseBody.Households[0].address.doorNo == '#string'
        * match householdResponseBody.Households[0].address.type == '#string'
        * match householdResponseBody.Households[0].address.addressLine1 == '#string'
        * match householdResponseBody.Households[0].address.addressLine2 == '#string'
        * match householdResponseBody.Households[0].address.landmark == '#string'
        * match householdResponseBody.Households[0].address.city == '#string'
        * match householdResponseBody.Households[0].address.buildingName == '#string'
        * match householdResponseBody.Households[0].address.street == '#string'
        * match householdResponseBody.Households[0].address.locality.code == '#present'
        * match householdResponseBody.Households[0].address.locality.name == '#present'
        * match householdResponseBody.Households[0].address.locality.label == '#present'
        * match householdResponseBody.Households[0].address.locality.latitude == '#present'
        * match householdResponseBody.Households[0].address.locality.longitude == '#present'
        * match householdResponseBody.Households[0].isDeleted == '#boolean'
        * match householdResponseBody.Households[0].rowVersion == '#number'
        * match householdResponseBody.Households[0].auditDetails == '#object'
        * match householdResponseBody.Households[0].auditDetails.createdBy == '#present'
        * match householdResponseBody.Households[0].auditDetails.createdBy != null
        * match householdResponseBody.Households[0].auditDetails.createdBy == '#string'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedBy == '#present'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedBy != null
        * match householdResponseBody.Households[0].auditDetails.lastModifiedBy == '#string'
        * match householdResponseBody.Households[0].auditDetails.createdTime == '#present'
        * match householdResponseBody.Households[0].auditDetails.createdTime != null
        * match householdResponseBody.Households[0].auditDetails.createdTime == '#number'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedTime == '#present'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedTime != null
        * match householdResponseBody.Households[0].auditDetails.lastModifiedTime == '#number'

    @SuccessHouseholdBulkSearchSchemaValidation
    Scenario: Validate success response schema for household API which returns a household array
        # response schema validations
        * match householdResponseBody.Households == '#array'
        * match householdResponseBody.Households[0].id == '#present'
        * match householdResponseBody.Households[0].id != null
        * match householdResponseBody.Households[0].id == '#string'
        * match householdResponseBody.Households[0].address.id == '#present'
        * match householdResponseBody.Households[0].address.id != null
        * match householdResponseBody.Households[0].address.id == '#string'
        * match householdResponseBody.Households[0].clientReferenceId == '#present'
        * match householdResponseBody.Households[0].memberCount == '#number'
        * match householdResponseBody.Households[0].address == '#object'
        * match householdResponseBody.Households[0].address.id == '#string'
        * match householdResponseBody.Households[0].address.tenantId == '#string'
        * match householdResponseBody.Households[0].address.doorNo == '#string'
        * match householdResponseBody.Households[0].address.type == '#string'
        * match householdResponseBody.Households[0].address.addressLine1 == '#string'
        * match householdResponseBody.Households[0].address.addressLine2 == '#string'
        * match householdResponseBody.Households[0].address.landmark == '#string'
        * match householdResponseBody.Households[0].address.city == '#string'
        * match householdResponseBody.Households[0].address.buildingName == '#string'
        * match householdResponseBody.Households[0].address.street == '#string'
        * match householdResponseBody.Households[0].address.locality.code == '#present'
        * match householdResponseBody.Households[0].address.locality.name == '#present'
        * match householdResponseBody.Households[0].address.locality.label == '#present'
        * match householdResponseBody.Households[0].address.locality.latitude == '#present'
        * match householdResponseBody.Households[0].address.locality.longitude == '#present'
        * match householdResponseBody.Households[0].isDeleted == '#boolean'
        * match householdResponseBody.Households[0].rowVersion == '#number'
        * match householdResponseBody.Households[0].auditDetails == '#object'
        * match householdResponseBody.Households[0].auditDetails.createdBy == '#present'
        * match householdResponseBody.Households[0].auditDetails.createdBy != null
        * match householdResponseBody.Households[0].auditDetails.createdBy == '#string'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedBy == '#present'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedBy != null
        * match householdResponseBody.Households[0].auditDetails.lastModifiedBy == '#string'
        * match householdResponseBody.Households[0].auditDetails.createdTime == '#present'
        * match householdResponseBody.Households[0].auditDetails.createdTime != null
        * match householdResponseBody.Households[0].auditDetails.createdTime == '#number'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedTime == '#present'
        * match householdResponseBody.Households[0].auditDetails.lastModifiedTime != null
        * match householdResponseBody.Households[0].auditDetails.lastModifiedTime == '#number'
        * match householdResponseBody.Households[1].id == '#present'
        * match householdResponseBody.Households[1].id != null
        * match householdResponseBody.Households[1].id == '#string'
        * match householdResponseBody.Households[1].address.id == '#present'
        * match householdResponseBody.Households[1].address.id != null
        * match householdResponseBody.Households[1].address.id == '#string'
        * match householdResponseBody.Households[1].clientReferenceId == '#present'
        * match householdResponseBody.Households[1].memberCount == '#number'
        * match householdResponseBody.Households[1].address == '#object'
        * match householdResponseBody.Households[1].address.id == '#string'
        * match householdResponseBody.Households[1].address.tenantId == '#string'
        * match householdResponseBody.Households[1].address.doorNo == '#string'
        * match householdResponseBody.Households[1].address.type == '#string'
        * match householdResponseBody.Households[1].address.addressLine1 == '#string'
        * match householdResponseBody.Households[1].address.addressLine2 == '#string'
        * match householdResponseBody.Households[1].address.landmark == '#string'
        * match householdResponseBody.Households[1].address.city == '#string'
        * match householdResponseBody.Households[1].address.buildingName == '#string'
        * match householdResponseBody.Households[1].address.street == '#string'
        * match householdResponseBody.Households[1].address.locality.code == '#present'
        * match householdResponseBody.Households[1].address.locality.name == '#present'
        * match householdResponseBody.Households[1].address.locality.label == '#present'
        * match householdResponseBody.Households[1].address.locality.latitude == '#present'
        * match householdResponseBody.Households[1].address.locality.longitude == '#present'
        * match householdResponseBody.Households[1].isDeleted == '#boolean'
        * match householdResponseBody.Households[1].rowVersion == '#number'
        * match householdResponseBody.Households[1].auditDetails == '#object'
        * match householdResponseBody.Households[1].auditDetails.createdBy == '#present'
        * match householdResponseBody.Households[1].auditDetails.createdBy != null
        * match householdResponseBody.Households[1].auditDetails.createdBy == '#string'
        * match householdResponseBody.Households[1].auditDetails.lastModifiedBy == '#present'
        * match householdResponseBody.Households[1].auditDetails.lastModifiedBy != null
        * match householdResponseBody.Households[1].auditDetails.lastModifiedBy == '#string'
        * match householdResponseBody.Households[1].auditDetails.createdTime == '#present'
        * match householdResponseBody.Households[1].auditDetails.createdTime != null
        * match householdResponseBody.Households[1].auditDetails.createdTime == '#number'
        * match householdResponseBody.Households[1].auditDetails.lastModifiedTime == '#present'
        * match householdResponseBody.Households[1].auditDetails.lastModifiedTime != null
        * match householdResponseBody.Households[1].auditDetails.lastModifiedTime == '#number'

    @bulkHouseholdSuccessSchemaValidation
    Scenario: Validate the schema for the successful creation of household with bulk API
        # response schema validations
        * match householdResponseBody.apiId == '#present'
        * match householdResponseBody.ver == '#present'
        * match householdResponseBody.ts == '#present'
        * match householdResponseBody.resMsgId == '#present'
        * match householdResponseBody.msgId == '#present'
        * match householdResponseBody.status == '#present'

    @createHouseholdSuccess
    Scenario: Create a household for a HCM campaign
        Given url createHouseholdURL
        And request createHouseholdRequest.householdCreateBody
        When method post
        Then status 202
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')

    @householdErrorResponseSchemaValidations
    Scenario: Schema validation for household API error Scenario
        # response schema validations
        * match householdResponseBody.Errors == '#array'
        * match householdResponseBody.Errors[0].code == '#present'
        * match householdResponseBody.Errors[0].code != null
        * match householdResponseBody.Errors[0].code == '#string'
        * match householdResponseBody.Errors[0].message == '#present'
        * match householdResponseBody.Errors[0].message != null
        * match householdResponseBody.Errors[0].message == '#string'
        * match householdResponseBody.Errors[0].description == '#present'
        * match householdResponseBody.Errors[0].params == '#present'

    @createHouseholdError
    Scenario: Create a household for a HCM campaign but with statuscode of 400
        Given url createHouseholdURL
        And request createHouseholdRequest.householdCreateBody
        When method post
        Then status 400
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@householdErrorResponseSchemaValidations')

    @createHouseholdUnauthorised
    Scenario: Create a household for a HCM campaign but with statuscode of 400
        Given url createHouseholdURL
        And request createHouseholdRequest.householdCreateBody
        When method post
        Then status 403
        And def householdResponseBody = response
        # response schema validations
        * call read('../../health-services/pretest/householdServicePretest.feature@householdErrorResponseSchemaValidations')
        * match householdResponseBody.Errors[0].description != null
        * match householdResponseBody.Errors[0].description == '#string'
        * match householdResponseBody.Errors[0].params == '#present'

    @searchHouseholdWithoutQueryParamsSchemaValidation
    Scenario: Search household without query params schema validations
        # response schema validations
        * match searchHouseholdResponseBody.Errors == '#array'
        * match searchHouseholdResponseBody.Errors[0].code == '#present'
        * match searchHouseholdResponseBody.Errors[0].code == '#string'
        * match searchHouseholdResponseBody.Errors[0].message == '#present'
        * match searchHouseholdResponseBody.Errors[0].message != null
        * match searchHouseholdResponseBody.Errors[0].message == '#string'
        * match searchHouseholdResponseBody.Errors[0].description == '#present'
        * match searchHouseholdResponseBody.Errors[0].params == '#present'

    @searchHouseholdWithIdWithoutQueryParams
    Scenario: Search a household for a HCM campaign with id of household and without query parameters
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithId
        And request requestBody
        When method post
        Then status 400
        And def searchHouseholdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithoutQueryParamsSchemaValidation')

    @searchByHouseholdIdWithQueryParamsError
    Scenario: Search a household by passing query params and get 400 as reponse code.
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithId
        And params parameters
        And request requestBody
        When method post
        Then status 400
        And def searchHouseholdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithoutQueryParamsSchemaValidation')

    @searchByHouseholdClientReferenceIdWithQueryParamsError
    Scenario: Search a household by passing query params and get 400 as reponse code.
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithClientReferenceId
        And params parameters
        And request requestBody
        When method post
        Then status 400
        And def searchHouseholdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithoutQueryParamsSchemaValidation')

    @searchByHouseholdBoundaryCodeWithQueryParamsError
    Scenario: Search a household by passing query params and get 400 as reponse code.
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithBoundaryCode
        And params parameters
        And request requestBody
        When method post
        Then status 400
        And def searchHouseholdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@searchHouseholdWithoutQueryParamsSchemaValidation')

    @searchHouseholdWithId
    Scenario: Search a household for a HCM campaign with id of household
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithId
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSearchSchemaValidation')

    @searchHouseholdWithIdOfNull
    Scenario: Search a household for a HCM campaign with id of household as null
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithId
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def searchHouseholdResponseBody = response

    @searchHouseholdWithClientReferenceId
    Scenario: Search a household for a HCM campaign with a single clientReferenceId of household
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSearchSchemaValidation')

    @searchHouseholdWithMultipleClientReferenceId
    Scenario: Search a household for a HCM campaign with multiple clientReferenceId of household
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithMultipleClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdBulkSearchSchemaValidation')

    @searchHouseholdWithBoundaryCode
    Scenario: Search a household for a HCM campaign with boundaryCode of household
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithBoundaryCode
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSearchSchemaValidation')

    @searchHouseholdWithAllCriteria
    Scenario: Search a household for a HCM campaign with all criteria
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithAllCriteria
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSearchSchemaValidation')

    @updateHouseholdFailure
    Scenario: Update an existing household for a HCM campaign and get a 400 response code
        Given url updateHouseholdURL
        And request updateHouseholdRequest.householdUpdateBodyGeneric
        When method post
        Then status 400
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@householdErrorResponseSchemaValidations')

    @updateHouseholdSuccess
    Scenario: Update an existing household for a HCM campaign
        Given url updateHouseholdURL
        And request updateHouseholdRequest.householdUpdateBody
        When method post
        Then status 202
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')

    @deleteHouseholdFailure
    Scenario: Delete an existing household for a HCM campaign and get a 400 response code
        Given url deleteHouseholdURL
        And request deleteHouseholdRequest.householdDeleteBodyGeneric
        When method post
        Then status 400
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@householdErrorResponseSchemaValidations')

    @deleteHouseholdSuccess
    Scenario: Deleting an existing household for a HCM campaign
        Given url deleteHouseholdURL
        And request deleteHouseholdRequest.deleteHouseholdRequestBody
        When method post
        Then status 202
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')

    @bulkCreateHouseholdSuccess
    Scenario: Bulk create households for a HCM campaign
        Given url bulkCreateHouseholdURL
        And def bulkCreateHouseholdRequest = createHouseholdRequest.bulkHouseholdCreateBody
        And request bulkCreateHouseholdRequest
        When method post
        Then status 202
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@bulkHouseholdSuccessSchemaValidation')

    @bulkUpdateHouseholdSuccess
    Scenario: Bulk update households for a HCM campaign
        Given url bulkUpdateHouseholdURL
        And def bulkUpdateHouseholdRequest = updateHouseholdRequest.bulkHouseholdUpdateBody
        And request bulkUpdateHouseholdRequest
        When method post
        Then status 202
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@bulkHouseholdSuccessSchemaValidation')

    @bulkDeleteHouseholdSuccess
    Scenario: Bulk delete households for a HCM campaign
        Given url bulkDeleteHouseholdURL
        And def bulkDeleteHouseholdRequest = deleteHouseholdRequest.bulkDeleteHouseholdRequestBody
        And request bulkDeleteHouseholdRequest
        When method post
        Then status 202
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@bulkHouseholdSuccessSchemaValidation')

    @searchHouseholdWithEmptyBodyForTimestamp
    Scenario: Search household created or updated after a speciifc timestamp
        Given url searchHouseholdURL
        And params parameters
        And request searchHouseholdWithEmptyBodyForTimestamp
        When method post
        Then status 200
        And def householdResponseBody = response
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdBulkSearchSchemaValidation')