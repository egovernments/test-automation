Feature: HCM Household API

    Background:
        * def createHouseholdRequest = read('../../health-services/requestPayload/household-service/create.json')
        * def searchHouseholdRequest = read('../../health-services/requestPayload/household-service/search.json')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

    @SuccessHouseholdSchemaValidation
    Scenario: Validate success response schemd for household API
        # response schema validations
        * match createHouseholdResponseBody.Household == '#array'
        * match createHouseholdResponseBody.Household[0].id == '#present'
        * match createHouseholdResponseBody.Household[0].id != null
        * match createHouseholdResponseBody.Household[0].id == '#string'
        * match createHouseholdResponseBody.Household[0].address.id == '#present'
        * match createHouseholdResponseBody.Household[0].address.id != null
        * match createHouseholdResponseBody.Household[0].address.id == '#string'
        * match createHouseholdResponseBody.Household[0].clientReferenceId == '#present'
        * match createHouseholdResponseBody.Household[0].memberCount == '#number'
        * match createHouseholdResponseBody.Household[0].address == '#object'
        * match createHouseholdResponseBody.Household[0].address.id == '#string'
        * match createHouseholdResponseBody.Household[0].address.tenantId == '#string'
        * match createHouseholdResponseBody.Household[0].address.doorNo == '#string'
        * match createHouseholdResponseBody.Household[0].address.type == '#string'
        * match createHouseholdResponseBody.Household[0].address.addressLine1 == '#string'
        * match createHouseholdResponseBody.Household[0].address.addressLine2 == '#string'
        * match createHouseholdResponseBody.Household[0].address.landmark == '#string'
        * match createHouseholdResponseBody.Household[0].address.city == '#string'
        * match createHouseholdResponseBody.Household[0].address.buildingName == '#string'
        * match createHouseholdResponseBody.Household[0].address.street == '#string'
        * match createHouseholdResponseBody.Household[0].address.locality.code == '#present'
        * match createHouseholdResponseBody.Household[0].address.locality.name == '#present'
        * match createHouseholdResponseBody.Household[0].address.locality.label == '#present'
        * match createHouseholdResponseBody.Household[0].address.locality.latitude == '#present'
        * match createHouseholdResponseBody.Household[0].address.locality.longitude == '#present'
        * match createHouseholdResponseBody.Household[0].isDeleted == '#boolean'
        * match createHouseholdResponseBody.Household[0].rowVersion == '#number'
        * match createHouseholdResponseBody.Household[0].auditDetails == '#object'
        * match createHouseholdResponseBody.Household[0].auditDetails.createdBy == '#present'
        * match createHouseholdResponseBody.Household[0].auditDetails.createdBy != null
        * match createHouseholdResponseBody.Household[0].auditDetails.createdBy == '#string'
        * match createHouseholdResponseBody.Household[0].auditDetails.lastModifiedBy == '#present'
        * match createHouseholdResponseBody.Household[0].auditDetails.lastModifiedBy != null
        * match createHouseholdResponseBody.Household[0].auditDetails.lastModifiedBy == '#string'
        * match createHouseholdResponseBody.Household[0].auditDetails.createdTime == '#present'
        * match createHouseholdResponseBody.Household[0].auditDetails.createdTime != null
        * match createHouseholdResponseBody.Household[0].auditDetails.createdTime == '#number'
        * match createHouseholdResponseBody.Household[0].auditDetails.lastModifiedTime == '#present'
        * match createHouseholdResponseBody.Household[0].auditDetails.lastModifiedTime != null
        * match createHouseholdResponseBody.Household[0].auditDetails.lastModifiedTime == '#number'

    @createHouseholdSuccess
    Scenario: Create a household for a HCM campaign
        Given url createHouseholdURL
        And request createHouseholdRequest
        When method post
        Then status 202
        And def createHouseholdResponseHeader = responseHeaders
        And def createHouseholdResponseBody = response
        And def Household = createHouseholdResponseBody.Household
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')

    @createHouseholdError
    Scenario: Create a household for a HCM campaign but with statuscode of 400
        Given url createHouseholdURL
        And request createHouseholdRequest
        When method post
        Then status 400
        And def createHouseholdResponseHeader = responseHeaders
        And def createHouseholdResponseBody = response
        # response schema validations
        * match createHouseholdResponseBody.Errors == '#array'
        * match createHouseholdResponseBody.Errors[0].code == '#present'
        * match createHouseholdResponseBody.Errors[0].code != null
        * match createHouseholdResponseBody.Errors[0].code == '#string'
        * match createHouseholdResponseBody.Errors[0].message == '#present'
        * match createHouseholdResponseBody.Errors[0].message != null
        * match createHouseholdResponseBody.Errors[0].message == '#string'
        * match createHouseholdResponseBody.Errors[0].description == '#present'
        * match createHouseholdResponseBody.Errors[0].params == '#present'

    @createHouseholdUnauthorised
    Scenario: Create a household for a HCM campaign but with statuscode of 400
        Given url createHouseholdURL
        And request createHouseholdRequest
        When method post
        Then status 403
        And def createHouseholdResponseHeader = responseHeaders
        And def createHouseholdResponseBody = response
        # response schema validations
        * match createHouseholdResponseBody.Errors == '#array'
        * match createHouseholdResponseBody.Errors[0].code == '#present'
        * match createHouseholdResponseBody.Errors[0].code != null
        * match createHouseholdResponseBody.Errors[0].code == '#string'
        * match createHouseholdResponseBody.Errors[0].message == '#present'
        * match createHouseholdResponseBody.Errors[0].message != null
        * match createHouseholdResponseBody.Errors[0].message == '#string'
        * match createHouseholdResponseBody.Errors[0].description == '#present'
        * match createHouseholdResponseBody.Errors[0].description != null
        * match createHouseholdResponseBody.Errors[0].description == '#string'
        * match createHouseholdResponseBody.Errors[0].params == '#present'

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
        And def searchHouseholdResponseHeader = responseHeaders
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
        And def searchHouseholdResponseHeader = responseHeaders
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
        And def searchHouseholdResponseHeader = responseHeaders
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
        And def searchHouseholdResponseHeader = responseHeaders
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
        And def searchHouseholdResponseHeader = responseHeaders
        And def searchHouseholdResponseBody = response
        And def Household = searchHouseholdResponseBody.Household
        * def createHouseholdResponseBody = searchHouseholdResponseBody
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')

    @searchHouseholdWithClientReferenceId
    Scenario: Search a household for a HCM campaign with clientReferenceId of household
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def searchHouseholdResponseHeader = responseHeaders
        And def searchHouseholdResponseBody = response
        And def Household = searchHouseholdResponseBody.Household
        * def createHouseholdResponseBody = searchHouseholdResponseBody
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')

    @searchHouseholdWithBoundaryCode
    Scenario: Search a household for a HCM campaign with boundaryCode of household
        Given url searchHouseholdURL
        * def requestBody = searchHouseholdRequest.searchWithBoundaryCode
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def searchHouseholdResponseHeader = responseHeaders
        And def searchHouseholdResponseBody = response
        And def Household = searchHouseholdResponseBody.Household
        * def createHouseholdResponseBody = searchHouseholdResponseBody
        * call read('../../health-services/pretest/householdServicePretest.feature@SuccessHouseholdSchemaValidation')