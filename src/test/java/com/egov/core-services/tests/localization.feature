Feature: Core service - Localization

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def expectedMessage = read('../constants/localization.yaml')
    * def notenantId = ''
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def tenantId = tenantId
    * print tenantId
    * def authUserType = expectedMessage.parameters.userType
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


@SearchLocale_noTenantId_06
Scenario: Search without query parameter tenantid in the url

    * def tenantId = expectedMessage.parameters.noTenantId
    
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


@Update_Localisation_01 @positive @localization
Scenario: Test to update existing localisation message

    * def module = 'rainmaker-common' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'TEST AUTO'
    * def message = 'Updated Localization Message'
    * def module1 = module
    * def locale1 = locale
    #update 
    * call read('../pretests/localizationUpdate.feature@Success_Update') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code


@Update_Localisation_02 @negative @localization
Scenario: Test to update module/locale

    * def module = 'rainmaker-common' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'TEST AUTO'
    * def message = 'Updated Localization Message'
    * def module1 = 'rainmaker-pt'
    * def locale1 = expectedMessage.parameters.hindhiLocale
    #update 
    * call read('../pretests/localizationUpdate.feature@Success_Update') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code
    * assert updateResponseBody.messages[0].module != module1
    * assert updateResponseBody.messages[0].locale != locale1


@Update_Localisation_Null_03 @negative @localization
Scenario: Test by passing null values 

    * def message = expectedMessage.parameters.noMessage
	* def code = expectedMessage.parameters.noCode
    * def module = expectedMessage.parameters.noModule
    #update 
    * call read('../pretests/localizationUpdate.feature@Error_Update') 
    * assert updateResponseBody.error.fields[0].message == expectedMessage.expectedErrorMessages.Empty


@Update_Localisation_Invalid_tenantid_06 @negative @localization
Scenario: Test by passing a invalid value for Tenant ID 
    
    * def tenantId = notenantId
    * call read('../pretests/localizationUpdate.feature@Error_accessingResource_update')  
	* match updateResponseBody.Errors[0].message contains expectedMessage.expectedErrorMessages.Authorized



@Update_Search_Localisation_07 @positive @localization
Scenario: Test to update existing localisation message

    * def module = 'rainmaker-common' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'TEST AUTO'
    * def message = 'Updated Localization Message'
    #update 
    * call read('../pretests/localizationUpdate.feature@Success_Update') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code

    * def module_value = module
    * def code_value = code
    #search
	* call read('../pretests/localizationMessage.feature@Success_MultiData_Localization')
    * assert localizationMessageResponseBody.messages[0].message == message

#Create Test cases
@Create_Localisation_01 @positive @localization
Scenario: Test to create a localization

    * def module = 'rainmaker-common' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'TEST AUTO ' + ranInteger(2)
    * def message = 'Updated Localization Message'

    * call read('../pretests/localizationUpdate.feature@Create_Success')
    * assert createResponseBody.messages[0].code == code


@Create_search_Localisation_02 @positive @localization
Scenario: Test searching the creating localisation message

    * def module = 'rainmaker-pt' 
    * def locale = expectedMessage.parameters.hindhiLocale
    * def code = 'TEST AUTO ' + ranInteger(2)
    * def message = 'अद्यतन स्थानीयकरण संदेश'

    * call read('../pretests/localizationUpdate.feature@Create_Success')
    * assert createResponseBody.messages[0].code == code
    * assert createResponseBody.messages[0].message == message

    * def module_value = module
    * def code_value = code
    #search
	* call read('../pretests/localizationMessage.feature@Success_MultiData_Localization')
    * assert localizationMessageResponseBody.messages[0].message == message
    * assert localizationMessageResponseBody.messages[0].code == code


@Create_update_Localisation_03 @positive @localization
Scenario: Test updating a newly created localisation message

    * def module = 'rainmaker-pt' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'TEST AUTO ' + ranInteger(2)
    * def message = 'Updated Message' + code

    * call read('../pretests/localizationUpdate.feature@Create_Success')
    * assert createResponseBody.messages[0].code == code
    * assert createResponseBody.messages[0].message == message

    * def message = 'Updated Localization Message ' + ranInteger(2)
    #update 
    * call read('../pretests/localizationUpdate.feature@Success_Update') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code


@Create_null_Localisaltion_04 @negative @localization
Scenario: Test for null values in  messages, code, module,locale in the request

    * def message = expectedMessage.parameters.noMessage
	* def code = expectedMessage.parameters.noCode
    * def module = expectedMessage.parameters.noModule
    #update 
    * call read('../pretests/localizationUpdate.feature@Error_Update') 
    * assert updateResponseBody.error.fields[0].message == expectedMessage.expectedErrorMessages.Empty


@Create_multiple_messages_05 @positive @localization
Scenario: Test creating multiple messages

    * def module = 'rainmaker-pt' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'TEST AUTO ' + ranInteger(2)
    * def message = 'Updated Message' + code
    * def codeValue = code

    * def module1 = 'rainmaker-common' 
    * def locale1 = expectedMessage.parameters.hindhiLocale
    * def code1 = 'TEST AUTO ' + ranInteger(2)
    * def message1 = 'Updated Message' + code1
    * def codeValue2 = code1

    * call read('../pretests/localizationUpdate.feature@Create_MultiMessages_Success') 
    * match createResponseBody.messages[*].code contains ['#(codeValue)', '#(codeValue2)']


@Create_InvaliidTenantId_06 @negative @localization
Scenario: Test by passing a invalid value for Tenant ID 
    
    * def tenantId = notenantId
    * call read('../pretests/localizationUpdate.feature@Error_accessingResource_update')  
	* match updateResponseBody.Errors[0].message contains expectedMessage.expectedErrorMessages.Authorized


#V2/Search Test cases

@v2Search_Localisation_01 @positive @localization
Scenario: Test to search a localisation 
    
    * def module = 'rainmaker-pt' 
    * def locale = expectedMessage.parameters.engLocale
    * def code = 'AUTO TEST'
    
    * call read('../pretests/localizationMessage.feature@SearchV2Call')
    * assert localizationV2SearchResponseBody.messages[0].code == code
    * assert localizationV2SearchResponseBody.messages.length == 1


@v2Search_Localisation_multiple_02 @positive @localization
Scenario: Test to search a localisation by passing multiple values 
    
    * def module = expectedMessage.parameters.multiModule
    * def locale = expectedMessage.parameters.engLocale
    * def code = expectedMessage.parameters.code
    * def code1 = expectedMessage.parameters.code1
    
    * call read('../pretests/localizationMessage.feature@SearchV2Call')
    * match localizationV2SearchResponseBody.messages[*].code contains expectedMessage.expectedOutput.Codes
    * assert localizationV2SearchResponseBody.messages.length == 2


@v2Search_Localisation_v1Url_03 @positive @localization
Scenario: Test to search a localisation with v1 in the url
    
    * def module = expectedMessage.parameters.multiModule
    * def locale = expectedMessage.parameters.engLocale
    * def code = expectedMessage.parameters.code

    * call read('../pretests/localizationMessage.feature@SearchV1ErrorCall')
    * assert localizationV2SearchResponseBody.Errors[0].message == expectedMessage.expectedErrorMessages.Nolocale

@v2Search_Localisation_Invalid_locale_06  @negative @localization
Scenario: Test by passing a invalid , non existent,null value for locale in the request 

    * def locale = expectedMessage.parameters.invalidLocale

	* call read('../pretests/localizationMessage.feature@SearchV2Call')
	* match localizationV2SearchResponseBody.messages == []
    * assert localizationV2SearchResponseBody.message == null


@v2Search_Localisation_Invalid_tenantid_07 @negative @localization
Scenario: Test by passing a invalid , non existent,null value for tenantid in the request 
    
    * def tenantId = notenantId
    * def module = expectedMessage.parameters.multiModule
    * def locale = expectedMessage.parameters.engLocale
    * def code = expectedMessage.parameters.code

    * call read('../pretests/localizationMessage.feature@SearchV2ErrorCall') 
	* match localizationV2SearchResponseBody.Errors[0].message contains expectedMessage.expectedErrorMessages.Authorized
    

    