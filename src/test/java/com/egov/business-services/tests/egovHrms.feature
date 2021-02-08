Feature: Business Services - HRMS

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    
    * def authUsername = authUsername
    * def authPassword = authPassword
    * def authUserType = authUserType
    * call read('../../common-services/pretests/authenticationToken.feature')
    * call read('../../common-services/pretests/egovMdmsPretest.feature')
    * def hrmsConstants = read('../../business-services/constants/egov-hrms.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def today = getCurrentEpochTime()
    * def tomorrow = getTomorrowEpochTime()
    * def name = 'AUTO-EMPLOYEE-' + ranInteger(6)
    * def mobileNumber = '78' + randomMobileNumGen(8)
    * def employeeStatus = mdmsStateEgovHrms.EmployeeStatus[0].code
    * def dob = 635404414000 + ''
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def fatherOrHusbandName = 'AUTO-EMPLOYEE-' + ranInteger(6)
    * def employeeType = mdmsStateEgovHrms.EmployeeType[0].code
    * def hierarchy = mdmsCityEgovLocation.TenantBoundary[0].hierarchyType.code
    * def boundaryType = mdmsCityEgovLocation.TenantBoundary[0].boundary.label
    * def boundary = tenantId
    * def department = mdmsStatecommonMasters.Department[0].code
    * def designation = mdmsStatecommonMasters.Designation[0].code
    * def isCurrentAssignment = true
    * def fromDate = today
    * def dateOfAppointment = today
    * def toDate = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithoutEmployeeCodes')

@HRMS_create_emp01 @positive @hrms_create @eGovHrms
Scenario: Test to create a employee
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * print hrmsResponseBody
    * def code = hrmsResponseBody.Employees[0].user.userName
    * print code
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert hrmsResponseBody.Employees[0].user.name == name
    * assert hrmsResponseBody.Employees[0].user.mobileNumber == mobileNumber
    #Search
    * call read('../../business-services/pretests/egovHrmsPretest.feature@successSearch')
    * print hrmsResponseBody.Employees[0].user.userName

@HRMS_create_InvalidEMpStatus_02 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null status
    * def employeeStatus = "Invalid-status-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidEmployeeStatus

@HRMS_create_InvalidUserName_03 @negative @hrms_create @hrms_bug
Scenario: Test to create a employee with an invalid/nonexistent/null User Name
    * def name = "Invalid-name-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userCreationFailed 

@HRMS_create_InvalidDOB_04 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null DOB
    * def dob = "Invalid-dob-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.failedToDeserializeJson

@HRMS_create_InvalidGender_05 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null gender
    * def gender = "Invalid-gender-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userCreationFailed

@HRMS_create_NoFatherName_06 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with no "fatherOrHusbandName"
    * def fatherOrHusbandName = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_ExistingMobile_07 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an existing mobile number
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * def mobileNumber = Employees[0].user.mobileNumber
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userAlreadyExists

@HRMS_create_NoMobile_08 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with no "Mobile Number" parameter
    * def mobileNumber = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_InvalidMobileNumber_09 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null mobile number
    * def mobileNumber = "Invalid-mobileNuumber-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidMobileNumber

@HRMS_create_NoEMpStatus_10 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with no "employee status" parameter
    * def employeeStatus = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_NoUser_11 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with no "user" parameter
    * def name = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_Notenantid_12 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with no "tenantid" parameter
    * def tenantId = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_InvalidTenantId_13 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null Tenant Id
    * def tenantId = 'Invalid-tenantId-' + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeAuthorizationError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized

@HRMS_create_InvalidFromDate_14 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an null assignment from date
    * def fromDate = null
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

@HRMS_create_DateValidation_15 @negative @hrms_create @eGovHrms
Scenario: Test when current assignment is true and end date exists for assignments
    * def toDate = today
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * def errorMessage = hrmsResponseBody.Errors[0].message
    * assert errorMessage == hrmsConstants.expectedMessages.invalidAssignmentPeriod || errorMessage == hrmsConstants.expectedMessages.toDateShouldBeBlank

@HRMS_create_InvalidEMpStatus_16 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null employee type
    * def employeeType = "Invalid-authUserType-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidEmployeeType

@HRMS_create_InvalidJudistrictions_17 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with an invalid/nonexistent/null judistrictions
    * def hierarchy = "Invalid-hierarchy-" + ranString(5)
    * def boundaryType = "Invalid-boundaryType-" + ranString(5)
    * def boundary = "Invalid-boundary-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidJurisdictionHierarchyValue
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundaryType
    * assert hrmsResponseBody.Errors[2].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundary

@HRMS_create_HierarchySize_18 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee by entering hierarchy invalid value
    * def hierarchy = "Invalid-hierarchy-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    # * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidSizeRange
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidJurisdictionHierarchyValue
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundaryType
    * assert hrmsResponseBody.Errors[2].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundary

@HRMS_InvalidCheck_19 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee with invalid department & designation
    * def department = "Invalid-department-" + ranString(5)
    * def designation = "Invalid-designation-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidDepartment
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidDesignation

@HRMS_create_DateValidation1_20 @negative @hrms_create @eGovHrms
Scenario: Test to create a employee when current date is false
    * def isCurrentAssignment = false
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.toDateShouldBeBlankForNonCurrentAssignment
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.onlyOneCurrentAssigment
    
@HRMS_Search_Emp_01 @positive @hrms_search @eGovHrms
Scenario: Test to search a employee
    * def code = employeeCode1
    * call read('../../business-services/pretests/egovHrmsPretest.feature@successSearch')
    * print hrmsResponseBody

@HRMS_Search_AllEmp_02 @positive @hrms_search @eGovHrms
Scenario: Test to search all employee
    * call read('../../business-services/pretests/egovHrmsPretest.feature@successSearch')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success

@HRMS_Search_Name_05 @negative @hrms_search @eGovHrms
Scenario: Test to search a name by not passing any tenant id
    * def name = "Invalid-name-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeError')
    * print hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.tenantIdMandatory

@HRMS_Search_InvalidTenantId_06 @negative @hrms_search @eGovHrms
Scenario: Test to search a employee with an invalid/nonexistent/null Tenant Id]
    * def tenantId = "Invalid-tenantId-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeAuthorizationError')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized

@HRMS_Search_Multiple_07 @positive @hrms_search @eGovHrms
Scenario: Test by passing multiple values in the query parameter
    * def code = employeeCode1 + ',' + employeeCode2
    * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithMultipleEmployeeCodes')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert hrmsResponseBody.Employees[0].code == employeeCode1
    * assert hrmsResponseBody.Employees[1].code == employeeCode2

@HRMS_Update_01 @positive @positive @hrms_update @eGovHrms
Scenario: Test to Update an employee
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * eval Employees[0].user.fatherOrHusbandName = fatherOrHusbandName + "Updated"
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert hrmsResponseBody.Employees[0].user.name == name
    * assert hrmsResponseBody.Employees[0].user.mobileNumber == mobileNumber
    * assert hrmsResponseBody.Employees[0].code == code
    * assert hrmsResponseBody.Employees[0].user.fatherOrHusbandName == fatherOrHusbandName + "Updated"

@HRMS_update_InvalidValidations_02 @negative @hrms_update @eGovHrms
Scenario: Test to update an employee with invalid validation
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * eval Employees[0].assignments[0].designation = "Invalid-designation-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeError')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DESG

@HRMS_update_DateValDOB_03 @negative @hrms_update @eGovHrms
Scenario: Test to cupdate an employee invalid date of birth validation
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * eval Employees[0].user.dob = tomorrow
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DOB
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_DATES

@HRMS_update_DateValCurAssign_04 @negative @hrms_update @eGovHrms
Scenario: Test to update an employee with is currently assigned as false and to date as null 
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * eval Employees[0].assignments[0].isCurrentAssignment = false
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_NOT_CURRENT_TO_DATE
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_CURRENT_ASSGN

@HRMS_update_InvalidTenant_05 @negative @hrms_update @hrms_bug
Scenario: Test to update an employee with invalid tenant
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * def invalidTenantId = "Invalid"
    * eval Employees[0].tenantId = invalidTenantId
    * eval Employees[0].jurisdictions[0].tenantId = invalidTenantId
    * eval Employees[0].user.roles[0].tenantId = invalidTenantId
    * eval Employees[0].user.tenantId = invalidTenantId
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeAuthorizationError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized

@HRMS_update_DateValCurSer_06 @negative @hrms_update @eGovHrms
Scenario: Test to update an employee with is currently assigned as true and a valid to date
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * eval Employees[0].assignments[0].toDate = today
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeError')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_CURRENT_TO_DATE

@HRMS_update_AdhaarVal_07 @negative @hrms_update @eGovHrms
Scenario: Test to update an employee with invalid aadhar number
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * eval Employees[0].user.aadhaarNumber = "Invalid-aadhaar-" + ranString(5)
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeError')
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.INVALID_AADHAR

@HRMS_update_Deactivate_08 @negative @hrms_update @hrms_bug
Scenario: Test to update an employee deactivating the employee
    * call read('../../business-services/pretests/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * def name = Employees[0].user.name
    * def code = Employees[0].code
    * call read('../../business-services/pretests/egovHrmsPretest.feature@deactivateEmployeeSuccessfully')
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * print hrmsResponseBody
    * call read('../../business-services/pretests/egovHrmsPretest.feature@updateEmployeeError')
    * print hrmsResponseBody