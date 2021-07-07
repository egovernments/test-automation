Feature: DCR Service Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def transactionNumber = randomString(20)
    * def applicantName = 'AUTO_NAME_' + ranInteger(10)
    * def appliactionType = mdmsStateBPA.ApplicationType[0].code
    * def applicationSubType = mdmsStateBPA.ServiceType[0].code
    * def testData = '../../common-services/testData/scrunity.dxf'
    * def dcrConstants = read('../../municipal-services/constants/dcrServices.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # TODO : taking hardCode value of ocdcrNumber as pf now, once end to end BPA is done will remove this ocdcrNumber hardCoded value
    * def ocdcrNumber = 'OCDCR42021JH3YL'

@scrutinizePlan_01 @positive @regression @dcrService
Scenario: Verify scrutinizing a plan through API call
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunity')
    * match scrunityResponseBody.edcrDetail[0] == '#present'
    * match scrunityResponseBody.edcrDetail[0].status == dcrConstants.status

#Throwing 500 error Should throw 400 status
@scrutinizePlan_FileError_02 @negative @regression @dcrService
Scenario: Verify by not uploading any file 
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityNoFileError')
    * match scrunityResponseBody.Errors[0].message == dcrConstants.errorMessages.noFileError

@scrutinizePlan_TxnError_03 @negative @regression @dcrService
Scenario: Verify by sending same transaction number twice
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunity')
    * def transactionNumber = scrunityResponseBody.edcrDetail[0].transactionNumber
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityError')
    * match scrunityResponseBody[0].errorMessage == dcrConstants.errorMessages.transactionError

@scrutinizePlan_InvalidTenant_04 @negative @regression @dcrService
Scenario: Verifying by passing a invalid tenant id in the request
    * def tenantId = dcrConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityError')
    * match scrunityResponseBody.error_description == commonConstants.errorMessages.invalidTenantId + ': ' + tenantId

@scrutinizePlan_Txn_null_05 @negative @regression @dcrService
Scenario: Verify by passing "null" for transaction number
    * def transactionNumber = commonConstants.invalidParameters.emptyValue
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityError')
    * match scrunityResponseBody[0].errorMessage == dcrConstants.errorMessages.emptyTransaction

@scrutinizePlan_InvalidAppTypeSubType_06 @negative @regression @dcrService
Scenario: Verifying by passing a invalid application type and sub type in the request 
    * def appliactionType = commonConstants.invalidParameters.invalidValue
    * def applicationSubType = commonConstants.invalidParameters.invalidValue
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityError')
    * match scrunityResponseBody[*].errorCode contains dcrConstants.errorCode.invalidApplicationType
    * match scrunityResponseBody[*].errorCode contains dcrConstants.errorCode.invalidServiceType 

@scrutinizePlan_InvalidFile_07 @negative @regression @dcrService
Scenario: Verifying by uploading a invalid file type
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityErrorFile')
    * match scrunityResponseBody[0].errorMessage == dcrConstants.errorMessages.invalidFileError

@scrutinizePlan_MultipleFile_08 @positive @regression @dcrService
Scenario: Verifying by uploading multiple files
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunityMultiFile')
    * match scrunityResponseBody.edcrDetail[0] == '#present'
    * match scrunityResponseBody.edcrDetail[0].status == dcrConstants.status


@scrutinydetails_01 @positive @regression @dcrService
Scenario: Verify fetching scrutiny details through API call
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunity')
    * def transactionNumber = scrunityResponseBody.edcrDetail[0].transactionNumber
    * def searchScrutinyParams = { tenantId: '#(tenantId)', transactionNumber: '#(transactionNumber)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinySuccessfully')
    * match scrunityResponseBody.edcrDetail[0] == '#present'
    * match scrunityResponseBody.edcrDetail[0].transactionNumber == transactionNumber
#Bug : Actual Status code is giving 200, It should give 404 
@scrutinydetails_null_02 @negative @regression @dcrService
Scenario: Verify by passing null or invalid value for transactionNumber
    * def transactionNumber = commonConstants.invalidParameters.invalidValue
    * def searchScrutinyParams = { tenantId: '#(tenantId)', transactionNumber: '#(transactionNumber)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinySuccessfully')
    * match scrunityResponseBody == dcrConstants.errorMessages.noRecords

@scrutinydetails_AllRecords_03 @positive @regression @dcrService
Scenario: Verify fetching scrutiny details for a given tenant id
    * def searchScrutinyParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinySuccessfully')
    * match scrunityResponseBody.edcrDetail[0] == '#present'
    
#NOTE: Error Messages are throwing with 200 Status once they fix will change accordingly
@scrutinydetails_InvalidTenant_04 @negative @regression @dcrService
Scenario: Verify by not passing null or invalid value for tenant id
    * def tenantId = dcrConstants.invalidParameters.invalidValue
    * def searchScrutinyParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinyError')
    * match scrunityResponseBody.error_description == commonConstants.errorMessages.invalidTenantId + ': ' + tenantId

@scrutinydetails_null_edcr_05 @negative @regression @dcrService
Scenario: Verify by not passing null or invalid value for EDCR 
    * def edcrNumber = commonConstants.invalidParameters.invalidValue
    * def searchScrutinyParams = { edcrNumber: '#(edcrNumber)', tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinySuccessfully')
    * match scrunityResponseBody == dcrConstants.errorMessages.noRecords

@scrutinydetails_Invalid_tenant_06 @negative @regression @dcrService
Scenario: Verify by not passing null or invalid value for tenant id
    * def tenantId = dcrConstants.invalidParameters.invalidValue
    * def searchScrutinyParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinyError')
    * match scrunityResponseBody.error_description == commonConstants.errorMessages.invalidTenantId + ': ' + tenantId

@scrutinydetails_Invalid_Txn_07 @negative @regression @dcrService
Scenario: Verify by not passing comma separated values
    * def transactionNumber = commonConstants.invalidParameters.invalidValue
    * def searchScrutinyParams = { tenantId: '#(tenantId)', transactionNumber: '#(transactionNumber)'}
    # * print searchScrutinyParams
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinySuccessfully')
    * match scrunityResponseBody == dcrConstants.errorMessages.noRecords

@scrutinydetails_id_08 @negative @regression @dcrService
Scenario: Verify fetching the scrutiny details using 'id' as a search param
    * def id = commonConstants.invalidParameters.nullValue
    * def searchScrutinyParams = { tenantId: '#(tenantId)', id: '#(id)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchScrutinySuccessfully')
    * match scrunityResponseBody.edcrDetail[0] == '#present'

@comparison_01 @positive @regression @dcrService
Scenario: Verify comparing edcrNumber and ocdcrNumber
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunity')
    * def edcrNumber = scrunityResponseBody.edcrDetail[0].edcrNumber
    * def comparisonParams = { edcrNumber: '#(edcrNumber)', ocdcrNumber: '#(ocdcrNumber)',tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonSuccessfully')
    * match comparisonResponseBody.comparisonDetail == '#present'

@comparison_NoTenant_02 @negative @regression @dcrService
Scenario: Verify by not passing tenant id 
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunity')
    * def edcrNumber = scrunityResponseBody.edcrDetail[0].edcrNumber
    * def comparisonParams = { edcrNumber: '#(edcrNumber)', ocdcrNumber: '#(ocdcrNumber)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonSuccessfully')
    * match comparisonResponseBody[0].errorMessage == dcrConstants.errorMessages.tenantError

@comparison_OnlyTenant_03 @negative @regression @dcrService
Scenario: Verify by not passing only tenant id 
    * def comparisonParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonSuccessfully')
    * match comparisonResponseBody[*].errorMessage contains dcrConstants.errorMessages.edcrMissingError
    * match comparisonResponseBody[*].errorMessage contains dcrConstants.errorMessages.ocdcrMissingError

@comparison_InvalidValues_04 @negative @regression @dcrService
Scenario: Verify by not passing invalid edcr and odcr number
    * def edcrNumber = commonConstants.invalidParameters.invalidValue
    * def ocdcrNumber = commonConstants.invalidParameters.invalidValue
    * def comparisonParams = { edcrNumber: '#(edcrNumber)', ocdcrNumber: '#(ocdcrNumber)', tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonSuccessfully')
    * match comparisonResponseBody[*].errorMessage contains dcrConstants.errorMessages.edcrInvalidError + ' ' + edcrNumber
    * match comparisonResponseBody[*].errorMessage contains dcrConstants.errorMessages.ocdcrInvalidError + ' ' + edcrNumber

@comparison_InvalidTenant_05 @negative @regression @dcrService
Scenario: Verify by passing invalid tenant id 
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@scrunity')
    * def edcrNumber = scrunityResponseBody.edcrDetail[0].edcrNumber
    * def tenantId = dcrConstants.invalidParameters.invalidValue
    * def comparisonParams = { edcrNumber: '#(edcrNumber)', ocdcrNumber: '#(ocdcrNumber)',tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonError')
    * match comparisonResponseBody.error_description == commonConstants.errorMessages.invalidTenantId + ': ' + tenantId

    
