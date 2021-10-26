Feature: FSM9 E2E Flow via Citizen Application Creation

@fsm9
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
  And Select Property "Institutional"
  And Select Property SubType "InstitutionalSubType"
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
 
@fsm9
Scenario: Admin Send Back Application
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
  Then Click On Send Back
  And Select Reason "adminReason1"
  And Enter Comment
  Then Click On Send Back button
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
 
   
   
@fsm9
Scenario: Explore Employee Inbox- Search Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "EE"
  And Enter eGov password
  And Select eGov city field
  And Select City
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
  And Update Property "Commercial" and "InstitutionalSubType"
  And Select Property SubType "CommercialSubType"
  And Enter Pincode Number as "pincode_2"
  And Select Locality Mohalla "Mohalla_2"
  Then Update Name of the Slum as "Slum_Area2"
  And Enter Street House and Landmark
  When Select Sanitation Type "Sanitation_Type2"
  Then Enter Length Breadth
  And Select Vehicle Type "Vehicle_Type2"
  And Click On Update Application button
  And Click On Download button
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
  
