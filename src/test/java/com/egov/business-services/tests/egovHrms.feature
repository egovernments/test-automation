Feature: Business Services - HRMS

        Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../common-services/pretests/egovMdmsPretest.feature')
    * def hrmsConstants = read('../../business-services/constants/egov-hrms.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def today = getCurrentEpochTime()
    * def tomorrow = getTomorrowEpochTime()
    * def name = 'AUTOEMPLOYEE' + randomString(6)
    * def mobileNumber = '78' + randomMobileNumGen(8)
    * def email = randomString(10) + '@' + randomString(5) + '.com'
    * def employeeStatus = mdmsStateEgovHrms.EmployeeStatus[0].code
    * def dob = 635404414000 + ''
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
    * def fatherOrHusbandName = 'AUTOEMPFATHER' + randomString(6)
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
    * call read('../../business-services/pretest/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithoutEmployeeCodes')

        @HRMS_create_emp01 @regression @positive @hrms_create @hrms @smoke @businessService
        Scenario: Test to create a employee
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    * def code = hrmsResponseBody.Employees[0].user.userName
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * assert hrmsResponseBody.Employees[0].user.name == name
    * assert hrmsResponseBody.Employees[0].user.mobileNumber == mobileNumber
        @HRMS_create_InvalidEMpStatus_02 @regression @negative @hrms_create @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null status
    # Defining employee status with invalid status
    * def employeeStatus = "Invalid-status-" + ranString(5)
    # Steps to generate error message for invalid employee status
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidEmployeeStatus

        @HRMS_create_InvalidUserName_03 @negative @hrmsCreate @hrms_bug
        Scenario: Test to create a employee with an invalid/nonexistent/null User Name
    # Defining employee name with invalid name
    * def name = "Invalid-name-" + ranString(5)
    # Steps to generate error message for invalid employee name
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userCreationFailed 

        @HRMS_create_InvalidDOB_04 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null DOB
    # Defining employee DOB with invalid DOB
    * def dob = "Invalid-dob-" + ranString(5)
    # Steps to generate error message for invalid DOB
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.failedToDeserializeJson

        @HRMS_create_InvalidGender_05 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null gender
    # Defining employee Gender with invalid Gender
    * def gender = "Invalid-gender-" + ranString(5)
    # Steps to generate error message for invalid Gender
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userCreationFailed

        @HRMS_create_NoFatherName_06 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with no "fatherOrHusbandName"
    # Defining employee's Father's or Husband's name as null as this value will not considered
    * def fatherOrHusbandName = null
    # Steps to generate error message as Father's or Husband's name is not mentioned
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

        @HRMS_create_ExistingMobile_07 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an existing mobile number
    # Create a new Employee
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Defining mobile number with an existing or already used mobile number
    * def mobileNumber = Employees[0].user.mobileNumber
    # Steps to create new employee with existing or used mobile number
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.userAlreadyExists

        @HRMS_create_NoMobile_08 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with no "Mobile Number" parameter
    # Defining employee's mobile number as null as this value will not considered
    * def mobileNumber = null
    # Steps to generate error message as mobileNumber parameter is not been defined
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

        @HRMS_create_InvalidMobileNumber_09 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null mobile number
    # Defining Invalid mobile number
    * def mobileNumber = "Invalid-mobileNuumber-" + ranString(5)
    # Steps to generate error message as provided mobile number in Invalid
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidMobileNumber

        @HRMS_create_NoEMpStatus_10 @regression @negative @hrms_create @hrms
        Scenario: Test to create a employee with no "employee status" parameter
    # Defining employeeStatus as null as this value will not considered
    * def employeeStatus = null
    # Steps to generate error message as employeeStatus parameter is not been defined
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

        @HRMS_create_NoUser_11 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with no "user" parameter
    # Defining name as null as this value will not considered
    * def name = null
    # Steps to generate error message as name parameter is not been defined
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

        @HRMS_create_Notenantid_12 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with no "tenantid" parameter
    # Defining tenantId as null as this value will not considered
    * def tenantId = null
    # Steps to generate error message as name parameter is not been defined
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

        @HRMS_create_InvalidTenantId_13 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null Tenant Id
    # Defining tenantId as Invalid
    * def tenantId = 'Invalid-tenantId-' + ranString(5)
    # Steps to generate error message due to Invalid tenantId
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeAuthorizationError')
    # Checking actual error message returned by API with expected error message
    
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized

        @HRMS_create_InvalidFromDate_14 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an null assignment from date
    # Defining fromDate as null as this value will not considered
    * def fromDate = null
    # Steps to generate error message as fromDate is not been passed
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.notNull

        @HRMS_create_DateValidation_15 @regression @negative @hrmsCreate @hrms
        Scenario: Test when current assignment is true and end date exists for assignments
    # Defining toDate value as current date
    * def toDate = today
    # Steps to generate error message 
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    * def errorMessage = hrmsResponseBody.Errors[0].message
    # Checking actual error message returned by API with expected error message
    * assert errorMessage == hrmsConstants.expectedMessages.invalidAssignmentPeriod || errorMessage == hrmsConstants.expectedMessages.toDateShouldBeBlank

        @HRMS_create_InvalidEMpStatus_16 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null employee type
    # Defining employeeType as Invalid
    * def employeeType = "Invalid-authUserType-" + ranString(5)
    # Steps to generate error message as employeeType set as Invalid
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidEmployeeType

        @HRMS_create_InvalidJudistrictions_17 @regression @negative @hrmsCreate @hrms
        Scenario: Test to create a employee with an invalid/nonexistent/null judistrictions
    # Defining hierarchy as Invalid
    * def hierarchy = "Invalid-hierarchy-" + ranString(5)
    # Defining boundaryType as Invalid
    * def boundaryType = "Invalid-boundaryType-" + ranString(5)
    # Defining boundary as Invalid
    * def boundary = "Invalid-boundary-" + ranString(5)
    # Steps to generate error message as hierarchy,boundaryType and boundary value set as Invalid
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error message returned by API with expected error message for invalid hierarchy
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidJurisdictionHierarchyValue
    # Checking actual error message returned by API with expected error message for invalid boundaryType
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundaryType
    # Checking actual error message returned by API with expected error message for invalid boundary
    * assert hrmsResponseBody.Errors[2].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundary

        @HRMS_create_HierarchySize_18 @regression @negative @hrms_create @hrms
        Scenario: Test to create a employee by entering hierarchy invalid value
    # Defining hierarchy value as Invalid
    * def hierarchy = "Invalid-hierarchy-" + ranString(5)
    # Steps to generate error message as hierarchy value set as Invalid
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error messages returned by API with expected error message for invalid hierarchy
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidJurisdictionHierarchyValue
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundaryType
    * assert hrmsResponseBody.Errors[2].message == hrmsConstants.expectedMessages.invalidJurisdictionBoundary

        @HRMS_InvalidCheck_19 @regression @negative @hrms_create @hrms
        Scenario: Test to create a employee with invalid department & designation
    # Defining department value as Invalid
    * def department = "Invalid-department-" + ranString(5)
    # Defining designation value as Invalid
    * def designation = "Invalid-designation-" + ranString(5)
    # Steps to generate error messages as department and designation values set as Invalid
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error messages returned by API with expected error message for invalid Department
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.invalidDepartment
    # Checking actual error messages returned by API with expected error message for invalid Designation
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.invalidDesignation

        @HRMS_create_DateValidation1_20 @regression @negative @hrms_create @hrms
        Scenario: Test to create a employee when current date is false
    # Defining Current date is false
    * def isCurrentAssignment = false
    # Steps to generate error messages as isCurrentAssignment value set as false
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeError')
    # Checking actual error messages returned by API due to false isCurrentAssignment 
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.toDateShouldBeBlankForNonCurrentAssignment
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.onlyOneCurrentAssigment
    
        @HRMS_Search_Emp_01 @regression @positive @hrmsSearch @hrms @smoke
        Scenario: Test to search a employee
    # Defining code with a valid employee code to search
    * def code = employeeCode1
    # Steps to search the employee
    * call read('../../business-services/pretest/egovHrmsPretest.feature@searchEmployeeSuccessfully')

        @HRMS_Search_AllEmp_02 @regression @positive @hrmsSearch @hrms
        Scenario: Test to search all employee
    # Steps to search all employees hence no specific parameters provided
    * call read('../../business-services/pretest/egovHrmsPretest.feature@searchEmployeeSuccessfully')
    # Validate the response status is Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success

        @HRMS_Search_Name_05 @regression @negative @hrmsSearch @hrms
        Scenario: Test to search a name by not passing any tenant id
    # Defining name with Invalid value
    * def name = "Invalid-name-" + ranString(5)
    # Steps to search employee with invalid name and generate error message
    * call read('../../business-services/pretest/egovHrmsPretest.feature@searchEmployeeError')
    # Validate actual error message returned by API due to invalid employee name with expected error
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.tenantIdMandatory

        @hrmsSearch_InvalidTenantId_06 @regression @negative @hrmsSearch @hrms
        Scenario: Test to search a employee with an invalid/nonexistent/null Tenant Id]
    # Defining tenantId with Invalid tenantID
    * def tenantId = "Invalid-tenantId-" + ranString(5)
    # Steps to search an employee with invalid tenatID
    * call read('../../business-services/pretest/egovHrmsPretest.feature@searchWithInvalidTenantId')
    # Checking actual error message returned by API due to invalid tenantID 
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized

        @HRMS_Search_Multiple_07 @regression @positive @hrmsSearch @hrms
        Scenario: Test by passing multiple values in the query parameter
    # Defining code with multiple employee code parameters
    * def code = employeeCode1 + ',' + employeeCode2
    # Steps to search employee with multiple parameters
    * call read('../../business-services/pretest/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithMultipleEmployeeCodes')
    # Validating the response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Validating the first employee code from API response
    * assert hrmsResponseBody.Employees[0].code == employeeCode1
    # Validating the second employee code from API response
    * assert hrmsResponseBody.Employees[1].code == employeeCode2

        @HRMS_Update_01 @regression @positive @regression @positive @hrmsupdate @hrms
        Scenario: Test to Update an employee
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Assigning employee father's or husband's
    * eval Employees[0].user.fatherOrHusbandName = fatherOrHusbandName + "Updated"
    # Steps to update employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeHrms')
    # Validating response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Validating employee's updated name 
    * assert hrmsResponseBody.Employees[0].user.name == name
    # Validating employee's updated phone number
    * assert hrmsResponseBody.Employees[0].user.mobileNumber == mobileNumber
    # Validating employee's updated code
    * assert hrmsResponseBody.Employees[0].code == code
    # Validating employee's updated father's or husband's name
    * assert hrmsResponseBody.Employees[0].user.fatherOrHusbandName == fatherOrHusbandName + "Updated"

        @HRMS_update_InvalidValidations_02 @regression @negative @hrmsupdate @hrms
        Scenario: Test to update an employee with invalid validation
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Assigning employee's designation as Invalid designation
    * eval Employees[0].assignments[0].designation = "Invalid-designation-" + ranString(5)
    # Steps to update employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeError')
    # Validate atual error message returned by API with expected error message for invalid designation
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DESG

        @HRMS_update_DateValDOB_03 @regression @negative @hrmsupdate @hrms
        Scenario: Test to cupdate an employee invalid date of birth validation
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Assigning employee's DOB as Invalid DOB
    * eval Employees[0].user.dob = tomorrow
    # Steps to update employee with invalid details to generate error messages
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeError')
    # Validate actual error messages returned by API with expected error message for invalid DOB
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DOB
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_DATES

        @HRMS_update_DateValCurAssign_04 @regression @negative @hrmsupdate @hrms
        Scenario: Test to update an employee with is currently assigned as false and to date as null
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Assigning employee's current assignment as false
    * eval Employees[0].assignments[0].isCurrentAssignment = false
    # Steps to update employee with invalid details to generate error messages
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeError')
    # Validate actual error messages returned by API with expected error message for false current assignment value
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_NOT_CURRENT_TO_DATE
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_CURRENT_ASSGN

        @HRMS_update_InvalidTenant_05 @negative @hrmsupdate @hrms_bug
        Scenario: Test to update an employee with invalid tenant
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Defining tenantID as Invalid
    * def invalidTenantId = "Invalid"
    # Assigning tenantID as Invalid tenantID
    * eval Employees[0].tenantId = invalidTenantId
    # Assigning jurisdictions tenantID as Invalid tenantID
    * eval Employees[0].jurisdictions[0].tenantId = invalidTenantId
    # Assigning roles tenantID as Invalid tenantID
    * eval Employees[0].user.roles[0].tenantId = invalidTenantId
    # Assigning user tenantID as Invalid tenantID
    * eval Employees[0].user.tenantId = invalidTenantId
    # Steps to update employee with invalid tenant ids and generate error
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeWithInvalidTenantId')
    # Validating actual error message returned by API with expected error message for invalid tenantIDs
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.unauthorized

        @HRMS_update_DateValCurSer_06 @regression @negative @hrmsupdate @hrms
        Scenario: Test to update an employee with is currently assigned as true and a valid to date
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Assigning assignment todaDate value as today
    * eval Employees[0].assignments[0].toDate = today
    # Steps to update employee
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeError')
     # Validating actual error message returned by API with expected error message for invalid assignment and current to date
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_CURRENT_TO_DATE

        @HRMS_update_AdhaarVal_07 @regression @negative @hrmsupdate @hrms
        Scenario: Test to update an employee with invalid aadhar number
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Assigning aadhaarNumber value as invalid aadhaar number
    * eval Employees[0].user.aadhaarNumber = "Invalid-aadhaar-" + ranString(5)
    # Steps to update employee with invalid aadhaar number
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeError')
    # Validating actual error message returned by API with expected error message for invalid aadhaarNumber
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.INVALID_AADHAR

        @HRMS_update_Deactivate_08 @negative @hrmsupdate @hrms_bug
        Scenario: Test to update an employee deactivating the employee
    # Steps to Create a new Employee through HRMS
    * call read('../../business-services/pretest/egovHrmsPretest.feature@createEmployeeSuccessfully')
    # Validate response status as Success
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    # Defining name as new employee name
    * def name = Employees[0].user.name
    # Defining code as new employee code
    * def code = Employees[0].code
    # Steps to Deactivate an active employee
    * call read('../../business-services/pretest/egovHrmsPretest.feature@deactivateEmployeeSuccessfully')
    # Validate response status as Success once employee is Deactivated
    * assert hrmsResponseBody.ResponseInfo.status == commonConstants.expectedStatus.success
    * call read('../../business-services/pretest/egovHrmsPretest.feature@updateEmployeeError')
