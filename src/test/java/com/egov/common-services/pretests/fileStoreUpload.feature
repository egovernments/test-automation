Feature: File Store feature
* configure headers = 'multipart/form-data;boundary=----WebKitFormBoundaryBDVBPRx02pZ7ePhq'

@uploadFileToFilestore
Scenario:
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def fileStoreConstant = read('../../core-services/constants/fileStore.yaml')
    * def module = commonConstants.parameters.module[0]
    * call read('../../core-services/pretests/fileStoreCreate.feature@uploadDocumentsSuccessfully')
    * def fileStoreId = filecreateResponseBody.files[0].fileStoreId