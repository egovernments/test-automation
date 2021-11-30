Feature: FSM Citizen Login to Verify FSM options
	
 
@fsmEE
Scenario Outline: Editor Assign DSO
	Given Open new web url "<url>"
	When Select the language as English
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
  Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|QAEE  | eGov@123  | City | blankpage.jpeg|
 
 @fsmEditorExploreWithFilter
Scenario Outline: GRO complaint assign to LME
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Enter Application Number
  Then Click On Search
  And Verify Search Result "<ValidNumber>"
  When Enter Mobile Number "<ValidMobile>"
  Then Click On Search
  And Verify Search Result "<ValidNumber>"
  And Clear Search
  When Enter Wrong Application Number "<InvalidNumber>"
  Then Click On Search
  And Verify Wrong Application Search Result
  And Clear Search
  When Enter Wrong Mobile Number "<InvalidMobile>"
  Then Click On Search
  And Verify Wrong Application Search Result
  And Clear All
  When Select Assign to all
  And Select Locality By Editor
  And Select Status Options
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
   | https://uat.digit.org/employee/language-selection| QAEE  | eGov@123  | City | blankpage.jpeg|1013-FSM-2021-09-06-000534|PB-PGR-2021-08-20-002211|7979797979|9869313101|
   
 @fsmEditorExplore
Scenario Outline: GRO complaint assign to LME
	Given Open new web url "<url>"
	When Select the language as English
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
  And Update Property "Commercial"
  And Select Property SubType "Hotel"
  And Enter Pincode Number "143003"
  And Select Locality Mohalla "Preet Nagar"
  Then Update Name of the Slum "Gangadhar Sahi"
  And Enter Street House and Landmark
  When Select Sanitation Type "Septic tank with soak pit"
  Then Enter Length Breadth
  And Select Vehicle Type "Tata - 407 - 3000 Ltrs"
  And Click On Update Application button
  #Then Click On Assign button

  
	#And Logout from eGov
		Examples: 
   | url |Username | Password  | City| file | ValidNumber| InvalidNumber| ValidMobile|InvalidMobile|
   | https://uat.digit.org/employee/language-selection| QAEE  | eGov@123  | City | blankpage.jpeg|1013-FSM-2021-09-06-000534|PB-PGR-2021-08-20-002211|7979797979|9869313101|
   