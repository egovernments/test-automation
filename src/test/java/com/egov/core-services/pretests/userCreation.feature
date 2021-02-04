Feature: Create user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = authUsername
  * def authPassword = authPassword
  * def authUserType = authUserType
  * call read('../pretests/authenticationToken.feature')
  * def newUser = read('../requestPayload/userCreation/createUser.json')
  * print newUser
  * def envValue = read('file:envYaml/' + env + '/' + env +'.yaml')
  * print envValue
  
@usercreation
Scenario: Creating new user 
   * print result
   * def mobileNumberGen = randomMobileNumGen(10)
   * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
   * print validMobileNum
   * set newUser.user.mobileNumber = validMobileNum
   * set newUser.user.userName = validMobileNum
   * configure headers = read('classpath:websCommonHeaders.js') 
   
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
     * def doStorage =
     """
     function(args) {
     var DataStorage = Java.type('com.egov.base.ReadWriteCitizenUserName');
     var dS = new DataStorage();
     return dS.updateFile(args);
     }
     """
     * def old = envValue.userName.toString()
     * print old
     * def result = call doStorage {'old': #(old), 'new': #(createdUser), 'env': #(env) }
     * print result