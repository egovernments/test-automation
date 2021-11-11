Feature: FSM12 E2E Flow via Employee creator

@fsm12
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
  And Select Property "Property_Commercial"
  And Select Property SubType "CommercialSubType"
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
  
  
@fsm12
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
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click Collect Payment
  And Enter GEN Receipt Number
  And Click on Genrate Receipt
  Then Check Receipt number
  And Employee Logout and Close
   
  @fsm12
Scenario: Admin Reject the Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "ADMIN"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Select Assign to all
  When Enter Application Number
  Then Click On Search
  And Select Status "status2"
  And Click on Application Number
  When Click On Take Action button
  Then Click On Cancel Request
  And Select Reason "adminReason3"
  And Enter Comment
  Then Click On Decline Request button
  And Employee Logout and Close
   
   
 