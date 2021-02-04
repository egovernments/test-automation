Feature: eGov_User - Update user profile tests

Background:
        * def jsUtils = read('classpath:jsUtils.js')
        
        * def authUsername = authUsername
        * def authPassword = authPassword
        * def authUserType = authUserType
        * print tenantId
        * def authUserType = authUserType
        * call read('../pretests/authenticationToken.feature')
        * def errorMessage = read("../constants/user.yaml")
        * def code = authUsername
        * call read('../../business-services/preTests/egov-hrmsPretest.feature@successMultiSearch')
        * def updatedUserProfile = read('../../core-services/requestPayload/user/update/updateUser.json')
        * def username = ranString(10)
        * def email = ranString(5)+'@auto.com'
        * def city = tenantId.split(".")[0]
        * def randomMobileNo = '9'+ randomMobileNumGen(9)
        * def invalidGender = randomNumber(3)

@User_Update_ValidDataWithNameEmailCity_01 @positive @updateProfile @eGovUser
  Scenario: To verify user profile data is updating correctly 
   * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
   * set updatedUserProfile.user.name = username
   * set updatedUserProfile.user.emailId = email
   * set updatedUserProfile.user.correspondenceCity = city
   * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
   * call read('../../business-services/preTests/egov-hrmsPretest.feature@success_MultiSearch')
   * karate.log(hrmsResponseBody)
   * assert hrmsResponseBody.Employees[0].user.name == username
   * assert hrmsResponseBody.Employees[0].user.emailId == email
   * assert hrmsResponseBody.Employees[0].user.correspondenceCity == city
   
@User_Update_ValidDataWithAlltheParameters_02 @positive @updateProfile @eGovUser
Scenario: Update existing user profile with all valid parameters
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * assert hrmsResponseBody.Employees.size() > 0

@User_Update_NameWithSpecialCharacters_03 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when an invalid username is passed
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.name = username+'@automation!'
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.missMatchError

@User_Update_InvalidEmail_04 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when an invalid emailid is passed
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.emailId = username
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidEmailError

@User_Update_InvalidMobileNumber_05 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when an invalid phone number is passed
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.mobileNumber = randomMobileNumGen(10)
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidPhoneNumberError

@User_Update_RandomDigit_MobileNumber_06 @negative @updateProfile @eGovUser
Scenario: To verify the phone number is not get updated even though it is valid
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.mobileNumber = randomMobileNo
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * call read('../../business-services/preTests/egov-hrmsPretest.feature@success_MultiSearch')
        * assert hrmsResponseBody.Employees[0].user.mobileNumber != randomMobileNo 

@User_Update_InvalidGender_07 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when an invalid gender is passed
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.gender = invalidGender
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidGenderError

@User_Update_noTenantId_08 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when tenant id passed as null
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.tenantId = null
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.tenantIdNull

@User_Update_noUUID_09 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when UUID passed as blank
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.uuid = ''
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].code
        * assert updatedUserprofileResponseBody.Errors[0].code == errorMessage.errormessages.noUUIDErrorCode

@User_Update_InvalidUUID_10 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when an invalid UUID passed
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.uuid = generateUUID()
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].code
        * assert updatedUserprofileResponseBody.Errors[0].code == errorMessage.errormessages.noUUIDErrorCode

@User_Update_noID_11 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when ID is removed
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * remove updatedUserProfile.user.id
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.tenantIdNull

@User_Update_InvalidID_12 @negative @updateProfile @eGovUser
Scenario: To verify the error message returned by API when ID is invalid
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.id = randomNumber(3)
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.tenantIdNull

@User_Update_NameWithMorethanMaxCharacters_13 @negative @updateProfile @eGovUser
Scenario: To verify the max length of characters of username
        * eval updatedUserProfile.user = hrmsResponseBody.Employees[0].user
        * set updatedUserProfile.user.name = randomString(55)
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserProfile')
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.usernameLengthError
     