Feature: File store Metadata
Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')

    @Filestore_Metadata_01 @coreServices @regression @positive @fileStore
    Scenario: Filestore metadata successfull
        #Calling filestore metadata preset 
        * call read('../../core-services/pretests/fileStoreMetadataPretest.feature@getFilestoreMetadataSuccessfully')

        * match fileStoreMetadataResponseBody == '#present'

    @Filestore_Metadata_02 @coreServices @regression @negative @fileStore
    Scenario: Filestore metadata invalid TenantId
        #Calling filestore metadata preset 
        * call read('../../core-services/pretests/fileStoreMetadataPretest.feature@getFilestoreMetadataInvalidTenantId')

        * assert.fileStoreMetadataResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid    