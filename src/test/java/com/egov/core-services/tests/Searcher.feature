Feature: Core service - Searcher

        Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def searcherConstants = read('../../core-services/constants/searcher.yaml')
    # initializing searcher request payload objects
    * def errorManadatoryTenantId = searcherConstants.errorMessages.tenantIdMandatory
    * def businesService = mdmsStateBillingService.BusinessService[0].code
    * def url1 = mdmsStateBillingService.BusinessService[0].billGineiURL
    * def searcherWSURL = mdmsStateBillingService.BusinessService[1].billGineiURL
    * def businesServiceSW = mdmsStateBillingService.BusinessService[86].code
    * def businesServiceWS = mdmsStateBillingService.BusinessService[85].code
    * def multiServiceCode = businesService + ',' + businesServiceSW + ',' + businesServiceWS
    * def mobileNumber = commonConstants.invalidParameters.nullValue
    # calling searcherPretest with NO mobilenumber to get the registered number
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * def MobileNum = searcherResponseBody.Bills[0].mobileNumber

        @Searcher_Bill_01 @positive @Searcher
        Scenario: Test searching for a bill using egov searcher API service
    
    * def mobileNumber = MobileNum
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * assert searcherResponseBody.Bills.length != 0
    * assert searcherResponseBody.Bills[0].billDetails.length != 0
    * assert searcherResponseBody.Bills[0].businessService == businesService


        @Searcher_InvalidReqUrl_02 @negative @Searcher
        Scenario: Test searching for a bill using egov searcher API service

    * def businesService = businesServiceWS
    * def mobileNumber = MobileNum
    * def url1 = searcherWSURL
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * assert searcherResponseBody.Bills.length == 0

        @Searcher_InvalidTenant_03 @negative @Searcher
        Scenario: Test by passing invalid/non existent or null value for tenant id
 
    * def tenantId = commonConstants.invalidParameters.emptyValue
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchError')
    * assert searcherResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

        @Searcher_Mandatory_04 @negative @Searcher
        Scenario: Test by not passing the mandatory parameter tenantid

    * def tenantId = commonConstants.invalidParameters.nullValue
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchWithoutTenantIdError')
    * match searcherResponseBody.Errors[0].message == errorManadatoryTenantId
    

        @Searcher_MultipleSearch_06 @negative @Searcher
        Scenario: Test by passing multiple parameters

    * def businesService = multiServiceCode
    * def mobileNumber = MobileNum
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * assert searcherResponseBody.Bills.length == 0


        @Searcher_NullMobile_07 @negative @Searcher
        Scenario: Test by passing null value for mobile number

    * def businesService = businesServiceWS
    * def mobileNumber = commonConstants.invalidParameters.emptyValue
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * assert searcherResponseBody.Bills.length == 0



        @Searcher_NullBusinessSer_08 @negative @Searcher
        Scenario: Test by passing null value for Business Service

    * def businesService = commonConstants.invalidParameters.emptyValue
    * def mobileNumber = MobileNum
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * assert searcherResponseBody.Bills.length == 0


        @Searcher_NullUrl_09 @negative @Searcher
        Scenario: Test by passing null value for URL

    * def mobileNumber = MobileNum
    * def url1 = commonConstants.invalidParameters.emptyValue
    # calling searcher pretest
    * call read('../../core-services/pretests/searcherPretest.feature@searchSuccessfully')
    * assert searcherResponseBody.Bills.length != 0
   

    