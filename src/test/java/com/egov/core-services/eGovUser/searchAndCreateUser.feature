Feature: user 
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def userConstant = read('../../core-services/constants/user.yaml')

@User_Search_ValidUserName_01  @positive  @userSearch  @eGovUser
Scenario: Test to Search for user by passing valid UserName in the request
  * call read('../../core-services/pretests/userPretest.feature@finduser')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user
  * match user == '#present'

@User_Search_InValidUsername_02  @negative  @userSearch  @eGovUser 
Scenario: Test to Search for user by passing InValid UserName in the request 
  * call read('../../core-services/pretests/userPretest.feature@finduserwithinvalidusername')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user
  * match user == '#present'

@User_Search_InValidTenantId_03  @negative  @userSearch  @eGovUser
Scenario: Search for user by giving InValid tenantId
  * call read('../../core-services/pretests/userPretest.feature@finduserwithinvalidtenantid')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user
  * match user == '#present'

@User_Search_NoUserName_04  @negative  @userSearch  @eGovUser
Scenario: Search for user without username parameter/Search for user without username parameter
  * call read('../../core-services/pretests/userPretest.feature@finduserwithoutusername')
  * print searchUserResponseBody
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.forInvalidUserName

@User_Search_NotenantId_05  @negative  @@userSearch  @eGovUser
Scenario: Search for user without tenantId parameter
  * call read('../../core-services/pretests/userPretest.feature@finduserwithouttenantid')
  * print searchUserResponseBody
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.withoutTenanntId

@User_SearchMultipleTenantUsers_08  @positive  @userSearch  @eGovUser
Scenario: Search by passing 2 tenantids. Make sure both are valid or Multiple Users
  * call read('../../core-services/pretests/userPretest.feature@finduserwithmultipletenantid')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user

@User_SearchBlankTenant_09  @negative  @userSearch  @eGovUser
Scenario: Pass null value for tenantid and check for errors
  * call read('../../core-services/pretests/userPretest.feature@finduseremptytenantid')
  * print searchUserResponseBody
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.withEmptyStringTenantId

@Create_Citizen_InValidOTP_02  @negative  @userSearch  @eGovUser
Scenario: Create Citizen with Invalid OTP & valid data
  * call read('../../core-services/pretests/citizenCreate.feature@citizencreate')
  * print citizenCreateResponseBody
  * assert citizenCreateResponseBody.error.message == userConstant.errormessages.invalidOtp
  

@Create_Citizen_NoUsername_03 @negative  @createSearch  @eGovUser
Scenario: Create citizen without username parameter in the request
  * call read('../../core-services/pretests/citizenCreate.feature@citizencreatewithoutusername')
  * print citizenCreateResponseBody
  * assert citizenCreateResponseBody.Errors[0].code == userConstant.errormessages.invalidUserName 

@Create_Citizen_NoName_04  @negative  @createSearch  @eGovUser
Scenario: Create citizen without name parameter in the request
   * call read('../../core-services/pretests/citizenCreate.feature@citizencreatewithoutname')
   * print citizenCreateResponseBody
   * assert citizenCreateResponseBody.Errors[0].code == userConstant.errormessages.invalidName

@Create_Citizen_NotenantId_05  @negative  @createSearch  @eGovUser
Scenario: Create citizen without tenantId parameter in the request
   * call read('../../core-services/pretests/citizenCreate.feature@citizencreatewithouttenantid')
   * print citizenCreateResponseBody
   * assert citizenCreateResponseBody.Errors[0].code == userConstant.errormessages.invalidTenantId

@Create_Citizen_InvalidUsername_06  @negative  @createSearch  @eGovUser
Scenario: Create citizen with InValid username in the request
   * call read('../../core-services/pretests/citizenCreate.feature@citizencreateinvalidusername')
   * print citizenCreateResponseBody
   * assert citizenCreateResponseBody.Errors[0].code == userConstant.errormessages.invalidUserName

@Create_Citizen_NameWithMoreThan50Characters_07  @negative  @createSearch  @eGovUser
Scenario: Create citizen name with more than 50 characters in the request
   * call read('../../core-services/pretests/citizenCreate.feature@citizencreatenamewith50chars')
   * print citizenCreateResponseBody
   * assert citizenCreateResponseBody.Errors[0].message == userConstant.errormessages.nameCharsSize
   
   
  