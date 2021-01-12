Feature: Core service - accessControl

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def accessControlConstants = read('../constants/accessControl.yaml')
    * def appId = accessControlConstants.parameters.appId
    * def ver = accessControlConstants.parameters.ver
    * def ts = accessControlConstants.parameters.ts
    * def action = accessControlConstants.parameters.action
    * def did = accessControlConstants.parameters.did
    * def msgId = accessControlConstants.parameters.msgId
    * def roleCOdes = accessControlConstants.parameters.roleCOdes
    * def actionMaster = accessControlConstants.parameters.actionMaster
    * def enabled = accessControlConstants.parameters.enabled
    * def roleCodes = accessControlConstants.parameters.roleCodes
    # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def authUserType = accessControlConstants.parameters.userType
    * call read('../pretests/authenticationToken.feature')
   
@AC_search_01 @AC_search_rolecode_03 @positive @accessControl
Scenario: Test to search an access control
    * call read('../pretests/accessControlSearch.feature@success_search')
    * print accessControlResponseBody
    * assert accessControlResponseBody.responseInfo.status == '200 OK'
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
    * call read('../pretests/accessControlSearch.feature@error_search_invalid_tenant')
    * print accessControlResponseBody
    * assert accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.IllegalArgumentException

@AC_search_invalidRoleCode_04 @positive @accessControl
Scenario: Test to search access control with invalid role code
    * def roleCodes = "abc"
    * call read('../pretests/accessControlSearch.feature@success_search')
    * print accessControlResponseBody
    * assert accessControlResponseBody.responseInfo.status == '200 OK'
    * match accessControlResponseBody.actions == '#[0]'

@AC_search_invalidActionMaster_05 @negative @accessControl
Scenario: Test to search an access control with invalid action-master
    * def actionMaster = "abc"
    * call read('../pretests/accessControlSearch.feature@error_search')
    * print accessControlResponseBody
    * assert accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.PathNotFoundException

@AC_search_BlankActionMaster_06 @negative @accessControl
Scenario: Test to search an access control with action-master as blank
    * def actionMaster = " "
    * call read('../pretests/accessControlSearch.feature@error_search')
    * print accessControlResponseBody
    * assert accessControlResponseBody.Errors[0].description == accessControlConstants.expectedDescriptions.InvalidPathException

@AC_search_enabled_07 @negative @accessControl
Scenario: Test to search an access control with invalid value for enabled
    * def enabled = "abd"
    * call read('../pretests/accessControlSearch.feature@error_search')
    * print accessControlResponseBody
    * assert accessControlResponseBody.Errors[0].message == accessControlConstants.expectedMessages.JsonMappingException

@AC_search_InvalidAuth_08 @negative @accessControl
Scenario: Test to search an access control with invalid authToken
    * call read('../pretests/accessControlSearch.feature@error_search_invalid_authToken')

@AC_search_InvalidEndPoint_09 @negative @accessControl
Scenario: Test to search an access control with invalid search method
    * call read('../pretests/accessControlSearch.feature@error_search_invalid_method')
    * print accessControlResponseBody
    * assert accessControlResponseBody.Errors[0].message == accessControlConstants.expectedMessages.CustomException
