Feature: search mdms

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * def searchMdmsConstant = read('../../core-services/constants/searchMdms.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def moduleName = searchMdmsConstant.parameters.moduleName[0]
  * def name = searchMdmsConstant.parameters.name[0]

@SearchMDMS_Data_01  @positive  @searchmdms
Scenario: Test to search data for a particular module and tenant
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody
      * match searchMdmsResponseBody == '#present'

@SearchMDMS_InvalidTenant_04  @negative  @searchmdms
Scenario: Test by passing invalid/non existent or null value for tenant id
     * def tenantId = commonConstants.'Invalid-tenantId-' + ranString(5)
     * call read('../pretests/mdmsService.feature@searchmdmsinvalidtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.invalidTenantid

@SearchMDMS_Non-existentMod_05   @negative  @searchmdms
Scenario: Test by passing invalid/non existent or null value for Module Name
      * def moduleName = 'INVALID-module-' + randomString(3)
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody 
      * def mdmsResponse = searchMdmsResponseBody.MdmsRes
      * print mdmsResponse
      * match mdmsResponse == '#present'

@SearchMDMS_Non-name_06  @negative    @searchmdms
Scenario: Test by passing invalid/non existent or null value for Name in Masterdetails
     * def name = 'INVALID-Name-' + randomString(3)
     * call read('../pretests/mdmsService.feature@searchmdms')
     * print searchMdmsResponseBody
     * def mdmsResponseSecond = searchMdmsResponseBody.MdmsRes["common-masters"]
     * print mdmsResponseSecond
     * match mdmsResponseSecond == '#present'

@SearchMDMS_MandatoryCheck_07  @negative  @searchmdms
Scenario: Test by removing tenantid and module name parameter in the request
     * def tenantId = ''
     * def moduleName = searchMdmsConstant.parameters.noModuleName
     * call read('../pretests/mdmsService.feature@searchmdmsinvalidtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.messageForTenantId
     * assert searchMdmsResponseBody.Errors[1].message == searchMdmsConstant.errorMessages.messageForTenantId

@SearchMDMS_NoMasterDetails_08  @negative  @searchmdms
Scenario: Test by removing MasterDetails parameter in the request
     * def name = ''
     * call read('../pretests/mdmsService.feature@searchmdms')
     * print searchMdmsResponseBody
     * match searchMdmsResponseBody == '#present'

      
      