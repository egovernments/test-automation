Feature: User Search
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def envContant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * def existingUser = envContant.userName
  * print existingUser
  * def findUser = read('../requestPayload/userCreation/searchUser.json')
  * print findUser
  * def userConstant = read('../constants/user.yaml')
  * def commonConstants = read('../constants/commonConstants.yaml')

@finduser
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js') 
     * def payload = findUser.validPayload
     Given url searchUser 
     * print searchUser  
     And request payload
     * print payload
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response

@finduserwithmultipletenantid
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js')
     * def payload = findUser.validPayload
     * set findUser.validPayload.tenantId = userConstant.parameters.multipleTenantId
     Given url searchUser 
     * print searchUser  
     And request payload
     * print payload
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response
  
@finduserwithinvalidusername
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js') 
     * def payload = findUser.validPayload
     * set findUser.validPayload.userName = userConstant.parameters.notRegisteredUserName
     Given url searchUser 
     * print searchUser  
     And request payload
     * print payload
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response

@finduserwithinvalidtenantid
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js')
     * def payLoad = findUser.validPayload  
     * set findUser.validPayload.tenantId = commonConstants.invalidParameters.invalidTenantId
     Given url searchUser 
     * print searchUser  
     And request payLoad
     * print payLoad
     When method post
     Then status 200
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response

@finduserwithoutusername
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js')
     * def payLoad = findUser.validPayload 
     * set findUser.validPayload.userName = userConstant.parameters.withoutUserName
     Given url searchUser 
     * print searchUser  
     And request payLoad
     * print payLoad
     When method post
     Then status 400
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response

@finduserwithouttenantid
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js') 
     * def payLoad = findUser.invalidPayload
     Given url searchUser 
     * print searchUser  
     And request payLoad
     * print payload
     When method post
     Then status 400
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response

@finduseremptytenantid
Scenario: Search user
     * configure headers = read('classpath:websCommonHeaders.js') 
     * def payLoad = findUser.validPayload
     * set findUser.validPayload.tenantId = userConstant.parameters.emptyStringInTenantId
     Given url searchUser 
     * print searchUser  
     And request payLoad
     * print payload
     When method post
     Then status 400
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response