Feature: File Store feature

@uploadFileToFilestore
Scenario:
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def fileStoreConstant = read('../../core-services/constants/fileStore.yaml')
    * def module = commonConstants.parameters.module[0]
    * call read('../../core-services/pretests/fileStoreCreate.feature@uploadSuccess')
    * def fileStoreId = filecreateResponseBody.files[0].fileStoreId