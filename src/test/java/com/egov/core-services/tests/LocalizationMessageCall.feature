Feature: Localization Messages Demo Tests

        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')

  # Calling access token
	* def authUsername = counterEmployeeUserName
	* def authPassword = counterEmployeePassword
	* def authUserType = 'EMPLOYEE'
	* call read('../pretests/authenticationToken.feature')
	
        @upsert-localization
        Scenario: Creating the eGov Demo Tests
	# Upsert new Message and validate the message code in the response
	* call read('../pretests/upsert.feature')
	
	# Localization search
	* call read('../pretests/localizationMessage.feature@LocalMsgCall_200')
	
	# Verify upserted message in Localization search
	* print upsertedMessage + '*********************************'
	* match karate.jsonPath(localizationMessageResponseBody,"$..messages[?(@.code==\'"+upsertedMessage+"\')]") == '#present'
	* print '***********************' + karate.jsonPath(localizationMessageResponseBody,"$..messages[?(@.code==\'"+upsertedMessage+"\')]") + '******************'



        @searchLocale_SpecificModule_01 @eGov_Localization @eGov
        Scenario: Search for Localization in English(Specific Module)
    #* def module_Name = { module: 'rainmaker-uc' }
    * call read('../pretests/localizationMessage.feature@LocalMsgCall_200') { locale_value: 'en_IN',  tenant_value: 'pb', module_value: 'rainmaker-common'}
	* assert localizationMessageResponseBody.messages[0].module == 'rainmaker-common'
	* assert localizationMessageResponseBody.messages[0].locale == 'en_IN'



        @searchLocale_AllModules_02 @eGov_Localization @eGov
        Scenario: Search for Localization in Hindhi(All module)
      
    * call read('../pretests/localizationMessage.feature@LocalMsgCall_200') { locale_value: 'hi_IN',  tenant_value: 'pb', module_value: ''}
	* assert localizationMessageResponseBody.messages[0].locale == 'hi_IN'


#@search-localization_05 @eGov
        Scenario: Search for a specific code

    * def Expected_code = 'ACTION_TEST_SEARCH_APPLICATION'
	* call read('../pretests/localizationMessage.feature')
	* match localizationMessageResponseBody.messages[*].code contains Expected_code


        @searchLocale_noLocale_05 @eGov_Localization
        Scenario: Search without query parameter locale in the url

    * def Expected_ErrorMessage = 'Required String parameter \'locale\' is not present'
    * print Expected_ErrorMessage 
	* def paramValue = 'tenantId=pb'
	* call read('../pretests/localizationMessage.feature@LocalMsgCall_400') { tenant_value: paramValue}
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == Expected_ErrorMessage




        @searchLocale_noTenantId_06 @eGov_Localization @eGov
        Scenario: Search without query parameter tenantid in the url

    * def Expected_ErrorMessage = 'Required String parameter \'tenantId\' is not present'
    * print Expected_ErrorMessage 
	* def paramValue = 'locale=hi_IN'
	* call read('../pretests/localizationMessage.feature@LocalMsgCall_400') { tenant_value: paramValue}
	* assert localizationMessageResponseBody.ResponseInfo == null
	* assert localizationMessageResponseBody.Errors[0].message == Expected_ErrorMessage

        @SearchLocale_MultiModules_06 @eGov_Localization @eGov
        Scenario: Search with multiple modules

    * def Expected_modules = ['rainmaker-tl', 'rainmaker-common']
	* call read('../pretests/localizationMessage.feature@LocalMsgCall_200') { locale_value: 'hi_IN',  tenant_value: 'pb', module_value: 'rainmaker-common,rainmaker-tl'}
	* match localizationMessageResponseBody.messages[*].module contains Expected_modules

        @searchLocale_InvalidLocale_03 @eGov_Localization @eGov
        Scenario: Search with different locale

    * def Expected_result = read('classpath:responseJson/different_LocaleResponse.json')
	* print Expected_result
	 * call read('../pretests/localizationMessage.feature@LocalMsgCall_200') { locale_value: 'Mumbai',  tenant_value: 'pb'}
	* match localizationMessageResponseBody == Expected_result




        @upsert_ManadatoryValidation_08 @eGov_Localization @eGov
        Scenario: Test by not passing any value for Message,Code and Module
    * def index = 1

    * call read('../pretests/upsert.feature@upsert_400') { index: '#(index)'}
	* match upsertResponseBody.error.fields[*].code contains 'NotEmpty'
	* match upsertResponseBody.error.fields[*].message contains 'may not be empty'

        @upsert_CharCount_Code_10 @eGov_Localization @eGov
        Scenario: Test by passing Maximum value for Code
    * def message = ranString(50)
    * def code = ranString(256)
    * print code
    * def index = 0

    * call read('../pretests/upsert.feature@upsert_400') { index: '#(index)'}
	* match upsertResponseBody.error.fields[0].code contains 'core.MESSAGE_PERSIST_FAILED'
	* match upsertResponseBody.error.fields[0].message contains 'Message persist failed'
	* match upsertResponseBody.error.fields[0].field contains 'core.MESSAGE_PERSIST_FAILED'

        @upsert_CharCount_message_11 @eGov_Localization @eGov
        Scenario: Test by passing Maximum value for Message
    * def message = ranString(515)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
    * print message
    * def index = 0

    * call read('../pretests/upsert.feature@upsert_400') { index: '#(index)'}
	* match upsertResponseBody.error.fields[0].code contains 'core.MESSAGE_PERSIST_FAILED'
	* match upsertResponseBody.error.fields[0].message contains 'Message persist failed'
	* match upsertResponseBody.error.fields[0].field contains 'core.MESSAGE_PERSIST_FAILED'


        @upsert_CharCount_Locale_12 @eGov_Localization @eGov
        Scenario: Test by passing Maximum value for Locale
    * def message = ranString(50)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* def locale = ranString(256)
	* print locale
	* print code
    * print message
    * def index = 0

    * call read('../pretests/upsert.feature@upsert_400') { index: '#(index)'}
	* match upsertResponseBody.error.fields[0].code contains 'core.MESSAGE_PERSIST_FAILED'
	* match upsertResponseBody.error.fields[0].message contains 'Message persist failed'
	* match upsertResponseBody.error.fields[0].field contains 'core.MESSAGE_PERSIST_FAILED'

        @searchLocale_InvalidUrl_04 @eGov_Localization @eGov
        Scenario: Search Localization with Invalid URL
   
	* def authToken = 'invalid_authToken'
    * call read('../pretests/localizationMessage.feature@LocalMsgCall_500') { locale_value: 'en_IN',  tenant_value: 'pb', module_value: 'rainmaker-common'}

        @upsert_InvalidUrl_14 @eGov_Localization @eGov
        Scenario: Upsert with Invalid URL
     * def index = 0

    * def upsertUrl = 'https://egov-micro-qa.egovernments.org/localization/v1/_upsert'
    * call read('../pretests/upsert.feature@upsert_403')  { upsertUrl: '#(upsertUrl)', index: '#(index)'}
	* match upsertResponseBody.Errors[0].message contains 'Not authorized to access this resource'

        @Upsert_InvaliidTenantId_09 @eGov_Localization @eGov
        Scenario: Test by passing a invalid value for Tenant ID
    * def message = ranString(50)
	* def code = 'TB.CHALLAN_UNDER_SECTION_' + ranInteger(4) + '_FIELD_FEE'
	* print code
    * print message
    * def index = 2
    
    * call read('../pretests/upsert.feature@upsert_403') { index: '#(index)'}
	* match upsertResponseBody.Errors[0].message contains 'Not authorized to access this resource'
	
        @search-localization_14 @eGov_Localization @eGov
        Scenario: Upsert with Invalid Auth_Token

    * def authToken = 'invalid_authToken'
    * call read('../pretests/upsert.feature@upsert_500')
	* match upsertResponseBody.Errors[0].message contains 'InvalidAccessTokenException'
