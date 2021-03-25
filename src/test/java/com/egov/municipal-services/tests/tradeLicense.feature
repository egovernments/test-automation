Feature: TL-Service endpont tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../municipal-services/tests/PropertyService.feature@createPropertyAndAssess')
    * def tradeLicenseConstants = read('../../municipal-services/constants/tradeLicense.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # initializing request payload variables
    * def licenseType = tradeLicenseConstants.licenseType.permenant
    * def tenantId = tenantId
    * def city = tenantId.split(".")[0]
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def department = mdmsStatecommonMasters.Department[0].code
    * def structureType = mdmsStatecommonMasters.StructureType[1].code
    * def tradeType = tradeLicenseConstants.tradeType.goodsManufactureT15
    * def subOwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code +"."+mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def tlmobileNumber = '78' + randomMobileNumGen(8)
    * def ownerName = randomString(20)
    * def fatherHusbandName = randomString(20)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def dob = getPastEpochDate(5000)
    * def permenantAddress = randomString(50)
    * def financialYear = commonConstants.parameters.financialYear
    * def tradeName = randomString(20)
    * def commencementDate = getPastEpochDate(50)
    * def workflowCode = tradeLicenseConstants.workflowCode.newTradeLicense
    * def applicationType = tradeLicenseConstants.applicationType.type
    * def tlAction = tradeLicenseConstants.processInstanceActions.initiate

@tradeLicenseCreate_1 @municipalServices @regression @positive @tradeLicenseCreate @sewerageConnection
Scenario: Test to create Trade License With Valid Payload
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    * assert tradeLicenseResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # #Match the response
    * match tradeLicenseResponseBody.Licenses[0].id == "#present"
    * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId
    * match tradeLicenseResponseBody.Licenses[0].propertyId == "#present"
    * match tradeLicenseResponseBody.Licenses[0].applicationNumber == "#present"
    * match tradeLicenseResponseBody.Licenses[0].status == tradeLicenseConstants.status.initiated
    * match tradeLicenseResponseBody.Licenses[0].applicationType == tradeLicenseConstants.applicationType.type
    * match tradeLicenseResponseBody.Licenses[0].status == tradeLicenseConstants.status.initiated