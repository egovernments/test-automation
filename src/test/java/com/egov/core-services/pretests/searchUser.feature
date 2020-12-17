Feature: Search user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def createUser = read('../pretests/userCreation.feature')
  * print createdUser
  * def findUser = read('../requestPayload/userCreation/searchUser.json')
  * print findUser

# Search user
@searchuser
Scenario: Search user
  # * def createUser = read('../pretests/userCreation.feature')
  # * print userCreationResponseBody
  # * def createdUser = userCreationResponseBody.user[0].userName
  # * print createdUser 
   * configure headers = read('classpath:websCommonHeaders.js') 
  # * set findUser.userName = createdUser
     Given url searchUser   
     And request findUser
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response
     * print searchUserResponseBody
     * def user = searchUserResponseBody.user.length
     * print user
     And eval if (user == 0) karate.call('../pretests/userCreation.feature')
     