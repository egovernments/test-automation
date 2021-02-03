Feature: eGovWorkflow process search
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * call read('../../common-services/pretests/eGovMdmsPretest.feature@successSearchCity')
  * call read('../../municipal-services/pretests/propertyServicesPretest.feature@successCreateProperty')
  * def workFlowProcessSearchPayload = read('../../core-services/requestPayload/eGovWorkFlow/process/processSearch.json')
  * def processSearchConstant = read('../../core-services/constants/eGovWorkFlowProcessSearch.yaml')
  * def history = 'true'
#  * def businessIds = processSearchConstant.parameters.businessId
  * def commonConstants = read('../../common-services/constants/genericConstants')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def invalidHistory = commonConstants.invalidParameters.invalidValue

@Search_01  @positive @egovworkflowprocess
Scenario: Perform search using business id, tenant and history 
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_withoutBusId_02  @positive  @egovworkflowprocess
Scenario: Perform search using only tenant and history 
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchwithoutbusinessid')
  * print processSearchResponseBody

@Search_onlyTenant_03  @positive  @egovworkflowprocess
Scenario: Perform search using only tenant 
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchonlytenantid')
  * print processSearchResponseBody

@Search_NoInputParams_04  @positive  @egovworkflowprocess
Scenario: Perform search by not passing any input params
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchnoparameter')
  * print processSearchResponseBody

@Search_Invaid_tenant_05  @negative  @egovworkflowprocess
Scenario: Perform search by passing invalid/non existent or null value for tenant id and check for errors
  * def tenantId = invalidTenantId
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchinvalidtenantid')
  * print processSearchResponseBody

@Search_Invaid_history_06  @negative  @egovworkflowprocess
Scenario: Perform search by passing invalid/non existent or null value for histroy and check for errors
  * def history = invalidHistory
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchfail')
  * print processSearchResponseBody 

@Search_MultipleTenant_07 @negative  @egovworkflowprocess
Scenario: Perform search by passing multple values for tenantId
  * def tenantId = tenant.tenants[1].code + ',' + tenant.tenants[3].code
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_MultipleBusIds_09  @negative  @egovworkflowprocess
Scenario: Perform search by passing multple values for Business Id
  * def businessIds = processSearchConstant.parameters.multipleBusinessId
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchsuccess')
  * print processSearchResponseBody

@Search_OffsetLimit_10  @positive  @egovworkflowprocess
Scenario: Perform search by passing offset and limit
  * def start = '1'
  * def end = '10'
  * call read('.././core-services/pretests/eGovWorkFlowProcessSearch.feature@processsearchoffset&limit')
  * print processSearchResponseBody

@Process_count  @positive  @egovworkflowprocess
Scenario: Perform search to get the count of process
  * call read('.././core-services/pretests/eGovWorkFlowProcessCount.feature@processcountsuccess')
  * print processCountResponseBody
