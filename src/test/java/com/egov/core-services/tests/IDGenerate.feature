Feature: Core service - IDGenerate

        Background:

    * def jsUtils = read('classpath:jsUtils.js')
    #* def javaUtils = Java.type('com.egov.base.EGovTest')
    * def idGenServiceConstants = read('../constants/idGenerate.yaml')
    # Common global Constants
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def index = randomNumber(mdmsStatecommonMasters.IdFormat.length)

        @IdGen_Generate_01 @positive @idGenerate
        Scenario: Test a unique Id is created for every new application,receipt

    * def idName = mdmsStatecommonMasters.IdFormat[index].idname
    * def format = mdmsStatecommonMasters.IdFormat[index].format
    * call read('../pretests/idGeneratePretest.feature@idGenerateSuccessfully')
    * assert idGenerateResponseBody.responseInfo.status == commonConstants.successMessages.successful
    * match idGenerateResponseBody.idResponses == '#notnull'

        @IdGen_GeneratetMulti_02 @positive @idGenerate
        Scenario: Search for Localization in English(Specific Module)

    * def idName = mdmsStatecommonMasters.IdFormat[index].idname
    * def format = mdmsStatecommonMasters.IdFormat[index].format
    * call read('../pretests/idGeneratePretest.feature@idGenerateSuccessfully')
    * def id1 = idGenerateResponseBody.idResponses[0].id
    * def value1 = stringToInteger(id1.slice(-2))
    * call read('../pretests/idGeneratePretest.feature@idGenerateSuccessfully')
    * def id2 = idGenerateResponseBody.idResponses[0].id
    * def value2 = stringToInteger(id2.slice(-2))
    # Verfiying the sequence ID values
    * match value2 == value1 + 1
    * assert idGenerateResponseBody.responseInfo.status == commonConstants.successMessages.successful
    * match idGenerateResponseBody.idResponses == '#notnull'

        @IdGen_switchIdName_03 @positive @idGenerate
        Scenario: Test by interchanging the id names from different modules

    * def idName = mdmsStatecommonMasters.IdFormat[index].idname
    * def format = mdmsStatecommonMasters.IdFormat[index].format
    * call read('../pretests/idGeneratePretest.feature@idGenerateSuccessfully')
    * assert idGenerateResponseBody.responseInfo.status == commonConstants.successMessages.successful
    * match idGenerateResponseBody.idResponses == '#notnull'

        @IdGen_invalidTenantId_04 @negative @idGenerate
        Scenario: Test by passing a invalid or a nonexistent tenant id

    * def tenantId = commonConstants.invalidParameters.invalidTenantId
    * def idName = mdmsStatecommonMasters.IdFormat[index].idname
    * def format = mdmsStatecommonMasters.IdFormat[index].format
    * call read('../pretests/idGeneratePretest.feature@idGenerateError')
    * assert idGenerateResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

        @IdGen_BlankFormat_06 @negative @idGenerate
        Scenario: Test by not passing any value for format

    * def format = commonConstants.invalidParameters.emptyValue
    * call read('../pretests/idGeneratePretest.feature@idGenerateFailed')
    * assert idGenerateResponseBody.ResponseInfo.status == commonConstants.errorMessages.failed
    * assert idGenerateResponseBody.Errors[0].message == idGenServiceConstants.errorMessages.noFormatError

        @IdGen_InvalidSeqFormat_07 @negative @idGenerate
        Scenario: Test by not passing invalid Sequence format which is not in MDMS

    * def format = idGenServiceConstants.invalidParameters.sequenceFormat
    * call read('../pretests/idGeneratePretest.feature@idGenerateFailed')
    * assert idGenerateResponseBody.ResponseInfo.status == commonConstants.errorMessages.failed
    * assert idGenerateResponseBody.Errors[0].message == idGenServiceConstants.errorMessages.dbError