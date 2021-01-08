Feature: search user
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def findUser = read('../requestPayload/userCreation/searchUser.json')
  * print findUser

@finduser
Scenario: Search user
   #  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url searchUser 
     * print searchUser  
     And request findUser
     * print findUser
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response