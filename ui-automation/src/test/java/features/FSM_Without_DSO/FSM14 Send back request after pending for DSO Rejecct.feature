Feature: E2E Flow via Employee creator
	
@fsm14
Scenario Outline: Employee Editor Create Collector and Editor Flow
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Select City "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
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
  And Click Collect Payment button
  When Select Card and Enter Details
  And Click on Genrate Receipt
  Then Check Receipt number
  And Click on Home Option Top
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
   | url     |Username | Password  | City   |Property   |Subtype          |Pincode|Mohalla          |Slum_Area|Sanitation_Type         |Vehicle_Type                        |
   | employee| UATCEC  | eGov@123  | City A |Residential|Independent house|143001 |Main Road Abadpura|K.K sahi|Conventional septic tank|Mahindra - Bolero Pickup - 1000 Ltrs|

   
 @fsm144
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
   | url   |mobile     | pin   |
   |citizen|8919146216 | 123456| 
   
@fsm144
Scenario Outline: DSO Reject the Application
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
  Then Click On Decline Request
  And Choose Decline Reason "<reason>"
  And Enter Comment
  Then Click On Decline Request button
  And Logout from eGov and Close

Examples: 
   | url   |mobile     | pin   | reason                 |
   |citizen|8919146216 | 123456| Vehicle is under repair|
   
   
 @fsm144
Scenario Outline: Admin Send Back the Application
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
  And Select Status "<Status>"
  And Click on Application Number
  When Click On Take Action button
  Then Click On Send Back
  And Select Reason "<reason>"
  And Enter Comment
  Then Click On Send Back button
  And Employee Logout and Close

Examples: 
   | url    |Username |Password   | City   | reason                       |Status      |
   |employee|QAADMIN  | eGov@123  | City A | Not able to contact applicant|DSO Rejected|
   