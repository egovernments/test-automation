Feature: User otp send API call

        Background:
  * configure headers = read('classpath:websCommonHeaders.js')
  * def jsUtils = read('classpath:jsUtils.js')
  # Calling user creation feature to create new user
  * call read('../../core-services/pretests/userCreation.feature@usercreation')
  # initialing user otp realted payload objects
  * def registeredMobileNumber = createdUser
  * def mobileNumberGen = randomMobileNumGen(10)
  * def mobileNumber = new java.math.BigDecimal(mobileNumberGen)
  * print mobileNumber
  * def mobileNumberGen1 = randomMobileNumGen(9)
  * def invalidMobileNo = new java.math.BigDecimal(mobileNumberGen1)
  * print invalidMobileNo
  * def userOtpPayload = read('../../core-services/requestPayload/userOtp/userOtpSend.json')
  * def userOtpConstant = read('../../core-services/constants/userOtp.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def typeForRegister = commonConstants.parameters.type[0]
  * def typeForLogin = commonConstants.parameters.type[1]
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId

        @registerUserSuccessfully
        Scenario: User otp send success call
   * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * set userOtpPayload.otp.type = typeForRegister
            Given url userOtpRegisterUrl
     * print userOtpRegisterUrl
              And params userOtpParam
     * print userOtpParam
              And request userOtpPayload
     * print userOtpPayload
             When method post
             Then status 201
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response
     * print userOtpSendResponseBody

        @loginSuccessfully
        Scenario: User otp send success call
  * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * set userOtpPayload.otp.type = typeForLogin
  * set userOtpPayload.otp.mobileNumber = registeredMobileNumber
            Given url userOtpRegisterUrl
      * print userOtpRegisterUrl
              And params userOtpParam
      * print userOtpParam
              And request userOtpPayload
      * print userOtpPayload
             When method post
             Then status 201
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response

        @successNoType
        Scenario: User otp send success call
  * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * set userOtpPayload.otp.type = ''
            Given url userOtpRegisterUrl
    * print userOtpRegisterUrl
              And params userOtpParam
    * print userOtpParam
              And request userOtpPayload
    * print userOtpPayload
             When method post
             Then status 201
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response

        @errorRegister
        Scenario: User otp send fail call
   * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
   * set userOtpPayload.otp.mobileNumber = registeredMobileNumber
   * set userOtpPayload.otp.type = typeForRegister
            Given url userOtpRegisterUrl
     * print userOtpRegisterUrl
              And params userOtpParam
     * print userOtpParam
              And request userOtpPayload
     * print userOtpPayload
             When method post
             Then status 400
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response

        @errorLogin
        Scenario: User otp send fail call
   * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
   * set userOtpPayload.otp.type = typeForLogin 
            Given url userOtpRegisterUrl
    * print userOtpRegisterUrl
              And params userOtpParam
    * print userOtpParam
              And request userOtpPayload
    * print userOtpPayload
             When method post
             Then status 400
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response

        @errorInvalidMobileNo
        Scenario: User otp send fail call
   * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
   * set userOtpPayload.otp.mobileNumber = invalidMobileNo
   * set userOtpPayload.otp.type = typeForRegister 
            Given url userOtpRegisterUrl
    * print userOtpRegisterUrl
              And params userOtpParam
    * print userOtpParam
              And request userOtpPayload
    * print userOtpPayload
             When method post
             Then status 400
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response

        @errorMobileNoNull
        Scenario: User otp send fail call
  * def userOtpParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * set userOtpPayload.otp.mobileNumber = ''
  * set userOtpPayload.otp.type = typeForLogin  
            Given url userOtpRegisterUrl
    * print userOtpRegisterUrl
              And params userOtpParam
    * print userOtpParam
              And request userOtpPayload
    * print userOtpPayload
             When method post
             Then status 400
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response

        @errorInvalidTenant
        Scenario: User otp send fail call
  * set userOtpPayload.otp.mobileNumber = registeredMobileNumber
  * set userOtpPayload.otp.type = typeForLogin  
  * set userOtpPayload.otp.tenantId = invalidTenantId
  * def userOtpParam = 
    """
    {
     tenantId: '#(invalidTenantId)'
    }
    """
            Given url userOtpRegisterUrl
    * print userOtpRegisterUrl
              And params userOtpParam
    * print userOtpParam
              And request userOtpPayload
    * print userOtpPayload
             When method post
             Then status 400
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response
    * print userOtpSendResponseBody

        @errorTenantNull
        Scenario: User otp send fail call
  * set userOtpPayload.otp.mobileNumber = '' 
  * set userOtpPayload.otp.type = ''
  * set userOtpPayload.otp.tenantId = ''
            Given url userOtpRegisterUrl
    * print userOtpRegisterUrl
              And request userOtpPayload
    * print userOtpPayload
             When method post
             Then status 400
              And def userOtpSendResponseHeader = responseHeaders
              And def userOtpSendResponseBody = response