Feature: FSM6 E2E Flow via Employee creator

@fsm6
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
  And Select Property "Commercial"
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
  
   
@fsm6
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
   
 @fsm6
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

   
  @fsm6
Scenario: Editor Re-Assign Application To DSO
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
  And Click on Re-Assign DSO
  And Enter Reason For Re-assign "reason1"
  And Re Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close
 
   
  @fsm6
Scenario: Editor Re Re-Assign Application To DSO
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
  And Click on Re-Assign DSO
  And Enter Reason For Re-assign "reason2"
  And Re Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close
   
  @fsm6
Scenario: DSO Assign Vehicle Number
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
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

   
 
 