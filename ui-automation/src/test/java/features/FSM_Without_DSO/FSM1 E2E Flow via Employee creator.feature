Feature: FSM1 E2E Flow via Employee creator

@fsm1
Scenario: Employee Editor Create Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "CE"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on New Application
  And Select Application Channel
  And Enter Application Name
  And Enter Mobile Number
  And Select Property "Residential"
  And Select Property SubType "ResidentialSubType"
  And Enter Pincode Number
  And Select Locality Mohalla "Mohalla"
  Then Update Name of the Slum
  And Enter Street House and Landmark
  When Select Sanitation Type "Sanitation_Type1"
  Then Enter Length Breadth and Depth
  And Select Vehicle Type "Vehicle_Type"
  And Click Submit Application button
  Then Check Application Number
  And Click On Download button
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
  

 
  
@fsm1
Scenario: Payment by Collector
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "COLL"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click Search Application
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click Collect Payment
  And Enter GEN Receipt Number
  And Click on Genrate Receipt
  Then Check Receipt number
  And Click On Print Recipt
  And Employee Logout and Close

 
 
@fsm1
Scenario: Editor Assign Application To DSO
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "EE"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  And Click on Assign DSO
  And Click On DSO from dropdown
  Then Click On Assign button
  And Employee Logout and Close

 
 @fsm111
Scenario: DSO Assign Vehicle Number
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number
	And Feed Pin code
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Assign Vehicle
  And Click On Vehicle Number from dropdown
  Then Click On Assign button
  And Logout from eGov and Close
  

  
@fsm111
 Scenario: DSO Complete Application Request
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number
	And Feed Pin code
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  And Click On Complete Request
  And Choose Date and Waste Collected
  Then Click On Complete button
  And Logout from eGov and Close

   
@fsm111
Scenario: FSTPO Vehicle 
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "FSTPO"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click Vehicle Log
  When Enter Vehicle In Time
  And Enter Vehicle Out Time
  Then Click Submit button
  And Employee Logout and Close
  


@fsm111
Scenario: Citizen gives Rating
	Given Open new web url "citizen"
	When Click On Fsm My Application
	And Feed mobile number
	And Feed Pin code
	And Click On View
	And Click on Rate Us
	And Select Ratings and Comment
	Then Click Submit button
	And Click On Download button
	And Logout from eGov and Close
	
   
 @fsm1
Scenario: Employee Editor Check Final Status
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "CE"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click Search Application
  When Enter Application Number
  Then Click On Search
 # And Check final Status
  And Employee Logout and Close
  
  
 