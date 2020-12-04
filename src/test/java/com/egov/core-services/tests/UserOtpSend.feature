Feature: User OTP
        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def userOtpSend = read('classpath:requestJson/userOtpSend.json')
  
  * def errorMsgForRegMobNo = 'This MobileNumber Already Register as UserName in System. Pls try Another UserName'
  * def errorMsgForUnRegMobNo = 'User not Found With this UserName'
  * def errorMsgForValidMobNo = 'Mobile number length should be min 10 and max 13 digits'
  * def errorMsgForMand_MobNo = 'Mobile number field is mandatory'
  * def errorMsgForMand_TenantId = 'Tenant field is mandatory'
  * def errorMsgForMobNo_Num = 'Mobile number field should be numeric.'
  * def errorMsgForInvaldReq = 'You are not authorized to access this resource'


  @UserOtp_Send_Register_01   @positive @smoke
  Scenario: Test to send the OTP to a valid mobile number during registration
        * call read('../pretests/userOtpPretest.feature@Success_register')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_RegisterDuplicate_05  @negative @smoke
  Scenario: Test registering using a already registered number
        * call read('../pretests/userOtpPretest.feature@Error_register')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == 'OTP.MOBILENUMBER'
        * assert userOtpSendResponseBody.error.fields[0].message == errorMsgForRegMobNo
 
  @UserOtp_Send_Login_02  @positive @smoke
  Scenario: Test to send the OTP to a valid mobile number during login
         * call read('../pretests/userOtpPretest.feature@Success_login')
         * print userOtpSendResponseBody
         * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_Unregistered_03  @negative @smoke
  Scenario: Test to send the OTP using a unregistered mobile number during login
        * call read('../pretests/userOtpPretest.feature@Error_login')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == errorMsgForUnRegMobNo
 
        
  @UserOtp_Send_InavlidMobile_04  @negative  @smoke
  Scenario: Test to send the OTP using a invalid mobile number during login or register
        * call read('../pretests/userOtpPretest.feature@Error_InvldMobNo')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == 'OTP.MOBILE_NUMBER_INVALIDLENGTH'
        * assert userOtpSendResponseBody.error.fields[0].message == errorMsgForValidMobNo

  @UserOtp_Send_noMandatoryfields_06  @negative  @smoke
  Scenario: Test by not passing mobile number or tenant id for type ' login'
        * call read('../pretests/userOtpPretest.feature@Error_MobNoNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == errorMsgForMand_MobNo

  @UserOtp_Send_invalidTenant_Login_07  @negative  @smoke
  Scenario: Test by passing a invalid or a non existent tenant ID
        * call read('../pretests/userOtpPretest.feature@Error_InvldTenant')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == 'OTP.UNKNOWN_USER'
        * assert userOtpSendResponseBody.error.fields[0].message == errorMsgForUnRegMobNo

 @UserOtp_Send_NoType_08  @negative  @smoke
 Scenario: Test by not passing any value for 'type'
        * call read('../pretests/userOtpPretest.feature@Success_notype')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true
        
 @UserOtp_Send_NoMandatoryOtpParameters_08  @negative @smoke
 Scenario: Test without mobile number, tenantid and type' parameters
        * call read('../pretests/userOtpPretest.feature@Error_TenantNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.message == 'Invalid OTP request'
        * assert userOtpSendResponseBody.error.fields[0].message == errorMsgForMand_TenantId
        * assert userOtpSendResponseBody.error.fields[1].message == errorMsgForMand_MobNo
        * assert userOtpSendResponseBody.error.fields[2].message == errorMsgForMobNo_Num
        * assert userOtpSendResponseBody.error.fields[3].message == errorMsgForValidMobNo

 @UserOtp_InvalidRequestURL_09  @positive  @smoke
 Scenario: Test by not passing a invalid request url

        * call read('../pretests/userOtpPretest.feature@Error_Invldurl')
        * print userOtpSendResponseBody
        * print userOtpSendResponseBody.Errors[0].message
        * assert userOtpSendResponseBody.Errors[0].message == errorMsgForInvaldReq
        
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