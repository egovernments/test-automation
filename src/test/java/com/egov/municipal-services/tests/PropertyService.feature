Feature: Property Services Create
Background:
    * call read('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore')
    * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
@createActiveProperty
Scenario: Create Active Property
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../../common-services/pretests/authenticationToken.feature')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@locationsuccess')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def localityName = searchLocationResponseBody.TenantBoundary[0].boundary[0].name + ', ' + cityCode
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successVerifyProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successForwardProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successApproveProperty')
    * print propertyServiceResponseBody

@createPropertyAndAssess
Scenario: Create Active Property
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../../common-services/pretests/authenticationToken.feature')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@locationsuccess')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def localityName = searchLocationResponseBody.TenantBoundary[0].boundary[0].name + ', ' + cityCode
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successVerifyProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successForwardProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successApproveProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successAssessProperty')