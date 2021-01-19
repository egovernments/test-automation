Feature: Location

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def location = read('../requestPayload/location/searchLocation.json')
  * print location
  * def locationconstant = read('../constants/location.yaml')
  

@SearchLocation_01  @Positive  @location
Scenario: Send a POST request for a given tenant Id to search for the location details
      * def hierarchyTypeCode = locationconstant.parameters.hierarchyTypeCode
      * def boundaryType = locationconstant.parameters.boundaryType
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'

@SearchLocation_NoTenantId_02  @Negative  @location
Scenario: Search for  location details without tenantId
      * def hierarchyTypeCode = locationconstant.parameters.hierarchyTypeCode
      * def boundaryType = locationconstant.parameters.boundaryType
      * call read('../pretests/location.feature@locationwithnotenantid')
      * print searchLocationResponseBody
      * assert searchLocationResponseBody.Errors[0].message == locationconstant.errorMessages.noTenantId

@SearchLocation_NonExistentValues_03  @Negative  @location
Scenario: Send a POST request by passing  invalid/ non existent tenantId and search for the location details
      * def hierarchyTypeCode = locationconstant.parameters.hierarchyTypeCode
      * def boundaryType = locationconstant.parameters.boundaryType
      * def tenantId = locationconstant.parameters.invldTenantId
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'

@SearchLocation_MultiplehierarchyTypeCode_04  @Positive  @location
Scenario: Send a POST request by passing Multiple hierarchyTypeCode and search for the location details for a particular Tenant
      * def hierarchyTypeCode = locationconstant.parameters.multiHierarchyTypeCode
      * def boundaryType = locationconstant.parameters.boundaryType
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
      * def hierarchyTypeCode = locationconstant.parameters.hierarchyTypeCode
      * def boundaryType = locationconstant.parameters.boundaryType
      * def tenantId = locationconstant.parameters.multiTenantid
      * call read('../pretests/location.feature@locationsuccess')
      * print searchLocationResponseBody
      * match searchLocationResponseBody == '#present'





