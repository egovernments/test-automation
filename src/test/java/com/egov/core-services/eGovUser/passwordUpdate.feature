Feature: eGov_User - Update password tests

Background:
     * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
     * def authUsername = existingUserName
     * def authPassword = existingUserPassword
     * def tenantId = existingUserTenantId
     * print tenantId
     * def authUserType = existingUserAuthUserType
     * call read('../../pretests/authenticationToken.feature')
     * def userProfileData = read('../../common-services/userDetails/' + env + '/' + 'userDetails.yaml');
     * def errorMessage = read('../constants/user.yaml')
     * def existingPassword = authPassword
     * def newPassword = userProfileData.validPasswordDetails.newPassword
     * def username = existingUserName
     * def type = authUserType
     * def updatedUserPassword = read('../requestPayload/user/updatePassword/updatePassword.json')

@Update_Password_ValidExistingPassword_validNewPassword_01 @positive @userPassword @eGovUser
Scenario: To verify existing password is updating correctly
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.responseInfo.status == 200

@Update_Password_ValidExistingPassword_InvalidNewPassword_02 @negative @userPassword @eGovUser
Scenario: To verify the invalid length password error
        * set updatedUserPassword.newPassword = 'Pas'+ ranString(2)
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidPasswordLngthErrCode
        * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errormessages.invalidPasswordLengthError
   
@Update_Password_InValidExistingPassword_validNewPassword_03 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when an invalid existing password provided
        * set updatedUserPassword.existingPassword = 'Pas'+ ranString(2)
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.passwordMismatchError

@Update_Password_notenantId_04 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when tenantId field is removed
        * remove updatedUserPassword.tenantId
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_InValidtenantId_05 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API for an invalid tenantId
        * set updatedUserPassword.tenantId = ranString(5)
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errormessages.notAuthorizedToAccessResourceerror

@Update_Password_noType_06 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when userType field is removed
        * remove updatedUserPassword.type
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_noExistingPassword_07 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when existingPassword field is removed
        * remove updatedUserPassword.existingPassword
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_noNewPassword_08 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when newPassword field is removed
        * remove updatedUserPassword.newPassword
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_InvalidType_09 @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when invalid type is provided
         * set updatedUserPassword.type = ranString(8)
         * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
         * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidUpdatePasswordRequestError

@Update_Password_SameAsExistingPassword_10  @Positive @userPassword @eGovUser
Scenario: To verify the error message returned by API when invalid type is provided
        * call read('../pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        * match updatedPasswordResponseBody.responseInfo.status == '200'


     