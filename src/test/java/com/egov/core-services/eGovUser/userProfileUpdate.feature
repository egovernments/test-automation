Feature: eGov_User - Update user profile tests

Background:
        * def userProfileData = read('../constants/user.yaml')
        * def errorMessage = read("../constants/user.yaml")
        * def id = userProfileData.user.id
        * def userName = userProfileData.user.userName
        * def name = userProfileData.user.name
        * def gender = userProfileData.user.gender
        * def mobileNumber = userProfileData.user.mobileNumber
        * def emailId = userProfileData.user.emailId
        * def correspondenceAddress = userProfileData.user.correspondenceAddress
        * def correspondenceCity = userProfileData.user.correspondenceCity
        * def tenantId = userProfileData.user.tenantId
        * def roles = userProfileData.user.roles
        * def uuid = userProfileData.user.uuid
        * def type = userProfileData.user.type
        * def fatherOrHusbandName = userProfileData.user.fatherOrHusbandName
        * def salutation = userProfileData.user.salutation
        * def altContactNumber = userProfileData.user.altContactNumber
        * def pan = userProfileData.user.pan
        * def aadhaarNumber = userProfileData.user.aadhaarNumber
        * def permanentAddress = userProfileData.user.permanentAddress
        * def permanentCity = userProfileData.user.permanentCity
        * def permanentPinCode = userProfileData.user.permanentPinCode
        * def correspondencePinCode = userProfileData.user.correspondencePinCode
        * def active = userProfileData.user.active
        * def locale = userProfileData.user.locale
        * def accountLocked = userProfileData.user.accountLocked
        * def signature = userProfileData.user.signature
        * def bloodGroup = userProfileData.user.bloodGroup
        * def photo = userProfileData.user.photo
        * def identificationMark = userProfileData.user.identificationMark
        * def createdBy = userProfileData.user.createdBy
        * def accountLockedDate = userProfileData.user.accountLockedDate
        * def lastModifiedBy = userProfileData.user.lastModifiedBy
        * def createdDate = userProfileData.user.createdDate
        * def lastModifiedDate = userProfileData.user.lastModifiedDate
        * def dob = userProfileData.user.dob
        * def pwdExpiryDate = userProfileData.user.pwdExpiryDate

@User_Update_ValidDataWithNameEmailCity_01 @positive @updateProfile @user
Scenario: To verify user profile data is updating correctly
        * call read('../pretests/updateUserPretest.feature@validParameters')
        * print updatedUserprofileResponseBody.user[0].correspondenceCity
        * print updatedUserprofileResponseBody.user[0].name
        * print updatedUserprofileResponseBody.user[0].emailId
        * assert updatedUserprofileResponseBody.user[0].correspondenceCity == userProfileData.validProfileData.city
        * assert updatedUserprofileResponseBody.user[0].name == userProfileData.validProfileData.userName
        * assert updatedUserprofileResponseBody.user[0].emailId == userProfileData.validProfileData.emailId

@User_Update_ValidDataWithAlltheParameters_02 @positive @updateProfile @user
Scenario: Update existing user profile with all valid parameters
        * call read('../pretests/updateUserPretest.feature@validAllParameters')
        * match updatedUserprofileResponseBody.responseInfo.status == '200'

@User_Update_NameWithSpecialCharacters_03 @negative @updateProfile @user
Scenario: To verify the error message returned by API when an invalid username is passed
        * call read('../pretests/updateUserPretest.feature@inValidUserName')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.missMatchError

@User_Update_InvalidEmail_04 @negative @updateProfile @user
Scenario: To verify the error message returned by API when an invalid emailid is passed
        * call read('../pretests/updateUserPretest.feature@inValidEmailId')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidEmailError

@User_Update_InvalidMobileNumber_05 @negative @updateProfile @user
Scenario: To verify the error message returned by API when an invalid phone number is passed
        * call read('../pretests/updateUserPretest.feature@inValidPhoneNumber')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidPhoneNumberError

@User_Update_RandomDigit_MobileNumber_06 @negative @updateProfile @user
Scenario: To verify the phone number is not get updated even though it is valid
        * call read('../pretests/updateUserPretest.feature@validRandomPhoneNumber')
        * print updatedUserprofileResponseBody.user[0].mobileNumber
        * assert updatedUserprofileResponseBody.user[0].mobileNumber != userProfileData.inValidProfileData.mobileNumber 

@User_Update_InvalidGender_07 @negative @updateProfile @user
Scenario: To verify the error message returned by API when an invalid gender is passed
        * call read('../pretests/updateUserPretest.feature@invalidGender')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.invalidGenderError

@User_Update_noTenantId_08 @negative @updateProfile @user
Scenario: To verify the error message returned by API when tenant id passed as null
        * call read('../pretests/updateUserPretest.feature@invalidTenantId')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.tenantIdNull

@User_Update_noUUID_09 @negative @updateProfile @user
Scenario: To verify the error message returned by API when UUID passed as blank
        * call read('../pretests/updateUserPretest.feature@blankUUID')
        * print updatedUserprofileResponseBody.Errors[0].code
        * assert updatedUserprofileResponseBody.Errors[0].code == errorMessage.errormessages.noUUIDErrorCode

@User_Update_InvalidUUID_10 @negative @updateProfile @user
Scenario: To verify the error message returned by API when an invalid UUID passed
        * call read('../pretests/updateUserPretest.feature@invalidUUID')
        * print updatedUserprofileResponseBody.Errors[0].code
        * assert updatedUserprofileResponseBody.Errors[0].code == errorMessage.errormessages.noUUIDErrorCode

@User_Update_noID_11 @negative @updateProfile @user
Scenario: To verify the error message returned by API when ID is removed
        * call read('../pretests/updateUserPretest.feature@removeID')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.tenantIdNull

@User_Update_InvalidID_12 @negative @updateProfile @user
Scenario: To verify the error message returned by API when ID is invalid
        * call read('../pretests/updateUserPretest.feature@invalidID')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.tenantIdNull

@User_Update_NameWithMorethanMaxCharacters_13 @negative @updateProfile @user
Scenario: To verify the max length of characters of username
        * call read('../pretests/updateUserPretest.feature@nameWithMaxmiumCharacters')
        * print updatedUserprofileResponseBody.Errors[0].message
        * assert updatedUserprofileResponseBody.Errors[0].message == errorMessage.errormessages.usernameLengthError
     