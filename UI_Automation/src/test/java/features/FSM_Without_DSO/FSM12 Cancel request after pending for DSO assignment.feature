Feature: FSM12 E2E Flow via Employee creator

@fsm12
Scenario Outline: Employee Editor Create Application
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Select City "<City>"
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
   | url     |Username | Password  | City  |Property  |Subtype|Pincode|Mohalla           |Slum_Area|Sanitation_Type         |Vehicle_Type                        |
   | employee| QACE    | eGov@123  | City A  |Commercial|Hotel  |143001 |Main Road Abadpura|K.K sahi |Conventional septic tank|Mahindra - Bolero Pickup - 1000 Ltrs|
 
  
@fsm12
Scenario Outline: Payment by Collector
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Select City "<City>"
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
   | url     |Username | Password  | City  | 
   | employee|QACOLL   | eGov@123  | City A|
   
  @fsm12
Scenario Outline: Admin Reject the Application
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
	And Select City "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Select Assign to all
  When Enter Application Number
  Then Click On Search
  And Select Status "<Status>"
  And Click on Application Number
  When Click On Take Action button
  Then Click On Cancel Request
  And Select Reason "<reason>"
  And Enter Comment
  Then Click On Decline Request button
  And Employee Logout and Close

Examples: 
   | url    |Username |Password   | City   | reason               |Status                    |
   |employee|QAADMIN  | eGov@123  | City A | Duplicate Application|Pending for DSO Assignment|
   
   
 