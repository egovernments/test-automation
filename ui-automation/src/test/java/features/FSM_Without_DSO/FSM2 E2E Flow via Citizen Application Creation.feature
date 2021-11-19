Feature: FSM2 E2E Flow via Citizen Application Creation

@fsm2
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
   | url    |mobile      | pin    |Property    |Subtype           |Slum_Area | pincode | wrongpin |
   | citizen| 9999999999 | 123456 |Residential |Independent house |K.K sahi  | 143001  | 400013   |

@fsm2
Scenario Outline: Explore Employee Inbox- Search Application
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
   | url     |Username | Password  | City|Property  |Subtype|Pincode|Mohalla|Slum_Area|Sanitation_Type|Vehicle_Type|exSubtype|
   | employee| QAEE    | eGov@123  | City|Commercial|Hotel  |143003|Preet Nagar|Gangadhar Sahi|Septic tank with soak pit|Tata - 407 - 3000 Ltrs|Independent house|
   
@fsm2
Scenario Outline: Explore Paying as a citizen
	Given Open new web url "<url>"
	When Click On Fsm My Application
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Click On View
	And Click Make Payment
	And Click Pay button
	And Click On Master Card
	When Enter Card Details "<cardnum>"
	Then Click On Pay Now button
	And Click On Submit
	Then Check Receipt number
	And Download Reciept and Goto Homepage
	And Verify Citizen Home Page
	And Logout from eGov and Close
Examples: 
   | url   |mobile      | pin     |cardnum         |
   |citizen|9999999999  | 123456  |5457210001000019|
   
@fsm2
Scenario Outline: Assign DSO as a employee editor
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
  And Click on Inbox
  And Verify Employee Inbox Page
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close
  Examples: 
   | url     |Username  | Password   | City | 
   | employee|QAEE      | eGov@123   | City |
 
 @fsm22
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
   | url   |mobile      | pin     |
   |citizen|8919146216  | 123456  | 
   
@fsm22
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
   | url   |mobile      | pin     |
   |citizen|8919146216  | 123456  | 
   
@fsm22
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
  And Enter DSO Name and Vehicle
  Then Click On Search
  And Click Vehicle Log
  When Enter Vehicle In Time
  And Enter Vehicle Out Time
  Then Click Submit button
  And Employee Logout and Close
  Examples: 
   | url     |Username | Password  | City |
   | employee|QAFSTPO  | eGov@123  | City |

@fsm22
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
   | url   |mobile      | pin     | 
   |citizen|9999999999  | 123456  | 
	  
@fsm22
Scenario Outline: Citizen View Rating
	Given Open new web url "<url>"
	When Click On Fsm My Application
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Click On View
	And Click On View Rating
	And Check Ratings
	And Back till Home Page
	And Logout from eGov and Close
	Examples: 
   | url    |mobile      | pin     | 
   | citizen|9999999999  | 123456  |
	  
@fsm22
Scenario Outline: Citizen Explore Application
	Given Open new web url "<url>"
	When Click On Fsm My Application
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Click On View
	And Download Acknowledgement
	And Back till Home Page
	And Logout from eGov and Close
	Examples: 
   | url    |mobile      | pin     | 
   | citizen|9999999999  | 123456  |

