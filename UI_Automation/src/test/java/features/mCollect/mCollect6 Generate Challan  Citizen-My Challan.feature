Feature: mCollect6 E2E Flow via Citizen Application Creation

@mCollect6
Scenario: Citizen Application Creation
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
  When Click On Search mchallan
  And Check and Select Status "mcollectStatus1"
  And Scroll till Search button
  And Check and Select Status "mcollectStatus2"
  And Scroll till Search button
  And Check and Select Status "mcollectStatus3"
  And Scroll till Search button
  And Employee Logout and Close
 
  
@mCollect6
Scenario: Citizen Application Pay
  Given Open new web url "citizen"
	When Click On My Challans
	And Feed mobile number
	And Feed Pin code
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

  
  