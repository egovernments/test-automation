Feature: enc-Service API call

Background:
  # read the javascript utils file for using generic methods
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def encServiceData = read('../constants/encService.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  # initializing request payload objects
  * def type = 'Normal'
  * def value = 'AutoValue ' + randomString(5)
  * def name = 'AutoUser ' + randomString(5)
  * def mobileNumber = randomMobileNumGen(10)
  * def email = randomString(5) + '@gmail.com'

@Encrypt_01 @encService @coreServices @regression
Scenario: Verify to encrypt name, mobile number and email for a user
  # calling encryption pretest
  * call read('../../core-services/pretests/encServicePrestest.feature@EncryptSuccessfully')
  * match response[*].userObject1.name == '#present'
  * match response[*].userObject1.email == '#present'
  * match response[*].userObject1.mobileNumber == '#present'

@Encrypt_Invalidvalues_02 @encService @coreServices @regression
Scenario: Verify with a invalid or non existant tenant id/type and check for errors
   # setting invalid type for negative scenario
   * def type = commonConstants.invalidParameters.invalidValue
      # calling encryption pretest
   * call read('../../core-services/pretests/encServicePrestest.feature@EncryptError')
   * match encryptResponseBody.message == type +' '+ encServiceData.errorMessages.invalidType

#It will fail most of the time, this has not designed to be used with authToken 
@Decrypt_01 @encService @coreServices @regression
Scenario: Verify by sending encrypted message in the API
   # calling encryption pretest    
   * call read('../../core-services/pretests/encServicePrestest.feature@EncryptSuccessfully')
   # calling decryption pretest
   * call read('../../core-services/pretests/encServicePrestest.feature@decryptsuccessfully')
   * match response[*].userObject1.name contains name
   * match response[*].userObject1.email contains email

#It will fail for sometime,this has not designed to be used with authToken
@Rotate_01 @encService @coreServices @regression
Scenario: Verify roate key API for a given tenant id
   # calling rotate pretest
   * call read('../../core-services/pretests/encServicePrestest.feature@rotateSuccessfully')
   * match response.acknowledged == true

@Sign_01 @encService @coreServices @regression
Scenario: Test to Sign the data
   # calling sign pretest
   * call read('../../core-services/pretests/encServicePrestest.feature@signSuccessfully')
   * match response.value == value
   * match response.signature == '#present'
   * match response.signature != value

@Verify_01 @encService @coreServices @regression
Scenario: Test to verify signature through API call
   # calling sign pretest
   * call read('../../core-services/pretests/encServicePrestest.feature@signSuccessfully')
   * def signature = response.signature
   # calling verfy pretest
   * call read('../../core-services/pretests/encServicePrestest.feature@verifySuccessfully')
   * match response.verified == true

@Verify_InvalidValue_02 @encService @coreServices @regression
Scenario: Test to verify signature through API call by passing invalid value
    # calling sign pretest
    * call read('../../core-services/pretests/encServicePrestest.feature@signSuccessfully')
    * def signature = response.signature
    * def value = null
    # calling verfy pretest
    * call read('../../core-services/pretests/encServicePrestest.feature@verifyError')
    * match response.message == encServiceData.errorMessages.verifyError + ': 1'



