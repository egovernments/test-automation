Feature: Property Services Create
Background:
    * call read('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore')
    * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
@createActiveProperty
Scenario: Create Active Property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
    * print propertyServiceResponseBody