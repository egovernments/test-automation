Feature: enc-Service API call

        Background:

  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def encServiceData = read('../../core-services/constants/encService.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def type = 'Normal'
  * def value = 'AutoValue ' + randomString(5)
  * def name = 'AutoUser ' + randomString(5)
  * def mobileNumber = randomMobileNumGen(10)
  * def email = randomString(5) + '@gmail.com'

        @Encrypt_01 @encService
        Scenario: Verify to encrypt name, mobile number and email for a user

  * call read('../pretests/encServicePrestest.feature@EncryptSuccessfully')
  * match response[*].userObject1.name == '#present'
  * match response[*].userObject1.email == '#present'
  * match response[*].userObject1.mobileNumber == '#present'

        @Encrypt_Invalidvalues_02 @encService
        Scenario: Verify with a invalid or non existant tenant id/type and check for errors

  * def type = commonConstants.invalidParameters.invalidValue
  * call read('../pretests/encServicePrestest.feature@EncryptError')
  * match encryptResponseBody.message == type +' '+ encServiceData.errorMessages.invalidType

        @Decrypt_01 @encService
        Scenario: Verify by sending encrypted message in the API

  * call read('../pretests/encServicePrestest.feature@EncryptSuccessfully')
  * call read('../pretests/encServicePrestest.feature@decryptsuccessfully')
  * match response[*].userObject1.name contains name
  * match response[*].userObject1.email contains email


        @Rotate_01 @encService
        Scenario: Verify roate key API for a given tenant id

  #* def tenantId = 'pb.nayagaon'
  * call read('../pretests/encServicePrestest.feature@rotateSuccessfully')
  * match response.acknowledged == true


        @Sign_01 @encService
        Scenario: Test to Sign the data

  * call read('../pretests/encServicePrestest.feature@signSuccessfully')
  * match response.value == value
  * match response.signature == '#present'
  * match response.signature != value


        @Verify_01 @encService
        Scenario: Test to verify signature through API call

  * call read('../pretests/encServicePrestest.feature@signSuccessfully')
  * call read('../pretests/encServicePrestest.feature@verifySuccessfully')
  * match response.verified == true


        @Verify_InvalidValue_02 @encService
        Scenario: Test to verify signature through API call by passing invalid value

  * call read('../pretests/encServicePrestest.feature@signSuccessfully')
  * set verifyRequest.value = null
  * call read('../pretests/encServicePrestest.feature@verifyError')
  * match response.message == encServiceData.errorMessages.verifyError + ': 1'



