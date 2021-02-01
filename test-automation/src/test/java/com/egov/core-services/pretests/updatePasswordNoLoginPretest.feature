Feature: eGovUser-passwordNoLoginUpdate

  Background:
     * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
     * def authUsername = superUserUserName
     * def authPassword = superUserPassword
     * def tenantId = superUserTenantId
     * print tenantId
     * def authUserType = superUserAuthUserType
     * call read('../pretests/authenticationToken.feature')
     * def updateUserPasswordNoLogin = read('../requestPayload/user/updatePasswordNoLogin/updatePasswordNoLogin.json')
     * def updatePasswordData =    read('../constants/user.yaml')
     * set updateUserPasswordNoLogin.otpReference = updatePasswordData.userUpdateNoLoginValidData.otpReference
     * set updateUserPasswordNoLogin.newPassword = updatePasswordData.userUpdateNoLoginValidData.newPassword
     * set updateUserPasswordNoLogin.userName = updatePasswordData.userUpdateNoLoginValidData.userName
     * set updateUserPasswordNoLogin.tenantId = updatePasswordData.userUpdateNoLoginValidData.tenantId
     * set updateUserPasswordNoLogin.type = updatePasswordData.userUpdateNoLoginValidData.type
     * configure headers = read('classpath:websCommonHeaders.js') 

  @invalidOtp
  Scenario: Update password with invalid OTP
   * set updateUserPasswordNoLogin.otpReference = updatePasswordData.userUpdateNoLoginInvalidData.otpReference
     Given url updatePasswordNoLogin 
     * print updatePasswordNoLogin
     And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
     When method post
     Then status 400
     And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin

  @removeOtpReference
  Scenario: Update password with invalid OTP
   * remove updateUserPasswordNoLogin.otpReference
    Given url updatePasswordNoLogin
      * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
      * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
      * print updatedPasswordWithOutLogin

  @removeNewPassword
  Scenario: Update password with invalid OTP
   * remove updateUserPasswordNoLogin.newPassword
    Given url updatePasswordNoLogin
     * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin

  @removeUserName
  Scenario: Update password with invalid OTP
   * remove updateUserPasswordNoLogin.userName 
    Given url updatePasswordNoLogin
     * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin

  @removeTenantId
  Scenario: Update password with invalid OTP
   * remove updateUserPasswordNoLogin.tenantId
    Given url updatePasswordNoLogin
     * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin

  @removeUserType
  Scenario: Update password with invalid OTP
   * remove updateUserPasswordNoLogin.type
    Given url updatePasswordNoLogin
     * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin

  @inValidUserNameOnUpdatePassword
  Scenario: Update password with invalid OTP
   * set updateUserPasswordNoLogin.userName = updatePasswordData.userUpdateNoLoginInvalidData.userName
    Given url updatePasswordNoLogin
     * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin

  @inValidTenantIdOnUpdatePassword
  Scenario: Update password with invalid OTP
   * set updateUserPasswordNoLogin.tenantId = updatePasswordData.userUpdateNoLoginInvalidData.tenantId
    Given url updatePasswordNoLogin
     * print updatePasswordNoLogin
    And request updateUserPasswordNoLogin
     * print updateUserPasswordNoLogin
    When method post
    Then status 400
    And  def updatedPasswordWithOutLogin = response
     * print updatedPasswordWithOutLogin
    
