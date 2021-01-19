Feature: Core service - HRMS

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def hrmsConstants = read('../constants/egov-hrms.yaml')
    * def commonConstants = read('../constants/commonConstanrs.yaml')
    * def today = getTodayUtcDate()
    * def tomorrow = getTomorrowUtcDate()
    # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def tenantId = tenantId
    * def name = hrmsConstants.parameters.name + ranInteger(6)
    * def mobileNumber = randomMobileNumGen(10) + ''
    * def employeeStatus = hrmsConstants.parameters.employeeStatus
    * def dob = hrmsConstants.parameters.dob + ''
    * def gender = hrmsConstants.parameters.gender
    * def fatherOrHusbandName = hrmsConstants.parameters.fatherOrHusbandName
    * def employeeType = hrmsConstants.parameters.employeeType
    * def hierarchy = hrmsConstants.parameters.hierarchy
    * def boundaryType = hrmsConstants.parameters.boundaryType
    * def boundary = tenantId
    * def department = hrmsConstants.parameters.department
    * def designation = hrmsConstants.parameters.designation
    * def isCurrentAssignment = true
    * def fromDate = today
    * def dateOfAppointment = today
    * def toDate = null
    * def authUserType = hrmsConstants.parameters.userType
    * call read('../pretests/authenticationToken.feature')

@HRMS_create_emp01 @positive @hrms_create @hrms
Scenario: Test to create a employee

    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * print hrmsResponseBody
    * def code = hrmsResponseBody.Employees[0].user.userName
    * print code
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert hrmsResponseBody.Employees[0].user.name == name
    * assert hrmsResponseBody.Employees[0].user.mobileNumber == mobileNumber
    #Search
    * call read('../pretests/egovHrmsPretest.feature@success_Search')
    * print hrmsResponseBody.Employees[0].user.userName


@HRMS_create_InvalidEMpStatus_02 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null status

    * def employeeStatus = hrmsConstants.invalidParameters.employeeStatus

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidEmployeeStatus

@HRMS_create_InvalidUserName_03 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null User Name

    * def name = hrmsConstants.invalidParameters.employeeName

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userCreationFailed
    

@HRMS_create_InvalidDOB_04 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null DOB

    * def dob = hrmsConstants.invalidParameters.dob

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.failedToDeserializeJson


@HRMS_create_InvalidGender_05 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null gender

    * def gender = hrmsConstants.invalidParameters.gender

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userCreationFailed


@HRMS_create_NoFatherName_06 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "fatherOrHusbandName"

    * def fatherOrHusbandName = null

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_ExistingMobile_07 @negative @hrms_create @hrms
Scenario: Test to create a employee with an existing mobile number

    * def mobileNumber = hrmsConstants.invalidParameters.existingMobileNumber

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userAlreadyExists


@HRMS_create_NoMobile_08 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "Mobile Number" parameter

    * def mobileNumber = null

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull


@HRMS_create_InvalidMobileNumber_09 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null mobile number

    * def mobileNumber = hrmsConstants.invalidParameters.mobileNumber

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull


@HRMS_create_NoEMpStatus_10 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "employee status" parameter

    * def employeeStatus = null

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull


@HRMS_create_NoUser_11 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "user" parameter

    * def name = null

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull


@HRMS_create_Notenantid_12 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "tenantid" parameter

    * def tenantId = null

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull


@HRMS_create_InvalidTenantId_13 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null Tenant Id

    * def tenantId = commonConstants.invalidParameters.invalidTenantId

    * call read('../pretests/egovHrmsPretest.feature@errorAuth_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized


@HRMS_create_InvalidFromDate_14 @negative @hrms_create @hrms
Scenario: Test to create a employee with an null assignment from date

    * def fromDate = null

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull


@HRMS_create_DateValidation_15 @negative @hrms_create @hrms
Scenario: Test when current assignment is true and end date exists for assignments

    * def toDate = hrmsConstants.invalidParameters.toDate

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidAssignmentPeriod
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.toDateShouldBeBlank
    * assert hrmsResponseBody.Errors[2].message == hrmsConstants.expectedMessages.assigmentPeriodCannotBeBeforeDob


@HRMS_create_InvalidEMpStatus_16 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null employee type

    * def employeeType = hrmsConstants.invalidParameters.employeeType

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidEmployeeType


@HRMS_create_InvalidJudistrictions_17 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null judistrictions

    * def hierarchy = hrmsConstants.invalidParameters.hierarchy
    * def boundaryType = hrmsConstants.invalidParameters.boundryType
    * def boundary = hrmsConstants.invalidParameters.boundary

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidJurisdictionHierarchyValue
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundaryType
    * assert hrmsResponseBody.Errors[2].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundary


@HRMS_create_HierarchySize_18 @negative @hrms_create @hrms
Scenario: Test to create a employee by entering hierarchy invalid value

    * def hierarchy = hrmsConstants.invalidParameters.hierarchy

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidSizeRange


@HRMS_InvalidCheck_19 @negative @hrms_create @hrms
Scenario: Test to create a employee with invalid department & designation

    * def department = hrmsConstants.invalidParameters.department
    * def designation = h.invalidParameters.designation

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidDepartment
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidDesignation


@HRMS_create_DateValidation1_20 @negative @hrms_create @hrms
Scenario: Test to create a employee when current date is false

    * def isCurrentAssignment = false

    * call read('../pretests/egovHrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.toDateShouldBeBlank
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.onlyOneCurrentAssigment

    
@HRMS_Search_Emp_01 @positive @hrms_search @hrms
Scenario: Test to search a employee

    * def code = hrmsConstants.parameters.employeeCode1
    * call read('../pretests/egovHrmsPretest.feature@success_Search')
    * print hrmsResponseBody


@HRMS_Search_AllEmp_02 @positive @hrms_search @hrms
Scenario: Test to search all employee

    * call read('../pretests/egovHrmsPretest.feature@success_Search')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success


@HRMS_Search_Invaid_URL_03 @negative @hrms_search @hrms
Scenario: Test to search with invalid url

    * def hrmsSearchUrl = hrmsConstants.expectedMessages.invalidURL

    * call read('../pretests/egovHrmsPretest.feature@errorAuth_Search')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized


@HRMS_Search_Name_05 @negative @hrms_search @hrms
Scenario: Test to search a name by not passing any tenant id

    * def name = hrmsConstants.invalidParameters.employeeName
    * call read('../pretests/egovHrmsPretest.feature@error_Search')
    * print hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.tenantIdMandatory


@HRMS_Search_InvalidTenantId_06 @negative @hrms_search @hrms
Scenario: Test to search a employee with an invalid/nonexistent/null Tenant Id

    * def tenantId = commonConstants.invalidParameters.invalidTenantId

    * call read('../pretests/egovHrmsPretest.feature@errorAuth_Search')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized


@HRMS_Search_Multiple_07 @positive @hrms_search @hrms
Scenario: Test by passing multiple values in the query parameter

    * def code = employeeCodeParam

    * call read('../pretests/egovHrmsPretest.feature@success_MultiSearch')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert hrmsResponseBody.Employees[0].code == employeeCode1
    * assert hrmsResponseBody.Employees[1].code == employeeCode2


@HRMS_Update_01 @positive @positive @hrms_update @hrms
Scenario: Test to Update an employee

    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].user.fatherOrHusbandName = hrmsConstants.parameters.fatherOrHusbandNameUpdate
    * def updatedResponse = call read('../pretests/egovHrmsPretest.feature@success_Update') hrmsResponseBody
    * assert updatedResponse.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert updatedResponse.Employees[0].user.name == name
    * assert updatedResponse.Employees[0].user.mobileNumber == mobileNumber
    * assert updatedResponse.Employees[0].code == code
    * assert updatedResponse.Employees[0].user.fatherOrHusbandName == hrmsConstants.parameters.fatherOrHusbandNameUpdate


@HRMS_update_InvalidValidations_02 @negative @hrms_update @hrms
Scenario: Test to update an employee with invalid validation
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].assignments[0].designation = hrmsConstants.invalidParameters.designation
    * call read('../pretests/egovHrmsPretest.feature@error_Update') hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DESG


@HRMS_update_DateValDOB_03 @negative @hrms_update @hrms
Scenario: Test to cupdate an employee invalid date of birth validation
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].user.dob = tomorrow
    * call read('../pretests/egovHrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DOB
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_DATES

@HRMS_update_DateValCurAssign_04 @negative @hrms_update @hrms
Scenario: Test to update an employee with is currently assigned as false and to date as null 
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].assignments[0].isCurrentAssignment = false
    * call read('../pretests/egovHrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_NOT_CURRENT_TO_DATE
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_CURRENT_ASSGN

@HRMS_update_InvalidTenant_05 @negative @hrms_update @hrms
Scenario: Test to update an employee with invalid tenant
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].tenantId = 'abc'
    * call read('../pretests/egovHrmsPretest.feature@error_UnAuth_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized


@HRMS_update_DateValCurSer_06 @negative @hrms_update @hrms
Scenario: Test to update an employee with is currently assigned as true and a valid to date
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].assignments[0].toDate = today
    * call read('../pretests/egovHrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_CURRENT_TO_DATE


@HRMS_update_AdhaarVal_07 @negative @hrms_update @hrms
Scenario: Test to update an employee with invalid aadhar number
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].user.aadhaarNumber = hrmsConstants.invalidParameters.aadhaarNumber
    * call read('../pretests/egovHrmsPretest.feature@error_Update') hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.INVALID_AADHAR

@HRMS_update_Deactivate_08 @negative @hrms_update @hrms
Scenario: Test to update an employee deactivating the employee
    * call read('../pretests/egovHrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * call read('../pretests/egovHrmsPretest.feature@success_Update_Deactivate') hrmsResponseBody
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * call read('../pretests/egovHrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody