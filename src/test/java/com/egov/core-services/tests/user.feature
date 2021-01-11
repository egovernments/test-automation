Feature: user 
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def userConstant = read('../constants/user.yaml')
  * def findUser = read('../requestPayload/userCreation/searchUser.json')

@User_Search_ValidUserName_01  @Positive  @User
Scenario: Test to Search for user by passing valid UserName in the request
  * call read('../pretests/userPretest.feature@finduser')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user

@User_Search_InValidUsername_02  @Negative  @User
Scenario: Test to Search for user by passing InValid UserName in the request 
  * call read('../pretests/userPretest.feature@finduserwithinvalidusername')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user

@User_Search_InValidTenantId_03  @Negative  @User
Scenario: Search for user by giving InValid tenantId
  * call read('../pretests/userPretest.feature@finduserwithinvalidtenantid')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user

@User_Search_NoUserName_04  @Negative  @User
Scenario: Search for user without username parameter/Search for user without username parameter
  * call read('../pretests/userPretest.feature@finduserwithoutusername')
  * print searchUserResponseBody
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.forInvalidUserName

@User_Search_NotenantId_05  @Negative  @User
Scenario: Search for user without tenantId parameter
  * call read('../pretests/userPretest.feature@finduserwithouttenantid')
  * print searchUserResponseBody
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.withoutTenanntId

@User_Search_InvalidAuthToken_06  @500
Scenario: Search for user by giving Invalid AuthToken
  * call read('../pretests/userPretest.feature@finduser')
  * print searchUserResponseBody

@User_SearchMultipleTenantUsers_08  @Positive  @User
Scenario: Search by passing 2 tenantids. Make sure both are valid or Multiple Users
  * call read('../pretests/userPretest.feature@finduserwithmultipletenantid')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user

@User_SearchBlankTenant_09  @Negative  @User
Scenario: Pass null value for tenantid and check for errors
  * call read('../pretests/userPretest.feature@finduseremptytenantid')
  * print searchUserResponseBody
  * assert searchUserResponseBody.Errors[0].code == userConstant.errormessages.withEmptyStringTenantId
 
#@Create_Citizen_ValidOTP_01
#Scenario: Create Citizen with OTP & valid data

@Create_Citizen_InValidOTP  @Negative 
Scenario: Create Citizen with Invalid OTP & valid data
  * call read('../pretests/citizenCreate.feature@citizencreate')
  * print citizenCreateResponseBody
  * assert citizenCreateResponseBody.error.message == userConstant.errormessages.invalidOtp
  

@Create_Citizen_NoUsername_03 @Negative
Scenario: Create citizen without username parameter in the request
  