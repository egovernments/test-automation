Feature: Login Page Feature

Background:
    * def loginPage = read('../../ui-services/page-objects/login.yaml')
    * def loginPageurls = loginPage.urls
    * def loginPageObjects = loginPage.objects

@loginAsCitizen
Scenario: Login to UI as Citizen
	Given driver envHost
	* driver.fullscreen()
	* waitForUrl(loginPageurls.languageSelection)
	* click(loginPageObjects.languageEnglishButton)
	* click(loginPageObjects.continueButton)
	* waitForUrl(loginPageurls.register)
	* click(loginPageObjects.resendOtpButton)
	* waitForUrl(loginPageurls.login)
	* input(loginPageObjects.mobileNumberField, citizenUsername)
	* click(loginPageObjects.loginSubmitButton)
	* waitForUrl(loginPageurls.otp)
	* input(loginPageObjects.otpField, '123456')
	* click(loginPageObjects.submitOtpButton)

@loginAsAltCitizen
Scenario: Login to UI as Citizen
	Given driver envHost
	* driver.fullscreen()
	* waitForUrl(loginPageurls.languageSelection)
	* click(loginPageObjects.languageEnglishButton)
	* click(loginPageObjects.continueButton)
	* waitForUrl(loginPageurls.register)
	* click(loginPageObjects.resendOtpButton)
	* waitForUrl(loginPageurls.login)
	* input(loginPageObjects.mobileNumberField, altCitizenUsername)
	* click(loginPageObjects.loginSubmitButton)
	* waitForUrl(loginPageurls.otp)
	* input(loginPageObjects.otpField, '123456')
	* click(loginPageObjects.submitOtpButton)

@naviagteToHomePage
Scenario: Navigate To Home Page
	* waitFor(loginPageObjects.homePageLink).click()
	* waitForUrl(loginPageurls.homePage)