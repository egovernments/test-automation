Feature: FSM15 E2E Flow via Citizen Application Creation


@fsm15
Scenario Outline: Create FSM application as a citizen- Residential Property Type
  Given Open new web url "<url>"
	When Click on Apply Septic Tank Pit
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
  Then Click on Property type Radio button "<Property>"
  When Click on Next button
  And check SubType Radio button "<Subtype>"
  When Click on Next button
  And Pin Property Location
  And Check Can enter city
  When Scroll click on Next button
  Then Enter pincode "<wrongpin>"
  When Click on Next button
  Then Verify provide valid pin text 
  And Clear pin field
  And Click skip and next
  And Select City and Check Locality
  When Click on Next button
  And Click Slum Located Option
  When Click on Next button
  Then Provide Name of the Slum "<Slum_Area>"
  When Click on Next button
  Then Enter Street and Door
  When Click on Next button
  Then Verify Landmark Page
  And Click skip and next
  And Choose Sanitation type
  When Click on Next button
  Then Enter Length Breadth and Depth
  When Click on Next button
  Then Click Submit button
  Then Check Application Number
  And Click On Download button
  And Click On Back To Homepage button
  And Verify Citizen Home Page
  And Logout from eGov and Close

Examples: 
   | url    |mobile      | pin    |Property    |Subtype           |Slum_Area | wrongpin |
   | citizen| 9999999999  | 123456 |Residential |Independent house |K.K sahi  | 400013   |

  
@fsm15
Scenario Outline: EE Explore Filter
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
  When Enter Application Number
  When Enter Mobile Number "<ValidMobile>"
  Then Click On Search
  And Verify Enter Search Result
  And Clear Search
  When Select Assign to all
  And Select FSM Locality
  And Select Status Options
  And Change Language
  And Employee Logout and Close
 Examples: 
   | url     |Username | Password  | City    |ValidMobile|  InvalidNumber         |
   | employee| QAEE    | eGov@123  | City A  |9999999999 |PB-PGR-2021-08-20-002211|
   
   
   @fsm15
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
  And Click On Back To Homepage button
  And Verify Employee Inbox Page
  And Employee Logout and Close
 
 Examples: 
   | url     |Username | Password  | City   | Property  |Subtype|Pincode |Mohalla    |Slum_Area     |Sanitation_Type          |Vehicle_Type          |exSubtype        |
   | employee| QAEE    | eGov@123  | City A | Commercial|Hotel  |143003  |Preet Nagar|Gangadhar Sahi|Septic tank with soak pit|Tata - 407 - 3000 Ltrs|Independent house| 
 