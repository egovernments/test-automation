Feature: E2E Flow via Employee creator

@fsm6
Scenario Outline: Employee Editor Create Application
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on New Application
  And Select Application Channel
  And Enter Application Name
  And Enter Mobile Number
  And Select Property "<Property>"
  And Select Property SubType "<Subtype>"
  And Enter Pincode Number "<Pincode>"
  And Select Locality Mohalla "<Mohalla>"
  Then Update Name of the Slum "<Slum_Area>"
  And Enter Street House and Landmark
  When Select Sanitation Type "<Sanitation_Type>"
  Then Enter Length Breadth and Depth
  And Select Vehicle Type "<Vehicle_Type>"
  And Click Submit Application button
  Then Check Application Number
  And Employee Logout and Close
  
  Examples: 
   | url     |Username | Password  | City |Property  |Subtype|Pincode|Mohalla    |Slum_Area    |Sanitation_Type          |Vehicle_Type                        |
   | employee| QACE    | eGov@123  | City |Commercial|Hotel  |143003 |Preet Nagar|Gangadhar Sahi|Conventional septic tank|Mahindra - Bolero Pickup - 1000 Ltrs|
   
   
@fsm6
Scenario Outline: Payment by Collector
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
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
  Examples: 
   | url      |Username | Password  | City |
   | employee |QACOLL   | eGov@123  | City |
   
 @fsm6
Scenario Outline: Editor Assign Application To DSO
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
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
  Examples: 
   | url     |Username | Password  | City |
   | employee|QAEE     | eGov@123  | City | 
   
  @fsm6
Scenario Outline: Editor Re-Assign Application To DSO
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  And Click on Re-Assign DSO
  And Enter Reason For Re-assign "<Reason>"
  And Re Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close
  Examples: 
   | url     |Username | Password  | City |Reason|
   | employee|QAEE     | eGov@123  | City |Vehicle is under repair|
   
  @fsm6
Scenario Outline: Editor Re Re-Assign Application To DSO
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  And Click on Re-Assign DSO
  And Enter Reason For Re-assign "<Reason>"
  And Re Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close
  
  Examples: 
   | url     |Username | Password   | City |Reason           |
   | employee|QAEE     | eGov@123   | City |Inaccessible road|
   
  @fsm66
Scenario Outline: DSO Assign Vehicle Number
	Given Open new web url "<url>"
	When Click On DSO Login
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
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
Examples: 
   | url   |mobile    | pin    |
   |citizen|8919146216| 123456 | 
   
 
 