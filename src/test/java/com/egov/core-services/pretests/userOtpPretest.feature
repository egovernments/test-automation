Feature: User otp send API call 

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def userOtpSend = read('../requestPayload/userOtp/userOtpSend.json')
  * def constantValue = read('../constants/userOtp.yaml')
  * def envConstant = read('file:envYaml/' + env + '/' + env +'.yaml')
  * print envConstant
  * def mobNumber = envConstant.userName


@Success_register
Scenario: User otp send success call
   * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * def mobileNumberGen = randomMobileNumGen(10)
  * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
  * print validMobileNum

  * set userOtpSend.otp.mobileNumber = validMobileNum
  * set userOtpSend.otp.type = 'register'

     Given url userOtpRegisterUrl
     And params parameters
     And request userOtpSend
     When method post
     Then status 201
     And def userOtpSendResponseHeader = responseHeaders
     And def userOtpSendResponseBody = response
     * print userOtpSendResponseBody

@Success_login
Scenario: User otp send success call
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * set userOtpSend.otp.type = 'login'
  * set userOtpSend.otp.mobileNumber = mobNumber

      Given url userOtpRegisterUrl
      And params parameters
      And request userOtpSend
      When method post
      Then status 201
      And def userOtpSendResponseHeader = responseHeaders
      And def userOtpSendResponseBody = response

@Success_notype
Scenario: User otp send success call
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * def mobileNumberGen = randomMobileNumGen(10)
  * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
  * print validMobileNum

  * set userOtpSend.otp.mobileNumber = validMobileNum
  * set userOtpSend.otp.type = ''

    Given url userOtpRegisterUrl
    And params parameters
    And request userOtpSend
    When method post
    Then status 201
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_register
Scenario: User otp send fail call
   * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
   * set userOtpSend.otp.mobileNumber = mobNumber
   * set userOtpSend.otp.type = 'register'

     Given url userOtpRegisterUrl
     And params parameters
     And request userOtpSend
     When method post
     Then status 400
     And def userOtpSendResponseHeader = responseHeaders
     And def userOtpSendResponseBody = response

@Error_login
Scenario: User otp send fail call
   * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
   * def mobileNumberGen = randomMobileNumGen(10)
   * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
   * print validMobileNum

   * set userOtpSend.otp.mobileNumber = validMobileNum
   * set userOtpSend.otp.type = 'login' 

    Given url userOtpRegisterUrl
    And params parameters
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_InvldMobNo
Scenario: User otp send fail call
   * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
   * def mobileNumberGen = randomMobileNumGen(9)
   * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
   * print validMobileNum

   * set userOtpSend.otp.mobileNumber = validMobileNum
   * set userOtpSend.otp.type = 'register'

    Given url userOtpRegisterUrl
    And params parameters
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_MobNoNull
Scenario: User otp send fail call
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
  * set userOtpSend.otp.mobileNumber = null
  * set userOtpSend.otp.type = 'login' 

    Given url userOtpRegisterUrl
    And params parameters
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_InvldTenant
Scenario: User otp send fail call
  
  * set userOtpSend.otp.mobileNumber = mobNumber
  * set userOtpSend.otp.type = 'login'
  * set userOtpSend.otp.tenantId = "123" 

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_TenantNull
Scenario: User otp send fail call
  
  * set userOtpSend.otp.mobileNumber = null
  * set userOtpSend.otp.type = 'login'
  * set userOtpSend.otp.tenantId = ''

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_Invldurl
Scenario: User otp send fail call
 * def parameters = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """
 * set userOtpSend.otp.type = 'login'
 * set userOtpSend.otp.mobileNumber = mobNumber

    Given url invalidSendOpUser
    And params parameters
    And request userOtpSend
    When method post
    Then status 401
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response
