Feature: HCM Individual API

    Background:

        * def createIndividualRequest = read('../../health-services/requestPayload/individual-service/create.json')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

    @SuccessIndividualSchemaValidation
    Scenario: Validate success response schemd for household API
        # response schema validations
        * match createIndividualResponseBody.Individual == '#array'
        * match createIndividualResponseBody.Individual[0].id == '#present'
        * match createIndividualResponseBody.Individual[0].id != null
        * match createIndividualResponseBody.Individual[0].id == '#string'
        * match createIndividualResponseBody.Individual[0].tenantId == '#string'
        * match createIndividualResponseBody.Individual[0].tenantId == '#present'
        * match createIndividualResponseBody.Individual[0].tenantId != null
        * match createIndividualResponseBody.Individual[0].clientReferenceId == '#present'
        * match createIndividualResponseBody.Individual[0].userId == '#present'
        * match createIndividualResponseBody.Individual[0].name == '#object'
        * match createIndividualResponseBody.Individual[0].name == '#present'
        * match createIndividualResponseBody.Individual[0].name != null
        * match createIndividualResponseBody.Individual[0].name.givenName == '#present'
        * match createIndividualResponseBody.Individual[0].name.familyName == '#present'
        * match createIndividualResponseBody.Individual[0].name.otherNames == '#present'
        * match createIndividualResponseBody.Individual[0].dateOfBirth == '#present'
        * match createIndividualResponseBody.Individual[0].gender == '#present'
        * match createIndividualResponseBody.Individual[0].bloodGroup == '#present'
        * match createIndividualResponseBody.Individual[0].mobileNumber == '#present'
        * match createIndividualResponseBody.Individual[0].altContactNumber == '#present'
        * match createIndividualResponseBody.Individual[0].email == '#present'
        * match createIndividualResponseBody.Individual[0].address == '#array'
        * match createIndividualResponseBody.Individual[0].address == '#present'
        * match createIndividualResponseBody.Individual[0].address != null
        * match createIndividualResponseBody.Individual[0].address[0].id == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].id != null
        * match createIndividualResponseBody.Individual[0].address[0].id == '#string'
        * match createIndividualResponseBody.Individual[0].address[0].tenantId == '#string'
        * match createIndividualResponseBody.Individual[0].address[0].doorNo == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].type == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].addressLine1 == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].addressLine2 == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].landmark == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].city == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].buildingName == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].street == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].locality.code == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].locality.name == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].locality.label == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].locality.latitude == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].locality.longitude == '#present'
        * match createIndividualResponseBody.Individual[0].address[0].isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual[0].address[0].rowVersion == '#number'
        * match createIndividualResponseBody.Individual[0].fatherName == '#present'
        * match createIndividualResponseBody.Individual[0].husbandName == '#present'
        * match createIndividualResponseBody.Individual[0].identifiers == '#array'
        * match createIndividualResponseBody.Individual[0].identifiers == '#present'
        * match createIndividualResponseBody.Individual[0].identifiers != null
        * match createIndividualResponseBody.Individual[0].identifiers[0].id == '#present'
        * match createIndividualResponseBody.Individual[0].identifiers[0].id != null
        * match createIndividualResponseBody.Individual[0].identifiers[0].id == '#string'
        * match createIndividualResponseBody.Individual[0].identifiers[0].individualId == '#string'
        * match createIndividualResponseBody.Individual[0].identifiers[0].individualId != null
        * match createIndividualResponseBody.Individual[0].identifiers[0].identifierType == '#present'
        * match createIndividualResponseBody.Individual[0].identifiers[0].identifierId == '#present'
        * match createIndividualResponseBody.Individual[0].identifiers[0].identifierId != null
        * match createIndividualResponseBody.Individual[0].identifiers[0].isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual[0].identifiers[0].rowVersion == '#number'
        * match createIndividualResponseBody.Individual[0].identifiers[0].isDeleted == '#present'
        * match createIndividualResponseBody.Individual[0].identifiers[0].rowVersion == '#present'
        * match createIndividualResponseBody.Individual[0].photo == '#present'
        * match createIndividualResponseBody.Individual[0].isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual[0].rowVersion == '#number'
        * match createIndividualResponseBody.Individual[0].isDeleted == '#present'
        * match createIndividualResponseBody.Individual[0].rowVersion == '#present'
        * match createIndividualResponseBody.Individual[0].auditDetails == '#object'
        * match createIndividualResponseBody.Individual[0].auditDetails.createdBy == '#present'
        * match createIndividualResponseBody.Individual[0].auditDetails.createdBy != null
        * match createIndividualResponseBody.Individual[0].auditDetails.createdBy == '#string'
        * match createIndividualResponseBody.Individual[0].auditDetails.lastModifiedBy == '#present'
        * match createIndividualResponseBody.Individual[0].auditDetails.lastModifiedBy != null
        * match createIndividualResponseBody.Individual[0].auditDetails.lastModifiedBy == '#string'
        * match createIndividualResponseBody.Individual[0].auditDetails.createdTime == '#present'
        * match createIndividualResponseBody.Individual[0].auditDetails.createdTime != null
        * match createIndividualResponseBody.Individual[0].auditDetails.createdTime == '#number'
        * match createIndividualResponseBody.Individual[0].auditDetails.lastModifiedTime == '#present'
        * match createIndividualResponseBody.Individual[0].auditDetails.lastModifiedTime != null
        * match createIndividualResponseBody.Individual[0].auditDetails.lastModifiedTime == '#number'

    @createIndividualSuccess
    Scenario: Create an Individual for a HCM campaign
        Given url createIndividualURL
        And request createIndividualRequest
        When method post
        Then status 202
        And def createIndividualResponseHeader = responseHeaders
        And def createIndividualResponseBody = response
        And def Individual = createIndividualResponseBody.Individual
        * call read('../../health-services/pretest/individualServicePretest.feature@SuccessIndividualSchemaValidation')

    @createIndividualNotAuthorizedError
    Scenario: Create individual error
        Given url createIndividualURL
        And request createIndividualRequest
        When method post
        Then status 403
        And def createIndividualResponseHeader = responseHeaders
        And def createIndividualResponseBody = response

    @createIndividualError
    Scenario: Create individual error
        Given url createIndividualURL
        And request createIndividualRequest
        When method post
        Then status 400
        And def createIndividualResponseHeader = responseHeaders
        And def createIndividualResponseBody = response

    @searchIndividualSuccessfully
    Scenario: Search individual successfully
        Given url searchIndividualURL
        And param clientReferenceId = '#(hcmClientReferenceId)'
        And request searchIndividualRequest
        When method post
        Then status 200
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response

    @searchInividualSuccessfullyWithoutClientReferenceId
    Scenario: Search individual successfully without passing clientReferenceId
        Given url hrmsSearchUrl
        And param tenantId = tenantId
        And request searchIndividualRequest
        When method post
        Then status 200
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response
        * def individual1 = hrmsResponseBody.Individual[0].code
        * def individual2 = hrmsResponseBody.Individual[1].code

    @searchIndividualSuccessfullyWithMultipleClientReferenceId
    Scenario: Search individual successfully by passing multiple client reference id's
        * def parameters =
            """
            {
            tenantId: '#(tenantId)',
            clientreferenceid: '#(clientreferenceid)'
            }
            """
        Given url hrmsSearchUrl
        And params parameters
        And request searchIndividualRequest
        When method post
        Then status 200
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response

    @searchIndividualError
    Scenario: Search individual error
        Given url hrmsSearchUrl
        And param names = '#(name)'
        And request searchIndividualRequest
        When method post
        Then status 400
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response


    @searchWithInvalidTenantId
    Scenario: Search individual with Invalid tenant id
        Given url hrmsSearchUrl
        And param tenantId = '#(tenantId)'
        And request searchEmployeeRequest
        When method post
        Then status 403
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response

    @updateIndividualSuccessfully
    Scenario: Update individual successfully
        * eval updateIndividualRequest.Individual = Individual
        Given url hrmsUpdateUrl
        And request updateIndividualRequest
        When method post
        Then status 202
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response

    @updateIndividualError
    Scenario: Update individual error
        * eval updateIndividualRequest.Individual = Individual
        Given url hrmsUpdateUrl
        And request updateIndividualRequest
        When method post
        Then status 400
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response

    @updateIndividualWithInvalidTenantId
    Scenario: Error in update individual for invalid tenant Id
        * eval updateIndividualRequest.Individual = Individual
        Given url hrmsUpdateUrl
        And request updateIndividualRequest
        When method post
        Then status 403
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response

    @deactivateIndividualSuccessfully
    Scenario: Deactivate successfully
        * eval updateIndividualRequest.Individual = Individual
        * eval updateIndividualRequest.Individual[0].deactivationDetails = updateDeactivatindividualRequest.deactivationDetails
        * eval updateIndividualRequest.Individual[0].isActive = false
        * eval updateIndividualRequest.Individual[0].reActivateIndividual = false
        Given url hrmsUpdateUrl
        And request updateIndividualRequest
        When method post
        Then status 202
        And def hrmsResponseHeader = responseHeaders
        And def hrmsResponseBody = response


