Feature: Location

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def location = read('../requestPayload/location/searchLocation.json')
  * print location
  * def locationConstant = read('../constants/location.yaml')
  * def commonConstants = read('../constants/commonConstants.yaml')
  

@SearchLocation_01  @Positive  @location
Scenario: Send a POST request for a given tenant Id to search for the location details
      * def hierarchyTypeCode = locationConstant.parameters.hierarchyTypeCode
      * def boundaryType = locationConstant.parameters.boundaryType
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'

@SearchLocation_NoTenantId_02  @Negative  @location
Scenario: Search for  location details without tenantId
      * def hierarchyTypeCode = locationConstant.parameters.hierarchyTypeCode
      * def boundaryType = locationConstant.parameters.boundaryType
      * call read('../pretests/location.feature@locationwithnotenantid')
      * print searchLocationResponseBody
      * assert searchLocationResponseBody.Errors[0].message == locationConstant.errorMessages.noTenantId

@SearchLocation_NonExistentValues_03  @Negative  @location
Scenario: Send a POST request by passing  invalid/ non existent tenantId and search for the location details
      * def hierarchyTypeCode = locationConstant.parameters.hierarchyTypeCode
      * def boundaryType = locationConstant.parameters.boundaryType
      * def tenantId = commonConstants.invalidParameters.invalidTenantId
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'

@SearchLocation_MultiplehierarchyTypeCode_04  @Positive  @location
Scenario: Send a POST request by passing Multiple hierarchyTypeCode and search for the location details for a particular Tenant
      * def hierarchyTypeCode = locationConstant.parameters.multiHierarchyTypeCode
      * def boundaryType = locationConstant.parameters.boundaryType
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'   

@SearchLocation_AllRecords_05  @Positive  @location
Scenario: Search to fetch all the records for a particular tenant
      * call read('../pretests/location.feature@locationsuccesswithtenantid')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'  
      

# @SearchLocation_InvalidAuthToken_07  @500
# Scenario: Send a POST request by passing a wrong auth token
#      * call read('../pretests/location.feature')

@SearchLocation_MulltipleTenantId_08  @Negative  @location
Scenario: Send a POST request by passing multiple tenants which are valid in the request
      * def hierarchyTypeCode = locationConstant.parameters.hierarchyTypeCode
      * def boundaryType = locationConstant.parameters.boundaryType
      * def tenantId = locationConstant.parameters.multiTenantid
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'





