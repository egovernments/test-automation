Feature: Core service - Localization Automation Test Cases

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def expectedMessage = read('../constants/localization.yaml')
    * def notenantId = ''
    # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def authUserType = 'EMPLOYEE'
    * call read('../pretests/authenticationToken.feature')
	
#TestCases

@SearchLocale_SpecificModule_01 @positive @localization 
Scenario: Search for Localization in English(Specific Module)

    * def module_value = expectedMessage.parameters.module
    * def locale = expectedMessage.parameters.engLocale

    * call read('../pretests/localizationMessage.feature@Success_LocalizationMessage') 
	* assert localizationMessageResponseBody.messages[0].module == module_value
	* assert localizationMessageResponseBody.messages[0].locale == locale


@SearchLocale_AllModules_02  @positive @localization 
Scenario: Search for Localization in Hindhi(All module)

    * def locale = expectedMessage.parameters.hindhiLocale
    * def module_value = expectedMessage.parameters.noModule
      
    * call read('../pretests/localizationMessage.feature@Success_LocalizationMessage')
	* assert localizationMessageResponseBody.messages[0].locale == locale

@SearchLocale_InvalidLocale_03  @negative @localization @localizationdryRun
Scenario: Search with different locale

    * def locale = expectedMessage.parameters.invalidLocale

	* call read('../pretests/localizationMessage.feature@Success_LocalizationMessage')
	* match localizationMessageResponseBody.messages == []


@SearchLocale_noLocale_05  @negative @localization @localizationdryRun
Scenario: Search without query parameter locale in the url


	* call read('../pretests/localizationMessage.feature@Error_LocalizationMessage') 
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == expectedMessage.expectedErrorMessages.Nolocale


@SearchLocale_noTenantId_06 @negative @localization @localizationdryRun
Scenario: Search without query parameter tenantid in the url

    * def localizationMessagesUrl = expectedMessage.parameters.invalidSearchURL
    
	* call read('../pretests/localizationMessage.feature@Error_NoTenant_LocalizationMessage')
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == expectedMessage.expectedErrorMessages.NoTenantId

     
@SearchLocale_MultipleData_07 @positive @localization
Scenario: Search with multiple modules and codes

    * def module_value = expectedMessage.parameters.multiModule
    * def code_value = expectedMessage.parameters.multiCode

	* call read('../pretests/localizationMessage.feature@Success_MultiData_Localization')
	* match localizationMessageResponseBody.messages[*].module contains expectedMessage.expectedOutput.Modules
    * match localizationMessageResponseBody.messages[*].code contains expectedMessage.expectedOutput.Codes
      

@SearchLocale_noModule_08 @negative @localization @localizationdryRun   
Scenario: Search with no modules

    * def code_value = expectedMessage.parameters.code
    * def locale = 'hi_IN'

	* call read('../pretests/localizationMessage.feature@Error_NoModule_LocalizationMessage')
	* match localizationMessageResponseBody.Errors[0].message contains expectedMessage.expectedErrorMessages.Module


@Upsert_Locale_01 @positive @localization
Scenario: Test by a message in Eng locale to Hindi locale

    * def message = expectedMessage.parameters.hindhiMsg
    * def module_value = expectedMessage.parameters.module
    # Upsert new Message and validate the message code in the response
    * call read('../pretests/upsert.feature@Success_Upsert')
    * assert upsertResponseBody.messages[0].message == message
    * call read('../pretests/localizationMessage.feature@Success_LocalizationMessageCall')
	* match localizationMessageResponseBody.messages[*].message contains message


@Upsert_MandatoryValidation_02  @negative @localization
Scenario: Test by not passing any value for Message,Code and Module
    
    * def message = expectedMessage.parameters.noMessage
	* def code = expectedMessage.parameters.noCode
    * def module = expectedMessage.parameters.noModule

    * call read('../pretests/upsert.feature@Error_Upsert')
	* match upsertResponseBody.error.fields[*].message contains expectedMessage.expectedErrorMessages.Empty

@Upsert_InvaliidTenantId_03 @negative @localization @localizationdryRun
Scenario: Test by passing a invalid value for Tenant ID

    * def message = ranString(50)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
    * def module = expectedMessage.parameters.module
    * def tenantId = notenantId
    
    * call read('../pretests/upsert.feature@Error_accessingResource_upsert') 
	* match upsertResponseBody.Errors[0].message contains expectedMessage.expectedErrorMessages.Authorized


@Upsert_CharCount_Code_04  @negative @localization
Scenario: Test by passing Maximum value for Code

    * def message = ranString(50)
    * def code = ranString(256)
    * def module = expectedMessage.parameters.module

    * call read('../pretests/upsert.feature@Error_Upsert')
	* match upsertResponseBody.error.fields[0].code contains expectedMessage.expectedErrorMessages.Code
	* match upsertResponseBody.error.fields[0].message contains expectedMessage.expectedErrorMessages.Message


@Upsert_CharCount_message_05 @negative @localization
Scenario: Test by passing Maximum value for Message

    * def message = ranString(515)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
    * def module = expectedMessage.parameters.module

    * call read('../pretests/upsert.feature@Error_Upsert') 
	* match upsertResponseBody.error.fields[0].code contains expectedMessage.expectedErrorMessages.Code
	* match upsertResponseBody.error.fields[0].message contains expectedMessage.expectedErrorMessages.Message


@Upsert_CharCount_Locale_06 @negative @localization
Scenario: Test by passing Maximum value for Locale

    * def message = ranString(50)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* def locale = ranString(256)
    * def module = expectedMessage.parameters.module

    * call read('../pretests/upsert.feature@Error_Upsert') 
	* match upsertResponseBody.error.fields[0].code contains expectedMessage.expectedErrorMessages.Code
	* match upsertResponseBody.error.fields[0].message contains expectedMessage.expectedErrorMessages.Message


@Upsert_InvalidUrl_08 @negative @localization
Scenario: Upsert with Invalid URL

    
    * def upsertUrl = expectedMessage.parameters.invalidUpsertURL
    * call read('../pretests/upsert.feature@Error_accessingResource_upsert')  
	* match upsertResponseBody.Errors[0].message contains expectedMessage.expectedErrorMessages.Authorized



















        
        



