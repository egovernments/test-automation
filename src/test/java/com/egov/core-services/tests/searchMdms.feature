Feature: search mdms

Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def searchMdmsConstant = read('../../core-services/constants/searchMdms.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  # initializing search mdms request payload objects
  * def moduleName = searchMdmsConstant.parameters.moduleName[0]
  * def name = searchMdmsConstant.parameters.name[0]

@searchMdmsSuccessfully_Data_01  @coreServices @regression @positive  @searchMdms @mdmsService
Scenario: Test to search data for a particular module and tenant
      # calling search mdms pretest
      * call read('../../core-services/pretests/mdmsService.feature@searchMdmsSuccessfully')
      
      * match searchMdmsResponseBody == '#present'

@searchMdmsSuccessfully_InvalidTenant_04  @coreServices @regression @negative  @searchMdms @mdmsService
Scenario: Test by passing invalid/non existent or null value for tenant id
     * def tenantId = commonConstants.invalidParameters.invalidTenantId
     # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsWithInvalidtenantIdError')
     
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.invalidTenantid

@searchMdmsSuccessfully_Non-existentMod_05   @coreServices @regression @negative  @searchMdms @mdmsService
Scenario: Test by passing invalid/non existent or null value for Module Name
      * def moduleName = 'INVALID-module-' + randomString(3)
      # calling search mdms pretest
      * call read('../../core-services/pretests/mdmsService.feature@searchMdmsSuccessfully')
       
      * def mdmsResponse = searchMdmsResponseBody.MdmsRes
      
      * match mdmsResponse == '#present'

@searchMdmsSuccessfully_Non-name_06  @coreServices @regression @negative @searchMdms @mdmsService
Scenario: Test by passing invalid/non existent or null value for Name in Masterdetails
     * def name = 'INVALID-Name-' + randomString(3)
     # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsSuccessfully')
     
     * def mdmsResponseSecond = searchMdmsResponseBody.MdmsRes["common-masters"]
     * match mdmsResponseSecond == '#present'

@searchMdmsSuccessfully_MandatoryCheck_07  @coreServices @regression @negative  @searchMdms @mdmsService
Scenario: Test by removing tenantid and module name parameter in the request
     * def tenantId = commonConstants.invalidParameters.passValusAsNull
     * def moduleName = commonConstants.invalidParameters.passValusAsNull
     # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsWithInvalidtenantIdError')
     
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.messageForTenantId
     * assert searchMdmsResponseBody.Errors[1].message == searchMdmsConstant.errorMessages.messageForTenantId

@searchMdmsSuccessfully_NoMasterDetails_08  @coreServices @regression @negative  @searchMdms @mdmsService
Scenario: Test by removing MasterDetails parameter in the request
        # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsWithoutMasterDetailsError')
     
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.withoutMasterDetails

      
      