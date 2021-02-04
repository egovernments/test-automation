Feature: Create Citizen
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def authUsername = authUsername
  * def authPassword = authPassword
  * def authUserType = authUserType
  * call read('../pretests/authenticationToken.feature')
  * configure headers = read('classpath:websCommonHeaders.js') 

  * def citizen = read('../requestPayload/user/citizenCreation.json')
  * def createCitizenPayload = citizen.validPayload
  * print createCitizenPayload
  * def userConstant = read('../constants/user.yaml')
  * def envContant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * set createCitizenPayload.User.username = envContant.userName
  * set createCitizenPayload.User.otpReference = userConstant.parameters.invalidOtpReference
  * set createCitizenPayload.User.name = userConstant.parameters.name
  * set createCitizenPayload.User.permanentCity = userConstant.parameters.permanentCity

  * def citizenPayloadWithoutUserName = citizen.withoutUserNamePayload
  * set citizenPayloadWithoutUserName.User.otpReference = userConstant.parameters.invalidOtpReference
  * set citizenPayloadWithoutUserName.User.name = userConstant.parameters.name
  * set citizenPayloadWithoutUserName.User.permanentCity = userConstant.parameters.permanentCity

  * def citizenPayloadWithoutName = citizen.withoutNamePayload
  * set citizenPayloadWithoutName.User.username = envContant.userName
  * set citizenPayloadWithoutName.User.otpReference = userConstant.parameters.invalidOtpReference
  * set citizenPayloadWithoutName.User.permanentCity = userConstant.parameters.permanentCity

  * def citizenPayloadWithoutTenantId = citizen.withoutTenantIdPayloal
  * set citizenPayloadWithoutTenantId.User.username = envContant.userName
  * set citizenPayloadWithoutTenantId.User.otpReference = userConstant.parameters.invalidOtpReference
  * set citizenPayloadWithoutTenantId.User.name = userConstant.parameters.name
  * set citizenPayloadWithoutTenantId.User.permanentCity = userConstant.parameters.permanentCity

  * def citizenPayloadInvalidUserName = citizen.invalidUserNamePayload
  * set citizenPayloadInvalidUserName.User.username = userConstant.parameters.invalidUserName
  * set citizenPayloadInvalidUserName.User.otpReference = userConstant.parameters.invalidOtpReference
  * set citizenPayloadInvalidUserName.User.name = userConstant.parameters.name
  * set citizenPayloadInvalidUserName.User.permanentCity = userConstant.parameters.permanentCity
  
  * def citizenPayloadWithName = citizen.namePayload
  * set citizenPayloadWithName.User.username = envContant.userName
  * set citizenPayloadWithName.User.otpReference = userConstant.parameters.invalidOtpReference
  * set citizenPayloadWithName.User.name = userConstant.parameters.moreThan50CharsName
  * set citizenPayloadWithName.User.permanentCity = userConstant.parameters.permanentCity


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

  @citizencreatewithoutusername
  Scenario: Create citizen
     Given url createCitizen 
     * print createCitizen  
     And request citizenPayloadWithoutUserName
     * print createCitizenPayload
     When method post
     Then status 400
     And def citizenCreateResponseHeader = responseHeaders
     And def citizenCreateResponseBody = response

  @citizencreatewithoutname
  Scenario: Create citizen
     Given url createCitizen 
     * print createCitizen  
     And request citizenPayloadWithoutName
     * print createCitizenPayload
     When method post
     Then status 400
     And def citizenCreateResponseHeader = responseHeaders
     And def citizenCreateResponseBody = response

  @citizencreatewithouttenantid
  Scenario: Create citizen
     Given url createCitizen 
     * print createCitizen  
     And request citizenPayloadWithoutTenantId
     * print createCitizenPayload
     When method post
     Then status 400
     And def citizenCreateResponseHeader = responseHeaders
     And def citizenCreateResponseBody = response

  @citizencreateinvalidusername
  Scenario: Create citizen
     Given url createCitizen 
     * print createCitizen  
     And request citizenPayloadInvalidUserName
     * print createCitizenPayload
     When method post
     Then status 400
     And def citizenCreateResponseHeader = responseHeaders
     And def citizenCreateResponseBody = response

  @citizencreatenamewith50chars
  Scenario: Create citizen
     Given url createCitizen 
     * print createCitizen  
     And request citizenPayloadWithName
     * print createCitizenPayload
     When method post
     Then status 400
     And def citizenCreateResponseHeader = responseHeaders
     And def citizenCreateResponseBody = response