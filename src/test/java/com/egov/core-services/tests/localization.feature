Feature: Core service - Localization

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    #* def javaUtils = Java.type('com.egov.base.EGovTest')
    * def localizationServiceConstants = read('../../core-services/constants/localization.yaml')
    # Common global Constants
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def index = randomNumber(mdmsStatecommonMasters.StateInfo[0].localizationModules.length-6)
	
#TestCases

@SearchLocale_SpecificModule_01 @positive @localization
Scenario: Search for Localization in English(Specific Module)
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    # calling search localization pretest
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageSuccessfully') 
	* match localizationMessageResponseBody.messages[0].module contains module
	* assert localizationMessageResponseBody.messages[0].locale == locale

@SearchLocale_AllModules_02  @positive @localization
Scenario: Search for Localization in Hindhi(All module)
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    * def module = commonConstants.invalidParameters.emptyValue
    # calling search localization pretest
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageSuccessfully')
	* assert localizationMessageResponseBody.messages[0].locale == locale
    * assert localizationMessageResponseBody.messages.length != 0

@SearchLocale_InvalidLocale_03  @negative @localization
Scenario: Search with different locale
    * def locale = commonConstants.invalidParameters.invalidValue
    # calling search localization pretest
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageSuccessfully')
	* match localizationMessageResponseBody.messages == []
    * assert localizationMessageResponseBody.messages.length == 0

@SearchLocale_noLocale_05  @negative @localization
Scenario: Search without query parameter locale in the url
    # calling search localization pretest
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageError') 
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == localizationServiceConstants.expectedErrorMessages.Nolocale

@SearchLocale_noTenantId_06 @localization
Scenario: Search without query parameter tenantid in the url
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    * def tenantId = commonConstants.invalidParameters.emptyValue
    # calling search localization pretest
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageWithoutTenantIdError')
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == localizationServiceConstants.expectedErrorMessages.NoTenantId

@SearchLocale_MultipleData_07 @positive @localization
Scenario: Search with multiple modules and codes
    # calling search localization pretest
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def module1 = localizationMessageResponseBody.messages[index].module
    * def module2 = localizationMessageResponseBody.messages[index+1].module
    * def module = module1 + ',' + module2
    * def code1 = localizationMessageResponseBody.messages[index].code
    * def code2 = localizationMessageResponseBody.messages[index+1].code
    * def code = code1 + ',' + code2
    # calling search localization pretest with multiple modules
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageWithMutipleModuleSuccessfully')
	* match localizationMessageResponseBody.messages[*].module contains module1
    * match localizationMessageResponseBody.messages[*].module contains module2
    * match localizationMessageResponseBody.messages[*].code contains code1
    * match localizationMessageResponseBody.messages[*].code contains code2
      
@SearchLocale_noModule_08 @negative @localization
Scenario: Search with no modules
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    # calling search localization pretest
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def code1 = localizationMessageResponseBody.messages[index].code
    # calling search localization pretest without providing module
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageWithoutModuleError')
	* match localizationMessageResponseBody.Errors[0].message contains localizationServiceConstants.expectedErrorMessages.Module

@Upsert_Locale_01 @positive @localization
Scenario: Test by a message in Eng locale to Hindi locale
    * def code = 'AUTOMATION_SECTION_' + ranInteger(5) + '_FIELD_FEE'
    * def message = localizationServiceConstants.parameters.hindhiMsg + ranInteger(3)
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    # Upsert new Message and validate the message code in the response
    * call read('../../core-services/pretests/upsert.feature@upsertLocalizationSuccessfully')
    * assert upsertResponseBody.messages[0].message == message
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * print localizationMessageResponseBody
	* match localizationMessageResponseBody.messages[*].message contains message

@Upsert_MandatoryValidation_02  @negative @localization
Scenario: Test by not passing any value for Message,Code and Module
    * def message = commonConstants.invalidParameters.emptyValue
	* def code = commonConstants.invalidParameters.emptyValue
    * def module = commonConstants.invalidParameters.emptyValue
    # calling upsert localization pretest
    * call read('../../core-services/pretests/upsert.feature@upsertLocalizationError')
	* match upsertResponseBody.error.fields[*].message contains localizationServiceConstants.expectedErrorMessages.Empty

@Upsert_InvaliidTenantId_03 @negative @localization
Scenario: Test by passing a invalid value for Tenant ID
    * def message = randomString(50)
	* def code = 'AUTOMATION_SECTION_' + ranInteger(5) + '_FIELD_FEE'
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def tenantId = commonConstants.invalidParameters.emptyValue
    # calling upsert localization pretest
    * call read('../../core-services/pretests/upsert.feature@upsertLocalizationErrorAccessingResource') 
	* match upsertResponseBody.Errors[0].message contains commonConstants.errorMessages.authorizedError

@Upsert_CharCount_Code_04  @negative @localization
Scenario: Test by passing Maximum value for Code
    * def message = randomString(50)
    * def code = randomString(256)
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    # calling upsert localization pretest
    * call read('../../core-services/pretests/upsert.feature@upsertLocalizationError')
	* match upsertResponseBody.error.fields[0].code contains localizationServiceConstants.expectedErrorMessages.Code
	* match upsertResponseBody.error.fields[0].message contains localizationServiceConstants.expectedErrorMessages.Message

@Upsert_CharCount_message_05 @negative @localization
Scenario: Test by passing Maximum value for Message
    * def message = randomString(515)
	* def code = 'AUTOMATION_SECTION_' + ranInteger(4) + '_FIELD_FEE'
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    # calling upsert localization pretest
    * call read('../../core-services/pretests/upsert.feature@upsertLocalizationError') 
	* match upsertResponseBody.error.fields[0].code contains localizationServiceConstants.expectedErrorMessages.Code
	* match upsertResponseBody.error.fields[0].message contains localizationServiceConstants.expectedErrorMessages.Message

@Upsert_CharCount_Locale_06 @negative @localization
Scenario: Test by passing Maximum value for Locale
    * def message = randomString(50)
	* def code = 'AUTOMATION_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* def locale = randomString(256)
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    # calling upsert localization pretest
    * call read('../../core-services/pretests/upsert.feature@upsertLocalizationError') 
	* match upsertResponseBody.error.fields[0].code contains localizationServiceConstants.expectedErrorMessages.Code
	* match upsertResponseBody.error.fields[0].message contains localizationServiceConstants.expectedErrorMessages.Message

@Update_Localisation_01 @positive @localization
Scenario: Test to update existing localisation message
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def code = localizationMessageResponseBody.messages[index].code
    * def message = 'Automation Message' + ranInteger(5)
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageSuccessfully') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code

@Update_Localisation_02 @negative @localization
Scenario: Test to update module/locale
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def code = localizationMessageResponseBody.messages[index].code
    * def message = 'Automation Message' + ranInteger(5)
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageSuccessfully') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code
    * assert updateResponseBody.messages[0].module == module
    * assert updateResponseBody.messages[0].locale == locale

@Update_Localisation_Null_03 @negative @localization
Scenario: Test by passing null values
    * def message = commonConstants.invalidParameters.emptyValue
	* def code = commonConstants.invalidParameters.emptyValue
    * def module = commonConstants.invalidParameters.emptyValue
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageError') 
    * assert updateResponseBody.error.fields[0].message == localizationServiceConstants.expectedErrorMessages.Empty

@Update_Localisation_Invalid_tenantid_06 @negative @localization
Scenario: Test by passing a invalid value for Tenant ID
    * def tenantId = commonConstants.invalidParameters.invalidValue
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageWithInvalidTenantIdError')  
	* match updateResponseBody.Errors[0].message contains commonConstants.errorMessages.authorizedError

@Update_Search_Localisation_07 @positive @localization
Scenario: Test to update existing localisation message
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def code = localizationMessageResponseBody.messages[index].code
    * def message = 'Auto Message ' + ranInteger(5)
    * def module = localizationMessageResponseBody.messages[index].module
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageSuccessfully') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code
    # calling search localization pretest 
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageWithMutipleModuleSuccessfully')
    * assert localizationMessageResponseBody.messages[0].message == message

#Create Test cases
@Create_Localisation_01 @positive @localization
Scenario: Test to create a localization
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    * def code = 'AUTOMATION_CODE ' + ranInteger(5)
    * def message = 'Auto Message ' + ranInteger(5)
    # calling create localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@createLocalizationMessageSuccessfully')
    * assert createResponseBody.messages[0].code == code
    * assert createResponseBody.messages[0].message == message

@Create_search_Localisation_02 @positive @localization
Scenario: Test searching the creating localisation message
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    * def code = 'AUTOMATION_CODE ' + ranInteger(5)
    * def message = 'स्वचालन संदेश ' + ranInteger(5)
    # calling create localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@createLocalizationMessageSuccessfully')
    * assert createResponseBody.messages[0].code == code
    * assert createResponseBody.messages[0].message == message
    # calling search localization pretest 
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationMessageWithMutipleModuleSuccessfully')
    * assert localizationMessageResponseBody.messages[0].message == message
    * assert localizationMessageResponseBody.messages[0].code == code

@Create_update_Localisation_03 @positive @localization
Scenario: Test updating a newly created localisation message
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    * def code = 'AUTOMATION_CODE ' + ranInteger(5)
    * def message = 'Automation Message' + ranInteger(5)
    # calling create localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@createLocalizationMessageSuccessfully')
    * assert createResponseBody.messages[0].code == code
    * assert createResponseBody.messages[0].message == message
    * def message = 'Updated Automation Message ' + ranInteger(2)
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageSuccessfully') 
    * assert updateResponseBody.messages[0].message == message
    * assert updateResponseBody.messages[0].code == code

@Create_null_Localisaltion_04 @negative @localization
Scenario: Test for null values in  messages, code, module,locale in the request
    * def message = commonConstants.invalidParameters.emptyValue
	* def code = message
    * def module = message
    # calling update localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageError') 
    * assert updateResponseBody.error.fields[0].message == localizationServiceConstants.expectedErrorMessages.Empty

@Create_multiple_messages_05 @positive @localization
Scenario: Test creating multiple messages
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label 
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    * def code = 'AUTOMATION_CODE ' + ranInteger(5)
    * def message = 'Automation Message' + ranInteger(5)
    * def module1 = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale1 = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    * def code1 = 'AUTOMATION_CODE ' + ranInteger(5)
    * def message1 = 'Automation Message' + ranInteger(5)
    # calling create multiple localization pretest 
    * call read('../../core-services/pretests/localizationUpdate.feature@createMultipleLocalizationMessageSuccessfully') 
    * match createResponseBody.messages[*].code contains ['#(code)', '#(code1)']
    * match createResponseBody.messages[*].message contains ['#(message)', '#(message1)']

@Create_InvaliidTenantId_06 @negative @localization
Scenario: Test by passing a invalid value for Tenant ID
    * def tenantId = commonConstants.invalidParameters.emptyValue
    # calling create localization pretest
    * call read('../../core-services/pretests/localizationUpdate.feature@updateLocalizationMessageWithInvalidTenantIdError')  
	* match updateResponseBody.Errors[0].message contains commonConstants.errorMessages.authorizedError

#V2/Search Test cases

@v2Search_Localisation_01 @positive @localization
Scenario: Test to search a localisation
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[1].value
    # calling search localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def module = localizationMessageResponseBody.messages[index].module
    * def code = localizationMessageResponseBody.messages[index].code
    # calling search V2 localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationV2Successfully')
    * assert localizationV2SearchResponseBody.messages[0].code == code
    * assert localizationV2SearchResponseBody.messages.length == 1

@v2Search_Localisation_multiple_02 @positive @localization
Scenario: Test to search a localisation by passing multiple values
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    # calling search localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def index = randomNumber(localizationMessageResponseBody.messages.length)
    * def code = localizationMessageResponseBody.messages[index].code
    * def code1 = localizationMessageResponseBody.messages[index+1].code
    * def module1 = localizationMessageResponseBody.messages[index].module
    * def module2 = localizationMessageResponseBody.messages[index+1].module
    * def module = module1 + ',' + module2
    # calling search V2 localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationV2Successfully')
    * match localizationV2SearchResponseBody.messages[*].code contains code
    * match localizationV2SearchResponseBody.messages[*].code contains code1
    * assert localizationV2SearchResponseBody.messages.length == 2

@v2Search_Localisation_v1Url_03 @positive @localization
Scenario: Test to search a localisation with v1 in the url
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    # calling search localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def code = localizationMessageResponseBody.messages[index].code
    # calling search V2 localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationV1Error')
    * assert localizationV2SearchResponseBody.Errors[0].message == localizationServiceConstants.expectedErrorMessages.Nolocale

@v2Search_Localisation_Invalid_locale_06  @negative @localization
Scenario: Test by passing a invalid , non existent,null value for locale in the request
    * def locale = commonConstants.invalidParameters.invalidValue
    # calling search V2 localization pretest 
	* call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationV2Successfully')
	* match localizationV2SearchResponseBody.messages == []
    * assert localizationV2SearchResponseBody.message == null

@v2Search_Localisation_Invalid_tenantid_07 @negative @localization
Scenario: Test by passing a invalid , non existent,null value for tenantid in the request
    * def module = mdmsStatecommonMasters.StateInfo[0].localizationModules[index].label
    * def locale = mdmsStatecommonMasters.StateInfo[0].languages[0].value
    # calling search localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationSuccessfully')
    * def code = localizationMessageResponseBody.messages[0].code
    * def tenantId = commonConstants.invalidParameters.emptyValue
    # calling search V2 localization pretest 
    * call read('../../core-services/pretests/localizationMessage.feature@searchLocalizationV2Error') 
	* match localizationV2SearchResponseBody.Errors[0].message contains commonConstants.errorMessages.authorizedError
    

    