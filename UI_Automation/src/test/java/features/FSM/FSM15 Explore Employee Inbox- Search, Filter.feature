Feature: FSM15 E2E Flow via Citizen Application Creation


@fsm15
Scenario: Create FSM application as a citizen- Residential Property Type
  Given Open new web url "citizen"
	When Click on Apply Septic Tank Pit
	And Feed mobile number
	And Feed Pin code
  Then Click on Property type Radio button "Residential"
  When Click on Next button
  And check SubType Radio button "ResidentialSubType"
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
  And Click On Download button
  And Click On Back To Homepage button
  And Verify Citizen Home Page
  And Logout from eGov and Close
  
@fsm15
Scenario Outline: EE Explore Filter
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "EE"
  And Enter eGov password
  And Select eGov city field
  And Select City
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
  When Enter Mobile Number "mobile"
  Then Click On Search
  And Verify Enter Search Result
  And Clear Search
  When Select Assign to all
  And Select FSM Locality
  And Select Status Options
  And Change Language
  And Employee Logout and Close

   
   
   @fsm15
Scenario Outline: Explore Employee Inbox- Search Application
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
  And Click On Download button
  And Click On Back To Homepage button
  And Verify Employee Inbox Page
  And Employee Logout and Close
 