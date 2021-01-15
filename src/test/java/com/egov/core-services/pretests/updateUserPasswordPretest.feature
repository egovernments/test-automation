Feature: Update user password


Background:
     * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
     * def authUsername = 'EMP-1013-000443'
     * def authPassword = 'TestUser@1234'
     * def tenantId = superUserTenantId
     * print tenantId
     * def authUserType = superUserAuthUserType
     * call read('../pretests/authenticationToken.feature')
     * def updatedUserPassword = read('../requestPayload/user/updatePassword/updatePassword.json')
     * def userProfileData = read('../testData/user/userProfileData.yaml');
     * set updatedUserPassword.existingPassword = userProfileData.validPasswordDetails.existingPassword
     * set updatedUserPassword.newPassword = userProfileData.validPasswordDetails.newPassword
     * set updatedUserPassword.tenantId = userProfileData.validPasswordDetails.tenantId



@validPassword
Scenario: Update existing password with valid password
   * configure headers = read('classpath:websCommonHeaders.js') 
   
     Given url updatePassword
     * print updatePassword
     And request updatedUserPassword
     * print updatedUserPassword
     When method post
     And  def updatedPasswordResponseBody = response

@inValidNewPassword
Scenario: Update existing password with invalid new password
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js') 
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
   * configure headers = read('classpath:websCommonHeaders.js')
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   * set updatedUserPassword.existingPassword = authPassword
     Given url updatePassword
     * print updatePassword
     And request updatedUserPassword
     * print updatedUserPassword
     When method post
     And  def updatedPasswordResponseBody = response
     * print updatedPasswordResponseBody

