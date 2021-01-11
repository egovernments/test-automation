Feature: Create Citizen
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = counterEmployeeUserName
  * def authPassword = counterEmployeePassword
  * def authUserType = 'EMPLOYEE'
  * call read('../pretests/authenticationToken.feature')
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def createCitizenPayload = read('../requestPayload/user/citizenCreation.json')
  * def userConstant = read('../constants/user.yaml')

  * def envContant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * set createCitizenPayload.User.username = envContant.userName
  * set createCitizenPayload.User.otpReference = userConstant.parameters.invalidOtpReference
  * set createCitizenPayload.User.name = userConstant.parameters.name
  * set createCitizenPayload.User.permanentCity = userConstant.parameters.permanentCity
  

  @citizencreate 
  Scenario: Create citizen
     Given url createCitizen 
     * print createCitizen  
     And request createCitizenPayload
     * print createCitizenPayload
     When method post
     Then status 400
     And def citizenCreateResponseHeader = responseHeaders
     And def citizenCreateResponseBody = response
     * print citizenCreateResponseBody