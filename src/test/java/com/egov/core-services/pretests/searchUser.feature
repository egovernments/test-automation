Feature: Search user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = authUsername
  * def authPassword = authPassword
  * def authUserType = authUserType
  * call read('../pretests/authenticationToken.feature')
  * def envContant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * def existingUser = envContant.userName
  * print existingUser
  * def findUserPayload = read('../requestPayload/userCreation/searchUserInDb.json')
  * print findUserPayload

# Search user
@searchuser
Scenario: Search user
   * configure headers = read('classpath:websCommonHeaders.js') 
     Given url searchUser 
     * print searchUser  
     And request findUserPayload
     * print findUserPayload
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response
     * print searchUserResponseBody
     * def user = searchUserResponseBody.user.length
     * print user
     And eval if (user == 0) karate.call('userCreation.feature')
     