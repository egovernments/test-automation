Feature: eGov_User - Update password tests

Background:
    * def updatedUserPassword = read('../requestPayload/user/updatePassword/updatePassword.json')
    * def userProfileData = read('../constants/user.yaml')
    * def errorMessage = read('../constants/user.yaml')
    * def existingPassword = userProfileData.validPasswordDetails.existingPassword
    * def newPassword = userProfileData.validPasswordDetails.newPassword

@Update_Password_ValidExistingPassword_validNewPassword_01 @positive @userPassword @user
Scenario: To verify existing password is updating correctly
        * call read('../pretests/updateUserPasswordPretest.feature@validPassword')
        * assert updatedPasswordResponseBody.responseInfo.status == 200

@Update_Password_ValidExistingPassword_InvalidNewPassword_02 @negative @userPassword @user
Scenario: To verify the invalid length password error
   * call read('../pretests/updateUserPasswordPretest.feature@inValidNewPassword')
   * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidPasswordLngthErrCode
   * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errormessages.invalidPasswordLengthError
   
@Update_Password_InValidExistingPassword_validNewPassword_03 @negative @userPassword @user
Scenario: To verify the error message returned by API when an invalid existing password provided
        * call read('../pretests/updateUserPasswordPretest.feature@inValidExistingPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.passwordMismatchError

@Update_Password_notenantId_04 @negative @userPassword @user
Scenario: To verify the error message returned by API when tenantId field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noTenantId')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_InValidtenantId_05 @negative @userPassword @user
Scenario: To verify the error message returned by API when tenantId field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@invalidTenantIdOnPassword')
        * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errormessages.notAuthorizedToAccessResourceerror

@Update_Password_noType_06 @negative @userPassword @user
Scenario: To verify the error message returned by API when tenantId field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noUserType')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError


@Update_Password_noExistingPassword_07 @negative @userPassword @user
Scenario: To verify the error message returned by API when existingPassword field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noExistingPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_noNewPassword_08 @negative @userPassword @user
Scenario: To verify the error message returned by API when newPassword field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noNewPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_InvalidType_09 @negative @userPassword @user
Scenario: To verify the error message returned by API when invalid type is provided
        * call read('../pretests/updateUserPasswordPretest.feature@invalidUserType')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_SameAsExistingPassword_10  @Positive @userPassword @user
Scenario: To verify the error message returned by API when invalid type is provided
        * call read('../pretests/updateUserPasswordPretest.feature@sameValidPassword')
        * match updatedPasswordResponseBody.responseInfo.status == '200'


     