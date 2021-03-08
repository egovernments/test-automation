Feature: eGovUser - This feature is to test search and create user scenarios
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def userConstant = read('../../core-services/constants/user.yaml')

@User_Search_ValidUserName_01  @coreServices @regression @positive  @userSearch  @eGovUser
Scenario: Test to Search for user by passing valid UserName in the request
  # Steps to search user
  * call read('../../core-services/pretests/userPretest.feature@finduser')
  # Defining user with length of the searched user
  * def user = searchUserResponseBody.user.length
  
  # Validate the value of user is present
  * match user == '#present'

 @User_Search_InValidUsername_02  @coreServices @regression @negative  @userSearch  @eGovUser
 Scenario: Test to Search for user by passing InValid UserName in the request
  # Steps to search user with invalid user name
  * call read('../../core-services/pretests/userPretest.feature@finduserwithinvalidusername')
  # Defining user with length of the searched user
  * def user = searchUserResponseBody.user.length
  
  # Validate the value of user is present
  * match user == '#present'

@User_Search_InValidTenantId_03  @coreServices @regression @negative  @userSearch  @eGovUser
Scenario: Search for user by giving InValid tenantId
  # Steps to search user with invalid tenantId
  * call read('../../core-services/pretests/userPretest.feature@finduserwithinvalidtenantid')
  # Defining user with length of the searched user
  * def user = searchUserResponseBody.user.length
  
  # Validate the value of user is present
  * match user == '#present'

@User_Search_NoUserName_04  @coreServices @regression @negative  @userSearch  @eGovUser
Scenario: Search for user without username parameter/Search for user without username parameter
  # Steps to search user without userName parameter
  * call read('../../core-services/pretests/userPretest.feature@finduserwithoutusername')
  # Validate actual error message returned by API as userName parameter is missnig should equal to expected message
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.forInvalidUserName

@User_Search_NotenantId_05  @coreServices @regression @negative  @userSearch  @eGovUser
Scenario: Search for user without tenantId parameter
  # Steps to search user without tenantId parameter
  * call read('../../core-services/pretests/userPretest.feature@finduserwithouttenantid')
  # Validate actual error message returned by API as tenantId parameter is missnig should equal to expected message
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.withoutTenanntId

@User_SearchMultipleTenantUsers_08  @coreServices @regression @positive  @userSearch  @eGovUser
Scenario: Search by passing 2 tenantids. Make sure both are valid or Multiple Users
  # Steps to search user with multiple tenantIds 
  * call read('../../core-services/pretests/userPretest.feature@finduserwithmultipletenantid')
  # Defining user with length of the searched user
  * def user = searchUserResponseBody.user.length
  

@User_SearchBlankTenant_09  @coreServices @regression @negative  @userSearch  @eGovUser
Scenario: Pass null value for tenantid and check for errors
  # Steps to search user empty tenantId
  * call read('../../core-services/pretests/userPretest.feature@finduseremptytenantid')
  # Validate actual error code returned by API for null tenantId is equal to expected error code
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.withEmptyStringTenantId

@Create_Citizen_InValidOTP_02  @coreServices @regression @negative  @createSearch  @eGovUser
Scenario: Create Citizen with Invalid OTP & valid data
  # Steps to create citizen with invalid OTP and valid date
  * call read('../../core-services/pretests/citizenCreate.feature@createCitizen')
  # Validate actual error message returned by API for invalid OTP is equal to expected error message
  * assert createCitizenResponseBody.error.message == userConstant.errormessages.invalidOtp
  
@Create_Citizen_NoUsername_03 @coreServices @regression @negative  @createSearch  @eGovUser
Scenario: Create citizen without username parameter in the request
  # Steps to create citizen without userName parameter
  * call read('../../core-services/pretests/citizenCreate.feature@createCitizenWithoutUsername')
  # Validate actual error code returned by API for missed userName parameter is equal to expected error code
  * assert createCitizenResponseBody.Errors[0].code == userConstant.errormessages.invalidUserNameCode 

@Create_Citizen_NoName_04  @coreServices @regression @negative  @createSearch  @eGovUser
Scenario: Create citizen without name parameter in the request
   # Steps to create citizen without name parameter
   * call read('../../core-services/pretests/citizenCreate.feature@createCitizenWithoutName')
   # Validate actual error code returned by API for missed name parameter is equal to expected error code
   * assert createCitizenResponseBody.Errors[0].code == userConstant.errormessages.invalidName

@Create_Citizen_NotenantId_05  @coreServices @regression @negative  @createSearch  @eGovUser
Scenario: Create citizen without tenantId parameter in the request
   # Steps to create citizen without tenantId parameter
   * call read('../../core-services/pretests/citizenCreate.feature@createCitizenWithoutTenantId')
   # Validate actual error code returned by API for missed tenantId parameter is equal to expected error code
   * assert createCitizenResponseBody.Errors[0].code == userConstant.errormessages.invalidTenantId

@Create_Citizen_InvalidUsername_06  @coreServices @regression @negative  @createSearch  @eGovUser
Scenario: Create citizen with InValid username in the request
   # Steps to create citizen with invalid userName parameter
   * call read('../../core-services/pretests/citizenCreate.feature@createCitizenWithInvalidUsername')
   # Validate actual error code returned by API for invalid userName parameter is equal to expected error code
   * assert createCitizenResponseBody.Errors[0].code == userConstant.errormessages.invalidUserNameCode

@Create_Citizen_NameWithMoreThan50Characters_07  @coreServices @regression @negative  @createSearch  @eGovUser
Scenario: Create citizen name with more than 50 characters in the request
   # Steps to create citizen with invalid length of name 
   * call read('../../core-services/pretests/citizenCreate.feature@createCitizenWithNameMoreThan50chars')
   # Validate actual error message returned by API for invalid character length of name parameter is equal to expected error message
   * assert createCitizenResponseBody.Errors[0].message == userConstant.errormessages.nameCharsSize