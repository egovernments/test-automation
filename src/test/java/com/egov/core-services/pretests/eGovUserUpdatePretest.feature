Feature: eGovUser-userProfileUpdate pretest

  Background:
     * configure headers = read('classpath:websCommonHeaders.js') 
     * def updateUserPasswordNoLogin = read('../../core-services/requestPayload/user/updatePasswordNoLogin/updatePasswordNoLogin.json')

@updateUserProfile
  Scenario: Update existing user profile with valid parameters
    Given url updateUser
    And request profilePayload
    When method post
    Then assert responseStatus == 200
    And  def updatedUserprofileResponseBody = response

@updatePasswordNoLogin
  Scenario: Update password without login
     Given url updatePasswordNoLogin 
     And request updateUserPasswordNoLogin
     When method post
     Then assert responseStatus == 200
     And  def updatedPasswordWithOutLogin = response

@updateUserPassword
  Scenario: Update existing password with valid password
    Given url updatePassword
    And request updatedUserPassword
    When method post
    And  def updatedPasswordResponseBody = response
    Then assert responseStatus == 200

@errorInUpdateUserProfile
  Scenario: Update existing user profile with invalid parameters
    Given url updateUser
    And request profilePayload
    When method post
    Then assert responseStatus == 400
    And  def updatedUserprofileResponseBody = response

@errorInUpdatePasswordNoLogin
  Scenario: Error in update password without login
     Given url updatePasswordNoLogin 
     And request updateUserPasswordNoLogin
     When method post
     Then assert responseStatus == 400
     And  def updatedPasswordWithOutLogin = response

@errorInUpdateUserPassword
  Scenario: Update existing password with invalid password
    Given url updatePassword
    And request updatedUserPassword
    When method post
    And  def updatedPasswordResponseBody = response
    Then assert responseStatus == 400 || responseStatus == 403

  
