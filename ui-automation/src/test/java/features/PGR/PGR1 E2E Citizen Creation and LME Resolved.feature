Feature: PGR1 E2E Flow via Citizen Application Creation

@pgr1
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
 # And Click on upload
  #And Upload photo Maxmb photo at "<maxpic>"
#  And Check file large error message
  #And Click on upload
 # And Upload photo at "<photo>"
 # And Check delete icon
  And Click skip and next
  Then Enter Additional details
  When Click on Next button
  Then Click Submit button
  Then Check Complaint Number
  And Click On Back To Homepage button
  And Verify Citizen Home Page
  And Logout from eGov and Close

   
 @pgr1
 Scenario: GRO complaint assign to LME
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
  When Click On Complaint Assign
  When Enter comment
  And Click On LME from dropdown
  And File upload
  Then Click On Assign button
  And Employee Logout and Close


   
@pgr1
Scenario: LME Resolved
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "LME"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on compliant icon
  When Select Assign to all
  And Enter Complaint Number
  Then Click on Complaint Number
  And Click on Take Action
  And Click On Resolve
  When Enter comment
  And File upload
  Then Click On Assign button
  And Employee Logout and Close
 

     
 @pgr1
Scenario: Citizen gives Rating
	Given Open new web url "citizen"
	And Click On Complaint Option
	And Feed mobile number
	And Feed Pin code
	When Click On Complaint Number Label
	And Click on Rate Us
	And Citizen Select Ratings and Comment
	Then Click Submit button
	And Click On Back To Homepage button
  And Verify Citizen Home Page
	And Logout from eGov and Close
	
   
 @pgr1
Scenario: Citizen Explore Check Rate
	Given Open new web url "citizen"
	And Click On Complaint Option
	And Feed mobile number
	And Feed Pin code
	When Click On Complaint Number Label
	And Check You Rated Text
	And Logout from eGov and Close
	