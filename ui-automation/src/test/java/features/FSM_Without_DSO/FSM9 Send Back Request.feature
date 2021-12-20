Feature: E2E Flow via Citizen Application Creation

@fsm9
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
   | url      |Username | Password  | City   |Property     |Subtype|Pincode|Mohalla           |Slum_Area|Sanitation_Type         |Vehicle_Type|
   | employee | QACE    | eGov@123  | City A |Institutional|Temple |143001 |Main Road Abadpura|K.K sahi |Conventional septic tank|Mahindra - Bolero Pickup - 1000 Ltrs|

@fsm9
Scenario Outline: Admin Send Back Application
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
  Then Click On Send Back
  And Select Reason "<reason>"
  And Enter Comment
  Then Click On Send Back button
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
 
Examples: 
   | url    |Username |Password   | City    | reason                       |
   |employee|QAADMIN  | eGov@123  | City A  | Not able to contact applicant|
   
   
@fsm9
Scenario Outline: Explore Employee Inbox- Search Application
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Select City "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click Search Application
  Then Click On Search
  And Check Result Message
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Update Application
  And Update Property "<Property>" and "<exSubtype>"
  And Select Property SubType "<Subtype>"
  And Enter Pincode Number "<Pincode>"
  And Select Locality Mohalla "<Mohalla>"
  Then Update Name of the Slum "<Slum_Area>"
  And Enter Street House and Landmark
  When Select Sanitation Type "<Sanitation_Type>"
  Then Enter Length Breadth
  And Select Vehicle Type "<Vehicle_Type>"
  And Click On Update Application button
  And Click On Download button
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
  
Examples: 
   | url     |Username | Password  | City   |Property  |Subtype|Pincode|Mohalla    |Slum_Area     |Sanitation_Type          |Vehicle_Type          |exSubtype|
   | employee| QAEE    | eGov@123  | City A |Commercial|Hotel  |143003 |Preet Nagar|Gangadhar Sahi|Septic tank with soak pit|Tata - 407 - 3000 Ltrs|Temple   |
  