Feature: Login Page Feature

Background:
    * def homePage = read('../../ui-services/page-objects/home.yaml')
    * def hPO = homePage.objects

@clickComplaints
Scenario: Click Complaints link
	* clickElement(hPO.complaintsLink)
	