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


@eChallanEndToEnd1 @positive @regression @municipalService @echallanServie @eChallanServiceCreate
Scenario: Verify creation of eChallan as Admin
* call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
* match challanResponseBody.challans[0].id == '#present'
* match challanResponseBody.challans[0].tenantId == '#present'
* match challanResponseBody.challans[0].challanNo == '#present'

@eChallanEndToEnd2 @positive @regression @municipalService @echallanServie @eChallanServiceCreate
Scenario: Verify creation of eChallan as Citizen Unsucessfully
* def authToken = citizenAuthToken
* call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanError')
* match challanResponseBody.Errors[0].description == challanConstants.errorMessages.unAuthorizedError
* match challanResponseBody.Errors[0].message == '#present'

@eChallanEndToEnd3 @positive @regression @municipalService @echallanServie @eChallanServiceCreate
Scenario: Update eChallan as Emp Editor 
#login as empployee editor here -->
* call read('../../municipal-services/pretests/eChallanServicePretest.feature@createEChallanSuccessfully')
* match challanResponseBody.challans[0].id == '#present'
* match challanResponseBody.challans[0].tenantId == '#present'
* match challanResponseBody.challans[0].challanNo == '#present'
* call read('../../municipal-services/pretests/eChallanServicePretest.feature@updateEChallanSuccessfully')



