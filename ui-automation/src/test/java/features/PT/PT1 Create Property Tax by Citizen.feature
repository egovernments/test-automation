Feature: PT1 E2E Flow via Citizen Application Creation

@pt11
Scenario: Create Property Tax by citizen
  Given Open new web url "citizen"
  When Select Language "languageEng"
  And Select Location
  And Select Citizen Service "PT"
  And Click On Create Property
  And Feed mobile number
	And Feed Pin code
	When Click on Next button
	Then Select Yes for Is Resident Property
	When Click on Next button
  Then Click on Property type Radio button "PT_Property" 
  When Click on Next button
  And Choose Number of Floors
  And Choose Number of Basements
  And Enter Ground Floor Details
  Then Select Floor Self Occupied Option
  And Enter Rental Details
  And Select No for floor unoccupied
  And Enter VASIKA Property Details
  
@pt14
Scenario: Create Property Tax by citizen
  Given Open new web url "citizen"
  When Select Language "languageEng"
  And Select Location
  And Select Citizen Service "PT"
  And Click On Create Property
  And Feed mobile number
	And Feed Pin code
	When Check information and Next
	Then Select Yes for Is Resident Property
	When Click on Next button
  Then Click on Property type Radio button "PT_Property" 
  When Click on Next button
  And Enter Area
  And Enter VASIKA Property Details
  And Check Can enter city
  When Click on Next button
  Then Enter pincode "pincode"
  And Select City and Check Locality
  Then Enter Street and Door
  When Click on Next button
  Then Verify Landmark Page
  And Click skip and next
  And Select Proof of Address
  And File upload
  When Click on Next button
  Then Select Provide Ownership details Radio button "ownership"
  And Enter Owner Details
  And Select Special Owner category Radio button "specialOwner"
  And Enter Owners Address
  And Upload Special Owner Category Proof
  And Upload Proof Of Identity
  And Review Answer and accept
  Then Click Submit button
  And Check Property Application Number
  And Check Property Unique ID
  
  
@pt1
Scenario: Employee Editor Create Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "DV"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on Property Tax
  When Enter Application Details
  Then Click On Search
  And Click on Unique Property ID
  When Click On Take Action button
  Then Click on Verify
  And Select Field Field Inspectors
  And Enter Comment
  And File upload
  And Click On Verify button 
  
 @pt1
Scenario: Employee Editor Create Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "FI"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on Property Tax
  When Enter Application Details
  Then Click On Search
  And Click on Unique Property ID
  When Click On Take Action button
  Then Click on Forward
  And Select Approver
  And Enter Comment
  And File upload
  And Click On Forward button
  
 @pt1
Scenario: Employee Editor Create Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "AP"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on Property Tax
  When Enter Application Details
  Then Click On Search
  And Click on Unique Property ID
  When Click On Take Action button
  Then Click on APPROVE
  And Enter Comment
  And File upload
  And Click On Approve button
  
@pt11
Scenario: Employee Editor Create Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "PTCE"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on Property Tax
  And Click On Search Property
  And Select PT Locality
  When Enter UID and Number
  Then Click On Search
  And Click on Unique Property ID
  When Click On Take Action button
  Then Click on ASSESS PROPERTY
  And Select Financial Year
  And Click On Assess Property button
  
 @pt1
Scenario: Check My application
  Given Open new web url "citizen"
  When Select Language "languageEng"
  And Select Location
  And Select Citizen Service "PT"
  And Click On My Application
  And Feed mobile number
	And Feed Pin code
	And Click On Track button
	And Click On Download Label
	#And Click On View Property Details
  
  
@pt11
  Scenario: Search and pay
  Given Open new web url "citizen"
  When Select Language "languageEng"
  And Select Location
  And Select Citizen Service "PT"
  When Click On Search and Pay "PT"
  And Citizen Enter City 
  And Citizen Select Locality
  #And Citizen Enter Mobile
  And Enter Unique Property ID
  And Click on Search button
  And Click On View Details
  
  @pt11
  Scenario: Owner history
  Given Open new web url "citizen"
  When Select Language "languageEng"
  And Select Location
  And Select Citizen Service "PT"
  And Click On My Properties
  And Feed mobile number
	And Feed Pin code
  And Click On View Details PT
  And Click on Owner History
  And Back and Click first document
  
  
  @pt111
  Scenario: Owner history
  Given Open new web url "citizen"
  When Select Language "languageEng"
  And Select Location
  And Select Citizen Service "PT"
  And Click On My Properties
  And Feed mobile number
	And Feed Pin code
  And Click On Register New Property Label
  And Navigate Back
  #have to write till home page
  
  
  