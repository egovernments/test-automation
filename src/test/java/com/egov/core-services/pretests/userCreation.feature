Feature: Create user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * call read('../../common-services/pretests/eGovMdmsPretest.feature@successSearchState')
  # Calling access token
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * print newUserPayload
  * def userType = accessControlRoles.roles[0].code
  * def name = ranString(4)
  * def mobileNumberGen = '90' + randomMobileNumGen(8)
  * def mobileNumber = new java.math.BigDecimal(mobileNumberGen)
  * def emailId = ranEmailId(5)
  * def dob = todayDate()
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def gender = commonConstants.parameters.gender[0]
  * def newUserPayload = read('../../core-services/requestPayload/userCreation/createUser.json')

  
@usercreation
Scenario: Creating new user 
     * configure headers = read('classpath:websCommonHeaders.js')   
     Given url createUser 
     * print createUser
     And request newUserPayload
     * print newUserPayload
     When method post
     Then status 200
     And def userCreationResponseHeader = responseHeaders
     And def userCreationResponseBody = response
     * print userCreationResponseBody
     * def createdUser = userCreationResponseBody.user[0].userName
     * print createdUser