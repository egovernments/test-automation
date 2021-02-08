Feature: Core service - accessControl

        Background:
    # read the javascript utils file for using generic methods
    * def jsUtils = read('classpath:jsUtils.js')
    * def accessControlConstants = read('../../core-services/constants/accessControl.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # javascript method to the current date and time in epoch format
    * def ts = getCurrentEpochTime()
    # initializing the request payload objects
    * def roleCodes = mdmsStateAccessControlRoles.roles[2].code
    * def actionMaster = accessControlConstants.parameters.actionMaster
    * def enabled = true
   
        @AC_search_01 @AC_search_rolecode_03 @positive @accessControl
        Scenario: Test to search an access control with all valid fields
    # calling Search Access Control pretest
    * call read('../../core-services/pretests/accessControlPretest.feature@searchAccessControlSuccessfully')
    # verifying the response parameters
    * match accessControlResponseBody.responseInfo.status == commonConstants.expectedStatus.ok
    * match accessControlResponseBody.actions[*].id == '#present'
    * match accessControlResponseBody.actions[*].name == '#present'
    * match accessControlResponseBody.actions[*].url == '#present'
    * match accessControlResponseBody.actions[*].displayName == '#present'
    * match accessControlResponseBody.actions[*].orderNumber == '#present'
    * match accessControlResponseBody.actions[*].parentModule == '#present'
    * match accessControlResponseBody.actions[*].enabled == '#present'
    * match accessControlResponseBody.actions[*].serviceCode == '#present'
    * match accessControlResponseBody.actions[*].tenantId == '#present'
    * match accessControlResponseBody.actions[*].path == '#present'

        @AC_search_InvalidTenant_02 @negative @accessControl
        Scenario: Test to search an access control with invalid tenant
    # calling Search Access Control pretest
    * call read('../../core-services/pretests/accessControlPretest.feature@searchAccessControlWithInvalidTenant')
    * match accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.IllegalArgumentException

        @AC_search_invalidRoleCode_04 @positive @accessControl
        Scenario: Test to search access control with invalid role code
    # setting random invalid roleCode for negative scenario
    * def roleCodes = 'Invalid-rolecode-' + ranString(10)
    # calling Search Access Control pretest
    * call read('../../core-services/pretests/accessControlPretest.feature@searchAccessControlSuccessfully')
    * match accessControlResponseBody.responseInfo.status == commonConstants.expectedStatus.ok
    * match accessControlResponseBody.actions == '#[0]'

        @AC_search_invalidActionMaster_05 @negative @accessControl
        Scenario: Test to search an access control with invalid action-master
        # setting random invalid actionMaster for negative scenario
    * def actionMaster = 'Invalid-actionMaster-' + ranString(10)
    # calling Search Access Control pretest
    * call read('../../core-services/pretests/accessControlPretest.feature@searchAccessControlError')
    * match accessControlResponseBody.Errors[0].description contains accessControlConstants.expectedDescriptions.PathNotFoundException

        @AC_search_BlankActionMaster_06 @negative @accessControl
        Scenario: Test to search an access control with action-master as blank
        # setting blank value for actionMaster for negative scenario
    * def actionMaster = " "
    # calling Search Access Control pretest
    * call read('../../core-services/pretests/accessControlPretest.feature@searchAccessControlError')
    * match accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.InvalidPathException

        @AC_search_enabled_07 @negative @accessControl
        Scenario: Test to search an access control with invalid value for enabled
        # setting random invalid enabled for negative scenario
    * def enabled = 'Invalid-enabled-' + ranString(5)
    # calling Search Access Control pretest
    * call read('../../core-services/pretests/accessControlPretest.feature@searchAccessControlError')
    * match accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.JsonMappingException
