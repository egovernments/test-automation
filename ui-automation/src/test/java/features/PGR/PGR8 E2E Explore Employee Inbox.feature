Feature: PGR8 E2E Flow for CSR Employee Explore


@pgr8
Scenario: CSR Explore
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "CSR"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on compliant icon
  And Clear All
  When Enter Complaint Number 
  Then Click On Search
  And Verify Search Result
  And Clear Search
  When Enter Mobile Number "ValidMobile"
  Then Click On Search
  And Verify Search Result
  And Clear Search
  When Enter Complaint Number 
  When Enter Mobile Number "ValidMobile"
  Then Click On Search
  And Verify Search Result
  And Clear Search
  When Enter Wrong Complaint Number "InvalidNumber"
  Then Click On Search
  And Verify Wrong Search Result
  And Clear Search
  When Enter Wrong Mobile Number "InvalidMobile"
  Then Click On Search
  And Verify Wrong Search Result
  And Clear Search
  When Select Assign to all
  And Select Compliant Subtype
  And Select Locality
  And Check and Select Status
  And Click on New Complaint
  And Employee Logout and Close
 