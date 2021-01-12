Feature: Create user

Background:
  * def jsUtils = read('classpath:jsUtils.js')
 # * def javaUtils = Java.type('com.egov.base.EGovTest')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * def newUser = read('../requestPayload/userCreation/createUser.json')
  * print newUser
 # * def test = read('../../../../../../../envYaml/qa/qa.yaml')
  * def test = read('file:envYaml/' + env + '/' + env +'.yaml')
  * print test
  
@usercreation
Scenario: Creating new user 
  
 #  * def result = call doStorage 'createdUser'
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
     var DataStorage = Java.type('com.egov.base.testReadFile');
     var dS = new DataStorage();
     return dS.updateFile(args);
     }
     """
<<<<<<< HEAD
     * def old = test.userName.toString()
     * print old
     * def result = call doStorage {'old': #(old), 'new': #(createdUser), 'env': #(env) }
=======
     * def old = test.username.toString()
     * print old
     * def result = call doStorage {'old': #(old), 'new': #(createdUser)}
>>>>>>> 45ebfe8... Changed project content from cypress to karate
     * print result