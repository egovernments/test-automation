Feature: Create Property tax through new eGov UI and observe the API behaviour


@fsmDSOassign
Scenario Outline: DSO Assign Vehicle Number
	Given Open new web url "<url>"
	#When Select Create Property tax
	When Click On DSO Login
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Assign Vehicle
  And Click On Vehicle Number from dropdown
  Then Click On Assign button
Examples: 
   | url|mobile | pin  |
   |https://uat.digit.org/digit-ui/citizen|8919146216  | 123456  | 
   
@fsmDSOcpmplete
 Scenario Outline: DSO Complete Application Request
	Given Open new web url "<url>"
	#When Select Create Property tax
	When Click On DSO Login
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  And Click On Complete Request
  Then Click On Complete button
Examples: 
   | url|mobile | pin  |
   |https://uat.digit.org/digit-ui/citizen|8919146216  | 123456  | 