Feature: FSM5 E2E Flow via Citizen Application Creation

@fsm5
Scenario: Create FSM application as a citizen- Commercial Property Type
  Given Open new web url "citizen"
	When Click on Apply Septic Tank Pit
	And Feed mobile number
	And Feed Pin code
  Then Click on Property type Radio button "Commercial"
  When Click on Next button
  And check SubType Radio button "CommercialSubType"
  When Click on Next button
  And Pin Property Location
  And Check Can enter city
  When Scroll click on Next button
  Then Enter pincode "wrongpin"
  When Click on Next button
  Then Verify provide valid pin text 
  And Clear pin field
  And Click skip and next
  And Select City and Check Locality
  When Click on Next button
  And Click Slum Located Option
  When Click on Next button
  Then Provide Name of the Slum "Slum_Area"
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


@fsm5
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
  And Update Property "Commercial" and "ResidentialSubType"
  And Select Property SubType "CommercialSubType"
  And Enter Pincode Number
  And Select Locality Mohalla "Mohalla_2"
  Then Update Name of the Slum
  And Enter Street House and Landmark
  When Select Sanitation Type "Sanitation_Type2"
  Then Enter Length Breadth
  And Select Vehicle Type "Vehicle_Type2"
  And Click On Update Application button
  And Click on Home Option Top
  And Employee Logout and Close

 @fsm5
Scenario: Payment by Collector
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "COLL"
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
  Then Click Collect Payment
  And Enter Payer Details
  And Click on Genrate Receipt
  Then Check Receipt number
  And Employee Logout and Close
  
 
@fsm5
Scenario: Editor Assign Application To DSO
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "EE"
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
  And Click on Assign DSO
  And Click On DSO from dropdown
  Then Click On Assign button
  And Employee Logout and Close
 

 @fsm5
Scenario: DSO Reject the Application
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Decline Request
  And Choose Decline Reason "reason1"
  And Enter Comment
  Then Click On Decline Request button
  And Logout from eGov and Close
   

 @fsm5
Scenario: Editor Re-Assign Application To DSO
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "EE"
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
  And Click on Re-Assign DSO
  And Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close

   
 @fsm5
Scenario: DSO Assign Vehicle Number
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
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
   
 @fsm5
Scenario: DSO Reject the Application
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Decline Request
  And Choose Decline Reason "reason2"
  And Enter Comment
  Then Click On Decline Request button
  And Logout from eGov and Close

   
  @fsm5
Scenario: Editor Re-Assign Application To DSO
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "EE"
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
  And Click on Re-Assign DSO
  And Re Assign DSO and Date
  Then Click On Assign button
  And Employee Logout and Close

        
 @fsm5
Scenario: DSO Assign Vehicle Number
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
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
   
@fsm5
 Scenario: DSO Complete Application Request
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
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

@fsm5
Scenario: FSTPO Vehicle 
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "FSTPO"
  And Enter eGov password
  And Select eGov city field
  And Select City
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

  