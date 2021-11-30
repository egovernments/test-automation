Feature: Location

Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def locationPayload = read('../../core-services/requestPayload/location/searchLocation.json')
  * def locationConstant = read('../../core-services/constants/location.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  

@SearchLocation_01  @coreServices @regression @positive  @location
Scenario: Send a POST request for a given tenant Id to search for the location details
      * def hierarchyTypeCode = mdmsCityEgovLocation.TenantBoundary[0].hierarchyType.code
      * def boundaryType = mdmsCityEgovLocation.TenantBoundary[0].boundary.children[0].children[0].children[0].label
      # calling search location pretest
      * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
      
      * match searchLocationResponseBody == '#present'

@SearchLocation_NoTenantId_02  @coreServices @regression @negative  @location
Scenario: Search for  location details without tenantId
      * def hierarchyTypeCode = mdmsCityEgovLocation.TenantBoundary[0].hierarchyType.code
      * def boundaryType = mdmsCityEgovLocation.TenantBoundary[0].boundary.children[0].children[0].children[0].label
      # calling search location pretest
      * call read('../../core-services/pretests/location.feature@searchLocationWithoutTenantIdError')
      
      * assert searchLocationResponseBody.Errors[0].message == locationConstant.errorMessages.noTenantId

@SearchLocation_NonExistentValues_03  @coreServices @regression @negative  @location
Scenario: Send a POST request by passing  invalid/ non existent tenantId and search for the location details
      * def hierarchyTypeCode = mdmsCityEgovLocation.TenantBoundary[0].hierarchyType.code
      * def boundaryType = mdmsCityEgovLocation.TenantBoundary[0].boundary.children[0].children[0].children[0].label
      * def tenantId = commonConstants.invalidParameters.invalidTenantId
      # calling search location pretest
      * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
      
      * match searchLocationResponseBody == '#present'

@SearchLocation_MultiplehierarchyTypeCode_04  @coreServices @regression @positive  @location
Scenario: Send a POST request by passing Multiple hierarchyTypeCode and search for the location details for a particular Tenant
      * def hierarchyTypeCode = mdmsCityEgovLocation.TenantBoundary[0].hierarchyType.code + ',' + mdmsCityEgovLocation.TenantBoundary[1].hierarchyType.code
      * def boundaryType = mdmsCityEgovLocation.TenantBoundary[0].boundary.children[0].children[0].children[0].label
      # calling search location pretest
      * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
      
      * match searchLocationResponseBody == '#present'   
@SearchLocation_AllRecords_05  @coreServices @regression @positive  @location
Scenario: Search to fetch all the records for a particular tenant
      # calling search location pretest
      * call read('../../core-services/pretests/location.feature@searchLocationSuccessfulyWithOnlyTenantId')
      
      * match searchLocationResponseBody == '#present'  
      
@SearchLocation_MulltipleTenantId_08  @coreServices @regression @negative  @location
Scenario: Send a POST request by passing multiple tenants which are valid in the request
      * def hierarchyTypeCode = mdmsCityEgovLocation.TenantBoundary[0].hierarchyType.code + ',' + mdmsCityEgovLocation.TenantBoundary[1].hierarchyType.code
      * def boundaryType = mdmsCityEgovLocation.TenantBoundary[0].boundary.children[0].children[0].children[0].label
      * def tenantId = mdmsCityTenant.tenants[1].code + ',' + mdmsCityTenant.tenants[3].code
      # calling search location pretest
      * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
      
      * match searchLocationResponseBody == '#present'





