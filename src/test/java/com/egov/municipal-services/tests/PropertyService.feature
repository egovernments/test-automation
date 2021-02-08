Feature: Property Services Create

        Background:
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def areaCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].area
    * def localityName = searchLocationResponseBody.TenantBoundary[0].boundary[0].name + ', ' + cityCode
        
        @createProperty
        Scenario: Create Active Property
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
        
        @createActiveProperty
        Scenario: Create Active Property
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
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successVerifyProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successForwardProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successApproveProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successSearchProperty')
    * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successAssessProperty')