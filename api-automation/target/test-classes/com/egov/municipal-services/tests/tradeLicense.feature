Feature: Trade License Service Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    #* call read('../../municipal-services/tests/PropertyService.feature@createActiveProperty')
    * def tradeLicenseConstants = read('../../municipal-services/constants/tradeLicense.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # initializing request payload variables
    * def licenseType = tradeLicenseConstants.licenseType.permenant
    * def tenantId = tenantId
    * def city = tenantId.split(".")[0]
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def department = mdmsStatecommonMasters.Department[0].code
    * def structureType = mdmsStatecommonMasters.StructureType[1].code
    * def tradeType = tradeLicenseConstants.tradeType.goodsManufactureT15
    * def subOwnerShipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code +"."+mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def tlmobileNumber = citizenUsername
    * def ownerName = randomString(20)
    * def fatherHusbandName = randomString(20)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def dob = getPastEpochDate(5000)
    * def permenantAddress = randomString(50)
    * def financialYear = commonConstants.parameters.financialYear
    * def financialYear2 = tradeLicenseConstants.financialYear
    * def tradeName = randomString(20)
    * def commencementDate = getPastEpochDate(50)
    * def workflowCode = tradeLicenseConstants.workflowCode.newTradeLicense
    * def applicationType = tradeLicenseConstants.applicationType.new
    * def tlAction = tradeLicenseConstants.processInstanceActions.initiate
    * def documentType1 = tradeLicenseConstants.documentType.type1
    * def documentType2 = tradeLicenseConstants.documentType.type2
    * def documentType3 = tradeLicenseConstants.documentType.type3    
    * def uom = mdmsStateTradeLicense.AccessoriesCategory[0].uom
    * def accessoryCategory = mdmsStateTradeLicense.AccessoriesCategory[0].code
    * def count = randomNumber(200)
    * def uomValue = randomNumber(200)
    * def invalidLicenseType = randomString(10)
    * def invalidLocalityCode = randomString(10)
    * def invalidStructureType = randomString(10)
    * def invalidMobileNumber = tlmobileNumber + randomString(2)
    * def invalidFinancialYear = financialYear + randomString(2)
    * def invalidTenantId =  tenantId  + randomString(3)
    * def invalidUom = uom + randomString(2)
    * def tradeLicenseOffset = 0


    @tradeLicenseCreate1 @municipalServices @regression @positive @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Valid Payload
    # Steps to create a new trade license    
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    * assert tradeLicenseResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # #Match the response
    * match tradeLicenseResponseBody.Licenses[0].id == "#present"
    * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId
    * match tradeLicenseResponseBody.Licenses[0].propertyId == "#present"
    * match tradeLicenseResponseBody.Licenses[0].applicationNumber == "#present"
    * match tradeLicenseResponseBody.Licenses[0].status == tradeLicenseConstants.status.initiated
    * match tradeLicenseResponseBody.Licenses[0].applicationType == tradeLicenseConstants.applicationType.new

    #BUG - INVALID LICENSE TYPE - ERROR RESPONSE IS NOT PROPER
     @tradeLicenseCreate2 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid License Type
    * def licenseType = invalidLicenseType
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicense')
    # #Match the response
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidLicenseType
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.invalidLicenseType


     @tradeLicenseCreate4 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid Locality Type
    * def localityCode = invalidLocalityCode
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicense')
    # #Match the response
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidLocality
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.invalidLocality

    #Bug: Same error message returns Two times.
    @tradeLicenseCreate5 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid Structure Type
    * def structureType = invalidStructureType
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicense')
    # #Match the response
    * def errorMessage = "The structureType '"+invalidStructureType+"' does not exists"
    # * print tradeLicenseResponseBody
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidStructureType
    * match tradeLicenseResponseBody.Errors[0].message == errorMessage

    @tradeLicenseCreate6 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid Mobile Number
    * def tlmobileNumber = invalidMobileNumber
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicense')
    # #Match the response
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidMobileNumber
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.invalidMobileNumber

    @tradeLicenseCreate7 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid Financial Year
    * def financialYear = invalidFinancialYear
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicense')
    # #Match the response
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidFinancialYear
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.invalidFinancialYear + invalidFinancialYear

    #Bug - Sometimes getting custom exception. Need to discuss
    @tradeLicenseCreate8 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid Tenant Id
    * def tenantId = invalidTenantId
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicenseUnAuthorized')
    # #Match the response
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidTenantId
    * match tradeLicenseResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError


    @tradeLicenseCreate9 @municipalServices @regression @negative @tradeLicenseCreate @tradeLicense
    Scenario: Test to create Trade License With Invalid Tenant Id
    * def uom = invalidUom
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@errorCreateTradeLicense')
    # #Match the response
    * def errorMessage = "The UOM: "+uom+" is not valid for accessoryCategory: "+accessoryCategory+""
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.invalidUOM
    * match tradeLicenseResponseBody.Errors[0].message == errorMessage
    

    @tradeLicenseSearch1 @tradeLicense @positive @regression @municipalServices
    Scenario: Search Trade License with valid query parameters
    # Steps to create a new Trade License
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def searchTradeLicenseParams = { offset: #(tradeLicenseOffset), tenantId: '#(tenantId)', offset: #(tradeLicenseOffset), mobileNumber: '#(tlmobileNumber)', applicationType: '#(applicationType)', applicationNumber: '#(tradeLicenseApplicationNumber)', status: '#(tradeLicenseStatus)'}
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTradeLicenseSuccessfully')
    # Validate response body
    * match tradeLicenseResponseBody.Licenses[0].id == "#present"
    * match tradeLicenseResponseBody.Licenses[0].applicationNumber == tradeLicenseApplicationNumber
    * match tradeLicenseResponseBody.Licenses[0].status == tradeLicenseStatus
    * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId

    @tradeLicenseSearch2 @tradeLicense @negative @regression @municipalServices
    Scenario: Search Trade License with No Tenant
    # Steps to create a new Trade License
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def searchTradeLicenseParams = { offset: #(tradeLicenseOffset), mobileNumber: '#(tlmobileNumber)', applicationType: '#(applicationType)', applicationNumber: '#(tradeLicenseApplicationNumber)', status: '#(tradeLicenseStatus)'}
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTradeLicenseError')
    # Validate response body
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.noTenantId
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.noTenantId

    @tradeLicenseSearch3 @tradeLicense @negative @regression @municipalServices
    Scenario: Search Trade License with Invalid License Type
    # Steps to create a new Trade License
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def searchTradeLicenseParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTradeLicenseError')
    # Validate response body
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.onlyTenantId
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.onlyTenantId



    @tradeLicenseSearch4 @tradeLicense @positive @regression @municipalServices
    Scenario: Search Trade License with valid query parameters
    # Steps to create a new Trade License
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def invalidTradeLicenseApplicationNumber = tradeLicenseApplicationNumber + randomString(10)
    * def invalidtlmobileNumber = randomNumber(10)

    * def searchTradeLicenseParams = { tenantId: '#(tenantId)', mobileNumber: '#(invalidtlmobileNumber)', applicationType: '#(applicationType)', applicationNumber: '#(invalidTradeLicenseApplicationNumber)', status: '#(tradeLicenseStatus)'}
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTradeLicenseSuccessfullyWithInvalidData')
    # Validate response body
    * assert tradeLicenseResponseBody.Licenses.length == 0


    @tradeLicenseSearch5 @tradeLicense @positive @regression @municipalServices
    Scenario: Search Trade License with tenant Id and Mobile Number
    # Steps to create a new Trade License
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def searchTradeLicenseParams = { tenantId: '#(tenantId)', mobileNumber: '#(tlmobileNumber)'}
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTradeLicenseSuccessfully')
    # Validate response body
    * match tradeLicenseResponseBody.Licenses[0].id == "#present"
    * match tradeLicenseResponseBody.Licenses[0].applicationNumber == tradeLicenseApplicationNumber
    * match tradeLicenseResponseBody.Licenses[0].status == tradeLicenseStatus
    * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId

    @tradeLicenseUpdate1  @tradeLicenseUpdate @positive  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Update To Document Verification
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
        # Initializing search query params
        * set tradeLicense.action = tradeLicenseConstants.processInstanceActions.initiate
        * set tradeLicense.status = tradeLicenseConstants.status.initiated
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseSuccessfully')
        * match tradeLicenseResponseBody.Licenses[0].id == "#present"
        * match tradeLicenseResponseBody.Licenses[0].applicationNumber == tradeLicenseApplicationNumber
        * match tradeLicenseResponseBody.Licenses[0].status == tradeLicenseStatus
        * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId
    @tradeLicenseUpdate2  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Business Service
        # Create a Trade License
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
        # Initializing search query params
        * set tradeLicense.businessService = randomString(10)
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
        * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidBusinessService
        * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.updateInvalidBusinessService

    @tradeLicenseUpdate3  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid License Type
        # Create a Trade License
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
        # Initializing search query params
        * set tradeLicense.licenseType = randomString(10)
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
        * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidLicenseType
        * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.updateInvalidLicenseType

    @tradeLicenseUpdate4  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Financial Year
    # Create a Trade License
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def invalidFinancialYear = randomNumber(3) + "-" + randomNumber(3)
    * set tradeLicense.financialYear = invalidFinancialYear
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidFinancialYear
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.updateInvalidFinancialYear + invalidFinancialYear

    @tradeLicenseUpdate5  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Id
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * set tradeLicense.id = randomString(10)
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidId
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.updateInvalidId

    @tradeLicenseUpdate6  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Trade License Id
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def tradeLicenseInvalidId = randomString(10)
    * set tradeLicense.tradeLicenseDetail.id = tradeLicenseInvalidId
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidLicenseId
    * match tradeLicenseResponseBody.Errors[0].message == replaceString(tradeLicenseConstants.errors.errorMessages.updateInvalidLicenseId,"<<license_id>>",tradeLicenseInvalidId)

    @tradeLicenseUpdate8  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid UUID
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def invalidOwnerUUID = randomString(10)
    * def validUUID = tradeLicense.tradeLicenseDetail.owners[0].uuid
    * set tradeLicense.tradeLicenseDetail.owners[0].uuid = invalidOwnerUUID
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidOwnerUUID
    * match tradeLicenseResponseBody.Errors[0].message == replaceString(tradeLicenseConstants.errors.errorMessages.updateInvalidOwnerUUID,"<<owner_id>>",validUUID)

    @tradeLicenseUpdate9  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Mobile Number
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def invalidtlMobileNumber = randomNumber(9)
    * set tradeLicense.tradeLicenseDetail.owners[0].mobileNumber = invalidtlMobileNumber
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidMobileNumber
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.updateInvalidMobileNumber

    @tradeLicenseUpdate10  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid UOM
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def accessoryCategory = tradeLicense.tradeLicenseDetail.accessories[0].accessoryCategory
    * def invalidUOM = randomString(9)
    * set tradeLicense.tradeLicenseDetail.accessories[0].uom = invalidUOM
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidUOM
    * match tradeLicenseResponseBody.Errors[0].message == replaceString(tradeLicenseConstants.errors.errorMessages.updateInvalidUOM,"<<invalid_uom>>",invalidUOM) + accessoryCategory

    @tradeLicenseUpdate11  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Tenant Id
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * set tradeLicense.tenantId = randomString(10)
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidTenantId
    * match tradeLicenseResponseBody.Errors[0].message == tradeLicenseConstants.errors.errorMessages.updateInvalidTenantId

   @tradeLicenseUpdate12  @tradeLicenseUpdate @negative  @regression  @municipalServices @tradeLicense
    Scenario: Update Trade License - Invalid Application Number
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def applicatonNumber = tradeLicense.applicationNumber
    * def invalidApplicationNumber = applicatonNumber + randomString(1)
    * set tradeLicense.applicationNumber = invalidApplicationNumber
    * def invalidapperrormessage1 = replaceString(tradeLicenseConstants.errors.errorMessages.updateInvalidApplicationId,"<<application_search_no>>",applicatonNumber)
    * def invalidapperrormessage = replaceString(invalidapperrormessage1,"<<application_update_no>>",invalidApplicationNumber)
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@updateTradeLicenseError')
    * match tradeLicenseResponseBody.Errors[0].code == tradeLicenseConstants.errors.errorCodes.updateInvalidApplicationId
    * match tradeLicenseResponseBody.Errors[0].message == invalidapperrormessage 

    @createAndupdateTL
    Scenario: Create and Update Trade License - Update To Document Verification
        * def financialYear = financialYear2
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@forwardTradeLicenseToDocumentVerifier')
        * match tradeLicenseResponseBody.Licenses[0].id == "#present"
        * match tradeLicenseResponseBody.Licenses[0].applicationNumber == "#present"
        * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @updateTL_Only
    Scenario: Update Trade License - Update To Document Verification
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@citizenToDocumentVerifier')
        * match tradeLicenseResponseBody.Licenses[0].id == "#present"
        * match tradeLicenseResponseBody.Licenses[0].applicationNumber == "#present"

    @docVerTL
    Scenario: Update Trade License - Update To Field Inspector
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@forwardTradeLicenseToFieldInspector')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @fiTL
    Scenario: Update Trade License - Update To Approver
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@forwardTradeLicenseToApprover')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @approveTL
    Scenario: Update Trade License - Update To Payment pending
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@forwardTradeLicenseToPendingPayment')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @rejectTLAsdocVer
    Scenario: Update Trade License - Reject as Doc Verifier
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@rejectDocVerifier')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @rejectTLAsFieldInspector
    Scenario: Reject As Field Ispector
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@rejectFieldInspector')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @rejectTLAsApprover
    Scenario: Reject TL As Approver
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@rejectApprover')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @sendBackToCitizenFromFieldInspector
    Scenario: Send Back to Citizen from Field Inspector
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@sendBackToCitizen_FI')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @sendBackToDocVerifierFromFieldInspector
    Scenario: Send Back to DocVerifier from Field Inspector
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@sendBackToDocVerifier_FI')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @sendBackToFieldInspectorFromApprover
    Scenario: Send Back to FieldInspector from Approver
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@sendBackToFieldInspector_Approver')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @tradeLicenseSearch
    Scenario: Search Trade License with valid query parameters
        # Initializing search query params
        * def searchTradeLicenseParams = { tenantId: '#(tenantId)', applicationNumber: '#(tradeLicenseApplicationNumber)'}
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTradeLicenseSuccessfully')
        # Validate response body
        * match tradeLicenseResponseBody.Licenses[0].id == "#present"
        * match tradeLicenseResponseBody.Licenses[0].applicationNumber == tradeLicenseApplicationNumber
        * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]
        * def validTo = tradeLicense.validTo

    @cancelTL
    Scenario: Cancel TL application : Approver
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@cancel_Approver')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]
        * match tradeLicense.status == 'CANCELLED'

    @submitRenewal
    Scenario: Submit for Renewal
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@submitForRenewal')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]
        * match tradeLicense.status == 'PENDINGPAYMENT'

    @editRenewal
    Scenario: Edit Renewal : Counter Employee
        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@editForRenewal')
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]
        #* match tradeLicense.status == 'PENDINGPAYMENT'

    @updateTLAfterEdit
    Scenario: Update After Editing Trade License - Update To Document Verification

        * call read('../../municipal-services/pretests/tradeLicensePretest.feature@forwardTradeLicenseToDocumentVerifierAfterEditing')
        * match tradeLicenseResponseBody.Licenses[0].id == "#present"
        * match tradeLicenseResponseBody.Licenses[0].applicationNumber == "#present"
        * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId
        * def tradeLicense = tradeLicenseResponseBody.Licenses[0]

    @SearchLicense_TL01 @tradeLicense @positive @municipalServices @searchLicense @r2dot6
    Scenario: Search Trade License with valid query parameters
    # Steps to create a new Trade License
    #* call read('../../municipal-services/pretests/tradeLicensePretest.feature@successCreateTradeLicense')
    # Initializing search query params
    * def searchLicenseParams = {tenantId: '#(tenantId)', mobileNumber: '7979797979', RenewalPending: true}
    * call read('../../municipal-services/pretests/tradeLicensePretest.feature@searchTLLicenseSuccessfully')
    # Validate response body
    * match tradeLicenseResponseBody.Licenses[0].id == '#present'
    * match tlApplicationNumber == '#present'
    * match tradeLicenseResponseBody.Count == '#present'
    * match tradeLicenseResponseBody.Licenses[0].tenantId == tenantId