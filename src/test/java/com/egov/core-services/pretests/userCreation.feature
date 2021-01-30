Feature: Create user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../pretests/authenticationToken.feature')
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def newUser = read('../requestPayload/userCreation/createUser.json')
  * print newUser
  * def name = ranString(4)
  * def mobileNumberGen = '90' + randomMobileNumGen(8)
  * def mobileNumber = new java.math.BigDecimal(mobileNumberGen)
  * def emailId = ranEmailId(5)
  * def dob = todayDate()

  
@usercreation
Scenario: Creating new user    
     Given url createUser 
     * print createUser
     And request newUser
     * print newUser
     When method post
     Then status 200
     And def userCreationResponseHeader = responseHeaders
     And def userCreationResponseBody = response
     * print userCreationResponseBody
     * def createdUser = userCreationResponseBody.user[0].userName
     * print createdUser