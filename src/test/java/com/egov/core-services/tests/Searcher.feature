Feature: Core service - Searcher

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    #* def searcherServiceConstants = read('../constants/searcher.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def errorManadatoryTenantId = 'Missing Mandatory Property: $.searchCriteria.tenantId'
    # Calling access token
    * def authUsername = authUsername
    * def authPassword = authPassword
    * def authUserType = authUserType
    * call read('../pretests/authenticationToken.feature')
    # MDMS call
    * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
    * def businesService = mdmsStateBillingService.BusinessService[0].code
    # PT billGineiURL
    * def url1 = mdmsStateBillingService.BusinessService[0].billGineiURL
    * def searcherWSURL = mdmsStateBillingService.BusinessService[1].billGineiURL
    * def businesServiceSW = mdmsStateBillingService.BusinessService[86].code
    * def businesServiceWS = mdmsStateBillingService.BusinessService[85].code
    * def multiServiceCode = businesService + ',' + businesServiceSW + ',' + businesServiceWS
    * def mobileNumber = commonConstants.invalidParameters.nullValue
    # calling searcherPretest with NO mobilenumber to get the registered number
    * call read('../pretests/searcherPretest.feature@success')
    * def MobileNum = searcherResponseBody.Bills[0].mobileNumber

@Searcher_Bill_01 @positive @Searcher
Scenario: Test searching for a bill using egov searcher API service
    
    * def mobileNumber = MobileNum
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length != 0
    * assert searcherResponseBody.Bills[0].billDetails.length != 0
    * assert searcherResponseBody.Bills[0].businessService == businesService


@Searcher_InvalidReqUrl_02 @negative @Searcher
Scenario: Test searching for a bill using egov searcher API service

    * def businesService = businesServiceWS
    * def mobileNumber = MobileNum
    * def url1 = searcherWSURL
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0

@Searcher_InvalidTenant_03 @negative @Searcher
Scenario: Test by passing invalid/non existent or null value for tenant id
 
    * def tenantId = commonConstants.invalidParameters.emptyValue
    * call read('../pretests/searcherPretest.feature@error')
    * assert searcherResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError
    * print searcherResponseBody.Errors[0].message

@Searcher_Mandatory_04 @negative @Searcher
Scenario: Test by not passing the mandatory parameter tenantid

    * def tenantId = commonConstants.invalidParameters.nullValue
    * call read('../pretests/searcherPretest.feature@error_notenant')
    * assert searcherResponseBody.Errors[0].message == errorManadatoryTenantId
    

@Searcher_MultipleSearch_06 @negative @Searcher
Scenario: Test by passing multiple parameters

    * def businesService = multiServiceCode
    * def mobileNumber = MobileNum
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0


@Searcher_NullMobile_07 @negative @Searcher
Scenario: Test by passing null value for mobile number

    * def businesService = businesServiceWS
    * def mobileNumber = commonConstants.invalidParameters.emptyValue
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0



@Searcher_NullBusinessSer_08 @negative @Searcher
Scenario: Test by passing null value for Business Service

    * def businesService = commonConstants.invalidParameters.emptyValue
    * def mobileNumber = MobileNum
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length == 0


@Searcher_NullUrl_09 @negative @Searcher
Scenario: Test by passing null value for URL

    * def mobileNumber = MobileNum
    * def url1 = commonConstants.invalidParameters.emptyValue
    * call read('../pretests/searcherPretest.feature@success')
    * assert searcherResponseBody.Bills.length != 0
   

    