Feature: eGovUser-passwordUpdate

  Background:
     * def jsUtils = read('classpath:jsUtils.js')
     * def userProfileData = read('../constants/user.yaml')
     # Calling access token
     * def authUsername = userProfileData.password.userName
     * def authPassword = userProfileData.password.password
     * def tenantId = superUserTenantId
     * print tenantId
     * def authUserType = superUserAuthUserType
     * call read('../pretests/authenticationToken.feature')
     * def updatedUserPassword = read('../requestPayload/user/updatePassword/updatePassword.json')
     * set updatedUserPassword.existingPassword = userProfileData.validPasswordDetails.existingPassword
     * set updatedUserPassword.newPassword = userProfileData.validPasswordDetails.newPassword
     * set updatedUserPassword.tenantId = userProfileData.validPasswordDetails.tenantId
     * set updatedUserPassword.username = userProfileData.password.userName
     * set updatedUserPassword.type = userProfileData.user.type
     * configure headers = read('classpath:websCommonHeaders.js')

  @validPassword
  Scenario: Update existing password with valid password
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    And  def updatedPasswordResponseBody = response

  @inValidNewPassword
  Scenario: Update existing password with invalid new password
   * set updatedUserPassword.newPassword = userProfileData.inValidPasswordDetails.newInvalidPassword
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @inValidExistingPassword
  Scenario: Update existing password with invalid existing password
   * set updatedUserPassword.existingPassword = userProfileData.inValidPasswordDetails.existingPassword
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @noTenantId
  Scenario: Update password without tenantId
   * remove updatedUserPassword.tenantId
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @invalidTenantIdOnPassword
  Scenario: Update password without tenantId
   * set updatedUserPassword.tenantId = userProfileData.inValidPasswordDetails.tenantId
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 403
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @noUserType
  Scenario: Update password without user type parameter
   * remove updatedUserPassword.type
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @noExistingPassword
  Scenario: Update password without existing password parameter
   * remove updatedUserPassword.existingPassword
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @noNewPassword
  Scenario: Update password without new password parameter
   * remove updatedUserPassword.newPassword
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @invalidUserType
  Scenario: Update password without new password parameter
   * set updatedUserPassword.type = userProfileData.inValidPasswordDetails.type 
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    Then status 400
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

  @sameValidPassword
  Scenario: Update existing password with same valid existing password
   * set updatedUserPassword.existingPassword = authPassword
    Given url updatePassword
     * print updatePassword
    And request updatedUserPassword
     * print updatedUserPassword
    When method post
    And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

