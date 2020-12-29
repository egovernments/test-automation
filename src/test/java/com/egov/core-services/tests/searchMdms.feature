Feature: Location

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def searchMdmsConst = read('../constants/searchMdms.yaml')

@SearchMDMS_Data_01  @positive
Scenario: Test to search data for a particular module and tenant
      * def moduleName = searchMdmsConst.parameters.modulename
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody
      * match searchMdmsResponseBody == '#present'

@SearcherMDMS_InvalidURL_02 @negative
Scenario: Test for invalid url
      * def moduleName = searchMdmsConst.parameters.modulename
      * call read('../pretests/mdmsService.feature@mdmsinvldurl')
      * print searchMdmsResponseBody
      * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConst.errorMessages.invldEndPoint

@SearchMDMS_InvalidAuth_03  @bug
Scenario: Test by passing a invalid/non existent auth token
      * def moduleName = searchMdmsConst.parameters.modulename
      * def authToken = searchMdmsConst.parameters.invldauth
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody

@SearchMDMS_InvalidTenant_04  @negative
Scenario: Test by passing invalid/non existent or null value for tenant id
     * def moduleName = searchMdmsConst.parameters.modulename
     * def tenantId = searchMdmsConst.parameters.tenantId
     * call read('../pretests/mdmsService.feature@searchmdmsinvldtenant')
     * print searchMdmsResponseBody
     * assert searchMdmsResponseBody.Errors[0].message == searchMdmsConst.errorMessages.invldTenantid

@SearchMDMS_Non-existentMod_05 
Scenario: Test by passing invalid/non existent or null value for Module Name
      * def moduleName = searchMdmsConst.parameters.invldmodulename
      * call read('../pretests/mdmsService.feature@searchmdms')
      * print searchMdmsResponseBody 

@SearchMDMS_Non-name_06
Scenario: Test by passing invalid/non existent or null value for Name in Masterdetails




      
      