Feature: HCM Individual API

    Background:

        * def createIndividualRequest = read('../../health-services/requestPayload/individual-service/create.json')
        * def searchIndividualRequest = read('../../health-services/requestPayload/individual-service/search.json')
        * def updateIndividualRequest = read('../../health-services/requestPayload/individual-service/update.json')
        * def deleteIndividualRequest = read('../../health-services/requestPayload/individual-service/delete.json')
        * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

    @SuccessIndividualSchemaValidation
    Scenario: Validate success response schemd for individual API
        # response schema validations
        * match createIndividualResponseBody.Individual == '#object'
        * match createIndividualResponseBody.Individual == '#present'
        * match createIndividualResponseBody.Individual.id == '#present'
        * match createIndividualResponseBody.Individual.id != null
        * match createIndividualResponseBody.Individual.id == '#string'
        * match createIndividualResponseBody.Individual.tenantId == '#string'
        * match createIndividualResponseBody.Individual.tenantId == '#present'
        * match createIndividualResponseBody.Individual.tenantId != null
        * match createIndividualResponseBody.Individual.clientReferenceId == '#present'
        * match createIndividualResponseBody.Individual.userId == '#present'
        * match createIndividualResponseBody.Individual.name == '#object'
        * match createIndividualResponseBody.Individual.name == '#present'
        * match createIndividualResponseBody.Individual.name != null
        * match createIndividualResponseBody.Individual.name.givenName == '#present'
        * match createIndividualResponseBody.Individual.name.familyName == '#present'
        * match createIndividualResponseBody.Individual.name.otherNames == '#present'
        * match createIndividualResponseBody.Individual.dateOfBirth == '#present'
        * match createIndividualResponseBody.Individual.gender == '#present'
        * match createIndividualResponseBody.Individual.bloodGroup == '#present'
        * match createIndividualResponseBody.Individual.mobileNumber == '#present'
        * match createIndividualResponseBody.Individual.altContactNumber == '#present'
        * match createIndividualResponseBody.Individual.email == '#present'
        * match createIndividualResponseBody.Individual.address == '#array'
        * match createIndividualResponseBody.Individual.address == '#present'
        * match createIndividualResponseBody.Individual.address != null
        * match createIndividualResponseBody.Individual.address[0].clientReferenceId == '#present'
        * match createIndividualResponseBody.Individual.address[0].id == '#present'
        * match createIndividualResponseBody.Individual.address[0].id != null
        * match createIndividualResponseBody.Individual.address[0].id == '#string'
        * match createIndividualResponseBody.Individual.address[0].tenantId == '#string'
        * match createIndividualResponseBody.Individual.address[0].doorNo == '#present'
        * match createIndividualResponseBody.Individual.address[0].type == '#present'
        * match createIndividualResponseBody.Individual.address[0].addressLine1 == '#present'
        * match createIndividualResponseBody.Individual.address[0].addressLine2 == '#present'
        * match createIndividualResponseBody.Individual.address[0].landmark == '#present'
        * match createIndividualResponseBody.Individual.address[0].city == '#present'
        * match createIndividualResponseBody.Individual.address[0].buildingName == '#present'
        * match createIndividualResponseBody.Individual.address[0].street == '#present'
        * match createIndividualResponseBody.Individual.address[0].locality.code == '#present'
        * match createIndividualResponseBody.Individual.address[0].locality.name == '#present'
        * match createIndividualResponseBody.Individual.address[0].locality.label == '#present'
        * match createIndividualResponseBody.Individual.address[0].locality.latitude == '#present'
        * match createIndividualResponseBody.Individual.address[0].locality.longitude == '#present'
        * match createIndividualResponseBody.Individual.address[0].isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual.fatherName == '#present'
        * match createIndividualResponseBody.Individual.husbandName == '#present'
        * match createIndividualResponseBody.Individual.identifiers == '#array'
        * match createIndividualResponseBody.Individual.identifiers == '#present'
        * match createIndividualResponseBody.Individual.identifiers != null
        * match createIndividualResponseBody.Individual.identifiers[0].id == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].id != null
        * match createIndividualResponseBody.Individual.identifiers[0].id == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].clientReferenceId == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].clientReferenceId != null
        * match createIndividualResponseBody.Individual.identifiers[0].clientReferenceId == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].individualId == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].individualId == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].individualId != null
        * match createIndividualResponseBody.Individual.identifiers[0].identifierType == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].identifierType != null
        * match createIndividualResponseBody.Individual.identifiers[0].identifierType == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].identifierId == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].identifierId == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].identifierId != null
        * match createIndividualResponseBody.Individual.identifiers[0].isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual.identifiers[0].isDeleted == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails == '#object'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.createdBy == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.createdBy != null
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.createdBy == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.lastModifiedBy == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.lastModifiedBy != null
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.lastModifiedBy == '#string'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.createdTime == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.createdTime != null
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.createdTime == '#number'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.lastModifiedTime == '#present'
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.lastModifiedTime != null
        * match createIndividualResponseBody.Individual.identifiers[0].auditDetails.lastModifiedTime == '#number'
        * match createIndividualResponseBody.Individual.skills == '#array'
        * match createIndividualResponseBody.Individual.skills == '#present'
        * match createIndividualResponseBody.Individual.skills != null
        * match createIndividualResponseBody.Individual.skills[0].id == '#present'
        * match createIndividualResponseBody.Individual.skills[0].id != null
        * match createIndividualResponseBody.Individual.skills[0].id == '#string'
        * match createIndividualResponseBody.Individual.skills[0].clientReferenceId == '#present'
        * match createIndividualResponseBody.Individual.skills[0].clientReferenceId != null
        * match createIndividualResponseBody.Individual.skills[0].clientReferenceId == '#string'
        * match createIndividualResponseBody.Individual.skills[0].individualId == '#present'
        * match createIndividualResponseBody.Individual.skills[0].individualId == '#string'
        * match createIndividualResponseBody.Individual.skills[0].individualId != null
        * match createIndividualResponseBody.Individual.skills[0].type == '#present'
        * match createIndividualResponseBody.Individual.skills[0].type == '#string'
        * match createIndividualResponseBody.Individual.skills[0].type != null
        * match createIndividualResponseBody.Individual.skills[0].level == '#present'
        * match createIndividualResponseBody.Individual.skills[0].level == '#string'
        * match createIndividualResponseBody.Individual.skills[0].level != null
        * match createIndividualResponseBody.Individual.skills[0].experience == '#present'
        * match createIndividualResponseBody.Individual.skills[0].experience == '#string'
        * match createIndividualResponseBody.Individual.skills[0].experience != null
        * match createIndividualResponseBody.Individual.skills[0].isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual.skills[0].isDeleted == '#present'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails == '#object'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.createdBy == '#present'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.createdBy != null
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.createdBy == '#string'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.lastModifiedBy == '#present'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.lastModifiedBy != null
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.lastModifiedBy == '#string'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.createdTime == '#present'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.createdTime != null
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.createdTime == '#number'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.lastModifiedTime == '#present'
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.lastModifiedTime != null
        * match createIndividualResponseBody.Individual.skills[0].auditDetails.lastModifiedTime == '#number'
        * match createIndividualResponseBody.Individual.photo == '#present'
        * match createIndividualResponseBody.Individual.isDeleted == '#boolean'
        * match createIndividualResponseBody.Individual.rowVersion == '#number'
        * match createIndividualResponseBody.Individual.isDeleted == '#present'
        * match createIndividualResponseBody.Individual.rowVersion == '#present'
        * match createIndividualResponseBody.Individual.auditDetails == '#object'
        * match createIndividualResponseBody.Individual.auditDetails.createdBy == '#present'
        * match createIndividualResponseBody.Individual.auditDetails.createdBy != null
        * match createIndividualResponseBody.Individual.auditDetails.createdBy == '#string'
        * match createIndividualResponseBody.Individual.auditDetails.lastModifiedBy == '#present'
        * match createIndividualResponseBody.Individual.auditDetails.lastModifiedBy != null
        * match createIndividualResponseBody.Individual.auditDetails.lastModifiedBy == '#string'
        * match createIndividualResponseBody.Individual.auditDetails.createdTime == '#present'
        * match createIndividualResponseBody.Individual.auditDetails.createdTime != null
        * match createIndividualResponseBody.Individual.auditDetails.createdTime == '#number'
        * match createIndividualResponseBody.Individual.auditDetails.lastModifiedTime == '#present'
        * match createIndividualResponseBody.Individual.auditDetails.lastModifiedTime != null
        * match createIndividualResponseBody.Individual.auditDetails.lastModifiedTime == '#number'

    @successIndividualSearchSchemaValidation
    Scenario: Validate success response schema for individual API which returns a individual array
        # response schema validations
        * match individualResponseBody.Individual == '#array'
        * match individualResponseBody.Individual == '#present'
        * match individualResponseBody.Individual[0].id == '#present'
        * match individualResponseBody.Individual[0].id != null
        * match individualResponseBody.Individual[0].id == '#string'
        * match individualResponseBody.Individual[0].tenantId == '#string'
        * match individualResponseBody.Individual[0].tenantId == '#present'
        * match individualResponseBody.Individual[0].tenantId != null
        * match individualResponseBody.Individual[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].userId == '#present'
        * match individualResponseBody.Individual[0].name == '#object'
        * match individualResponseBody.Individual[0].name == '#present'
        * match individualResponseBody.Individual[0].name != null
        * match individualResponseBody.Individual[0].name.givenName == '#present'
        * match individualResponseBody.Individual[0].name.familyName == '#present'
        * match individualResponseBody.Individual[0].name.otherNames == '#present'
        * match individualResponseBody.Individual[0].dateOfBirth == '#present'
        * match individualResponseBody.Individual[0].gender == '#present'
        * match individualResponseBody.Individual[0].bloodGroup == '#present'
        * match individualResponseBody.Individual[0].mobileNumber == '#present'
        * match individualResponseBody.Individual[0].altContactNumber == '#present'
        * match individualResponseBody.Individual[0].email == '#present'
        * match individualResponseBody.Individual[0].address == '#array'
        * match individualResponseBody.Individual[0].address == '#present'
        * match individualResponseBody.Individual[0].address != null
        * match individualResponseBody.Individual[0].address[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].address[0].id == '#present'
        * match individualResponseBody.Individual[0].address[0].id != null
        * match individualResponseBody.Individual[0].address[0].id == '#string'
        * match individualResponseBody.Individual[0].address[0].tenantId == '#string'
        * match individualResponseBody.Individual[0].address[0].doorNo == '#present'
        * match individualResponseBody.Individual[0].address[0].type == '#present'
        * match individualResponseBody.Individual[0].address[0].addressLine1 == '#present'
        * match individualResponseBody.Individual[0].address[0].addressLine2 == '#present'
        * match individualResponseBody.Individual[0].address[0].landmark == '#present'
        * match individualResponseBody.Individual[0].address[0].city == '#present'
        * match individualResponseBody.Individual[0].address[0].buildingName == '#present'
        * match individualResponseBody.Individual[0].address[0].street == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.code == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.name == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.label == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.latitude == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.longitude == '#present'
        * match individualResponseBody.Individual[0].address[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].fatherName == '#present'
        * match individualResponseBody.Individual[0].husbandName == '#present'
        * match individualResponseBody.Individual[0].identifiers == '#array'
        * match individualResponseBody.Individual[0].identifiers == '#present'
        * match individualResponseBody.Individual[0].identifiers != null
        * match individualResponseBody.Individual[0].identifiers[0].id == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].id != null
        * match individualResponseBody.Individual[0].identifiers[0].id == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].clientReferenceId != null
        * match individualResponseBody.Individual[0].identifiers[0].clientReferenceId == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].individualId == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].individualId == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].individualId != null
        * match individualResponseBody.Individual[0].identifiers[0].identifierType == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].identifierType != null
        * match individualResponseBody.Individual[0].identifiers[0].identifierType == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].identifierId == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].identifierId == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].identifierId != null
        * match individualResponseBody.Individual[0].identifiers[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].identifiers[0].isDeleted == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails == '#object'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[0].skills == '#array'
        * match individualResponseBody.Individual[0].skills == '#present'
        * match individualResponseBody.Individual[0].skills != null
        * match individualResponseBody.Individual[0].skills[0].id == '#present'
        * match individualResponseBody.Individual[0].skills[0].id != null
        * match individualResponseBody.Individual[0].skills[0].id == '#string'
        * match individualResponseBody.Individual[0].skills[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].skills[0].clientReferenceId != null
        * match individualResponseBody.Individual[0].skills[0].clientReferenceId == '#string'
        * match individualResponseBody.Individual[0].skills[0].individualId == '#present'
        * match individualResponseBody.Individual[0].skills[0].individualId == '#string'
        * match individualResponseBody.Individual[0].skills[0].individualId != null
        * match individualResponseBody.Individual[0].skills[0].type == '#present'
        * match individualResponseBody.Individual[0].skills[0].type == '#string'
        * match individualResponseBody.Individual[0].skills[0].type != null
        * match individualResponseBody.Individual[0].skills[0].level == '#present'
        * match individualResponseBody.Individual[0].skills[0].level == '#string'
        * match individualResponseBody.Individual[0].skills[0].level != null
        * match individualResponseBody.Individual[0].skills[0].experience == '#present'
        * match individualResponseBody.Individual[0].skills[0].experience == '#string'
        * match individualResponseBody.Individual[0].skills[0].experience != null
        * match individualResponseBody.Individual[0].skills[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].skills[0].isDeleted == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails == '#object'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[0].photo == '#present'
        * match individualResponseBody.Individual[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].rowVersion == '#number'
        * match individualResponseBody.Individual[0].isDeleted == '#present'
        * match individualResponseBody.Individual[0].rowVersion == '#present'
        * match individualResponseBody.Individual[0].auditDetails == '#object'
        * match individualResponseBody.Individual[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedTime == '#number'

    @successIndividualBulkSearchSchemaValidation
    Scenario: Validate success response schema for individual API which returns a individual array
        # response schema validations
        * match individualResponseBody.Individual == '#array'
        * match individualResponseBody.Individual == '#present'
        * match individualResponseBody.Individual[0].id == '#present'
        * match individualResponseBody.Individual[0].id != null
        * match individualResponseBody.Individual[0].id == '#string'
        * match individualResponseBody.Individual[0].tenantId == '#string'
        * match individualResponseBody.Individual[0].tenantId == '#present'
        * match individualResponseBody.Individual[0].tenantId != null
        * match individualResponseBody.Individual[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].userId == '#present'
        * match individualResponseBody.Individual[0].name == '#object'
        * match individualResponseBody.Individual[0].name == '#present'
        * match individualResponseBody.Individual[0].name != null
        * match individualResponseBody.Individual[0].name.givenName == '#present'
        * match individualResponseBody.Individual[0].name.familyName == '#present'
        * match individualResponseBody.Individual[0].name.otherNames == '#present'
        * match individualResponseBody.Individual[0].dateOfBirth == '#present'
        * match individualResponseBody.Individual[0].gender == '#present'
        * match individualResponseBody.Individual[0].bloodGroup == '#present'
        * match individualResponseBody.Individual[0].mobileNumber == '#present'
        * match individualResponseBody.Individual[0].altContactNumber == '#present'
        * match individualResponseBody.Individual[0].email == '#present'
        * match individualResponseBody.Individual[0].address == '#array'
        * match individualResponseBody.Individual[0].address == '#present'
        * match individualResponseBody.Individual[0].address != null
        * match individualResponseBody.Individual[0].address[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].address[0].id == '#present'
        * match individualResponseBody.Individual[0].address[0].id != null
        * match individualResponseBody.Individual[0].address[0].id == '#string'
        * match individualResponseBody.Individual[0].address[0].tenantId == '#string'
        * match individualResponseBody.Individual[0].address[0].doorNo == '#present'
        * match individualResponseBody.Individual[0].address[0].type == '#present'
        * match individualResponseBody.Individual[0].address[0].addressLine1 == '#present'
        * match individualResponseBody.Individual[0].address[0].addressLine2 == '#present'
        * match individualResponseBody.Individual[0].address[0].landmark == '#present'
        * match individualResponseBody.Individual[0].address[0].city == '#present'
        * match individualResponseBody.Individual[0].address[0].buildingName == '#present'
        * match individualResponseBody.Individual[0].address[0].street == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.code == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.name == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.label == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.latitude == '#present'
        * match individualResponseBody.Individual[0].address[0].locality.longitude == '#present'
        * match individualResponseBody.Individual[0].address[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].fatherName == '#present'
        * match individualResponseBody.Individual[0].husbandName == '#present'
        * match individualResponseBody.Individual[0].identifiers == '#array'
        * match individualResponseBody.Individual[0].identifiers == '#present'
        * match individualResponseBody.Individual[0].identifiers != null
        * match individualResponseBody.Individual[0].identifiers[0].id == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].id != null
        * match individualResponseBody.Individual[0].identifiers[0].id == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].clientReferenceId != null
        * match individualResponseBody.Individual[0].identifiers[0].clientReferenceId == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].individualId == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].individualId == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].individualId != null
        * match individualResponseBody.Individual[0].identifiers[0].identifierType == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].identifierType != null
        * match individualResponseBody.Individual[0].identifiers[0].identifierType == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].identifierId == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].identifierId == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].identifierId != null
        * match individualResponseBody.Individual[0].identifiers[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].identifiers[0].isDeleted == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails == '#object'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[0].identifiers[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[0].skills == '#array'
        * match individualResponseBody.Individual[0].skills == '#present'
        * match individualResponseBody.Individual[0].skills != null
        * match individualResponseBody.Individual[0].skills[0].id == '#present'
        * match individualResponseBody.Individual[0].skills[0].id != null
        * match individualResponseBody.Individual[0].skills[0].id == '#string'
        * match individualResponseBody.Individual[0].skills[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[0].skills[0].clientReferenceId != null
        * match individualResponseBody.Individual[0].skills[0].clientReferenceId == '#string'
        * match individualResponseBody.Individual[0].skills[0].individualId == '#present'
        * match individualResponseBody.Individual[0].skills[0].individualId == '#string'
        * match individualResponseBody.Individual[0].skills[0].individualId != null
        * match individualResponseBody.Individual[0].skills[0].type == '#present'
        * match individualResponseBody.Individual[0].skills[0].type == '#string'
        * match individualResponseBody.Individual[0].skills[0].type != null
        * match individualResponseBody.Individual[0].skills[0].level == '#present'
        * match individualResponseBody.Individual[0].skills[0].level == '#string'
        * match individualResponseBody.Individual[0].skills[0].level != null
        * match individualResponseBody.Individual[0].skills[0].experience == '#present'
        * match individualResponseBody.Individual[0].skills[0].experience == '#string'
        * match individualResponseBody.Individual[0].skills[0].experience != null
        * match individualResponseBody.Individual[0].skills[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].skills[0].isDeleted == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails == '#object'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[0].skills[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[0].photo == '#present'
        * match individualResponseBody.Individual[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[0].rowVersion == '#number'
        * match individualResponseBody.Individual[0].isDeleted == '#present'
        * match individualResponseBody.Individual[0].rowVersion == '#present'
        * match individualResponseBody.Individual[0].auditDetails == '#object'
        * match individualResponseBody.Individual[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[1] == '#present'
        * match individualResponseBody.Individual[1].id == '#present'
        * match individualResponseBody.Individual[1].id != null
        * match individualResponseBody.Individual[1].id == '#string'
        * match individualResponseBody.Individual[1].tenantId == '#string'
        * match individualResponseBody.Individual[1].tenantId == '#present'
        * match individualResponseBody.Individual[1].tenantId != null
        * match individualResponseBody.Individual[1].clientReferenceId == '#present'
        * match individualResponseBody.Individual[1].userId == '#present'
        * match individualResponseBody.Individual[1].name == '#object'
        * match individualResponseBody.Individual[1].name == '#present'
        * match individualResponseBody.Individual[1].name != null
        * match individualResponseBody.Individual[1].name.givenName == '#present'
        * match individualResponseBody.Individual[1].name.familyName == '#present'
        * match individualResponseBody.Individual[1].name.otherNames == '#present'
        * match individualResponseBody.Individual[1].dateOfBirth == '#present'
        * match individualResponseBody.Individual[1].gender == '#present'
        * match individualResponseBody.Individual[1].bloodGroup == '#present'
        * match individualResponseBody.Individual[1].mobileNumber == '#present'
        * match individualResponseBody.Individual[1].altContactNumber == '#present'
        * match individualResponseBody.Individual[1].email == '#present'
        * match individualResponseBody.Individual[1].address == '#array'
        * match individualResponseBody.Individual[1].address == '#present'
        * match individualResponseBody.Individual[1].address != null
        * match individualResponseBody.Individual[1].address[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[1].address[0].id == '#present'
        * match individualResponseBody.Individual[1].address[0].id != null
        * match individualResponseBody.Individual[1].address[0].id == '#string'
        * match individualResponseBody.Individual[1].address[0].tenantId == '#string'
        * match individualResponseBody.Individual[1].address[0].doorNo == '#present'
        * match individualResponseBody.Individual[1].address[0].type == '#present'
        * match individualResponseBody.Individual[1].address[0].addressLine1 == '#present'
        * match individualResponseBody.Individual[1].address[0].addressLine2 == '#present'
        * match individualResponseBody.Individual[1].address[0].landmark == '#present'
        * match individualResponseBody.Individual[1].address[0].city == '#present'
        * match individualResponseBody.Individual[1].address[0].buildingName == '#present'
        * match individualResponseBody.Individual[1].address[0].street == '#present'
        * match individualResponseBody.Individual[1].address[0].locality.code == '#present'
        * match individualResponseBody.Individual[1].address[0].locality.name == '#present'
        * match individualResponseBody.Individual[1].address[0].locality.label == '#present'
        * match individualResponseBody.Individual[1].address[0].locality.latitude == '#present'
        * match individualResponseBody.Individual[1].address[0].locality.longitude == '#present'
        * match individualResponseBody.Individual[1].address[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[1].fatherName == '#present'
        * match individualResponseBody.Individual[1].husbandName == '#present'
        * match individualResponseBody.Individual[1].identifiers == '#array'
        * match individualResponseBody.Individual[1].identifiers == '#present'
        * match individualResponseBody.Individual[1].identifiers != null
        * match individualResponseBody.Individual[1].identifiers[0].id == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].id != null
        * match individualResponseBody.Individual[1].identifiers[0].id == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].clientReferenceId != null
        * match individualResponseBody.Individual[1].identifiers[0].clientReferenceId == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].individualId == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].individualId == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].individualId != null
        * match individualResponseBody.Individual[1].identifiers[0].identifierType == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].identifierType != null
        * match individualResponseBody.Individual[1].identifiers[0].identifierType == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].identifierId == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].identifierId == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].identifierId != null
        * match individualResponseBody.Individual[1].identifiers[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[1].identifiers[0].isDeleted == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails == '#object'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[1].identifiers[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[1].skills == '#array'
        * match individualResponseBody.Individual[1].skills == '#present'
        * match individualResponseBody.Individual[1].skills != null
        * match individualResponseBody.Individual[1].skills[0].id == '#present'
        * match individualResponseBody.Individual[1].skills[0].id != null
        * match individualResponseBody.Individual[1].skills[0].id == '#string'
        * match individualResponseBody.Individual[1].skills[0].clientReferenceId == '#present'
        * match individualResponseBody.Individual[1].skills[0].clientReferenceId != null
        * match individualResponseBody.Individual[1].skills[0].clientReferenceId == '#string'
        * match individualResponseBody.Individual[1].skills[0].individualId == '#present'
        * match individualResponseBody.Individual[1].skills[0].individualId == '#string'
        * match individualResponseBody.Individual[1].skills[0].individualId != null
        * match individualResponseBody.Individual[1].skills[0].type == '#present'
        * match individualResponseBody.Individual[1].skills[0].type == '#string'
        * match individualResponseBody.Individual[1].skills[0].type != null
        * match individualResponseBody.Individual[1].skills[0].level == '#present'
        * match individualResponseBody.Individual[1].skills[0].level == '#string'
        * match individualResponseBody.Individual[1].skills[0].level != null
        * match individualResponseBody.Individual[1].skills[0].experience == '#present'
        * match individualResponseBody.Individual[1].skills[0].experience == '#string'
        * match individualResponseBody.Individual[1].skills[0].experience != null
        * match individualResponseBody.Individual[1].skills[0].isDeleted == '#boolean'
        * match individualResponseBody.Individual[1].skills[0].isDeleted == '#present'
        * match individualResponseBody.Individual[1].skills[0].auditDetails == '#object'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.createdBy != null
        * match individualResponseBody.Individual[1].skills[0].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[1].skills[0].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.createdTime != null
        * match individualResponseBody.Individual[1].skills[0].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[1].skills[0].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[1].skills[0].auditDetails.lastModifiedTime == '#number'
        * match individualResponseBody.Individual[1].photo == '#present'
        * match individualResponseBody.Individual[1].isDeleted == '#boolean'
        * match individualResponseBody.Individual[1].rowVersion == '#number'
        * match individualResponseBody.Individual[1].isDeleted == '#present'
        * match individualResponseBody.Individual[1].rowVersion == '#present'
        * match individualResponseBody.Individual[1].auditDetails == '#object'
        * match individualResponseBody.Individual[1].auditDetails.createdBy == '#present'
        * match individualResponseBody.Individual[1].auditDetails.createdBy != null
        * match individualResponseBody.Individual[1].auditDetails.createdBy == '#string'
        * match individualResponseBody.Individual[1].auditDetails.lastModifiedBy == '#present'
        * match individualResponseBody.Individual[1].auditDetails.lastModifiedBy != null
        * match individualResponseBody.Individual[1].auditDetails.lastModifiedBy == '#string'
        * match individualResponseBody.Individual[1].auditDetails.createdTime == '#present'
        * match individualResponseBody.Individual[1].auditDetails.createdTime != null
        * match individualResponseBody.Individual[1].auditDetails.createdTime == '#number'
        * match individualResponseBody.Individual[1].auditDetails.lastModifiedTime == '#present'
        * match individualResponseBody.Individual[1].auditDetails.lastModifiedTime != null
        * match individualResponseBody.Individual[1].auditDetails.lastModifiedTime == '#number'

    @individualErrorResponseSchemaValidations
    Scenario: Schema validation for individual API error Scenario
        # response schema validations
        * match individualResponseBody.Errors == '#array'
        * match individualResponseBody.Errors[0].code == '#present'
        * match individualResponseBody.Errors[0].code != null
        * match individualResponseBody.Errors[0].code == '#string'
        * match individualResponseBody.Errors[0].message == '#present'
        * match individualResponseBody.Errors[0].message != null
        * match individualResponseBody.Errors[0].message == '#string'
        * match individualResponseBody.Errors[0].description == '#present'
        * match individualResponseBody.Errors[0].params == '#present'

    @bulkIndividualSuccessSchemaValidation
    Scenario: Validate the schema for the successful creation of individual with bulk API
        # response schema validations
        * match individualResponseBody.apiId == '#present'
        * match individualResponseBody.ver == '#present'
        * match individualResponseBody.ts == '#present'
        * match individualResponseBody.resMsgId == '#present'
        * match individualResponseBody.msgId == '#present'
        * match individualResponseBody.status == '#present'

    @createIndividualSuccess
    Scenario: Create an Individual for a HCM campaign
        Given url createIndividualURL
        And request createIndividualRequest.individualCreateBody
        When method post
        Then status 202
        And def createIndividualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@SuccessIndividualSchemaValidation')

    @createIndividualNotAuthorizedError
    Scenario: Create individual error
        Given url createIndividualURL
        And request createIndividualRequest.individualCreateBody
        When method post
        Then status 403
        And def createIndividualResponseBody = response

    @createIndividualError
    Scenario: Create individual error
        Given url createIndividualURL
        And request createIndividualRequest.individualCreateBody
        When method post
        Then status 400
        And def createIndividualResponseBody = response

    @searchIndividualWithoutQueryParamsSchemaValidation
    Scenario: Search individual without query params schema validations
        # response schema validations
        * match searchIndividualResponseBody.Errors == '#array'
        * match searchIndividualResponseBody.Errors[0].code == '#present'
        * match searchIndividualResponseBody.Errors[0].code == '#string'
        * match searchIndividualResponseBody.Errors[0].message == '#present'
        * match searchIndividualResponseBody.Errors[0].message != null
        * match searchIndividualResponseBody.Errors[0].message == '#string'
        * match searchIndividualResponseBody.Errors[0].description == '#present'
        * match searchIndividualResponseBody.Errors[0].params == '#present'

    @searchIndividualWithIdWithoutQueryParams
    Scenario: Search individual for a HCM campaign with id of individual and without query parameters
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithId
        And request requestBody
        When method post
        Then status 400
        And def searchIndividualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithoutQueryParamsSchemaValidation')

    @searchByIndividualIdWithQueryParamsError
    Scenario: Search individual by passing query params and get 400 as reponse code.
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithId
        And params parameters
        And request requestBody
        When method post
        Then status 400
        And def searchIndividualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@searchIndividualWithoutQueryParamsSchemaValidation')

    @searchIndividualWithId
    Scenario: Search individual for a HCM campaign with id of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithId
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithClientReferenceId
    Scenario: Search individual for a HCM campaign with a single clientReferenceId of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithMultipleClientReferenceId
    Scenario: Search individual for a HCM campaign with multiple clientReferenceId of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithMultipleClientReferenceId
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@successIndividualBulkSearchSchemaValidation')

    @searchIndividualWithName
    Scenario: Search individual for a HCM campaign with name of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithName
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithDateOfBirth
    Scenario: Search individual for a HCM campaign with dateOfBirth of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithDateOfBirth
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def individualResponseBody = response
    #* call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithGender
    Scenario: Search individual for a HCM campaign with gender of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithGender
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def individualResponseBody = response
    #* call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithIdentifier
    Scenario: Search individual for a HCM campaign with identifier of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithIdentifier
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def individualResponseBody = response
    #* call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithBoundaryCode
    Scenario: Search individual for a HCM campaign with boundaryCode of individual
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithBoundaryCode
        And request requestBody
        And params parameters
        When method post
        Then status 200
        And def individualResponseBody = response
    #* call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @searchIndividualWithAllCriteria
    Scenario: Search individual for a HCM campaign with all criteria
        Given url searchIndividualURL
        * def requestBody = searchIndividualRequest.searchWithAllCriteria
        And params parameters
        And request requestBody
        When method post
        Then status 200
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@successIndividualSearchSchemaValidation')

    @updateIndividualFailure
    Scenario: Update an existing individual for a HCM campaign and get a 400 response code
        Given url updateIndividualURL
        And request updateIndividualRequest.individualUpdateBodyGeneric
        When method post
        Then status 400
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@individualErrorResponseSchemaValidations')

    @updateIndividualSuccess
    Scenario: Update an existing individual for a HCM campaign
        Given url updateIndividualURL
        And request updateIndividualRequest.individualUpdateBody
        When method post
        Then status 202
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@SuccessIndividualSchemaValidation')

    @deleteIndividualFailure
    Scenario: Delete an existing individual for a HCM campaign and get a 400 response code
        Given url deleteIndividualURL
        And request deleteIndividualRequest.individualDeleteBodyGeneric
        When method post
        Then status 400
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@individualErrorResponseSchemaValidations')

    @deleteIndividualSuccess
    Scenario: Deleting an existing individual for a HCM campaign
        Given url deleteIndividualURL
        And request deleteIndividualRequest.deleteIndividualRequestBody
        When method post
        Then status 202
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@SuccessIndividualSchemaValidation')

    @bulkCreateIndividualSuccess
    Scenario: Bulk create individuals for a HCM campaign
        Given url bulkCreateIndividualURL
        And def bulkIndividualRequest = createIndividualRequest.bulkIndividualCreateBody
        And request bulkIndividualRequest
        When method post
        Then status 202
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@bulkIndividualSuccessSchemaValidation')

    @bulkUpdateIndividualSuccess
    Scenario: Bulk update individuals for a HCM campaign
        Given url bulkUpdateIndividualURL
        And def bulkUpdateIndividualRequest = updateIndividualRequest.bulkIndividualUpdateBody
        And request bulkUpdateIndividualRequest
        When method post
        Then status 202
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@bulkIndividualSuccessSchemaValidation')

    @bulkDeleteIndividualSuccess
    Scenario: Bulk delete individuals for a HCM campaign
        Given url bulkDeleteIndividualURL
        And def bulkDeleteIndividualRequest = deleteIndividualRequest.bulkDeleteIndividualRequestBody
        And request bulkDeleteIndividualRequest
        When method post
        Then status 202
        And def individualResponseBody = response
        * call read('../../health-services/pretest/individualServicePretest.feature@bulkIndividualSuccessSchemaValidation')