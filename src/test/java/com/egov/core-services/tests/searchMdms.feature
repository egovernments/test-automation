Feature: search mdms

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def searchMdmsConst = read('../constants/searchMdms.yaml')

@SearchMDMS_Data_01  @positive @searchmdms
Scenario: Test to search data for a particular module and tenant
      * def moduleName = searchMdmsConst.parameters.modulename
      * def name = searchMdmsConst.parameters.name
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody
      * match searchMdmsResponseBody == '#present'

@SearcherMDMS_InvalidURL_02 @negative @searchmdms
Scenario: Test for invalid url
      * def moduleName = searchMdmsConst.parameters.modulename
      * def name = searchMdmsConst.parameters.name
      * call read('../pretests/mdmsService.feature@mdmsinvldurl')
      * print searchMdmsResponseBody
      * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConst.errorMessages.invldEndPoint

@SearchMDMS_InvalidAuth_03  @bug  
Scenario: Test by passing a invalid/non existent auth token
      * def moduleName = searchMdmsConst.parameters.modulename
      * def name = searchMdmsConst.parameters.name
      * def authToken = searchMdmsConst.parameters.invldauth
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody

@SearchMDMS_InvalidTenant_04  @negative  @searchmdms
Scenario: Test by passing invalid/non existent or null value for tenant id
     * def moduleName = searchMdmsConst.parameters.modulename
     * def name = searchMdmsConst.parameters.name
     * def tenantId = searchMdmsConst.parameters.tenantId
     * call read('../pretests/mdmsService.feature@searchmdmsinvldtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConst.errorMessages.invldTenantid

@SearchMDMS_Non-existentMod_05   @negative       @searchmdms
Scenario: Test by passing invalid/non existent or null value for Module Name
      * def moduleName = searchMdmsConst.parameters.invldmodulename
      * def name = searchMdmsConst.parameters.name
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody 

@SearchMDMS_Non-name_06     @negative    @searchmdms
Scenario: Test by passing invalid/non existent or null value for Name in Masterdetails
     * def moduleName = searchMdmsConst.parameters.modulename
     * def name = searchMdmsConst.parameters.invldname
     * call read('../pretests/mdmsService.feature@searchmdms')
     * print searchMdmsResponseBody

@SearchMDMS_MandatoryCheck_07   @negative      @searchmdms
Scenario: Test by removing tenantid and module name parameter in the request
     * def tenantId = searchMdmsConst.parameters.noTenantId
     * def moduleName = searchMdmsConst.parameters.noModuleName
     * def name = searchMdmsConst.parameters.name
     * call read('../pretests/mdmsService.feature@searchmdmsinvldtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConst.errorMessages.messageForTenantId
     * assert searchMdmsResponseBody.Errors[1].message == searchMdmsConst.errorMessages.messageForTenantId

@SearchMDMS_NoMasterDetails_08   @negative    @searchmdms
Scenario: Test by removing MasterDetails parameter in the request
     * def moduleName = searchMdmsConst.parameters.modulename
     * def name = searchMdmsConst.parameters.Noname
     * call read('../pretests/mdmsService.feature@searchmdms')
     * print searchMdmsResponseBody
     





      
      