Feature: Search user

        Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def envContant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * def existingUser = envContant.userName
  * def findUserPayload = read('../requestPayload/user-creation/searchUserInDb.json')

# Search user
        @searchuser
        Scenario: Search user
   * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js') 
            Given url searchUser
              And request findUserPayload
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response
     * def user = searchUserResponseBody.user.length
              And eval if (user == 0) karate.call('userCreation.feature')
     