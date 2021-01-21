Feature: Core service - HRMS

Background:

    * def jsUtils = read('classpath:jsUtils.js')
    * def javaUtils = Java.type('com.egov.base.EGovTest')
    * def hrmsConstants = read('../constants/hrms.yaml')
    * def today = getTodayUtcDate()
    * def tomorrow = getTomorrowUtcDate()
    # Calling access token
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
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

    * call read('../pretests/hrmsPretest.feature@success_Create')
    * print hrmsResponseBody
    * def code = hrmsResponseBody.Employees[0].user.userName
    * print code
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * assert hrmsResponseBody.Employees[0].user.name == name
    * assert hrmsResponseBody.Employees[0].user.mobileNumber == mobileNumber
    #Search
    * call read('../pretests/hrmsPretest.feature@success_Search')
    * print hrmsResponseBody.Employees[0].user.userName


@HRMS_create_InvalidEMpStatus_02 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null status

    * def employeeStatus = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'Invalid employment status entered.'

@HRMS_create_InvalidUserName_03 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null User Name

    * def name = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'User creation failed at the user service.'
    

@HRMS_create_InvalidDOB_04 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null DOB

    * def dob = 'a123a'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'Failed to deserialize certain JSON fields'


@HRMS_create_InvalidGender_05 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null gender

    * def gender = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'User creation failed at the user service.'


@HRMS_create_NoFatherName_06 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "fatherOrHusbandName"

    * def fatherOrHusbandName = null

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'must not be null'

@HRMS_create_ExistingMobile_07 @negative @hrms_create @hrms
Scenario: Test to create a employee with an existing mobile number

    * def mobileNumber = '7171717178'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'User already exists for the entered mobile number. Use a different mobile number to proceed.'


@HRMS_create_NoMobile_08 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "Mobile Number" parameter

    * def mobileNumber = null

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'must not be null'


@HRMS_create_InvalidMobileNumber_09 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null mobile number

    * def mobileNumber = '12345'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'Invalid mobile number entered.'


@HRMS_create_NoEMpStatus_10 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "employee status" parameter

    * def employeeStatus = null

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'must not be null'


@HRMS_create_NoUser_11 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "user" parameter

    * def name = null

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'must not be null'


@HRMS_create_Notenantid_12 @negative @hrms_create @hrms
Scenario: Test to create a employee with no "tenantid" parameter

    * def tenantId = null

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'must not be null'


@HRMS_create_InvalidTenantId_13 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null Tenant Id

    * def tenantId = '123'

    * call read('../pretests/hrmsPretest.feature@errorAuth_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'Not authorized to access this resource'


@HRMS_create_InvalidFromDate_14 @negative @hrms_create @hrms
Scenario: Test to create a employee with an null assignment from date

    * def fromDate = null

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'must not be null'


@HRMS_create_DateValidation_15 @negative @hrms_create @hrms
Scenario: Test when current assignment is true and end date exists for assignments

    * def toDate = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'Invalid period of assignment (From date - To date).'
    * assert hrmsResponseBody.Errors[1].message == 'To Date field should be blank for current assignment of the employee.'
    * assert hrmsResponseBody.Errors[2].message == 'Employee period of assignment (From Date or To date) can not be before date of birth.'


@HRMS_create_InvalidEMpStatus_16 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null employee type

    * def employeeType = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == 'Invalid employee type entered.'


@HRMS_create_InvalidJudistrictions_17 @negative @hrms_create @hrms
Scenario: Test to create a employee with an invalid/nonexistent/null judistrictions

    * def hierarchy = '123'
    * def boundaryType = '123'
    * def boundary = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == 'Jurisiction hierarchy value is invalid.'
    * assert hrmsResponseBody.Errors[1].message == 'Jurisiction boundary type value is invalid.'
    * assert hrmsResponseBody.Errors[2].message == 'Jurisiction boundary value is invalid.'


@HRMS_create_HierarchySize_18 @negative @hrms_create @hrms
Scenario: Test to create a employee by entering hierarchy invalid value

    * def hierarchy = '1'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == 'size must be between 2 and 100'


@HRMS_InvalidCheck_19 @negative @hrms_create @hrms
Scenario: Test to create a employee with invalid department & designation

    * def department = '123'
    * def designation = '123'

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == 'Invalid department of employee entered.'
    * assert hrmsResponseBody.Errors[1].message == 'Invalid designation of employee.'


@HRMS_create_DateValidation1_20 @negative @hrms_create @hrms
Scenario: Test to create a employee when current date is false

    * def isCurrentAssignment = false

    * call read('../pretests/hrmsPretest.feature@error_Create')
    * assert hrmsResponseBody.Errors[0].message == 'To date field should not be blank for non current assignment of the employee.'
    * assert hrmsResponseBody.Errors[1].message == 'There should be exactly one current assignment for the employee.'

    
@HRMS_Search_Emp_01 @positive @hrms_search @hrms
Scenario: Test to search a employee

    * def code = 'EMP-107-000298'
    * call read('../pretests/hrmsPretest.feature@success_Search')
    * print hrmsResponseBody


@HRMS_Search_AllEmp_02 @positive @hrms_search @hrms
Scenario: Test to search all employee

    * call read('../pretests/hrmsPretest.feature@success_Search')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'


@HRMS_Search_Invaid_URL_03 @negative @hrms_search @hrms
Scenario: Test to search with invalid url

    * def hrmsSearchUrl = hrmsConstants.expectedMessages.invalidURL

    * call read('../pretests/hrmsPretest.feature@errorAuth_Search')
    * assert hrmsResponseBody.Errors[0].message == 'Not authorized to access this resource'


@HRMS_Search_Name_05 @negative @hrms_search @hrms
Scenario: Test to search a name by not passing any tenant id

    * def name = 'shaik'
    * call read('../pretests/hrmsPretest.feature@error_Search')
    * print hrmsResponseBody.Errors[0].message == 'For search based on phone number and name, passing of tenant id is mandatory.'


@HRMS_Search_InvalidTenantId_06 @negative @hrms_search @hrms
Scenario: Test to search a employee with an invalid/nonexistent/null Tenant Id

    * def tenantId = 'invalid'

    * call read('../pretests/hrmsPretest.feature@errorAuth_Search')
    * assert hrmsResponseBody.Errors[0].message == 'Not authorized to access this resource'


@HRMS_Search_Multiple_07 @positive @hrms_search @hrms
Scenario: Test by passing multiple values in the query parameter

    * def code = 'EMP-107-000298,EMP111'

    * call read('../pretests/hrmsPretest.feature@success_MultiSearch')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * assert hrmsResponseBody.Employees[0].code == 'EMP-107-000298'
    * assert hrmsResponseBody.Employees[1].code == 'EMP111'


@HRMS_Update_01 @positive @positive @hrms_update @hrms
Scenario: Test to Update an employee

    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].user.fatherOrHusbandName = 'Father'
    * def updatedResponse = call read('../pretests/hrmsPretest.feature@success_Update') hrmsResponseBody
    * assert updatedResponse.ResponseInfo.status == 'successful'
    * assert updatedResponse.Employees[0].user.name == name
    * assert updatedResponse.Employees[0].user.mobileNumber == mobileNumber
    * assert updatedResponse.Employees[0].code == code
    * assert updatedResponse.Employees[0].user.fatherOrHusbandName == 'Father'


@HRMS_update_InvalidValidations_02 @negative @hrms_update @hrms
Scenario: Test to update an employee with invalid validation
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].assignments[0].designation = 'ABC'
    * call read('../pretests/hrmsPretest.feature@error_Update') hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DESG


@HRMS_update_DateValDOB_03 @negative @hrms_update @hrms
Scenario: Test to cupdate an employee invalid date of birth validation
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].user.dob = tomorrow
    * call read('../pretests/hrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_DOB
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_DATES

@HRMS_update_DateValCurAssign_04 @negative @hrms_update @hrms
Scenario: Test to update an employee with is currently assigned as false and to date as null 
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].assignments[0].isCurrentAssignment = false
    * call read('../pretests/hrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_NOT_CURRENT_TO_DATE
    * assert hrmsResponseBody.Errors[1].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_CURRENT_ASSGN

@HRMS_update_InvalidTenant_05 @negative @hrms_update @hrms
Scenario: Test to update an employee with invalid tenant
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].tenantId = 'abc'
    * call read('../pretests/hrmsPretest.feature@error_UnAuth_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.CustomException


@HRMS_update_DateValCurSer_06 @negative @hrms_update @hrms
Scenario: Test to update an employee with is currently assigned as true and a valid to date
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].assignments[0].toDate = today
    * call read('../pretests/hrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.ERR_HRMS_INVALID_ASSIGNMENT_CURRENT_TO_DATE


@HRMS_update_AdhaarVal_07 @negative @hrms_update @hrms
Scenario: Test to update an employee with invalid aadhar number
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * eval hrmsResponseBody.Employees[0].user.aadhaarNumber = 'abc'
    * call read('../pretests/hrmsPretest.feature@error_Update') hrmsResponseBody
    * assert hrmsResponseBody.Errors[0].message == hrmsConstants.expectedMessages.INVALID_AADHAR

@HRMS_update_Deactivate_08 @ignore
Scenario: Test to update an employee deactivating the employee
    * call read('../pretests/hrmsPretest.feature@success_Create')
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * def name = hrmsResponseBody.Employees[0].user.name
    * def code = hrmsResponseBody.Employees[0].code
    * call read('../pretests/hrmsPretest.feature@success_Update_Deactivate') hrmsResponseBody
    * assert hrmsResponseBody.ResponseInfo.status == 'successful'
    * print hrmsResponseBody
    * call read('../pretests/hrmsPretest.feature@error_Update') hrmsResponseBody
    * print hrmsResponseBody