Feature: FSM7 E2E Flow via Citizen Application Creation

@fsm7
Scenario: Create FSM application as a citizen- Institutional Property Type
 Given Open new web url "citizen"
	When Click on Apply Septic Tank Pit
	And Feed mobile number
	And Feed Pin code
  Then Click on Property type Radio button "Institutional"
  When Click on Next button
  And Select Citizen Property SubType "InstitutionalSubType"
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

@fsm7
Scenario: Admin Reject the Application
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
  Then Click On Reject
  And Select Reason "adminReason1"
  And Enter Comment
  Then Click On Decline Request button
  And Employee Logout and Close

   