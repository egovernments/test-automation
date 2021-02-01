Feature: Mdm Service Get tests

Background: 
    *  def authUsername = employeeUserName
    *  def authPassword = employeePassword
    *  def authUserType = employeeType
    *  call read('../pretests/authenticationToken.feature')
    *  def jsUtils = read('classpath:jsUtils.js')
    *  def mdmsServiceConstants = read('../constants/mdmsServiceGet.yaml')
    *  def moduleName = mdmsServiceConstants.parameters.moduleName
    *  def tenantId = mdmsServiceConstants.parameters.tenantId
    *  def masterName = mdmsServiceConstants.parameters.masterName
    *  def mdmsParam = {moduleName: '#(moduleName.split(",")[0])',tenantId: '#(tenantId)',masterName: '#(masterName)'}
    *  def serviceCode = mdmsServiceConstants.expectedResponse.serviceCode
    *  def keywords = mdmsServiceConstants.expectedResponse.keywords
    *  def department = mdmsServiceConstants.expectedResponse.department
    *  def slaHours = mdmsServiceConstants.expectedResponse.slaHours
    *  def menuPath = mdmsServiceConstants.expectedResponse.menuPath
    *  def active = mdmsServiceConstants.expectedResponse.active
    *  def order = mdmsServiceConstants.expectedResponse.order

@Get_MDMS_01 @positive @getMdms @mdmsService
Scenario: Test to get MDMS details 
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * def mdmsResponseArray = getMdmsResponseBody.MdmsRes['RAINMAKER-PGR'].ServiceDefs
    * assert mdmsResponseArray.size() > 0
    * match  mdmsResponseArray[*].serviceCode contains ['#(serviceCode)']
    * match  mdmsResponseArray[*].keywords contains ['#(keywords)']
    * match  mdmsResponseArray[*].department contains ['#(department)']
    * match  mdmsResponseArray[*].slaHours contains ['#(slaHours)']
    * match  mdmsResponseArray[*].menuPath contains ['#(menuPath)']
    * match  mdmsResponseArray[*].active contains ['#(active)']
    * match  mdmsResponseArray[*].order contains ['#(order)']

@Get_MDMS_MultipleMod_02 @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with multiple module name
    * set mdmsParam.moduleName = moduleName
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * match getMdmsResponseBody.MdmsRes == {}

@Get_MDMS_NoModName_03 @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with no module name
    * def mdmsParam = {tenantId: '#(tenantId)',masterName: '#(masterName)'}
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.noModuleName.message
    * match getMdmsResponseBody.Errors[0].params[0] == mdmsServiceConstants.errorMessages.noModuleName.params

@Get_MDMS_NoMasterName_04 @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with no module name
    * def mdmsParam = {moduleName: '#(moduleName.split(",")[0])',tenantId: '#(tenantId)'}
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.noMasterName.message
    * match getMdmsResponseBody.Errors[0].params[0] == mdmsServiceConstants.errorMessages.noMasterName.params

@Get_MDMS_NoTenantId_05 @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with no tenant Id
    * set mdmsParam.tenantId = null
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.noTenantId.message
    * match getMdmsResponseBody.Errors[0].params[0] == mdmsServiceConstants.errorMessages.noTenantId.params

@Get_MDMS_InvalidTenantId_06 @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with invalid tenant ID
    * set mdmsParam.tenantId = 'invalid_'+ ranString(5)
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.invalidTenantId.message
    * match getMdmsResponseBody.Errors[0].code == mdmsServiceConstants.errorMessages.invalidTenantId.code

@Get_MDMS_Invalidparamvalues_07 @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with invalid module name and service name
    * set mdmsParam.moduleName = 'invalid_'+ ranString(5)
    * set mdmsParam.masterName = 'invalid_'+ ranString(5)
    * call read('../pretests/mdmsService.feature@getMdmsService')
    * match getMdmsResponseBody.MdmsRes == {}