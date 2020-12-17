Feature: Create user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def newUser = read('../requestPayload/userCreation/createUser.json')
  * print newUser
 
# @usercreation
Scenario: Creating new user 
   * def mobileNumberGen = randomMobileNumGen(10)
   * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
   * print validMobileNum
   * set newUser.user.mobileNumber = validMobileNum
   * set newUser.user.userName = validMobileNum
   * configure headers = read('classpath:websCommonHeaders.js') 
     Given url createUser   
     And request newUser
     When method post
     Then status 200
     And def userCreationResponseHeader = responseHeaders
     And def userCreationResponseBody = response
     * print userCreationResponseBody
     * def createdUser = userCreationResponseBody.user[0].userName
     * print createdUser