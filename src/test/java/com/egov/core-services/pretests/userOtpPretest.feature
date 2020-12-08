Feature: User otp send API call 

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def userOtpSend = read('classpath:requestPayload/userOtp/userOtpSend.json')
  * def testData = read('classpath:constants/userOtp/parameters.yaml')

  * def invalidEndpoint = testData.inValidEndPoint
  * def registeredMobNo = testData.mobNo

@Success_register
Scenario: User otp send success call
  * def mobileNumberGen = randomMobileNumGen(10)
  * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
  * print validMobileNum

  * set userOtpSend.otp.mobileNumber = validMobileNum
  * set userOtpSend.otp.type = 'register'

     Given url userOtpRegisterUrl
     And request userOtpSend
     When method post
     Then status 201
     And def userOtpSendResponseHeader = responseHeaders
     And def userOtpSendResponseBody = response

@Success_login
Scenario: User otp send success call
  * set userOtpSend.otp.type = 'login'
  * set userOtpSend.otp.mobileNumber = registeredMobNo

      Given url userOtpRegisterUrl
      And request userOtpSend
      When method post
      Then status 201
      And def userOtpSendResponseHeader = responseHeaders
      And def userOtpSendResponseBody = response

@Success_notype
Scenario: User otp send success call
  * def mobileNumberGen = randomMobileNumGen(10)
  * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
  * print validMobileNum

  * set userOtpSend.otp.mobileNumber = validMobileNum
  * set userOtpSend.otp.type = ''

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 201
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_register
Scenario: User otp send fail call
   * set userOtpSend.otp.mobileNumber = registeredMobNo
   * set userOtpSend.otp.type = 'register'

     Given url userOtpRegisterUrl
     And request userOtpSend
     When method post
     Then status 400
     And def userOtpSendResponseHeader = responseHeaders
     And def userOtpSendResponseBody = response

@Error_login
Scenario: User otp send fail call
   * def mobileNumberGen = randomMobileNumGen(10)
   * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
   * print validMobileNum

   * set userOtpSend.otp.mobileNumber = validMobileNum
   * set userOtpSend.otp.type = 'login' 

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_InvldMobNo
Scenario: User otp send fail call
   * def mobileNumberGen = randomMobileNumGen(9)
   * def validMobileNum = new java.math.BigDecimal(mobileNumberGen)
   * print validMobileNum

   * set userOtpSend.otp.mobileNumber = validMobileNum
   * set userOtpSend.otp.type = 'register'

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_MobNoNull
Scenario: User otp send fail call
  * set userOtpSend.otp.mobileNumber = null
  * set userOtpSend.otp.type = 'login' 

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_InvldTenant
Scenario: User otp send fail call
  * set userOtpSend.otp.mobileNumber = registeredMobNo
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
  * set userOtpSend.otp.tenantId = null

    Given url userOtpRegisterUrl
    And request userOtpSend
    When method post
    Then status 400
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response

@Error_Invldurl
Scenario: User otp send fail call
 * set userOtpSend.otp.type = 'login'
 * set userOtpSend.otp.mobileNumber = registeredMobNo

    Given url invalidEndpoint
    And request userOtpSend
    When method post
    Then status 401
    And def userOtpSendResponseHeader = responseHeaders
    And def userOtpSendResponseBody = response
