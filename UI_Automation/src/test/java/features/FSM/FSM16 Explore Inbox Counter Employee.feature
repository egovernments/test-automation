Feature: E2E Flow Collector Editor Inbox

@fsm16
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
  
 
@fsm16
Scenario: CE Explore Filter
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "CC"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click on Home Option Top
  And Click on Inbox
  When Select Assign to all
  When Enter Application Number
  Then Click On Search
  And Verify Enter Search Result
  And Clear Search
  When Select Assign to all
  When Enter Application Number
  When Enter Mobile Number "ValidMobile"
  Then Click On Search
  And Verify Enter Search Result
  And Select FSM Locality
  And Select Pending for Payment Status
  And Click on Application Number
  And Click on Inbox
  And Verify Employee Inbox Page
  And Employee Logout and Close
 
  