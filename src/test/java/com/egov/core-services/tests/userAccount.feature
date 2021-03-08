Feature: User oauth token
Background:
  * configure headers = read('classpath:websCommonHeaders.js')
  * def jsUtils = read('classpath:jsUtils.js')
  * def userConstant = read('../../core-services/constants/user.yaml')
  
@User_AccountLock_01 @userAccountAfterLock @coreServices @regression
Scenario: Verify the user Account is locked after giving Invalid password for 5 times
# Execute 5tiimes with invalid password 
* def invalidPswToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@invalidPasswordError')

* def invalidPswPayload = read('../../core-services/requestPayload/user/oauthInvalidPassword.json')

* def result = call invalidPswToLock invalidPswPayload
* def accountLockError = $result[*].authResponseBody

# To execute this scenario, we need to wait 30mins
@ignore @userAccountAfterLock @coreServices @regression
Scenario: Verify the user Account is UnLocked after 1 hour from account locked time
* call waitTimeSec(1800)
* call read('../../core-services/pretests/userAccountUnlockPretest.feature@acountUnlockSuccess')

@User_AccountAfterLock_03 @userAccountAfterLock @coreServices @regression
Scenario: Verify user account after same account is locked by giving valid credentials
# call account lock feature
* def invalidPswToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@invalidPasswordError')

* def invalidPswPayload = read('../../core-services/requestPayload/user/oauthInvalidPassword.json')

* def result = call invalidPswToLock invalidPswPayload
# After account lock, Try to unlock with valid password
* call read('../../core-services/pretests/userAccountUnlockPretest.feature@validPasswordError')
* assert authResponseBody.error == userConstant.errormessages.accountLock

@User_Account_04 @userAccountAfterLock @coreServices @regression
Scenario: Verify the user Account is NOT locked after giving valid password for the 5th time  
# Execute 5times with valid password
* def validPasswordNotToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@validPasswordSuccess')
* def validPasswordPayload = read('../../core-services/requestPayload/user/oauthValidPassword.json')
* def resultOne = call validPasswordNotToLock validPasswordPayload

@User_Account_05 @userAccountAfterLock @coreServices @regression
Scenario: Verify the user Account before 1 hr after locked
# Call account lock feature
* def invalidPswToLock = read('../../core-services/pretests/userAccountUnlockPretest.feature@invalidPasswordError')

* def invalidPswPayload = read('../../core-services/requestPayload/user/oauthInvalidPassword.json')

* def result = call invalidPswToLock invalidPswPayload
# Try with valid password
* call read('../../core-services/pretests/userAccountUnlockPretest.feature@validPasswordError')
* assert authResponseBody.error == userConstant.errormessages.accountLock