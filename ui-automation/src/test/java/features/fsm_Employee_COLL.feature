Feature: FSM Citizen Login to Verify FSM options
	
@fsmCOLL
Scenario Outline: Payment by Collector
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
  Then Click Collect Payment
  And Click on Genrate Receipt
  Then Check Receipt number
  Examples: 
   | url |Username | Password  | City| file |
   | https://uat.digit.org/employee/language-selection|QACOLL  | eGov@123  | City | blankpage.jpeg|
 