Feature: search mdms

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def searchMdmsConstant = read('../constants/searchMdms.yaml')
  * def commonConstants = read('../constants/commonConstants.yaml')
  * def moduleName = searchMdmsConstant.parameters.moduleName
  * def name = searchMdmsConstant.parameters.name

@SearchMDMS_Data_01  @positive  @searchmdms
Scenario: Test to search data for a particular module and tenant
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody
      * match searchMdmsResponseBody == '#present'

@SearchMDMS_InvalidTenant_04  @negative  @searchmdms
Scenario: Test by passing invalid/non existent or null value for tenant id
     * def tenantId = commonConstants.invalidParameters.invalidTenantId
     * call read('../pretests/mdmsService.feature@searchmdmsinvalidtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.invalidTenantid

@SearchMDMS_Non-existentMod_05   @negative  @searchmdms
Scenario: Test by passing invalid/non existent or null value for Module Name
      * def moduleName = searchMdmsConstant.parameters.invalidModuleName
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody 
      * def mdmsResponse = searchMdmsResponseBody.MdmsRes
      * print mdmsResponse
      * match mdmsResponse == '#present'

@SearchMDMS_Non-name_06  @negative    @searchmdms
Scenario: Test by passing invalid/non existent or null value for Name in Masterdetails
     * def name = searchMdmsConstant.parameters.invalidName
     * call read('../pretests/mdmsService.feature@searchmdms')
     * print searchMdmsResponseBody
     * def mdmsResponseSecond = searchMdmsResponseBody.MdmsRes["common-masters"]
     * print mdmsResponseSecond
     * match mdmsResponseSecond == '#present'

@SearchMDMS_MandatoryCheck_07  @negative  @searchmdms
Scenario: Test by removing tenantid and module name parameter in the request
     * def tenantId = searchMdmsConstant.parameters.noTenantId
     * def moduleName = searchMdmsConstant.parameters.noModuleName
     * call read('../pretests/mdmsService.feature@searchmdmsinvalidtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConstant.errorMessages.messageForTenantId
     * assert searchMdmsResponseBody.Errors[1].message == searchMdmsConstant.errorMessages.messageForTenantId

@SearchMDMS_NoMasterDetails_08  @negative  @searchmdms
Scenario: Test by removing MasterDetails parameter in the request
     * def name = searchMdmsConstant.parameters.noName
     * call read('../pretests/mdmsService.feature@searchmdms')
     * print searchMdmsResponseBody
     * match searchMdmsResponseBody == '#present'
     





      
      