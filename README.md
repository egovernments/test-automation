## DIGIT Test Automation Framework and Setup Guide
# Preface:
DIGIT, a REST API platform based out of microservices architecture.
# Role of Test Automation:
1. Robust test framework, functions as Platform independent test suite
2. Framework handles multi tenant by tuning only environment properties file changes
3. Dynamic test data creations on instant API calls
4. Reusability of Code, Features with data driven tests
5. Test suites catagirisation to utilise automation suite based on Platform test requirements - In-Progress
6. Ensure Environment specific test data cleanup post test suite complete - In-Progress

##### Table of Contents
* [Project Brief](#about-the-project)
* [Tools and Technologies Used](#technology-used)
* [Automation Framework Kick-off](#getting-started)
  * [Pre-requisites](#prerequisites)
  * [KARATE Framework, Source Code, GIT Installation](#installation)
  * [Configurations](#configurations)
* [Run with Command Prompt](#run-with-command-prompt)
* [List Of Tags](#list-of-tags)
* [Test Reporting](#test-reporting)
* [Test Coverage](#test-coverage)
* [Upcoming Services](#upcoming-services)

## Project Brief
eGov test automation framework plays a significant role in automating DIGIT workflows of Core, business and Municipal services. automation test suit solves the problem of validating workflows and functionalities of DIGIT at any given point of code changes. 

Automation suite with One click brings quick turnaround of Quality validations of DIGIT services and workflows without any manual Quality Engineering test efforts.

Automation suite also majorly deals with various API services validation. It enables to test and validate back end services accross all active environments and as well as tenant ids. 

Automation suite covers most key role in testing eGov configuration "KAFKA" architecture by validating producing and consuming real time Event TOPICS to and from KAFKA Server.

For more details on KARATE framework architecture 
please refer the [KARATE FRAMEWORK Knowldge Base](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1028521985/Automation+Framework+Knowledge+Base)
 
### Tools and Technologies Used
 * [Java](https://www.java.com/en/):      Java version(s): 7.0, 8.0
 * [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
 * [Karate](https://github.com/intuit/karate/tree/v0.9.6) : 0.9.6
 * [Gherkin](https://cucumber.io/docs/gherkin/reference/)
 * [Cucumber](https://cucumber.io/docs/cucumber/api/)
 BDD framework - Behavior Driven Development is a software development approach 
 
## Automation Framework Kick-Off
### Pre-requisites
 * Two Main Software Utilities Required:  JAVA and MAVEN

 The step by step setup guidline is provided below based on Operating system.
 ###### On Windows
 * [JAVA Installl/Configure]
 *(https://www.java.com/en/download/help/windows_manual_download.html)
 [JAVA PATH Setting]: (https://javatutorial.net/set-java-home-windows-10)

 * [maven 3.6.3]
 (https://maven.apache.org/download.cgi)
(https://maven.apache.org/install.html)
###### On Mac
 * [JAVA Installl/Configure] (https://www.java.com/en/download/help/mac_install.html)
 [JAVA PATH Setting]: (https://docs.oracle.com/javase/tutorial/essential/environment/paths.html)

 * [maven 3.6.3]
 (https://www.baeldung.com/install-maven-on-windows-linux-mac)

<!--Installation-->
# KARATE Framework, Source Code, GIT Install
Supported IDEs for Code/Test Runs: (https://github.com/intuit/karate/wiki/IDE-Support)

Visual Studio Setup: (https://visualstudio.microsoft.com/downloads/)
* GIT Installation:
 -Install GIT in your local operating system 
  (https://git-scm.com/downloads)
 (https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Create a Local Repository Path Working Directory:
Windows Example: C:\Users\Prakat-L089\Desktop\Projects\Code base\Phase 1.1\automation-phase1.1-ktn\test-automation

- Open Visual studio: Ctl+~ (To Open terminal) and schange path to Local Repository Path
- Perform Source Code Clone to Local Repository Path Working Directory using git clone
Command: to clone the project repository in the system
- git clone https://github.com/egovernments/test-automation.git 
- git pull origin karate-master

# Check List to ensure to start automation test Runs:
1. JAVA, MAVEN Path set
2. Visual Stidio, GIT installed : Not Installed paths
3. eGov automation code suite is full loaded with all "Core, business and Municipal" Services Feature, pretest, Tests, constant, yaml Files.
4. Create Environment Configuration Yaml files as per Test environment to pass while we run automation suit in any path of your loacl system.
 
 Environement configuartion file contains parameteres such as host, cityCode, stateCode, user credentials etc.
Ex:  1. C:\Users\Prakat-L089\Desktop\Projects\EnvFiles karate]qa.yaml
     2. C:\Users\Prakat-L089\Desktop\Projects\EnvFiles karate\uat.yaml

Ex: qa.yaml
Save below Yaml File template in a txt file (qa.yaml)
host: https://qa.digit.org/
stateCode: pb
cityCode: amritsar
#Super User credentials for login(need to create user manually)
superUser:
  userName: EMPAUTO
  password: eGov@123
  type: EMPLOYEE
#Employee username and password to update an existing user's profile (need to create user manually)
employee:
  userName: EMP-107-000878
  password: Password@2
  type: EMPLOYEE

Ex: uat.yaml
Save below Yaml File template in a txt file (qa.yaml)
host: https://uat.digit.org/
#productHost is not in use currently hence commented 
#productHost: https://mseva-uat.lgpunjab.gov.in/ 
stateCode: pg
cityCode: citya
#Super User credentials for login(need to create user manually)
superUser:
  userName: EMP111
  password: eGov@123
  type: EMPLOYEE
#Employee username and password to update an existing user's profile (need to create user manually)
employee:
  userName: EMP-1013-000262
  password: eGov@uat123
  type: EMPLOYEE
  
### You are set to Start to start Automation test runs now

##### Run with Command Prompt
NOTE:
1. Test cases are grouped by TAG names based on DIGIT Services
Ex: AccessControl service composed of N Test cases are tagged as @accessControl

##### Generic Command prompt to start test runs:
<Local Repository Path Working Directory>\\mvn clean test "-DconfigPath=<Environement configuartion file path>" "-Dkarate.options=--tags <@tagname1>" classpath:com/egov"

Ex: 
C:\Users\Prakat-L089\Desktop\Projects\Code base\Phase 1.1> mvn clean test "-DconfigPath=C:\\Users\\Prakat-L089\\Desktop\\Projects\\EnvFiles karate\\qa.yaml" "-Dkarate.options=--tags @egfMasterBankAccount classpath:com/egov"

Note: Multiple Services and associated Test cases can be run adding multiple tag names with same command format

Ex: 
<Local Repository Path Working Directory>\\mvn clean test "-DconfigPath=<Environement configuartion file path>" "-Dkarate.options=--tags <@tagname1,@tagname2,@tagname3,@tagname4" classpath:com/egov"

- Note: 
- @regression is a TAG name to run full set of Core, business, Municipal Services and assiciated Test cases as a suite.
 
##### Caution: Avoid running @regression to avoid system performence issues and data consumptions at eGov configuarations.

## List Of all Services Tags
The listed tags are available currently in the framework
| Tags          		      | Description   			         |        
| ------------- 		      |:-------------:			         |
| @reports      		      | Reports tests 			         | 
| @searchMdms   		      | Search mdms tests         | 
| @Searcher     		      | Searcher tests            |
| @location     		      | Location tests			         |
| @localization 		      | Loacalization tests		     |
| @userotp      		      | User OTP tests			         |
| @eGovUser				         | User profile update tests |
| @accessControl		      | Access control tests 		   |
| @hrms         		      | HRMS tests				            |
| @collectionServices 	 | Collecetion Service tests	|
| @billingServiceDemand | Billing Demand tests		    |
| @pdfservice           | PDF Service tests			      |
| @billingServiceBill   | Billing Service Bill tests|
| @idGenerate			        | ID generation tests		     |
| @egovWorkflowProcess  | Workflow tests			         |
| @fileStore			         | File store tests			       |
| @pgservices			        | PG Service tests			       | 

## Test Reporting
To determine the test results and analysis the test faliures test reporting is required. This framework can generate two type of test reports
 * Post execution framework will automatically generate `karate-summary.html` file which can be found under `./target/surefire-reports/`
 * A folder will automatically create under `./target/` folder along with timestamp which will contain `cucumber-html-reports` 
 
<!-- Test Coverage -->
## Test Coverage
The automated tests cover validations for following services.
* Test Coverage details
   * core-services
   * business-services
   
<!-- Upcoming Services -->
### Upcoming Services
Services to be automated.
* municipal-services
 
[Refer Details Product Requirements on Services] :
(https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/2098331/Product+requirements)

##### HAPPY Automation testing...
