Feature: Update user

Background:
    * def errorMessage = read('../constants/user.yaml')

@Update_NoLogin_Password_InValidOTP_02  @negative   @userPasswordNoLogin @user
Scenario: To validate error message for invalid OTP
        * call read('../pretests/updatePasswordNoLoginPretest.feature@invalidOtp')
        * match updatedPasswordWithOutLogin.error.fields[0].message == errorMessage.errorMessages.otpValidationUnsuccessfulError

@Update_NoLogin_Password_NoOtpReference_03  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when otpSignal is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@removeOtpReference')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_NoNewPassword_04  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when newPassword is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@removeNewPassword')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_NoUserName_05  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when username is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@removeUserName')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_NotenantId_06  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when tenantId is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@removeTenantId')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_Notype_07  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when type is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@removeUserType')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.invalidNonLoggedInUserPasswordUpdateError

@Update_NoLogin_Password_InValidUserName_08  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when userName is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@inValidUserNameOnUpdatePassword')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.userNotFoundError

@Update_NoLogin_Password_InValidtenantId_09  @negative   @userPasswordNoLogin @user
Scenario: To validate error message when tenantId is missing
        * call read('../pretests/updatePasswordNoLoginPretest.feature@inValidTenantIdOnUpdatePassword')
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errorMessages.userNotFoundError




     