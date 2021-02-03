Feature: eGov_User - Update password no login tests

Background:
     * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
     * def authUsername = existingUserName
     * def authPassword = existingUserPassword
     * def tenantId = existingUserTenantId
     * print tenantId
     * def authUserType = existingUserAuthUserType
     * call read('../pretests/authenticationToken.feature')
     * def updatePasswordData = read('../../common-services/userDetails/' + env + '/' + 'userDetails.yaml');
     * def otpReference = randomNumber(5)
     * def newPassword = updatePasswordData.validPasswordDetails.newPassword
     * def userName = authUsername
     * def type = authUserType
     * def errorMessage = read('../constants/user.yaml')
     * def updateUserPasswordNoLogin = read('../requestPayload/user/updatePasswordNoLogin/updatePasswordNoLogin.json')

@Update_NoLogin_Password_InValidOTP_02 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message for invalid OTP
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.error.fields[0].message == errorMessage.errormessages.otpValidationUnsuccessfulError

@Update_NoLogin_Password_NoOtpReference_03 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when otpSignal is missing
        * remove updateUserPasswordNoLogin.otpReference
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_NoNewPassword_04 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when newPassword is missing
        * remove updateUserPasswordNoLogin.newPassword
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_NoUserName_05 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when username is missing
        * remove updateUserPasswordNoLogin.userName
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_NotenantId_06 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when tenantId is missing
        * remove updateUserPasswordNoLogin.tenantId
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_Notype_07 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when type is missing
        * remove updateUserPasswordNoLogin.type
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_InValidUserName_08 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when userName is invalid
        * set updateUserPasswordNoLogin.userName = ranString(10)
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.userNotFoundError

@Update_NoLogin_Password_InValidtenantId_09 @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when tenantId is invalid
        * set updateUserPasswordNoLogin.tenantId = ranString(10)
        * call read('../pretests/eGovUserUpdatePretest.feature@updatePasswordNoLogin')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.userNotFoundError

     