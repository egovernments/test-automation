Feature: FSM5 E2E Flow via Citizen Application Creation

@fsm5
Scenario Outline: Create FSM application as a citizen- Commercial Property Type
  Given Open new web url "<url>"
	When Click on Apply Septic Tank Pit
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
  Then Click on Property type Radio button "<Property>"
  When Click on Next button
  And Select Citizen Property SubType "<Subtype>"
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
  And Logout from eGov and Close

Examples: 
   | url    |mobile      | pin    | Property   | Subtype| Slum_Area | pincode | wrongpin |
   | citizen| 9999999999 | 123456 | Commercial | Hotel  |  K.K sahi | 143001  | 400013   |



@fsm5
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
  And Click on Home Option Top
  And Employee Logout and Close
 
		Examples: 
   | url     |Username | Password  | City | Property   | Subtype |Pincode|Mohalla    |Slum_Area     |Sanitation_Type          |Vehicle_Type          |exSubtype|
   | employee| QAEE    | eGov@123  | City | Commercial | Hotel   |143003 |Preet Nagar|Gangadhar Sahi|Septic tank with soak pit|Tata - 407 - 3000 Ltrs|Hotel    |
 
 @fsm5
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
  And Enter Payer Details
  And Click on Genrate Receipt
  Then Check Receipt number
  And Employee Logout and Close
  
  Examples: 
   | url     |Username | Password  | City | 
   | employee|QACOLL   | eGov@123  | City |
 
@fsm5
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

 @fsm55
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
   

 @fsm55
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
  And Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close
  Examples: 
   | url     |Username | Password  | City |Reason|
   | employee|QAEE     | eGov@123  | City |Vehicle is under repair|
   
 @fsm55
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
   | url   |mobile     | pin     |
   |citizen|8919146216 | 123456  | 
   
 @fsm55
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
   | url   |mobile    | pin    |reason            |
   |citizen|8919146216| 123456 |Inaccessible road |
   
  @fsm55
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
  And Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close
  Examples: 
   | url     |Username | Password  | City |Reason|
   | employee|QAEE     | eGov@123  | City |Vehicle is under repair|
        
 @fsm55
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
   
@fsm55
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
   
@fsm55
Scenario Outline: FSTPO Vehicle 
	Given Open new web url "<url>"
	When Select the language
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
  