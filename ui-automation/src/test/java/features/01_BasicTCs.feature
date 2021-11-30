Feature: Create Property tax through eGov and observe the API behaviour 

Background: Initiate the eGov web page 
	Given Launch Browser

Scenario Outline: Verify the login with valid credentials.
	Given Open eGov web page
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  Then Verify user lands on HomePage
  And Go to Property Tax page
  And Fill in the property tax details with "<Locality>", "<Mobile>", "<Owner>", "<UniqPropId>", "<ExistPropId>", "<DoorNo>"
  And Logout and Close Application
   Examples: 
   | Username | Password  | City   	| Locality  				 | Mobile       | Owner   | UniqPropId  | ExistPropId  | DoorNo  |
   | EMPAUTO  | eGov@123  | Amritsar|Ajit Nagar - Area1  |  9856342312  |UserABC  |  7954       |1111  				 |  K7g     |

   
@egov
Scenario Outline: Create Property Tax from eGov
	Given Open eGov web page
	When Select the language as English
	Then Enter eGov username as "<Username>"
  And Enter eGov password as "<Password>"
  And Select eGov city field
  And Search for the expected city as "<City>"
  And Click on Continue to proceed further
  Then Verify user lands on HomePage
  And Go to Property Tax page
  And Click on Add new Property button
  And Proceed with Apply button
  And Provide Locality in Property address as "<Locality>"
  And Go to Next screen
  And Provide1 Property details as "Residential" at field "Property Usage Type"
  And Provide2 Property details as "Vacant Land" at field "Property Type"
  #And Go to Next screen
  #And Provide Owner details as "<Owner>", "<Mobile>", "<Guardian>", "<Category>"
  #And Go to Next screen
  #And Upload first document at "testfile.pdf"
  #And Upload second document at "testfile2.pdf"
  #And Upload third document at "testfile3.pdf"
  #And Upload fourth document at "testfile4.pdf"
  #And Go to Next screen
  #And Click on add Property
  #And Get the unique property ID
  #And Logout and Close Application
  
     Examples: 
   | Username | Password  | City   	| Locality  				 | Mobile       | Owner   | Guardian   | Category| location   | DoorNo  |
   | EMPAUTO  | eGov@123  | Amritsar|Cinema Road - Area1  |  9856342322  |Userxyz  |  Userxyz|None of the above| testfile.pdf|  K7g     |
   
#@egov
Scenario Outline: Verify the created property tax details from Search API
	Given Trigger POST api to get the eGov AuthToken
	And Trigger Search API and extract Username, Mobile Number and Guardian for verification with tenant as "pb.amritsar"
	
	Examples: 
   | Username | Password  | City   	| Locality  				 | Mobile       | Owner   | Guardian   | location   | DoorNo  |
   | EMPAUTO  | eGov@123  | Amritsar|Ajit Nagar - Area1  |  9856342312  |Userddd  |  Userbbbgrd|testfile.pdf|  K7g    |
   
@test
Scenario: Create Property Tax from eGov
	Given Run Step def test