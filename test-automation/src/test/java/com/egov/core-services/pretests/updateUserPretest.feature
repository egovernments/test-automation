Feature: eGovUser-userProfileUpdate

  Background:
     * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
     * def authUsername = superUserUserName
     * def authPassword = superUserPassword
     * def tenantId = superUserTenantId
     * print tenantId
     * def authUserType = superUserAuthUserType
     * call read('../pretests/authenticationToken.feature')
     * def updatedUserProfile = read('../requestPayload/user/update/updateUser.json')
     * def userProfileData =    read('../constants/user.yaml')
     * configure headers = read('classpath:websCommonHeaders.js') 

  @validParameters
  Scenario: Update existing user profile with valid parameters
   * set updatedUserProfile.user.name = userProfileData.validProfileData.userName
   * set updatedUserProfile.user.emailId = userProfileData.validProfileData.emailId
   * set updatedUserProfile.user.correspondenceCity = userProfileData.validProfileData.city
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 200
    And  def updatedUserprofileResponseBody = response

  @validAllParameters
  Scenario: Update existing user profile with valid parameters
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    And  def updatedUserprofileResponseBody = response

  @inValidUserName
  Scenario: Update existing user profile with invalid username
   * set updatedUserProfile.user.name = userProfileData.inValidProfileData.userName
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @inValidEmailId
  Scenario: Update existing user email with invalid email id
   * set updatedUserProfile.user.emailId = userProfileData.inValidProfileData.emailId
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @inValidPhoneNumber
  Scenario: Update existing user email with invalid phone number
   * set updatedUserProfile.user.mobileNumber = userProfileData.inValidProfileData.mobileNumber
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
      * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @validRandomPhoneNumber
  Scenario: Update existing user profile with a random phone number
   * set updatedUserProfile.user.mobileNumber = userProfileData.validProfileData.randomPhoneNumber
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 200
    And  def updatedUserprofileResponseBody = response

  @invalidGender
  Scenario: Update existing user profile with an Invalid gender
   * set updatedUserProfile.user.gender = userProfileData.inValidProfileData.gender
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @invalidTenantId
  Scenario: Update existing tenantID with a null value
   * set updatedUserProfile.user.tenantId = userProfileData.inValidProfileData.tenantID
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @blankUUID
  Scenario: Update existing tenantID with a null value
   * set updatedUserProfile.user.uuid = ""
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @invalidUUID
  Scenario: Update existing tenantID with a null value
   * set updatedUserProfile.user.uuid = "invalid_UUID"
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @removeID
  Scenario: Remove existing id
   * remove updatedUserProfile.user.id 
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @invalidID
  Scenario: Update existing id with a invalid value
   * set updatedUserProfile.user.id = userProfileData.inValidProfileData.id
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response

  @nameWithMaxmiumCharacters
  Scenario: Update existing user name with 50 characters
   * def name = ranString(55)
   * set updatedUserProfile.user.name = name
    Given url updateUser
     * print updateUser
    And request updatedUserProfile
     * print updatedUserProfile
    When method post
    Then status 400
    And  def updatedUserprofileResponseBody = response
