Feature: User oauth token
Background:
  * configure headers = read('classpath:websCommonHeaders.js')
  * def jsUtils = read('classpath:jsUtils.js')
  * def userConstant = read('../../core-services/constants/user.yaml')
  
@User_AccountLock_01
Scenario: Verify the user Account is locked after giving Invalid password for 5 times 
* def invalidPswToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@invalidPasswordError')
* print invalidPswToLock
* def invalidPswPayload = read('../../core-services/requestPayload/user/oauthInvalidPassword.json')
* print invalidPswPayload
* def result = call invalidPswToLock invalidPswPayload
* def accountLockError = $result[*].authResponseBody
* print accountLockError

#@User_AccountUnLock_02
#Scenario: Verify the user Account is UnLocked after 1 hour from account locked time
#* call waitTimeSec(1800)
#* call read('../../core-services/pretests/userAccountUnlockPretest.feature@acountUnlockSuccess')
#* print authResponseBody.access_token

@User_AccountAfterLock_03
Scenario: Verify user account after same account is locked by giving valid credentials
* def invalidPswToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@invalidPasswordError')
* print invalidPswToLock
* def invalidPswPayload = read('../../core-services/requestPayload/user/oauthInvalidPassword.json')
* print invalidPswPayload
* def result = call invalidPswToLock invalidPswPayload
* call read('../../core-services/pretests/userAccountUnlockPretest.feature@validPasswordError')
* assert authResponseBody.error == userConstant.errormessages.accountLock

@User_Account_04 
Scenario: Verify the user Account is NOT locked after giving valid password for the 5th time  
* def validPasswordNotToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@validPasswordSuccess')
* print validPasswordNotToLock
* def validPasswordPayload = read('../../core-services/requestPayload/user/oauthValidPassword.json')
* print validPasswordPayload
* def resultOne = call validPasswordNotToLock validPasswordPayload

@User_Account_05
Scenario: Verify the user Account before 1 hr after locked
* def invalidPswToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@invalidPasswordError')
* print invalidPswToLock
* def invalidPswPayload = read('../../core-services/requestPayload/user/oauthInvalidPassword.json')
* print invalidPswPayload
* def result = call invalidPswToLock invalidPswPayload
* call read('../../core-services/pretests/userAccountUnlockPretest.feature@validPasswordError')
* assert authResponseBody.error == userConstant.errormessages.accountLock