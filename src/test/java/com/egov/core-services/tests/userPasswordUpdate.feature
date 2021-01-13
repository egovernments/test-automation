Feature: Update user

Background:
    * def updatedUserPassword = read('../requestPayload/user/updatePassword/updatePassword.json')
    * def userProfileData = read('../testData/user/userProfileData.yaml');
    * def errorMessage = read("../constants/userProfile.yaml")
    * def existingPassword = userProfileData.validPasswordDetails.existingPassword
    * def newPassword = userProfileData.validPasswordDetails.newPassword

@Update_Password_ValidExistingPassword_validNewPassword_01  @positive   @eGovUserPassword @eGovUser
Scenario: To verify existing password is updating correctly
        * call read('../pretests/updateUserPasswordPretest.feature@validPassword')
        * assert updatedPasswordResponseBody.responseInfo.status == 200

@Update_Password_ValidExistingPassword_InvalidNewPassword_02   @negative   @eGovUserPassword @eGovUser
Scenario: To verify the invalid length password error
   * call read('../pretests/updateUserPasswordPretest.feature@inValidNewPassword')
   * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.invalidPasswordLngthErrCode
   * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errorMessages.invalidPasswordLengthError
   

@Update_Password_InValidExistingPassword_validNewPassword_03  @negative    @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when an invalid existing password provided
        * call read('../pretests/updateUserPasswordPretest.feature@inValidExistingPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.passwordMismatchError

@Update_Password_notenantId_04  @negative @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when tenantId field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noTenantId')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.invalidUpdatePasswordRequestError

@Update_Password_InValidtenantId_05  @negative @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when tenantId field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@invalidTenantIdOnPassword')
        * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errorMessages.notAuthorizedToAccessResourceerror

@Update_Password_noType_06  @negative @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when tenantId field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noUserType')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.invalidUpdatePasswordRequestError


@Update_Password_noExistingPassword_07  @negative @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when existingPassword field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noExistingPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.invalidUpdatePasswordRequestError


@Update_Password_noNewPassword_08  @negative @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when newPassword field is removed
        * call read('../pretests/updateUserPasswordPretest.feature@noNewPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.invalidUpdatePasswordRequestError

@Update_Password_InvalidType_09  @negative @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when invalid type is provided
        * call read('../pretests/updateUserPasswordPretest.feature@invalidUserType')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errorMessages.invalidUpdatePasswordRequestError

@Update_Password_SameAsExistingPassword_10  @Positive @eGovUserPassword @eGovUser
Scenario: To verify the error message returned by API when invalid type is provided
        * call read('../pretests/updateUserPasswordPretest.feature@sameValidPassword')
        * match updatedPasswordResponseBody.responseInfo.status == '200'


     