Feature: Login Page Feature

Background:
    * def loginPage = read('../../ui-services/page-objects/login.yaml')
    * def loginPageurls = loginPage.urls
    * def lPO = loginPage.objects
	# * def geoLocationScript = "window.navigator.geolocation.getCurrentPosition = function(success){ var position = {'coords' : {  'latitude': '18.975080',   'longitude': '72.825838' }  };  success(position);}"
    * def loginPageData = loginPage.data
   

@loginAsCitizen
Scenario: Login to UI as Citizen
	* clickElement(lPO.languageEnglishButton)
	* clickElement(lPO.continueButton)
	* clickElement(lPO.resendOtpButton)
	* clickElement(lPO.mobileNumberField)
	* print getAttribute(lPO.mobileNumberField, loginPageData.mobileNumberFieldType)
	* sendKeys(lPO.mobileNumberField, citizenUsername)
	* clickElement(lPO.loginSubmitButton)
	* sendKeys(lPO.otpField, loginPageData.otpField)
	* clickElement(lPO.submitOtpButton)

@loginAsAltCitizen
Scenario: Login to UI as Citizen
	* waitForUrl(loginPageurls.languageSelection)
	* click(lPO.languageEnglishButton)
	* click(lPO.continueButton)
	* waitForUrl(loginPageurls.register)
	* click(lPO.resendOtpButton)
	* waitForUrl(loginPageurls.login)
	* input(lPO.mobileNumberField, altCitizenUsername)
	* click(lPO.loginSubmitButton)
	* waitForUrl(loginPageurls.otp)
	* input(lPO.otpField, loginPageData.otpField)
	* click(lPO.submitOtpButton)

@naviagteToHomePage
Scenario: Navigate To Home Page
	* waitFor(lPO.homePageLink).click()
	* waitForUrl(loginPageurls.homePage)

@logout
Scenario: Logout
	* retry(3, 5000).waitFor(lPO.userSettingsDropdown).click()
	* waitFor(lPO.logoutButton).click()

@loginAsSuperUser
Scenario: Login to UI as Super User
	* driver envHost + "/employee"
	* clickElement(lPO.languageEnglishButton)
	* clickElement(lPO.continueButton)
	* sendKeys(lPO.employeeUsername, loginPageData.employeeUsername)
	* sendKeys(lPO.employeePassword, loginPageData.employeePassword)
	* clickElement(lPO.employeeCity)
	* clickElement(lPO.amritsarDropdown)
	* clickElement(lPO.loginSubmitButton)
	