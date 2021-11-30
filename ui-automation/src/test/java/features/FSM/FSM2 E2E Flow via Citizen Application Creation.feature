Feature: FSM2 E2E Flow via Citizen Application Creation

@fsm22
Scenario: Create FSM application as a citizen- Residential Property Type
  Given Open new web url "citizen"
	When Click on Apply Septic Tank Pit
	And Feed mobile number
	And Feed Pin code
  Then Click on Property type Radio button "Property_Residential"
  When Click on Next button
  And check SubType Radio button "ResidentialSubType"
  When Click on Next button
  And Pin Property Location
  And Check Can enter city
  When Scroll click on Next button
  Then Enter pincode "pincode"
  And Select City and Check Locality
  Then Enter pincode "pincode"
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
  And Click On Download button
  And Click On Back To Homepage button
  And Verify Citizen Home Page
  And Logout from eGov and Close


@fsm2
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
  And Update Property "Property_Commercial" and "ResidentialSubType"
  And Select Property SubType "CommercialSubType"
  And Enter Pincode Number
  And Select Locality Mohalla "Mohalla"
  Then Update Name of the Slum
  And Enter Street House and Landmark
  When Select Sanitation Type "Sanitation_Type2"
  Then Enter Length Breadth
  And Select Vehicle Type "Vehicle_Type2"
  And Click On Update Application button
  And Click On Download button
  And Click On Back To Homepage button
  And Verify Employee Inbox Page
  And Employee Logout and Close
 
		
@fsm2
Scenario: Explore Paying as a citizen
	Given Open new web url "citizen"
	When Click On Fsm My Application
	And Feed mobile number
	And Feed Pin code
	And Click On View
	And Click Make Payment
	And Click Pay button
	And Click On Master Card
	When Enter Card Details "cardnumber"
	Then Click On Pay Now button
	And Click On Submit
	Then Check Receipt number
	And Download Reciept and Goto Homepage
	And Verify Citizen Home Page
	And Logout from eGov and Close

@fsm2
Scenario: Assign DSO as a employee editor
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
  And Click on Inbox
  And Verify Employee Inbox Page
  And Click on Home Option Top
  And Verify Employee Inbox Page
  And Employee Logout and Close

 
 @fsm2
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

   
@fsm2
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

   
@fsm2
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


@fsm2
Scenario: Citizen gives Rating
	Given Open new web url "citizen"
	When Click On Fsm My Application
	And Feed mobile number
	And Feed Pin code
	And Click On View
	And Click on Rate Us
	And Select Ratings and Comment
	Then Click Submit button
	And Click On Download button
	And Logout from eGov and Close
	  
@fsm2
Scenario: Citizen View Rating
	Given Open new web url "citizen"
	When Click On Fsm My Application
	And Feed mobile number
	And Feed Pin code
	And Click On View
	And Click On View Rating
	And Check Ratings
	And Back till Home Page
	And Logout from eGov and Close

	  
@fsm2
Scenario: Citizen Explore Application
	Given Open new web url "citizen"
	When Click On Fsm My Application
	And Feed mobile number
	And Feed Pin code
	And Click On View
	And Download Acknowledgement
	And Back till Home Page
	And Logout from eGov and Close

