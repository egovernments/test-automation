Feature: Create Citizen For BPA

      Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def citizenPayload = read('../../core-services/requestPayload/user/citizenCreation.json')
  # initializing create citizen request payload objects
  * def createCitizenvalidPayload = citizenPayload.validPayload
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
#   * def otpReference = '348356'
#   * def mobileNumberGen = randomMobileNumGen(10)
#   * def mobileNumber = new java.math.BigDecimal(mobileNumberGen)
  * def name = ranString(4)
  * def permanentCity = cityCode
# 
  
  # setting the payload for different usecases

  * set createCitizenvalidPayload.User.username = mobileNumber
  * set createCitizenvalidPayload.User.otpReference = otpReference
  * set createCitizenvalidPayload.User.name = name
  * set createCitizenvalidPayload.User.permanentCity = permanentCity
  

        @createCitizen
        Scenario: Create citizen
            Given url createCitizen
              And request createCitizenvalidPayload
              # * print createCitizenvalidPayload
             When method post
             Then status 400
              And def createCitizenResponseHeader = responseHeaders
              # * print response
              And def createCitizenResponseBody = response


#         Background:
#   * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
#   * def userType = mdmsStateAccessControlRoles.roles[0].code
#   # * print mdmsStateAccessControlRoles.roles
#   * def name = ranString(4)
#   * def emailId = ranEmailId(5)
#   * def dob = todayDate()
#   * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
#   * def gender = commonConstants.parameters.gender[0]
#   * def newUserPayload = read('../../core-services/requestPayload/userCreation/createUser.json')
# #---
#      * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
#   * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
#  # Calling user creation feature to create new user
#  # * call read('../../core-services/pretests/userCreation.feature@usercreation')
#  # initialing user otp realted payload objects
#   * def registeredMobileNumber = mobileNumber
#   * def userOtpPayload = read('../../core-services/requestPayload/userOtp/userOtpSend.json')
#   * def userOtpConstant = read('../../core-services/constants/userOtp.yaml')
#   * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
#   * def typeForRegister = commonConstants.parameters.type[0]
#   * def typeForLogin = commonConstants.parameters.type[1]
#   * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
#   #--
  
#         @usercreationForBPA
#         Scenario: Creating new user
#      * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
#       # * print "CREATING USER"
#       Given url createUser
#       And request newUserPayload
#       # * print newUserPayload
#       When method post
#       Then status 200
#       And def userCreationResponseHeader = responseHeaders
#       And def userCreationResponseBody = response
#      * def createdUser = userCreationResponseBody.user[0].userName
#      # * print "CREATED USER"

 

#         @registerUserSuccessfullyForBPA
#         Scenario: User otp send success call
#    * def userOtpParam = 
#     """
#     {
#      tenantId: '#(tenantId)'
#     }
#     """
#   * set userOtpPayload.otp.type = typeForRegister
#             Given url userOtpRegisterUrl
     
#               And params userOtpParam
     
#               And request userOtpPayload
     
#              When method post
#              Then status 201
#               And def userOtpSendResponseHeader = responseHeaders
#               And def userOtpSendResponseBody = response
     