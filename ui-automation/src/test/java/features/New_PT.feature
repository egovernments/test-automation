Feature: Create Property tax through new eGov UI and observe the API behaviour 

#Background: Initiate the eGov web page 
#	Given eGov Launch Browser

@ptUi
Scenario Outline: Verify the PT usin yaml file at screen level
	Given yml_eGov Open new web url "<url>"
	When yml_eGov Select Create Property tax
	And yml_Enter mobile number as "<mobile>"
	#And Go to Next eGov screen
	And yml_Enter Pin code as "<pin>"
	#And Go to Next eGov screen
	And yml_Register property tax
	And yml_Enter details for page "Is this a Residential Property"
	And yml_Enter details for page "Type of Property"
	And yml_Enter details for page "Area"
	And yml_Enter details for page "Pin Property Location"
	And yml_Enter details for page "Do you know the pincode"
	And yml_Enter details for page "Provide Property address"
	And yml_Enter details for page "Provide Property address"
	And yml_Enter details for page "Provide Landmark"
	And yml_Enter details for page "PT_PROOF_OF_ADDRESS_HEADER"
	And yml_Enter details for page "Provide Ownership details"
	And yml_Enter details for page "Owner Details"
	And yml_Enter details for page "Special Owner category"
	And yml_Enter details for page "Owner’s Address"
	And yml_Enter details for page "Special Owner Category Proof"
	And yml_Enter details for page "Proof Of Identity"
	#And yml_Enter details for page "Review your answers"
	
	Examples: 
   | url|mobile | pin  | 
   | https://qa.digit.org/digit-ui/citizen|9999999999  | 123456  | 
   
@ptUi1
Scenario Outline: Verify the PT usin yaml file
	Given Open new web url "<url>"
	When Select Create Property tax
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Register property tax
	And Execute tax payment form from "paytax.yaml"
	And Logout from eGov
		Examples: 
   | url|mobile | pin  |
   | https://qa.digit.org/digit-ui/citizen|9999999999  | 123456  | 
   
#@ptfsm
#Scenario Outline: Verify the PT usin yaml file
#	Given Open new web url "<url>"
	#When Select Create Property tax
	#When Select fsm Property tax
	#And Feed mobile number as "<mobile>"
#	And Feed Pin code as "<pin>"
#	And Execute tax payment form from "fsm.yaml"
	#And Logout from eGov
	#	Examples: 
   #| url|mobile | pin  | 
  # | https://qa.digit.org/digit-ui/citizen|9999999999  | 123456  | 
   
@ptpgrBackbutton
Scenario Outline: Verify the PT usin yaml file
	Given Open new web url "<url>"
	#When Select Create Property tax
	When Click File Complaint Option
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	When Execute tax payment form from "pgrwithBack.yaml"
	And Back till Home Page
	#And Logout from eGov
		Examples: 
   | url|mobile | pin  | 
   | https://qa.digit.org/digit-ui/citizen/all-services|9999999999  | 123456  | 
   
@ptpgr
Scenario Outline: Verify the PT usin yaml file
	Given Open new web url "<url>"
	#When Select Create Property tax
	When Click File Complaint Option
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	When Execute tax payment form from "pgr.yaml"
	Then Check complaint number
	And Logout from eGov
		Examples: 
   | url|mobile | pin  | 
   | https://qa.digit.org/digit-ui/citizen/all-services|9999999999  | 123456  | 
   
   
@gro
Scenario Outline: GRO complaint reject
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on compliant icon
  And Navigate New
  When Select Assign to all
  And Select Pending Assignment
#  Then Click on Complaint Number
  And Click on Take Action
  And Click on Reject
  When Enter comment
  And File upload "<file>"
 	# Then Click on Reject button
	#And Logout from eGov
Examples: 
   | url |Username | Password  | City| file |
   | https://qa.digit.org/employee/language-selection|QAPGRGRO  | eGov@123  | Amritsar | blankpage.jpeg|
   
@assigntoLME
Scenario Outline: GRO complaint assign to LME
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on compliant icon
  When Select Assign to all
  And Select Pending Assignment
  Then Click on Complaint Number
  And Click on Take Action
  When Click On Complaint Assign
  When Enter comment
  And Click On LME from dropdown
  And File upload "<file>"
  #Then Click On Assign button

  
	#And Logout from eGov
		Examples: 
   | url |Username | Password  | City| file |
   | https://qa.digit.org/employee/language-selection| QAPGRGRO  | eGov@123  | Amritsar | blankpage.jpeg|
   
   
@CSR
Scenario Outline: GRO complaint assign to LME
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on compliant icon
  And Clear All
  When Enter Complaint Number "<ValidNumber>"
  Then Click On Search
  And Verify Search Result "<ValidNumber>"
  And Clear Search
  When Enter Mobile Number "<ValidMobile>"
  Then Click On Search
  And Verify Search Result "<ValidNumber>"
  And Clear Search
  When Enter Wrong Complaint Number "<InvalidNumber>"
  Then Click On Search
  And Verify Wrong Search Result
  And Clear Search
  When Enter Wrong Mobile Number "<InvalidMobile>"
  Then Click On Search
  And Verify Wrong Search Result
  And Clear Search
  When Select Assign to all
  And Select Compliant Subtype
  And Select Locality
  And Check and Select Status
  And Click on New Complaint
 # Then Click on Complaint Number
  And Click on Take Action
  When Click On Complaint Assign
  When Enter comment
  And Click On LME from dropdown
  And File upload "<file>"
  #Then Click On Assign button

  
	#And Logout from eGov
		Examples: 
   | url |Username | Password  | City| file | ValidNumber| InvalidNumber| ValidMobile|InvalidMobile|
   | https://qa.digit.org/employee/language-selection| QAPGRCSR  | eGov@123  | Amritsar | blankpage.jpeg|PB-PGR-2021-08-20-002290|PB-PGR-2021-08-20-002211|9999999999|9869313101|
   
@LmeReassign
Scenario Outline: LME Resolved
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on compliant icon
  And Navigate New
  When Select Assign to all
  And Click LME Pendig Filter
  Then Click on Complaint Number
  And Click on Take Action
  And Reassign By LME
  And Reassign to GRO
  When Enter comment
  And File upload "<file>"
 	#Then Click On Assign button
	#And Logout from eGov
	Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|UATLME  | eGov@123  | City | blankpage.jpeg|
   
@LmeResolved
Scenario Outline: LME Resolved
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on compliant icon
  And Navigate New
  When Select Assign to all
  And Click LME Pendig Filter
  Then Click on Complaint Number
  And Click on Take Action
  And Click On Resolve
  When Enter comment
  And File upload "<file>"
 	# Then Click On Resolve button
	#And Logout from eGov
	Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|UATLME  | eGov@123  | City | blankpage.jpeg|
   
