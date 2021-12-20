Feature: FSM16 E2E Flow Collector Editor Inbox

@fsm16
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
  And Click On Download button
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
  
  Examples: 
   | url     |Username | Password  | City  |Property   |Subtype          |Pincode  |Mohalla           |Slum_Area|Sanitation_Type         |Vehicle_Type                        |
   | employee| QACE    | eGov@123  | City  |Residential|Independent house|143001   |Main Road Abadpura|K.K sahi |Conventional septic tank|Mahindra - Bolero Pickup - 1000 Ltrs|
 
 
@fsm16
Scenario Outline: CE Explore Filter
	Given Open new web url "<url>"
	When Select the language
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Select City "<City>"
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
  When Enter Mobile Number "<ValidMobile>"
  Then Click On Search
  And Verify Enter Search Result
  And Select FSM Locality
  And Select Pending for Payment Status
  And Click on Application Number
  And Click on Inbox
  And Verify Employee Inbox Page
  And Employee Logout and Close
 
 Examples: 
   | url     |Username | Password  | City    |ValidMobile|  InvalidNumber         |
   | employee| UATCC    | eGov@123  | City A  |9999999999 |PB-PGR-2021-08-20-002211|
  