Feature: User OTP

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def userOtpSend = read('classpath:requestPayload/userOtp/userOtpSend.json')
  * def expectedMsg = read('classpath:constants/userOtp/expectedMessages.yaml')
   # Calling access token
    * def authUsername = counterEmployeeUserName
    * def authPassword = counterEmployeePassword
    * def authUserType = 'EMPLOYEE'
    * call read('../pretests/authenticationToken.feature')
  
  @UserOtp_Send_Register_01   @positive @userotp
  Scenario: Test to send the OTP to a valid mobile number during registration
        * call read('../pretests/userOtpPretest.feature@Success_register')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_RegisterDuplicate_05  @negative @userotp
          
  Scenario: Test registering using a already registered number
        
        * call read('../pretests/userOtpPretest.feature@Error_register')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == expectedMsg.msgForMobNo
        * print expectedmsg[0].errormessages.errorMsgForRegMobNo
   #     * call read('src\test\java\constants.yaml')
        * assert userOtpSendResponseBody.error.fields[0].message == expectedMsg.errorMsgForRegMobNo
 
  @UserOtp_Send_Login_02  @positive @userotp
  Scenario: Test to send the OTP to a valid mobile number during login
         * call read('../pretests/userOtpPretest.feature@Success_login')
         * print userOtpSendResponseBody
         * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_Unregistered_03  @negative @userotp
  Scenario: Test to send the OTP using a unregistered mobile number during login
        * call read('../pretests/userOtpPretest.feature@Error_login')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == expectedMsg.errorMsgForUnRegMobNo
 
        
  @UserOtp_Send_InavlidMobile_04  @negative  @userotp
  Scenario: Test to send the OTP using a invalid mobile number during login or register
        * call read('../pretests/userOtpPretest.feature@Error_InvldMobNo')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == 'OTP.MOBILE_NUMBER_INVALIDLENGTH'
        * assert userOtpSendResponseBody.error.fields[0].message == expectedMsg.errorMsgForValidMobNo

  @UserOtp_Send_noMandatoryfields_06  @negative  @userotp
  Scenario: Test by not passing mobile number or tenant id for type ' login'
        * call read('../pretests/userOtpPretest.feature@Error_MobNoNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == expectedMsg.errorMsgForMandMobNo

  @UserOtp_Send_invalidTenant_Login_07  @negative  @userotp
  Scenario: Test by passing a invalid or a non existent tenant ID
        * call read('../pretests/userOtpPretest.feature@Error_InvldTenant')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == 'OTP.UNKNOWN_USER'
        * assert userOtpSendResponseBody.error.fields[0].message == expectedMsg.errorMsgForUnRegMobNo

 @UserOtp_Send_NoType_08  @negative  @userotp
 Scenario: Test by not passing any value for 'type'
        * call read('../pretests/userOtpPretest.feature@Success_notype')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true
        
 @UserOtp_Send_NoMandatoryOtpParameters_08  @negative @userotp
 Scenario: Test without mobile number, tenantid and type' parameters
        * call read('../pretests/userOtpPretest.feature@Error_TenantNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.message == 'Invalid OTP request'
        * assert userOtpSendResponseBody.error.fields[0].message == expectedMsg.errorMsgForMandTenantId
        * assert userOtpSendResponseBody.error.fields[1].message == expectedMsg.errorMsgForMandMobNo
        * assert userOtpSendResponseBody.error.fields[2].message == expectedMsg.errorMsgForMobNoNum
        * assert userOtpSendResponseBody.error.fields[3].message == expectedMsg.errorMsgForValidMobNo

 @UserOtp_InvalidRequestURL_09  @positive  @userotp
 Scenario: Test by not passing a invalid request url

        * call read('../pretests/userOtpPretest.feature@Error_Invldurl')
        * print userOtpSendResponseBody
        * print userOtpSendResponseBody.Errors[0].message
        * assert userOtpSendResponseBody.Errors[0].message == expectedMsg.errorMsgForInvaldReq
        
 @ignore @UserOtp_emptyAuthToken_10  @tbd  
 Scenario: Test by not passing any value for 'auth token'
        * set userOtpSend.otp.type = 'login'
        * set userOtpSend.otp.mobileNumber = registeredMobNo
        * set userOtpSend.RequestInfo.authToken = ''

        Given url userOtpRegisterUrl
        And request userOtpSend
        When method post
        Then status 501
        And def userOtpSendResponseHeader = responseHeaders
        And def userOtpSendResponseBody = response
        * print userOtpSendResponseBody