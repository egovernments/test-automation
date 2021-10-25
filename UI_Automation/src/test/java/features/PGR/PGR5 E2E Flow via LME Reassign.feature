Feature: PGR5 E2E Flow via CSR Application Creation

@pgr5
Scenario: CSR Create Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "CSR"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on compliant icon
  And Click on New Complaint
  And Enter Application Name
  And Enter Citizen Mobile Number
  And Select Complaint Type "CompaintType"
  And Select Complaint SubType "streetlight_subtype"
  And Enter Citizen Pincode Number
  And Select Locality Mohalla "Mohalla"
  When Enter Citizen Landmark
  Then Enter Citizen Additional details
  And Click On File Complaint button
  Then Check Complaint Number
  And Click On Back To Home button
  And Verify PGR Employee Home Page
  And Employee Logout and Close
  
   
 @pgr5
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


@pgr5
Scenario: LME Re-Assign
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
  And Reassign By LME
  And Reassign to GRO
  When Enter comment
  And File upload
 	Then Click On Assign button
  And Employee Logout and Close
	
 
