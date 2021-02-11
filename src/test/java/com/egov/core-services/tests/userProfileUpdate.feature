Feature: eGov_User - Update user profile tests

Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def authUsername = employeeUserName
        * def authPassword = employeePassword
        * def authUserType = employeeType
        * print tenantId
        * call read('../../common-services/pretests/authenticationToken.feature')
        * def code = authUsername
        * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithMultipleEmployeeCodes')
        * def profilePayload = read('../../core-services/requestPayload/user/update/updateUser.json')
        * def errorMessage = read("../../core-services/constants/user.yaml")
        * def genericError = read("../../common-services/constants/genericConstants.yaml")
        * def username = ranString(10)
        * def email = ranString(5)+'@auto.com'
        * def city = tenantId.split(".")[0]
        * def randomMobileNo = '9'+ randomMobileNumGen(9)
        * def invalidGender = randomNumber(3)

        @User_Update_ValidDataWithNameEmailCity_01 @positive @updateProfile @eGovUser
        Scenario: To verify user profile data is updating correctly
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set name field value with username 
        * set profilePayload.user.name = username
        # Set emailId field value with email 
        * set profilePayload.user.emailId = email
        # Set correspondenceCity field value with city 
        * set profilePayload.user.correspondenceCity = city
        # Steps to update user profile along with predefined field values
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        # Steps to search user again to validate the updated details
        * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithMultipleEmployeeCodes')
        # Validate name which should be equal to username
        * assert hrmsResponseBody.Employees[0].user.name == username
        # Validate emailId which should be equal to email
        * assert hrmsResponseBody.Employees[0].user.emailId == email
        # Validate correspondenceCity which should be equal to city
        * assert hrmsResponseBody.Employees[0].user.correspondenceCity == city
   
        @User_Update_ValidDataWithAlltheParameters_02 @positive @updateProfile @eGovUser
        Scenario: Update existing user profile with all valid parameters
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Steps to update user profile
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        # Validate that hrms search response size in not 0
        * assert hrmsResponseBody.Employees.size() > 0

        @User_Update_NameWithSpecialCharacters_03 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when an invalid username is passed
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set invalid username to the name field
        * set profilePayload.user.name = username+'@automation!'
        # Steps to update user profile with invalid name
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidUserName

        @User_Update_InvalidEmail_04 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when an invalid emailid is passed
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set invalid value to the emailId field
        * set profilePayload.user.emailId = username
        # Steps to update user profile with invalid emailID
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidEmail

        @User_Update_InvalidMobileNumber_05 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when an invalid phone number is passed
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set an Invalid random mobile number to mobileNumber field
        * set profilePayload.user.mobileNumber = randomMobileNumGen(10)
        # Steps to update user profile with invalid mobile number
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidPhoneNumber

        @User_Update_RandomDigit_MobileNumber_06 @negative @updateProfile @eGovUser
        Scenario: To verify the phone number is not get updated even though it is valid
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set random valid mobile number to the mobileNumber field of request payload
        * set profilePayload.user.mobileNumber = randomMobileNo
        # Steps to update user profile with new random mobile number
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        # Steps to search user through HRMS
        * call read('../../business-services/pretests/egovHrmsPretest.feature@searchEmployeeSuccessfullyWithMultipleEmployeeCodes')
        # Validate user's mobileNumber is not equal with rendomMobileNumber
        * assert hrmsResponseBody.Employees[0].user.mobileNumber != randomMobileNo 

        @User_Update_InvalidGender_07 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when an invalid gender is passed
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set an invalid gender 
        * set profilePayload.user.gender = invalidGender
        # Steps to update user's profile to generate error message for invalid gender
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidGender

        @User_Update_noTenantId_08 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when tenant id passed as null
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set tenantId field value as Blank
        * set profilePayload.user.tenantId = null
        # Steps to update user's profile to generate error message as tenantId is blank
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

        @User_Update_noUUID_09 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when UUID passed as blank
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set uuid field value as Blank
        * set profilePayload.user.uuid = ''
        # Steps to update user's profile to generate error message as uuid is blank
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].description == errorMessage.errormessages.invalidUUID

        @User_Update_InvalidUUID_10 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when an invalid UUID passed
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Set an invalid uuid to the uuid field
        * set profilePayload.user.uuid = generateUUID()
        # Steps to update user's profile to generate error message as uuid field is invalid
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

        @User_Update_noID_11 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when ID is removed
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Removing user id field from the request payload
        * remove profilePayload.user.id
        # Steps to update user's profile to generate error message as user id field is missing from the request
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

        @User_Update_InvalidID_12 @negative @updateProfile @eGovUser
        Scenario: To verify the error message returned by API when ID is invalid
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Assigning user's id with random invalid number
        * set profilePayload.user.id = randomNumber(3)
        # Steps to update user's profile to generate error message for invalid user id
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

        @User_Update_NameWithMorethanMaxCharacters_13 @negative @updateProfile @eGovUser
        Scenario: To verify the max length of characters of username
        # Assigning user's details from HRMS search user results
        * eval profilePayload.user = hrmsResponseBody.Employees[0].user
        # Assigning user's name with random string which charecter length is more than 50
        * set profilePayload.user.name = randomString(55)
        # Steps to update user's profile to generate error message for invalid charecter length name
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        # Checking actual error message returned by API with expected error message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.nameCharsSize
     