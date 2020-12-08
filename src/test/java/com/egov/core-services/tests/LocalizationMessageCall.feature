Feature: Core service - Localization Automation Test Cases

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def expectedMessage = read('classpath:constants/localization/expectedMessages.yaml')
   
    # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def authUserType = 'EMPLOYEE'
    * call read('../pretests/authenticationToken.feature')
	
#TestCases

@SearchLocale_SpecificModule_01 @positive @localization
Scenario: Search for Localization in English(Specific Module)

    * def module_value = 'rainmaker-common'
    * def locale_value = 'hi_IN'

    * call read('../pretests/localizationMessage.feature@Success_LocalizationMessage') 
	* assert localizationMessageResponseBody.messages[0].module == module_value
	* assert localizationMessageResponseBody.messages[0].locale == locale_value


@SearchLocale_AllModules_02  @positive @localization
Scenario: Search for Localization in Hindhi(All module)

    * def locale_value = 'hi_IN'
      
    * call read('../pretests/localizationMessage.feature@Success_LocalizationMessage') { locale_value: '#(locale_value)', module_value: ''}
	* assert localizationMessageResponseBody.messages[0].locale == locale_value

@SearchLocale_InvalidLocale_03  @negative @localization
Scenario: Search with different locale

    * def Expected_result = read('classpath:responseJson/localization/differentLocaleResponse.json')
	* print Expected_result
	* call read('../pretests/localizationMessage.feature@Success_LocalizationMessage') { locale_value: 'Mumbai'}
	* match localizationMessageResponseBody == Expected_result


@SearchLocale_noLocale_05  @negative @localization
Scenario: Search without query parameter locale in the url


	* call read('../pretests/localizationMessage.feature@Error_LocalizationMessage') 
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == expectedMessage.expectedlocaleErrorMessage


@SearchLocale_noTenantId_06 @negative @localization
Scenario: Search without query parameter tenantid in the url
    
	* call read('../pretests/localizationMessage.feature@Error_NoTenant_LocalizationMessage')
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == expectedMessage.expectedTenatIdErrorMessage

     
@SearchLocale_MultipleData_07 @positive @localization
Scenario: Search with multiple modules and codes


	* call read('../pretests/localizationMessage.feature@Success_MultiData_Localization') { locale_value: 'en_IN', module_value: 'rainmaker-common,rainmaker-ws', code_value: 'OWNER_ADDRESSPROOF,ACTION_TEST_SEARCH_APPLICATION'}
	* match localizationMessageResponseBody.messages[*].module contains expectedMessage.expectedModules
    * match localizationMessageResponseBody.messages[*].code contains expectedMessage.expectedCodes
      

@SearchLocale_noModule_08 @negative @localization
Scenario: Search with no modules

	* call read('../pretests/localizationMessage.feature@Error_NoModule_LocalizationMessage') { locale_value: 'hi_IN', code_value: 'ACTION_TEST_SEARCH_APPLICATION'}
	* match localizationMessageResponseBody.Errors[0].message contains expectedMessage.expectedModuleerrorMessage


@Upsert_Locale_01 @positive @localization
Scenario: Test by a message in Eng locale to Hindi locale

    * def message = 'संदेश मुखर करना'
    * def locale = 'en_IN'
    # Upsert new Message and validate the message code in the response
    * call read('../pretests/upsert.feature@Success_Upsert')
    * assert upsertResponseBody.messages[0].message == message
    * call read('../pretests/localizationMessage.feature@Success_LocalizationMessageCall') { locale_value: 'en_IN', module_value: 'rainmaker-common'}
	* match localizationMessageResponseBody.messages[*].message contains message


@Upsert_MandatoryValidation_02  @negative @localization
Scenario: Test by not passing any value for Message,Code and Module

    * def index = 1
    * call read('../pretests/upsert.feature@Error_Upsert')
	* match upsertResponseBody.error.fields[*].message contains expectedMessage.expectedEmptyErrorMessage

@Upsert_InvaliidTenantId_03 @negative @localization
Scenario: Test by passing a invalid value for Tenant ID

    * def message = ranString(50)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
    * print message
    * def index = 2
    
    * call read('../pretests/upsert.feature@Error_accessingResource_upsert') 
	* match upsertResponseBody.Errors[0].message contains expectedMessage.expectedAuthorizedMessage


@Upsert_CharCount_Code_04  @negative @localization
Scenario: Test by passing Maximum value for Code

    * def message = ranString(50)
    * def code = ranString(256)
    * print code
    * def index = 0

    * call read('../pretests/upsert.feature@Error_Upsert')
	* match upsertResponseBody.error.fields[0].code contains expectedMessage.expectedErrorCode
	* match upsertResponseBody.error.fields[0].message contains expectedMessage.expectedErrorMessage


@Upsert_CharCount_message_05 @negative @localization
Scenario: Test by passing Maximum value for Message

    * def message = ranString(515)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
    * print message
    * def index = 0

    * call read('../pretests/upsert.feature@Error_Upsert') 
	* match upsertResponseBody.error.fields[0].code contains expectedMessage.expectedErrorCode
	* match upsertResponseBody.error.fields[0].message contains expectedMessage.expectedErrorMessage


@Upsert_CharCount_Locale_06 @negative @localization
Scenario: Test by passing Maximum value for Locale

    * def message = ranString(50)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* def locale = ranString(256)
	* print locale
	* print code
    * print message
    * def index = 0

    * call read('../pretests/upsert.feature@Error_Upsert') 
	* match upsertResponseBody.error.fields[0].code contains expectedMessage.expectedErrorCode
	* match upsertResponseBody.error.fields[0].message contains expectedMessage.expectedErrorMessage


@Upsert_InvalidUrl_08 @negative @localization
Scenario: Upsert with Invalid URL

    * def index = 0
      #Removed messages in the url
    * def upsertUrl = 'https://egov-micro-qa.egovernments.org/localization/v1/_upsert'
    * call read('../pretests/upsert.feature@Error_accessingResource_upsert')  
	* match upsertResponseBody.Errors[0].message contains expectedMessage.expectedAuthorizedMessage



















        
        



