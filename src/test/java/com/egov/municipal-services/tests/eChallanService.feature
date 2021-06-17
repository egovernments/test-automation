Feature: eChallan Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(10000)
    * def formDate = mdmsStateBillingService.TaxPeriod[0].fromDate
    * def toDate = mdmsStateBillingService.TaxPeriod[0].toDate
    * def businessService = mdmsStateBillingService.BusinessService[7].code
    * def taxHeadCode = mdmsStateBillingService.TaxHeadMaster[25].code
    * def changeHeadCode = mdmsStateBillingService.TaxHeadMaster[26].code
    * def advt = "ADVT"
    * def challanConstants = read('../../municipal-services/constants/eChallanService.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def mobileNumber = '77' + randomMobileNumGen(8)
    * def name = 'AUTO' + randomString(10)
    * def amount = "8809"
    * def changeAmount = 108
    * def cash = "Cash"
    * def common = "COMMON_OWNER"
    * def cgst = "ADVT.HOARDINGS_CGST"
    * def sgst = "ADVT.HOARDINGS_SGST"

    @eChallan_create_01 @positive @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API 
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * match challanResponseBody.challans[0].id == '#present'
    * match challanResponseBody.challans[0].tenantId == '#present'
    * match challanResponseBody.challans[0].challanNo == '#present'

    @eChallan_create_InvalidTenantId_02 @negative @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API with wrong tenantID
    * def tenantId = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError')
    * match challanResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @eChallan_create_emptyBusinessService_03 @negative @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API with empty business service
    * def businessService = " "
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidBusinessSevice

    @eChallan_create_invalid_BusinessService_04 @negative @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API with invalid business service
    * def businessService = randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidBusinessSevice

    @eChallan_create_InvalidTaxHeadCode_05 @negative @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API with invalid textHead Code
    * def taxHeadCode = randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidTextCode

    @eChallan_create_InvalidLocality_06 @negative @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API with invalid locality Code
    * def localityCode = randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidLocality

    @eChallan_create_empty_CitizenName_07 @negative @regression @municipalService @echallanServie @eChallanServiceCreate
    Scenario: Verify creating a echallan service application through API with empty citizen name
    * def name = ""
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.emptyCitizenName

    @eChallan_search_01 @positive @regression @municipalService @echallanServie @eChallanServiceSearch
    Scenario: Verify search echallan service application through API
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanSearchParam = {"tenantId": '#(tenantId)', "challanNo": '#(challanNo)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@searchEChallanSuccessfully')
    * match challanResponseBody.challans[0] == '#present'

    @eChallan_search_InvalidTenant_02 @negative @regression @municipalService @echallanServie @eChallanServiceSearch
    Scenario: Verify search echallan service application through API with invalid tenantId
    * def tenantId = "invalid-tenant-" + randomString(10)
    * def geteChallanSearchParam = {"tenantId": '#(tenantId)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@searchEChallanError')
    * match challanResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @eChallan_search_InvalidChallan_03 @negative @regression @municipalService @echallanServie @eChallanServiceSearch
    Scenario: Verify search echallan service application through API with invalid challan
    * def challanNo = "invalid-tenant-" + randomString(10)
    * def geteChallanSearchParam = {"tenantId": '#(tenantId)', "challanNo": '#(challanNo)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@searchEChallanSuccessfully')
    * match challanResponseBody.challans[0] == '#notpresent'

    @eChallan_search_InvalidMobileNo_04 @negative @regression @municipalService @echallanServie @eChallanServiceSearch
    Scenario: Verify search echallan service application through API with invalid challan
    * def mobileNumber = commonConstants.invalidParameters.invalidMobileNumber
    * def geteChallanSearchParam = {"tenantId": '#(tenantId)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@searchEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidMobileNo

    @eChallan_search_Without_Params_05 @negative @regression @municipalService @echallanServie @eChallanServiceSearch
    Scenario: Verify search echallan service application through API without params
    * def geteChallanSearchParam = { }
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@searchEChallanError1')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.withoutParams

    @eChallan_update_01 @positive @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanSuccessfully')
    * match challanResponseBody.challans[0] == '#present'

    @eChallan_update_invalid_tenantId_02 @negative @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API with invalid tenantID
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def tenantId = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidTenantId

    @eChallan_update_invalid_challanId_03 @negative @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API with invalid challan ID
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def challanNo = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidChallan

    @eChallan_update_invalid_accountId_04 @negative @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API with invalid Account ID
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def accountId = "^%$#&*^%"
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanSuccessfully')
    * match challanResponseBody.challans[0] == '#present'

    @eChallan_update_invalid_taxHeadCode_05 @negative @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API with invalid textHeadCode
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * set amount[0].taxHeadCode = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidTextHeadCode

    @eChallan_update_invalid_localityCode_06 @negative @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API with invalid Locality
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * set address.locality.code = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidLocality

    @eChallan_update_invalid_applicationStatus_07 @negative @regression @municipalService @echallanServie @eChallanServiceUpdate
    Scenario: Verify update echallan service application through API with invalid applcaiton status
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def applicationStatus = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidApplicationStatus

    @eChallan_fetch_01 @positive @regression @municipalService @echallanServie @eChallanServiceFetch
    Scenario: Verify fetch echallan service application through API
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanFetchParam = {"challanNo": '#(challanNo)',"tenantId": '#(tenantId)', "businessService": '#(businessService)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@fetchEChallanSuccessfully')
    * match challanResponseBody.Bill[0] == '#present'

    @payments_create_01 @positive @regression @municipalService @echallanServie @eChallanServicePayment
    Scenario: Verify payment echallan service application through API
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanFetchParam = {"challanNo": '#(challanNo)',"tenantId": '#(tenantId)', "businessService": '#(businessService)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@fetchEChallanSuccessfully')
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@paymentEChallanSuccessfully')
    * match challanResponseBody == '#present'

    @payments_create_Invalid_billId_02 @negative @regression @municipalService @echallanServie @eChallanServicePayment
    Scenario: Verify payment echallan service application through API with invalid bill ID
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanFetchParam = {"challanNo": '#(challanNo)',"tenantId": '#(tenantId)', "businessService": '#(businessService)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@fetchEChallanSuccessfully')
    * def billId = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@paymentEChallaError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidBillId

    @payments_create_Invalid_TotalAmount_paid_03 @negative @regression @municipalService @echallanServie @eChallanServicePayment
    Scenario: Verify payment echallan service application through API with invalid Total Amount
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanFetchParam = {"challanNo": '#(challanNo)',"tenantId": '#(tenantId)', "businessService": '#(businessService)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@fetchEChallanSuccessfully')
    * def amount = randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@paymentEChallaError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.invalidBillId

    @payments_create_Invalid_TenantId_04 @negative @regression @municipalService @echallanServie @eChallanServicePayment
    Scenario: Verify payment echallan service application through API with invalid Total Amount
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanFetchParam = {"challanNo": '#(challanNo)',"tenantId": '#(tenantId)', "businessService": '#(businessService)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@fetchEChallanSuccessfully')
    * def tenantId = "invalid-tenant-" + randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@paymentEChallaError1')
    * match challanResponseBody.Errors[0].message == commonConstants.errorMessages.authorizedError

    @payments_create_Invalid_PaymentMode_05 @negative @regression @municipalService @echallanServie @eChallanServicePayment
    Scenario: Verify payment echallan service application through API with invalid Total Amount
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
    * def geteChallanFetchParam = {"challanNo": '#(challanNo)',"tenantId": '#(tenantId)', "businessService": '#(businessService)', "mobileNumber": '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@fetchEChallanSuccessfully')
    * def cash = randomString(10)
    * call read('../../municipal-services/pretests/eChallanServicePretest.feature@paymentEChallaError')
    * match challanResponseBody.Errors[0].message == challanConstants.errorMessages.withoutParams


    # echallan calculator isnot required to automate becuase we are checking in local only and also we are going to checking in kafka testcase place