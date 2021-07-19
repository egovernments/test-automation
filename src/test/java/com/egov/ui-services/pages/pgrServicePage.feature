Feature: Login Page Feature

Background:
    * def pgrPage = read('../../ui-services/page-objects/pgrService.yaml')
    * def PPO = pgrPage.objects
    * def data = pgrPage.Data

@clickComplaints
Scenario: Click Complaints link
	* waitFor(PPO.complaintsLink).click()
    #Click on Back Button
    * waitFor(PPO.backLink).click()
    * waitFor(PPO.backLink).click()

@selectComplaintType
Scenario: Select Complaints type
	* waitFor(PPO.radioButton).click()
    * waitFor(PPO.nextButton).click()

@searchLocationPincode
Scenario: Search Location Pincode
	* waitFor(PPO.pinCode).input(data.pinCode)
    * waitFor(PPO.nextButton).click()
    * waitFor(PPO.nextButton).click()
    * waitFor(PPO.locality).click()
    * waitFor(PPO.nextButton).click()
    * waitFor(PPO.nextButton).click()

@updalodComplaintPhoto
Scenario: Upload Complaint Photo
	* waitFor(PPO.pinCode).input(data.pinCode)
    * waitFor(PPO.nextButton).click()

@additionalDetails
Scenario: Providing Additional Details
	* waitFor(PPO.details).input(data.details)
    * waitFor(PPO.nextButton).click()