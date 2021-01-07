Feature: user 
Background:
  * def jsUtils = read('classpath:jsUtils.js')

@User_Search_ValidUserName_01
Scenario: Test to Search for user by passing valid UserName in the request
  * call read('../pretests/user.feature@finduser')
  * print searchUserResponseBody
  * def user = searchUserResponseBody.user.length
  * print user