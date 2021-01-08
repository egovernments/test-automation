Feature: user 
Background:
  * def jsUtils = read('classpath:jsUtils.js')

@User_Search_ValidUserName_01  @Positive
Scenario: Test to Search for user by passing valid UserName in the request
  * call read('../pretests/userPretest.feature@finduser')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user

# @User_Search_InValidUsername_02  @Negative
# Scenario: Test to Search for user by passing InValid UserName in the request 