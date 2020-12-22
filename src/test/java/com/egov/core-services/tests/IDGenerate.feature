Feature: Core service - IDGenerate

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def expectedMessage = read('../constants/idGenerate.yaml')
    # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def tenantId = tenantId
    * print tenantId
    * def authUserType = expectedMessage.parameters.userType
    * call read('../pretests/authenticationToken.feature')


@IdGen_Generate_01 @positive @idGenerate @idGenerate_dryRun
Scenario: Test a unique Id is created for every new application,receipt

    * call read('../pretests/idGeneratePretest.feature@success')
    * print idGenerateResponseBody
    * assert idGenerateResponseBody.responseInfo.status == 'SUCCESSFUL'
    * match idGenerateResponseBody.idResponses == '#notnull'


@IdGen_GeneratetMulti_02 @positive @idGenerate 
Scenario: Search for Localization in English(Specific Module)

    * call read('../pretests/idGeneratePretest.feature@success')
    * print idGenerateResponseBody
    * def id1 = idGenerateResponseBody.idResponses[0].id
    * def value1 = stringToInteger(id1.substring(id1.lastIndexOf('-') + 1))
    * call read('../pretests/idGeneratePretest.feature@success')
    * def id2 = idGenerateResponseBody.idResponses[0].id
    * def value2 = stringToInteger(id2.substring(id2.lastIndexOf('-') + 1))
    * match value2 == value1 + 1

    * assert idGenerateResponseBody.responseInfo.status == 'SUCCESSFUL'
    * match idGenerateResponseBody.idResponses == '#notnull'


@IdGen_switchIdName_03 @positive @idGenerate 
Scenario: Test by interchanging the id names from different modules

    * call read('../pretests/idGeneratePretest.feature@successWithDifferentIDName')
    * print idGenerateResponseBody
    * assert idGenerateResponseBody.responseInfo.status == 'SUCCESSFUL'
    * match idGenerateResponseBody.idResponses == '#notnull'


@IdGen_invalidTenantId_04 @negative @idGenerate @idGenerate_dryRun
Scenario: Test by passing a invalid or a nonexistent tenant id

    * call read('../pretests/idGeneratePretest.feature@forbidden')
    * print idGenerateResponseBody
    * assert idGenerateResponseBody.Errors[0].message == 'Not authorized to access this resource'


@IdGen_BlankFormat_06 @negative @idGenerate @idGenerate_dryRun
Scenario: Test by not passing any value for format

    * def format = ''

    * call read('../pretests/idGeneratePretest.feature@failed')
    * print idGenerateResponseBody
    * assert idGenerateResponseBody.ResponseInfo.status == 'FAILED'
    * assert idGenerateResponseBody.Errors[0].message == 'No Format is available in the MDMS for the given name and tenant'


@IdGen_InvalidSeqFormat_07 @negative @idGenerate @idGenerate_dryRun
Scenario: Test by not passing invalid Sequence format which is not in MDMS

    * def format = 'WS/OTP/[fy:yyyy-yy]/[SEQ_EGOV]'

    * call read('../pretests/idGeneratePretest.feature@failed')
    * print idGenerateResponseBody
    * assert idGenerateResponseBody.ResponseInfo.status == 'FAILED'
    * assert idGenerateResponseBody.Errors[0].message == 'Error occurred while auto creating seq in DB'


	