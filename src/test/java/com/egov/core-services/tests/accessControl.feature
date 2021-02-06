Feature: Core service - accessControl

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def accessControlConstants = read('../../core-services/constants/accessControl.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    
    * def authUsername = authUsername
    * def authPassword = authPassword
    * def authUserType = authUserType
    * call read('../../common-services/pretests/authenticationToken.feature')
    * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
    * def ts = getCurrentEpochTime()
    * def roleCodes = mdmsStateAccessControlRoles.roles[2].code
    * def actionMaster = accessControlConstants.parameters.actionMaster
    * def enabled = true
   
@AC_search_01 @AC_search_rolecode_03 @positive @accessControl
Scenario: Test to search an access control with all valid fields
    * call read('../../core-services/pretests/accessControlSearch.feature@searchEmployeeHrms')
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
    * call read('../../core-services/pretests/accessControlSearch.feature@errorSearchInvalidTenant')
    * match accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.IllegalArgumentException

@AC_search_invalidRoleCode_04 @positive @accessControl
Scenario: Test to search access control with invalid role code
    * def roleCodes = 'Invalid-rolecode-' + ranString(10)
    * call read('../../core-services/pretests/accessControlSearch.feature@searchEmployeeHrms')
    * match accessControlResponseBody.responseInfo.status == commonConstants.expectedStatus.ok
    * match accessControlResponseBody.actions == '#[0]'

@AC_search_invalidActionMaster_05 @negative @accessControl
Scenario: Test to search an access control with invalid action-master
    * def actionMaster = 'Invalid-actionMaster-' + ranString(10)
    * call read('../../core-services/pretests/accessControlSearch.feature@errorInSearchEmployee')
    * match accessControlResponseBody.Errors[0].description contains accessControlConstants.expectedDescriptions.PathNotFoundException

@AC_search_BlankActionMaster_06 @negative @accessControl
Scenario: Test to search an access control with action-master as blank
    * def actionMaster = " "
    * call read('../../core-services/pretests/accessControlSearch.feature@errorInSearchEmployee')
    * match accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.InvalidPathException

@AC_search_enabled_07 @negative @accessControl
Scenario: Test to search an access control with invalid value for enabled
    * def enabled = 'Invalid-enabled-' + ranString(5)
    * call read('../../core-services/pretests/accessControlSearch.feature@errorInSearchEmployee')
    * match accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.JsonMappingException
