Feature: Core service - Searcher

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def expectedMessage = read('../constants/searcher.yaml')
    * def errorManadatoryTenantId = "Missiing Mandatory Property: $.searchCriteria.tenantId"
    # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def tenantId = tenantId
    * print tenantId
    * def authUserType = expectedMessage.parameters.userType
    * call read('../pretests/authenticationToken.feature')

@Searcher_Bill_01 @positive @Searcher
Scenario: Test searching for a bill using egov searcher API service

    * def businesService = expectedMessage.parameters.businesServicePT
    * def mobileNumber = expectedMessage.parameters.mobileNumber

    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length != 0
    * assert searcherResponseBody.Bills[0].billDetails.length != 0
    * assert searcherResponseBody.Bills[0].businessService == businesService


@Searcher_InvalidReqUrl_02 @negative @Searcher
Scenario: Test searching for a bill using egov searcher API service

    * def businesService = expectedMessage.parameters.businesServiceWS
    * def mobileNumber = expectedMessage.parameters.mobileNumber
    * def url1 = expectedMessage.parameters.searcherWSURL

    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0


@Searcher_InvalidTenant_03 @negative @Searcher
Scenario: Test by passing invalid/non existent or null value for tenant id
 
    * def tenantId = expectedMessage.parameters.invalidtenantId
    * call read('../pretests/searcherPretest.feature@error')
    * assert searcherResponseBody.Errors[0].message == expectedMessage.expectedErrorMessages.Authorized


@Searcher_Mandatory_04 @negative @Searcher
Scenario: Test by not passing the mandatory parameter tenantid

    * def tenantId = null
    * def businesService = expectedMessage.parameters.businesServiceWS
    * call read('../pretests/searcherPretest.feature@error_notenant')
    * assert searcherResponseBody.Errors[0].message == errorManadatoryTenantId
    

@Searcher_MultipleSearch_06 @negative @Searcher
Scenario: Test by passing multiple parameters

    * def businesService = expectedMessage.parameters.allServices
    * def mobileNumber = expectedMessage.parameters.mobileNumber

    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0


@Searcher_NullMobile_07 @negative @Searcher
Scenario: Test by passing null value for mobile number

    * def businesService = expectedMessage.parameters.businesServiceWS
    * def mobileNumber = expectedMessage.parameters.noMobileNumber
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0



@Searcher_NullBusinessSer_08 @negative @Searcher
Scenario: Test by passing null value for Business Service

    * def businesService = expectedMessage.parameters.nobusinesService
    * def mobileNumber = expectedMessage.parameters.mobileNumber
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0


@Searcher_NullUrl_09 @negative @Searcher
Scenario: Test by passing null value for URL

    * def businesService = expectedMessage.parameters.businesServicePT
    * def mobileNumber = expectedMessage.parameters.mobileNumber
    * def url1 = expectedMessage.parameters.noURL
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length != 0
   

    