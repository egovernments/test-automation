Feature: User OTP

Background:
      * def jsUtils = read('classpath:jsUtils.js')
      * def userOtpConstant = read('../../core-services/constants/userOtp.yaml')
      # initializing user otp request payload objects
      * def userType = mdmsStateAccessControlRoles.roles[0].code
      * def name = ranString(4)
      * def permanentCity = cityCode
      * def commonConstants = read('../../common-services/constants/genericConstants.yaml')

        @UserOtp_Send_Register_01   @regression @positive  @userOtp
        Scenario: Test to send the OTP to a valid mobile number during registration
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@registerUserSuccessfully')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true

        @UserOtp_Send_RegisterDuplicate_05  @regression @negative  @userOtp
        Scenario: Test registering using a already registered number
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@errorRegister')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobNo
        * print userOtpConstant[0].errormessages.errorMsgForRegMobNo
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForRegMobNo
 
        @UserOtp_Send_Login_02  @regression @positive @userOtp
        Scenario: Test to send the OTP to a valid mobile number during login
         * call read('../../core-services/pretests/userOtpPretest.feature@loginSuccessfully')
         * print userOtpSendResponseBody
         * match userOtpSendResponseBody.isSuccessful == true

        @UserOtp_Send_Unregistered_03  @regression @negative @userOtp
        Scenario: Test to send the OTP using a unregistered mobile number during login
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@errorLogin')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForUnRegMobNo
 
        
        @UserOtp_Send_InavlidMobile_04  @regression @negative  @userOtp
        Scenario: Test to send the OTP using a invalid mobile number during login or register
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidMobileNo')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo

        @UserOtp_Send_noMandatoryfields_06  @regression @negative  @userOtp
        Scenario: Test by not passing mobile number or tenant id for type ' login'
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@errorMobileNoNull')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForMandMobNo

        @UserOtp_Send_invalidTenant_Login_07  @regression @negative  @userOtp
        Scenario: Test by passing a invalid or a non existent tenant ID
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidTenant')
        * print userOtpSendResponseBody
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForUnRegMobNo

        @UserOtp_Send_NoType_08  @regression @negative  @userOtp
        Scenario: Test by not passing any value for 'type'
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@successNoType')
        * print userOtpSendResponseBody
        * match userOtpSendResponseBody.isSuccessful == true
        
        @UserOtp_Send_NoMandatoryOtpParameters_08  @regression @negative @userOtp
        Scenario: Test without mobile number, tenantid and type' parameters
        # calling register user pretest
        * call read('../../core-services/pretests/userOtpPretest.feature@errorTenantNull')
        * print userOtpSendResponseBody
        # verifying error messages
        * assert userOtpSendResponseBody.error.message == userOtpConstant.errorMessages.msgForInvalidOtp
        * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForMandTenantId
        * assert userOtpSendResponseBody.error.fields[1].message == userOtpConstant.errorMessages.msgForMandMobNo
        * assert userOtpSendResponseBody.error.fields[2].message == userOtpConstant.errorMessages.msgForMobNoNum
        * assert userOtpSendResponseBody.error.fields[3].message == userOtpConstant.errorMessages.msgForValidMobNo