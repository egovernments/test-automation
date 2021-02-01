Feature: User OTP

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def userOtpSend = read('../requestPayload/userOtp/userOtpSend.json')
  * def userOtpConstant = read('../constants/userOtp.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants')
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../pretests/authenticationToken.feature')
  * def name = userOtpConstant.parameters.name
  * def userType = userOtpConstant.parameters.userType

  
  @UserOtp_Send_Register_01   @positive @userotp
  Scenario: Test to send the OTP to a valid mobile number during registration
        * call read('../pretests/userOtpPretest.feature@Success_register')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_RegisterDuplicate_05  @negative @userotp        
  Scenario: Test registering using a already registered number
        
        * call read('../pretests/userOtpPretest.feature@Error_register')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobNo
        * print userOtpConstant[0].errormessages.errorMsgForRegMobNo
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForRegMobNo
 
  @UserOtp_Send_Login_02  @positive @userotp
  Scenario: Test to send the OTP to a valid mobile number during login
         * call read('../pretests/userOtpPretest.feature@Success_login')
         * print userOtpSendResponseBody
         * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_Unregistered_03  @negative @userotp
  Scenario: Test to send the OTP using a unregistered mobile number during login
        * call read('../pretests/userOtpPretest.feature@Error_login')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForUnRegMobNo
 
        
  @UserOtp_Send_InavlidMobile_04  @negative  @userotp
  Scenario: Test to send the OTP using a invalid mobile number during login or register
        * call read('../pretests/userOtpPretest.feature@Error_InvldMobNo')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo

  @UserOtp_Send_noMandatoryfields_06  @negative  @userotp
  Scenario: Test by not passing mobile number or tenant id for type ' login'
        * call read('../pretests/userOtpPretest.feature@Error_MobNoNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForMandMobNo

  @UserOtp_Send_invalidTenant_Login_07  @negative  @userotp
  Scenario: Test by passing a invalid or a non existent tenant ID
        * def tenantId = commonConstants.'Invalid-tenantId-' + ranString(5)
        * call read('../pretests/userOtpPretest.feature@Error_InvldTenant')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForInvalidTenantId
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForUnRegMobNo

 @UserOtp_Send_NoType_08  @negative  @userotp
 Scenario: Test by not passing any value for 'type'
        * call read('../pretests/userOtpPretest.feature@Success_notype')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true
        
 @UserOtp_Send_NoMandatoryOtpParameters_08  @negative @userotp
 Scenario: Test without mobile number, tenantid and type' parameters
        * call read('../pretests/userOtpPretest.feature@Error_TenantNull')
        * def tenantId = userOtpConstant.parameters.withoutTenantId
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.message == userOtpConstant.errorMessages.msgForInvalidOtp
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForMandTenantId
        * assert userOtpSendResponseBody.error.fields[1].message == userOtpConstant.errorMessages.msgForMandMobNo
        * assert userOtpSendResponseBody.error.fields[2].message == userOtpConstant.errorMessages.msgForMobNoNum
        * assert userOtpSendResponseBody.error.fields[3].message == userOtpConstant.errorMessages.msgForValidMobNo