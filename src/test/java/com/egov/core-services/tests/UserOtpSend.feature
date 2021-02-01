Feature: User OTP

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def userOtpSend = read('../requestPayload/userOtp/userOtpSend.json')
  * def userOtpConstant = read('../constants/userOtp.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * call read('../../common-services/pretests/eGovMdmsPretest.feature@successSearchState')
  # Calling authToken
  * def authUsername = employeeUserName
  * def authPassword = employeePassword
  * def authUserType = employeeType
  * call read('../../core-services/pretests/authenticationToken.feature')
  * def userType = accessControlRoles[0].code
  * def userOtpConstant = read('../../core-services/constants/userOtp.yaml')
  * def name = ranString(4)
  * def permanentCity = userOtpConstant.parameters.permanentCity[env]
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')

  @UserOtp_Send_Register_01   @positive  @userOtp
  Scenario: Test to send the OTP to a valid mobile number during registration
        * call read('../../core-services/pretests/userOtpPretest.feature@successRegister')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_RegisterDuplicate_05  @negative  @userOtp        
  Scenario: Test registering using a already registered number
        * call read('../../core-services/pretests/userOtpPretest.feature@errorRegister')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobNo
        * print userOtpConstant[0].errormessages.errorMsgForRegMobNo
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForRegMobNo
 
  @UserOtp_Send_Login_02  @positive @userOtp
  Scenario: Test to send the OTP to a valid mobile number during login
         * call read('../../core-services/pretests/userOtpPretest.feature@successLogin')
         * print userOtpSendResponseBody
         * match userOtpSendResponseBody.isSuccessful == true

  @UserOtp_Send_Unregistered_03  @negative @userOtp
  Scenario: Test to send the OTP using a unregistered mobile number during login
        * call read('../../core-services/pretests/userOtpPretest.feature@errorLogin')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForUnRegMobNo
 
        
  @UserOtp_Send_InavlidMobile_04  @negative  @userOtp
  Scenario: Test to send the OTP using a invalid mobile number during login or register
        * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidMobileNo')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo

  @UserOtp_Send_noMandatoryfields_06  @negative  @userOtp
  Scenario: Test by not passing mobile number or tenant id for type ' login'
        * call read('../../core-services/pretests/userOtpPretest.feature@errorMobileNoNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForMandMobNo

  @UserOtp_Send_invalidTenant_Login_07  @negative  @userOtp
  Scenario: Test by passing a invalid or a non existent tenant ID
        * def tenantId = commonConstants.'Invalid-tenantId-' + ranString(5)
        * call read('../pretests/userOtpPretest.feature@Error_InvldTenant')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForInvalidTenantId
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForUnRegMobNo

 @UserOtp_Send_NoType_08  @negative  @userOtp
 Scenario: Test by not passing any value for 'type'
        * call read('../../core-services/pretests/userOtpPretest.feature@successNoType')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true
        
 @UserOtp_Send_NoMandatoryOtpParameters_08  @negative @userOtp
 Scenario: Test without mobile number, tenantid and type' parameters
        * call read('../../core-services/pretests/userOtpPretest.feature@errorTenantNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.message == userOtpConstant.errorMessages.msgForInvalidOtp
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForMandTenantId
        * assert userOtpSendResponseBody.error.fields[1].message == userOtpConstant.errorMessages.msgForMandMobNo
        * assert userOtpSendResponseBody.error.fields[2].message == userOtpConstant.errorMessages.msgForMobNoNum
        * assert userOtpSendResponseBody.error.fields[3].message == userOtpConstant.errorMessages.msgForValidMobNo