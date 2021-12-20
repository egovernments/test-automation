Feature: FSM Citizen Login to Verify FSM options
	
@ptfsm
Scenario Outline: Verify the FSM for residential using yaml file
	Given Open new web url "<url>"
	When Click on Apply Septic Tank Pit
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Execute tax payment form from "fsm_residential.yaml"
	#And Verify Application Number
	#And Logout from eGov
		Examples: 
   | url|mobile | pin  | 
   | https://uat.digit.org/digit-ui/citizen|9999999999  | 123456  | 

@ptfsm1
Scenario Outline: Verify the FSM for Institutional using yaml file
	Given Open new web url "<url>"
	When Select fsm Property tax
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Execute tax payment form from "fsm_institutional.yaml"
	#And Logout from eGov
		Examples: 
   | url|mobile | pin  | 
   | https://qa.digit.org/digit-ui/citizen/all-services|9999999999  | 123456  | 
   
@ptfsm1
Scenario Outline: Verify the FSM  using yaml file
	Given Open new web url "<url>"
	When Select fsm Property tax
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Execute tax payment form from "fsm_commerical.yaml"
	#And Logout from eGov
		Examples: 
   | url|mobile | pin  | 
   | https://qa.digit.org/digit-ui/citizen/all-services|9999999999  | 123456  | 
   
   
@ptfsm1
Scenario Outline: Verify the My Application login with mobile number
	Given Open new web url "<url>"
	When Select fsm Property tax
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Verify Next button is disabled in Property Type Page by default
	And Select Residential Property Type
	And Verify Residential Info Message
	#And Select Property Type as <propertytype>
	And Click Next Button
	And Navigate Back
	And Click Next Button
	And Select Independent house Sub Property Type
	#And Select Sub Property Type as <subpropertytype>
	And Click Next Button
	And Navigate Back
	Then Close App
	
	Examples: 
   | url                                               |mobile      | pin     | propertytype | subpropertytype   |
   | https://qa.digit.org/digit-ui/citizen/all-services|9999999999  | 123456  | Residential  | Independent house |
   
 @fsmCitizenRating
Scenario Outline: Verify the My Application login with mobile number
	Given Open new web url "<url>"
	When Click On Fsm My Application
	And Feed mobile number as "<mobile>"
	And Feed Pin code as "<pin>"
	And Click On View
	And Click on Rate Us
	And Select Ratings and Comment
	Then Click Submit button
	
	Examples: 
   | url                                               |mobile      | pin     | propertytype | subpropertytype   |
   | https://uat.digit.org/digit-ui/citizen|7979797979  | 123456  | Residential  | Independent house |
	  
 
	