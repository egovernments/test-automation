Feature: FSM8 E2E Flow via Citizen Application Creation

@fsm8
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
  And Select Property "Property_Residential"
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
  And Employee Logout and Close

@fsm8
Scenario Outline: Admin Reject the Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "ADMIN"
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
  Then Click On Reject
  And Select Reason "adminReason2"
  And Enter Comment
  Then Click On Decline Request button
  And Employee Logout and Close


   