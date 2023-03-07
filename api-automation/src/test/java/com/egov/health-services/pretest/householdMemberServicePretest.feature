Feature: HCM Household API

    Background:
        * def createHouseholdMemberRequest = read('../../health-services/requestPayload/household-member-service/create.json')
        * def searchHouseholdMemberRequest = read('../../health-services/requestPayload/household-member-service/search.json')
        * def updateHouseholdMemberRequest = read('../../health-services/requestPayload/household-member-service/update.json')
        * def deleteHouseholdMemberRequest = read('../../health-services/requestPayload/household-member-service/delete.json')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

    @SuccessHouseholdMemberSchemaValidation
    Scenario: Validate success response schema for household member API which returns a household object
        # response schema validations
        * match householdMemberResponseBody.HouseholdMember == '#object'
        * match householdMemberResponseBody.HouseholdMember.id == '#present'
        * match householdMemberResponseBody.HouseholdMember.id != null
        * match householdMemberResponseBody.HouseholdMember.id == '#string'
        * match householdMemberResponseBody.HouseholdMember.householdId == '#present'
        * match householdMemberResponseBody.HouseholdMember.householdId != null
        * match householdMemberResponseBody.HouseholdMember.householdId == '#string'
        * match householdMemberResponseBody.HouseholdMember.householdClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMember.householdClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMember.householdClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMember.individualId == '#present'
        * match householdMemberResponseBody.HouseholdMember.individualId != null
        * match householdMemberResponseBody.HouseholdMember.individualId == '#string'
        * match householdMemberResponseBody.HouseholdMember.individualClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMember.individualClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMember.individualClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == '#present'
        * match householdMemberResponseBody.HouseholdMember.isHeadOfHousehold != null
        * match householdMemberResponseBody.HouseholdMember.isHeadOfHousehold == '#boolean'
        * match householdMemberResponseBody.HouseholdMember.tenantId == '#present'
        * match householdMemberResponseBody.HouseholdMember.tenantId != null
        * match householdMemberResponseBody.HouseholdMember.tenantId == '#string'
        * match householdMemberResponseBody.HouseholdMember.isDeleted == '#boolean'
        * match householdMemberResponseBody.HouseholdMember.rowVersion == '#number'
        * match householdMemberResponseBody.HouseholdMember.auditDetails == '#object'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.createdBy == '#present'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.createdBy != null
        * match householdMemberResponseBody.HouseholdMember.auditDetails.createdBy == '#string'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.lastModifiedBy == '#present'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.lastModifiedBy != null
        * match householdMemberResponseBody.HouseholdMember.auditDetails.lastModifiedBy == '#string'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.createdTime == '#present'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.createdTime != null
        * match householdMemberResponseBody.HouseholdMember.auditDetails.createdTime == '#number'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.lastModifiedTime == '#present'
        * match householdMemberResponseBody.HouseholdMember.auditDetails.lastModifiedTime != null
        * match householdMemberResponseBody.HouseholdMember.auditDetails.lastModifiedTime == '#number'

    @SuccessHouseholdMemberSearchSchemaValidation
    Scenario: Validate success response schema for household member API which returns a household member array
        # response schema validations
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers[0].id == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].id != null
        * match householdMemberResponseBody.HouseholdMembers[0].id == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].householdId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].householdId != null
        * match householdMemberResponseBody.HouseholdMembers[0].householdId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].individualId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].individualId != null
        * match householdMemberResponseBody.HouseholdMembers[0].individualId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold != null
        * match householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == '#boolean'
        * match householdMemberResponseBody.HouseholdMembers[0].tenantId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].tenantId != null
        * match householdMemberResponseBody.HouseholdMembers[0].tenantId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].isDeleted == '#boolean'
        * match householdMemberResponseBody.HouseholdMembers[0].rowVersion == '#number'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails == '#object'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdBy == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdBy != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdBy == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedBy == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedBy != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedBy == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdTime == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdTime != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdTime == '#number'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedTime == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedTime != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedTime == '#number'

    @SuccessHouseholdMemberBulkSearchSchemaValidation
    Scenario: Validate success response schema for household member API which returns a household member array
        # response schema validations
        * match householdMemberResponseBody.HouseholdMembers == '#array'
        * match householdMemberResponseBody.HouseholdMembers[0].id == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].id != null
        * match householdMemberResponseBody.HouseholdMembers[0].id == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].householdId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].householdId != null
        * match householdMemberResponseBody.HouseholdMembers[0].householdId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMembers[0].householdClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].individualId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].individualId != null
        * match householdMemberResponseBody.HouseholdMembers[0].individualId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMembers[0].individualClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold != null
        * match householdMemberResponseBody.HouseholdMembers[0].isHeadOfHousehold == '#boolean'
        * match householdMemberResponseBody.HouseholdMembers[0].tenantId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].tenantId != null
        * match householdMemberResponseBody.HouseholdMembers[0].tenantId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].isDeleted == '#boolean'
        * match householdMemberResponseBody.HouseholdMembers[0].rowVersion == '#number'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails == '#object'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdBy == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdBy != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdBy == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedBy == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedBy != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedBy == '#string'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdTime == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdTime != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.createdTime == '#number'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedTime == '#present'
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedTime != null
        * match householdMemberResponseBody.HouseholdMembers[0].auditDetails.lastModifiedTime == '#number'
        * match householdMemberResponseBody.HouseholdMembers[1].id == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].id != null
        * match householdMemberResponseBody.HouseholdMembers[1].id == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].householdId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].householdId != null
        * match householdMemberResponseBody.HouseholdMembers[1].householdId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].householdClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].householdClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMembers[1].householdClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].individualId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].individualId != null
        * match householdMemberResponseBody.HouseholdMembers[1].individualId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].individualClientReferenceId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].individualClientReferenceId != null
        * match householdMemberResponseBody.HouseholdMembers[1].individualClientReferenceId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].isHeadOfHousehold == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].isHeadOfHousehold != null
        * match householdMemberResponseBody.HouseholdMembers[1].isHeadOfHousehold == '#boolean'
        * match householdMemberResponseBody.HouseholdMembers[1].tenantId == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].tenantId != null
        * match householdMemberResponseBody.HouseholdMembers[1].tenantId == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].isDeleted == '#boolean'
        * match householdMemberResponseBody.HouseholdMembers[1].rowVersion == '#number'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails == '#object'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.createdBy == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.createdBy != null
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.createdBy == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.lastModifiedBy == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.lastModifiedBy != null
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.lastModifiedBy == '#string'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.createdTime == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.createdTime != null
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.createdTime == '#number'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.lastModifiedTime == '#present'
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.lastModifiedTime != null
        * match householdMemberResponseBody.HouseholdMembers[1].auditDetails.lastModifiedTime == '#number'

    @bulkHouseholdMemberSuccessSchemaValidation
    Scenario: Validate the schema for the successful creation of household member with bulk API
        # response schema validations
        * match householdMemberResponseBody.apiId == '#present'
        * match householdMemberResponseBody.ver == '#present'
        * match householdMemberResponseBody.ts == '#present'
        * match householdMemberResponseBody.resMsgId == '#present'
        * match householdMemberResponseBody.msgId == '#present'
        * match householdMemberResponseBody.status == '#present'

    @householdMemberErrorSchemaValidation
    Scenario: Search household member without query params schema validations
        # response schema validations
        * match householdMemberResponseBody.Errors == '#array'
        * match householdMemberResponseBody.Errors[0].code == '#present'
        * match householdMemberResponseBody.Errors[0].code == '#string'
        * match householdMemberResponseBody.Errors[0].message == '#present'
        * match householdMemberResponseBody.Errors[0].message != null
        * match householdMemberResponseBody.Errors[0].message == '#string'
        * match householdMemberResponseBody.Errors[0].description == '#present'
        * match householdMemberResponseBody.Errors[0].params == '#present'

    @createHouseholdMemberSuccess
    Scenario: Create a household member for a HCM household
        Given url createHouseholdMemberURL
        And request createHouseholdMemberRequest.createHouseholdMemberBody
        When method post
        Then status 202
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSchemaValidation')

    @createHouseholdMemberError
    Scenario: Create a household member for a HCM campaign but with statuscode of 400
        Given url createHouseholdMemberURL
        And request createHouseholdMemberRequest.createHouseholdMemberBody
        When method post
        Then status 400
        And def householdMemberResponseBody = response
        # response schema validations
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@householdMemberErrorSchemaValidation')

    @createHouseholdMemberUnauthorised
    Scenario: Create a household member for a HCM campaign but with statuscode of 400
        Given url createHouseholdMemberURL
        And request createHouseholdMemberRequest.createHouseholdMemberBody
        When method post
        Then status 403
        And def householdMemberResponseBody = response
        # response schema validations
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@householdMemberErrorSchemaValidation')
        * match householdMemberResponseBody.Errors[0].code != null
        * match householdMemberResponseBody.Errors[0].description != null
        * match householdMemberResponseBody.Errors[0].description == '#string'
        * match householdMemberResponseBody.Errors[0].params == '#present'

    @searchHouseholdMemberWithIdWithoutQueryParams
    Scenario: Search a household for a HCM campaign with id of household and without query parameters
        Given url searchHouseholdMemberURL
        * def requestBody = searchHouseholdMemberRequest.searchHouseholdMemberById
        And request requestBody
        When method post
        Then status 400
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@householdMemberErrorSchemaValidation')

    @searchHouseholdMemberByIdWithQueryParamsError
    Scenario: Search a household by passing queryparams and get 400 as reponse code.
        Given url searchHouseholdMemberURL
        * def requestBody = searchHouseholdMemberRequest.searchHouseholdMemberById
        And params parameters
        And request requestBody
        When method post
        Then status 400
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@householdMemberErrorSchemaValidation')

    @searchHouseholdMemberWithHouseholdMemberId
    Scenario: Search a household member for a HCM campaign with id of household member
        Given url searchHouseholdMemberURL
        * def requestBody = searchHouseholdMemberRequest.searchHouseholdMemberById
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSearchSchemaValidation')

    @searchHouseholdMemberWithHouseholdClientReferenceId
    Scenario: Search a household member for a HCM campaign with clientReferenceId of household
        Given url searchHouseholdMemberURL
        * def requestBody = searchHouseholdMemberRequest.searchHouseholdMemberByHouseholdClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSearchSchemaValidation')

    @searchHouseholdMemberWithIndividualClientReferenceId
    Scenario: Search a household member for a HCM campaign with clientReferenceId of individual
        Given url searchHouseholdMemberURL
        * def requestBody = searchHouseholdMemberRequest.searchHouseholdMemberByIndividualClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSearchSchemaValidation')

    @searchHouseholdMemberWithAllCriteria
    Scenario: Search a household member for a HCM campaign with all criteria
        Given url searchHouseholdMemberURL
        * def requestBody = searchHouseholdMemberRequest.searchHouseholdMemberWithAllCriteria
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSearchSchemaValidation')

    @updateHouseholdMemberSuccess
    Scenario: Update an existing household member for a HCM campaign
        Given url updateHouseholdMemberURL
        And request updateHouseholdMemberRequest.updateHouseholdMemberBody
        When method post
        Then status 202
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSchemaValidation')

    @updateHouseholdMemberError
    Scenario: Update an existing household member for a HCM campaign and gets a response as 400
        Given url updateHouseholdMemberURL
        And request updateHouseholdMemberRequest.updateHouseholdMemberGenericBody
        When method post
        Then status 400
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@householdMemberErrorSchemaValidation')

    @deleteHouseholdMemberSuccess
    Scenario: Deleting an existing household member for a HCM campaign
        Given url deleteHouseholdMemberURL
        And request deleteHouseholdMemberRequest.deleteHouseholdMemberBody
        When method post
        Then status 202
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@SuccessHouseholdMemberSchemaValidation')

    @deleteHouseholdMemberError
    Scenario: Deleting an existing household member for a HCM campaign and gets a response as 400
        Given url deleteHouseholdMemberURL
        And request deleteHouseholdMemberRequest.deleteHouseholdMemberGenericBody
        When method post
        Then status 400
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@householdMemberErrorSchemaValidation')

    @bulkCreateHouseholdMemberSuccess
    Scenario: Bulk create household member for a HCM campaign
        Given url bulkCreateHouseholdMemberURL
        And def bulkCreateHouseholdMemberRequest = createHouseholdMemberRequest.bulkCreateHouseholdMemberBody
        And request bulkCreateHouseholdMemberRequest
        When method post
        Then status 202
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@bulkHouseholdMemberSuccessSchemaValidation')

    @bulkUpdateHouseholdMemberSuccess
    Scenario: Bulk update household member for a HCM campaign
        Given url bulkUpdateHouseholdMemberURL
        And def bulkUpdateHouseholdMemberRequest = updateHouseholdMemberRequest.bulkUpdateHouseholdMemberBody
        And request bulkUpdateHouseholdMemberRequest
        When method post
        Then status 202
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@bulkHouseholdMemberSuccessSchemaValidation')

    @bulkDeleteHouseholdMemberSuccess
    Scenario: Bulk delete household member for a HCM campaign
        Given url bulkDeleteHouseholdMemberURL
        And def bulkDeleteHouseholdMemberRequest = deleteHouseholdMemberRequest.bulkDeleteHouseholdMemberBody
        And request bulkDeleteHouseholdMemberRequest
        When method post
        Then status 202
        And def householdMemberResponseBody = response
        * call read('../../health-services/pretest/householdMemberServicePretest.feature@bulkHouseholdMemberSuccessSchemaValidation')