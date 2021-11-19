Feature: PGR7 Flow for Citizen Back Functionality

@pgr7
Scenario: Citizen Application Creation till Details and Back-Home
  Given Open new web url "citizen"
  And Click File Complaint Option
  And Feed mobile number
	And Feed Pin code
  Then Click on Complaint type Radio button
  When Click on Next button
  And check SubType Radio button "streetlight_subtype"
  When Click on Next button
  And Pin Complaint Location
  And Check Can enter city
  When Scroll click on Next button
  Then Enter pincode "wrongpin"
  When Click on Next button
  Then Verify provide valid pin text 
  And Clear pin field
  And Click skip and next
  And Select City and Check Locality
  When Click on Next button
  Then Verify Landmark Page
  And Click skip and next
  And Upload photo and Maxmb photo
  And Check file large error message
  And Check delete icon
  When Click on Next button
  Then Enter Additional details
  And Back till Home Page
  And Logout from eGov and Close


   