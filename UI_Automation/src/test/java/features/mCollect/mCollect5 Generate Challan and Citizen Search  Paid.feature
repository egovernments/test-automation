Feature: mCollect5 E2E Flow via Employee Application Creation

@mCollect5
Scenario: Employee Application Creation
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "S1"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on mCollect option
  And Enter Mobile Number "ValidMobile"
  And Enter Consumer Name
  And Enter Door Number
  And Enter Street Name
  And Enter Building Number
  And Enter Pincode
  And Select Locality Mohalla "Mohalla"
  And Select Service Category "serviceCategory"
  And Select Service Type "serviceType"
  And Select From and To Date
  And Enter Tax
  And Enter Feild Fee
  Then Click Submit button
  Then Check Challan Number
  And Click On Print
  And Click on Home Option Top
  And Employee Logout and Close

  
@mCollect5
Scenario: Citizen Application Pay
  Given Open new web url "citizen"
	When Click On Search and Pay
	And Feed mobile number
	And Feed Pin code
  And Citizen Enter City
  And Choose Service Category "serviceType"
  Then Citizen Enter Challan Number
  And Enter Mobile Number "ValidMobile"
  Then Click On Search
  And Click On View Details
  And Click Make Payment
	And Click Pay button
	And Click On Master Card
	When Enter Card Details "cardnumber"
	Then Click On Pay Now button
	And Click On Submit
	Then Check Payment Receipt number
	And Download Reciept and Goto Homepage
	And Verify Citizen Home Page

  
  