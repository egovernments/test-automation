Feature: eGov_User - This feature is to test Update user's password scenarios

Background:
     * def jsUtils = read('classpath:jsUtils.js')
     * def authUsername = employeeUserName
     * def authPassword = employeePassword
     * def authUserType = employeeType
     * call read('../../common-services/pretests/authenticationToken.feature')
     * def errorMessage = read('../../core-services/constants/user.yaml')
     * def genericError = read("../../common-services/constants/genericConstants.yaml")
     * def existingPassword = authPassword
     * def newPassword = 'Password@'+randomNumber(4)
     * def username = authUsername
     * def type = authUserType
     * def updatedUserPassword = read('../../core-services/requestPayload/user/updatePassword/updatePassword.json')

@Update_Password_ValidExistingPassword_validNewPassword_01 @Update_Password_SameAsExistingPassword_10 @regression @positive @userPassword @eGovUser
Scenario: To verify existing password is updating correctly
        # Steps to update user's password with valid reuest payload
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate the API responseInfo status as 200 once password update is succeeded 
        * assert updatedPasswordResponseBody.responseInfo.status == 200
        # Reset existingPassword value with updated password
        * set updatedUserPassword.existingPassword = newPassword
        # Reset newPassword value with old password value
        * set updatedUserPassword.newPassword = authPassword
        # Re-executing update user password steps to restore the existing password back, so that it can be reusable and independent
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')

@Update_Password_ValidExistingPassword_InvalidNewPassword_02 @regression @negative @userPassword @eGovUser
Scenario: To verify the invalid length password error
        # Set invalid password to newPassword field
        * set updatedUserPassword.newPassword = 'Pas'+ ranString(2)
        # Steps to update user's password with invalid newPassword field value and generate error
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error code and message returned by API due to invalid password length 
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.invalidPasswordLengthCode
        * assert updatedPasswordResponseBody.Errors[0].message == errorMessage.errormessages.invalidPasswordMessage
   
@Update_Password_InValidExistingPassword_validNewPassword_03 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when an invalid existing password provided
        # Set existingPassword as invalid
        * set updatedUserPassword.existingPassword = 'Pas'+ ranString(2)
        # Steps to update user's password with invalid existingPassword value and generate error
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error message returned by API is equal to expected error message
        * assert updatedPasswordResponseBody.Errors[0].code == errorMessage.errormessages.passwordMismatchCode
        * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

@Update_Password_notenantId_04 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when tenantId field is removed
        # Remove tenantId field from the request body
        * remove updatedUserPassword.tenantId
        # Steps to update user's password without tenantId and generate error message 
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error message returned by API is equal to expected error message
        * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

@Update_Password_InValidtenantId_05 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API for an invalid tenantId
        # Set random invalid value as tenantID
        * set updatedUserPassword.tenantId = ranString(5)
        # Steps to update user's password with invalid tenantId and generate error message 
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error message returned by API is equal to expected error message
        * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.authorizedError

@Update_Password_noType_06 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when userType field is removed
        # Remove type field from the request body
        * remove updatedUserPassword.type
        # Steps to update user's password without type field to generate error message
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error message returned by API is equal to expected error message
        * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

@Update_Password_noExistingPassword_07 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when existingPassword field is removed
        # Remove existingPassword field from the request body
        * remove updatedUserPassword.existingPassword
        # Steps to update user's password without existingPassword field to generate error message
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error message returned by API is equal to expected error message
        * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

@Update_Password_noNewPassword_08 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when newPassword field is removed
        # Remove newPassword field from the request body
        * remove updatedUserPassword.newPassword
        # Steps to update user's password without newPassword field to generate error message
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
        # Validate actual error message returned by API is equal to expected error message
        * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.unhandledException

@Update_Password_InvalidType_09 @regression @negative @userPassword @eGovUser
Scenario: To verify the error message returned by API when invalid type is provided
         # Set a random invalid value as user type
         * set updatedUserPassword.type = ranString(8)
         # Steps to update user's password and generate error message for invalid user type
         * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@updateUserPassword')
         # Validate actual error message returned by API is equal to expected error message
         * assert updatedPasswordResponseBody.Errors[0].message == genericError.errorMessages.unhandledException



     