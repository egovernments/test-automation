Feature: mCollect1 E2E New Challan by Empolyee

@mCollect1
Scenario: New Challan by Empolyee
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
  And Click On PAY
  When Select Card and Enter Details
  Then Click Submit button
  Then Check Payment Receipt number
  And Employee Logout and Close
 
@mCollect1
Scenario: Employee Application Payment
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "S1"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on mCollect option
  And Click on Home Option Top
  When Click On Search mchallan
  Then Enter Challan Number
  And Enter Mobile Number "ValidMobile"
  And Click On Search
  And Check and Select Status "mcollectStatus1"
  Then Click on Challan Number
  And Download Receipt
  And Click on Home Option Top
  And Employee Logout and Close
  
  