Feature: FSM3 E2E Flow via Employee creator

@fsm3
Scenario Outline: Employee Editor Create Application and Collector Collect
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
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
  And Click On Back To Homepage button
  And Click on Inbox
  And Click Search Application
  Then Click On Search
  And Check Result Message
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click Collect Payment
  And Select Cheque and Enter Details
  And Click on Genrate Receipt
  Then Check Receipt number
  And Employee Logout and Close
  
  Examples: 
   | url     |Username | Password  | City |Property   |Subtype          |Pincode|Mohalla           |Slum_Area|Sanitation_Type         |Vehicle_Type                        |
   | employee| UATCC   | eGov@123  | City |Residential|Independent house|143001 |Main Road Abadpura|K.K sahi |Conventional septic tank|Mahindra - Bolero Pickup - 1000 Ltrs|
   

@fsm3
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
  And Click Search Application
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
 
 @fsm33
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
   | url   |mobile     | pin    |
   |citizen|8919146216 | 123456 | 
   
@fsm33
 Scenario Outline: DSO Complete Application Request
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
  And Click On Complete Request
  And Choose Date and Waste Collected
  Then Click On Complete button
  And Logout from eGov and Close
  
Examples: 
   | url   |mobile     | pin   |
   |citizen|8919146216 | 123456| 
   
@fsm33
Scenario Outline: FSTPO Vehicle 
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click Vehicle Log
  When Enter Vehicle In Time
  And Enter Vehicle Out Time
  Then Click Submit button
  And Employee Logout and Close
  
  Examples: 
   | url     |Username | Password  | City | 
   | employee|QAFSTPO  | eGov@123  | City |


@fsm33
Scenario Outline: Citizen gives Rating
	Given Open new web url "<url>"
	When Click On Fsm My Application
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Click On View
	And Click on Rate Us
	And Select Ratings and Comment
	Then Click Submit button
	And Click On Download button
	And Logout from eGov and Close
	
	Examples: 
   | url    |mobile      | pin    | 
   | citizen|9999999999  | 123456 |
	  
    