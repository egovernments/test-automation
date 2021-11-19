Feature: FSM Citizen Login to Verify FSM options
	
@eefsm
Scenario Outline: Verify the FSM for residential using yaml file
	Given Open new web url "<url>"
	When Select Employee fsm
	And Go to FSM EE Home Page with "<empid>" and "<password>" and "<city>"
	#And Logout from eGov
		Examples: 
   | url|empid | password  | city|
   | https://uat.digit.org/employee/language-selection|UATEC  | eGov@123  | City A|
 
@CEfsm
Scenario Outline: Employee Editor Create Application
	Given Open new web url "<url>"
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  And Click on FSM
  And Click on New Application
  And Select Application Channel
  And Enter Application Name
  And Enter Mobile Number
  And Select Property
  And Select Property SubType
  And Enter Pincode Number
  And Select Locality Mohalla
  And Enter Street House and Landmark
  When Select Sanitation Type
  Then Enter Length Breadth and Depth
  And Select Vehicle Type
  And Click Submit Application button
  Then Check Application Number
  Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|QACE  | eGov@123  | City | blankpage.jpeg|
   
   
 @fsmFinalStatus
Scenario Outline: Emp Editor Check Final Status
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
  When Enter Application Number
  Then Click On Search
Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|QACE  | eGov@123  | City | blankpage.jpeg|
  
 