Feature: Update user profile


Background:
     * def jsUtils = read('classpath:jsUtils.js')
     # Calling access token
     * def authUsername = superUserUserName
     * def authPassword = superUserPassword
     * def tenantId = 'pb.jalandhar'
     * print tenantId
     * def authUserType = 'EMPLOYEE'
     * call read('../pretests/authenticationToken.feature')
     * def updatedUserProfile = read('../requestPayload/user/update/updateUser.json')
     * def userProfileData =    read('../testData/user/userProfileData.yaml');



@validParameters
Scenario: Update existing user profile with valid parameters
   * set updatedUserProfile.user.name = userProfileData.validProfileData.userName
   * set updatedUserProfile.user.emailId = userProfileData.validProfileData.emailId
   * set updatedUserProfile.user.correspondenceCity = userProfileData.validProfileData.city
   * configure headers = read('classpath:websCommonHeaders.js') 
   
     Given url updateUser 
     * print updateUser
     And request updatedUserProfile
     * print updatedUserProfile
     When method post
     Then status 200
     And  def updatedUserprofileResponseBody = response

@validAllParameters
Scenario: Update existing user profile with valid parameters
   * configure headers = read('classpath:websCommonHeaders.js') 
   
     Given url updateUser 
     * print updateUser
     And request updatedUserProfile
     * print updatedUserProfile
     When method post
     And  def updatedUserprofileResponseBody = response
     Then status 200

@inValidUserName
Scenario: Update existing user profile with invalid username
   * set updatedUserProfile.user.name = userProfileData.inValidProfileData.userName
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
   * configure headers = read('classpath:websCommonHeaders.js') 
   
     Given url updateUser 
     * print updateUser
     And request updatedUserProfile
     * print updatedUserProfile
     When method post
     Then status 400
     And  def updatedUserprofileResponseBody = response
