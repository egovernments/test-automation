Feature: egf-Instrument Surrender Reasons service Tests

Background: 
    * def jsUtils = read('classpath:jsUtils.js')
    #egf-Instruments Constants file
    * def egfInstrumentConstants = read('../../business-services/constants/egfInstrument.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    #initializing request payload variables
    * def randomNameDescription = 'Surrender-Reason-' + randomString(20)
    * def surrenderReasonName = randomNameDescription
    * def surrenderReasonDescription = randomNameDescription
  
#Create Instrument Surrender Reasons Test Cases
@Surrenderreasons_create_01 @positive @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with valid request payload
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons[0].name == surrenderReasonName
    * match surrenderReasonsResponseBody.surrenderReasons[0].description == surrenderReasonDescription

@Surrenderreasons_createNameWithMaxCharacter_02 @positive @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with name equal to max characters(50)
    # setting reeust payload variable values
    * def surrenderReasonName = 'Surrender-Reason-' + randomString(33)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons[0].name == surrenderReasonName
    * match surrenderReasonsResponseBody.surrenderReasons[0].description == surrenderReasonDescription

@Surrenderreasons_createNameWithMoreThan50Characters_03 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with name more than max characters(50)
    # setting reeust payload variable values
    * def surrenderReasonName = 'Surrender-Reason-' + randomString(50)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.surrenderReasonNameSize

@Surrenderreasons_createDescriptionWithMoreThan250Characters_04 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with description more than max characters(250)
    # setting reeust payload variable values
    * def surrenderReasonDescription = 'Surrender-Reason-' + randomString(250)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.surrenderReasonDescriptionSize

@Surrenderreasons_createNameWithNull_05 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with name as null
    # setting reeust payload variable values
    * def surrenderReasonName = null
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.fieldNotBlank

#bug: it is throwing 500 internal server error. should throw a proper error message
@Surrenderreasons_createDuplicateName_06 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with duplicate name
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # Creating a surredner reason again
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error == commonConstants.errorMessages.internalServerError

@Surrenderreasons_createDescriptionWithEmpty_07 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with description as null
    # setting reeust payload variable values
    * def surrenderReasonDescription = null
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.fieldNotBlank

@Surrenderreasons_createDescriptionWith250Characters_08 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with description more than max characters(250)
    # setting reeust payload variable values
    * def surrenderReasonDescription = 'Surrender-Reason-' + randomString(250)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.surrenderReasonDescriptionSize

@Surrenderreasons_createInvalidTenantId_09 @negative @surrenderReasonsCreate @surrenderReasons @egfInstrument @regression
Scenario: Create Suurender Reason with invalid tenantId
    # setting reeust payload variable values
    * def tenantId = "invalid-tenant-" + randomString(10)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInCreateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

#Search Instrument Surrender Reasons Test Cases
@Surrenderreasons_Search_ValidName_01 @positive @surrenderReasonsSearch @surrenderReasons @egfInstrument @regression
Scenario: Search Surrender Reason with valid name
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    * def surrenderReasonsParams =
    """
        {
            "name": "#(surrenderReasonName)",
            "tenantId": "#(tenantId)"
        }
    """
    # Search Surrender Reasons
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons[0].name == surrenderReasonName
    * match surrenderReasonsResponseBody.surrenderReasons[0].description == surrenderReasonDescription

@Surrenderreasons_Search_InvalidName_02 @negative @surrenderReasonsSearch @surrenderReasons @egfInstrument @regression
Scenario: Search Surrender Reason with invalid name
    * def surrenderReasonName = 'invalid-surrender-name-' + randomString(10)
    * def surrenderReasonsParams =
    """
        {
            "name": "#(surrenderReasonName)",
            "tenantId": "#(tenantId)"
        }
    """
    # Search Surrender Reasons
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons.size() == 0

@Surrenderreasons_Search_All_03 @positive @surrenderReasonsSearch @surrenderReasons @egfInstrument @regression
Scenario: Search All Surrender Reasons
    * def surrenderReasonsParams =
    """
        {
            "tenantId": "#(tenantId)"
        }
    """
    # Search Surrender Reasons
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons.size() != 0

@Surrenderreasons_Search_NameWithNull_04 @negative @surrenderReasonsSearch @surrenderReasons @egfInstrument @regression
Scenario: Search Surrender Reason with name as null
    * def surrenderReasonsParams =
    """
        {
            "name": null,
            "tenantId": "#(tenantId)"
        }
    """
    # Search Surrender Reasons
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@searchSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons.size() != 0

@Surrenderreasons_Search_InvalidTenantId_05 @negative @surrenderReasonsSearch @surrenderReasons @egfInstrument @regression
Scenario: Search Surrender Reason with invalid tenantId
    * def tenantId = 'invalid-tenant-' + randomString(5)
    * def surrenderReasonsParams =
    """
        {
            "tenantId": "#(tenantId)"
        }
    """
    # Search Surrender Reasons
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInSearchSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

#Update Instrument Surrender Reasons Test Cases
@Surrenderreasons_UpdateName_01 @positive @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with valid request payload
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons[0].name == surrenderReasonName
    * match surrenderReasonsResponseBody.surrenderReasons[0].description == surrenderReasonDescription

@Surrenderreasons_UpdateNameWithMaxCharacter_02 @positive @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with name equal to max characters(50)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * def reasonNameEqualMax = 'Surrender-Reason-' + randomString(33)
    * eval surrenderReasons[0].name = reasonNameEqualMax
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@updateSurrenderReasonSuccessfully')
    # Validating response body
    * match surrenderReasonsResponseBody.surrenderReasons[0].name == reasonNameEqualMax
    * match surrenderReasonsResponseBody.surrenderReasons[0].description == surrenderReasonDescription

@Surrenderreasons_UpdateNameWithMoreThan50Characters_03 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with name more than max characters(50)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * eval surrenderReasons[0].name = 'Surrender-Reason-' + randomString(50)
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.surrenderReasonNameSize

@Surrenderreasons_UpdateDescriptionWithMoreThan250Characters_04 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with description more than max characters(250)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * eval surrenderReasons[0].description = 'Surrender-Reason-' + randomString(250)
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.surrenderReasonDescriptionSize

@Surrenderreasons_UpdateNameWithNull_05 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with name as null
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * eval surrenderReasons[0].name = null
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.fieldNotBlank

#bug: it is throwing 500 internal server error. should throw a proper error message
@Surrenderreasons_UpdateDuplicateName_06 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with duplicate name
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # extracting name to pass it to update with duplicate name
    * def duplicateName = surrenderReasonsResponseBody.surrenderReasons[0].name
    # Setting request payload variables
    * def randomNameDescription = 'Surrender-Reason-' + randomString(20)
    * def surrenderReasonName = randomNameDescription
    * def surrenderReasonDescription = randomNameDescription
    # Creating another surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    * eval surrenderReasons[0].name = duplicateName
    # Creating a surredner reason again
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error == commonConstants.errorMessages.internalServerError

@Surrenderreasons_UpdateDescriptionWithEmpty_07 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with description as null
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * eval surrenderReasons[0].description = null
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.fieldNotBlank

@Surrenderreasons_UpdateDescriptionWith250Characters_08 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with description more than max characters(250)
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * eval surrenderReasons[0].description = 'Surrender-Reason-' + randomString(250)
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.error.fields[0].message == egfInstrumentConstants.errorMessages.surrenderReasonDescriptionSize

@Surrenderreasons_UpdateInvalidTenantId_09 @negative @surrenderReasonsUpdate @surrenderReasons @egfInstrument @regression
Scenario: Update Suurender Reason with invalid tenantId
    # Creating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@createSurrenderReasonSuccessfully')
    # setting reeust payload variable values
    * eval surrenderReasons[0].tenantId = "invalid-tenant-" + randomString(10)
    # Updating a surrender reason
    * call read('../../business-services/pretest/egfInstrumentPretest.feature@errorInUpdateSurrenderReason')
    # Validating response body
    * match surrenderReasonsResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError