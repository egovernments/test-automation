Feature: File store Tag
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def fileStoreConst = read('../../core-services/constants/fileStore.yaml')

@FileStore_Tag_01 @coreServices @regression @positive @filestore
  Scenario: Filestore tag successfull
      #Calling tag preset
       * call read('../../core-services/pretests/fileStoreTagPretest.feature@getFilestoreTagSuccessfully')   

       * match fileStoreTagResponseBody == '#present'

  @FileStore_Tag_02 @coreServices @regression @negative @filestore
  Scenario: Filestore incorrect tag
      #Calling tag preset
       * call read('../../core-services/pretests/fileStoreTagPretest.feature@getFilestoreIncorrectTag')   

       * assert.fileStoreTagResponseBody.Errors[0].message == fileStoreConst.errorMessages.noTenantid 