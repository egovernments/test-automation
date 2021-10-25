Feature: PGR3 Flow for Citizen Creation and GRO Reject

@pgr3
Scenario: Citizen Application Creation
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
  When Click on Next button
  Then Click Submit button
  Then Check Complaint Number
  And Click On Back To Homepage button
  And Verify Citizen Home Page
  And Logout from eGov and Close


  @pgr3
Scenario: GRO Reject
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "GRO"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on compliant icon
  When Select Assign to all
  And Enter Complaint Number
  Then Click on Complaint Number
  And Click on Take Action
  And Click on Reject Complaint
  When Enter comment
  And File upload
 	Then Click on Reject button
  And Employee Logout and Close
	
  