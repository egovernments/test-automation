Feature: File Store feature

@uploadFileToFilestore
Scenario:
    * def fileStoreConstant = read('../../core-services/constants/fileStore.yaml')
    * def module = fileStoreConstant.parameters.module
    * call read('../../core-services/pretests/fileStoreCreate.feature@uploadsuccess')
    * def fileStoreId = filecreateResponseBody.files[0].fileStoreId