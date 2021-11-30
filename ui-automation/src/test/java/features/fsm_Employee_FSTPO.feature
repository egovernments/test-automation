Feature: FSM Citizen Login to Verify FSM options
	
@fsmFSTPO
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
  And Click Vehicle Log
  When Enter Vehicle In Time
  Then Click Submit button
  Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|QAFSTPO  | eGov@123  | City | blankpage.jpeg|
 