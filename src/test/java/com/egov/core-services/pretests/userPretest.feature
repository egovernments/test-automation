Feature: User Search
Background:
  * configure headers = read('classpath:websCommonHeaders.js')
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * call read('../../common-services/pretests/eGovMdmsPretest.feature@successSearchCity')
  * def multipleTenantId = tenant.tenants[1].code + ',' + tenant.tenants[3].code
  * call read('../../core-services/pretests/userCreation.feature@usercreation')
  * def existingUser = createdUser
  * def mobileNumberGen = randomMobileNumGen(10)
  * def unRegisteredNumber = new java.math.BigDecimal(mobileNumberGen)
  * print unRegisteredNumber
  * def withoutUserName = ''
  * def emptyStringInTenantId = ''
  * def userConstant = read('../../core-services/constants/user.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def findUser = read('../../core-services/requestPayload/userCreation/searchUser.json')
  * print findUser

@finduser
Scenario: Search user
  #   * configure headers = read('classpath:websCommonHeaders.js') 
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
    # * configure headers = read('classpath:websCommonHeaders.js')
     * def payload = findUser.validPayload
     * set findUser.validPayload.tenantId = multipleTenantId
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
 #    * configure headers = read('classpath:websCommonHeaders.js') 
     * def payload = findUser.validPayload
     * set findUser.validPayload.userName = unRegisteredNumber
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
 #    * configure headers = read('classpath:websCommonHeaders.js')
     * def payLoad = findUser.validPayload  
     * set findUser.validPayload.tenantId = invalidTenantId
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
 #    * configure headers = read('classpath:websCommonHeaders.js')
     * def payLoad = findUser.validPayload 
     * set findUser.validPayload.userName = withoutUserName
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
 #    * configure headers = read('classpath:websCommonHeaders.js') 
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
 #    * configure headers = read('classpath:websCommonHeaders.js') 
     * def payLoad = findUser.validPayload
     * set findUser.validPayload.tenantId = emptyStringInTenantId
     Given url searchUser 
     * print searchUser  
     And request payLoad
     * print payload
     When method post
     Then status 400
     And def searchUserResponseHeader = responseHeaders
     And def searchUserResponseBody = response