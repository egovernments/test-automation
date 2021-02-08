Feature: search mdms

        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def searchMdmsConstant = read('../../core-services/constants/searchMdms.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  # initializing search mdms request payload objects
  * def moduleName = searchMdmsConstant.parameters.moduleName[0]
  * def name = searchMdmsConstant.parameters.name[0]

        @searchMdmsSuccessfully_Data_01  @positive  @searchMdms
        Scenario: Test to search data for a particular module and tenant
        # calling search mdms pretest
      * call read('../../core-services/pretests/mdmsService.feature@searchMdmsSuccessfully')
      * print searchMdmsResponseBody
      * match searchMdmsResponseBody == '#present'

        @searchMdmsSuccessfully_InvalidTenant_04  @negative  @searchMdms
        Scenario: Test by passing invalid/non existent or null value for tenant id
     * def tenantId = commonConstants.invalidParameters.invalidTenantId
     # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsWithInvalidtenantIdError')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.invalidTenantid

        @searchMdmsSuccessfully_Non-existentMod_05   @negative  @searchMdms
        Scenario: Test by passing invalid/non existent or null value for Module Name
      * def moduleName = 'INVALID-module-' + randomString(3)
      # calling search mdms pretest
      * call read('../../core-services/pretests/mdmsService.feature@searchMdmsSuccessfully')
      * print searchMdmsResponseBody 
      * def mdmsResponse = searchMdmsResponseBody.MdmsRes
      * print mdmsResponse
      * match mdmsResponse == '#present'

        @searchMdmsSuccessfully_Non-name_06  @negative    @searchMdms
        Scenario: Test by passing invalid/non existent or null value for Name in Masterdetails
     * def name = 'INVALID-Name-' + randomString(3)
     # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsSuccessfully')
     * print searchMdmsResponseBody
     * def mdmsResponseSecond = searchMdmsResponseBody.MdmsRes["common-masters"]
     * print mdmsResponseSecond
     * match mdmsResponseSecond == '#present'

        @searchMdmsSuccessfully_MandatoryCheck_07  @negative  @searchMdms
        Scenario: Test by removing tenantid and module name parameter in the request
     * def tenantId = commonConstants.invalidParameters.passValusAsNull
     * def moduleName = commonConstants.invalidParameters.passValusAsNull
     # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsWithInvalidtenantIdError')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.messageForTenantId
     * assert searchMdmsResponseBody.Errors[1].message == searchMdmsConstant.errorMessages.messageForTenantId

        @searchMdmsSuccessfully_NoMasterDetails_08  @negative  @searchMdms
        Scenario: Test by removing MasterDetails parameter in the request
        # calling search mdms pretest
     * call read('../../core-services/pretests/mdmsService.feature@searchMdmsWithoutMasterDetailsError')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.withoutMasterDetails

      
      