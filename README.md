# DIGIT Test Automation Framework Setup guide
##### Table of Contents
* [About the Project](#about-the-project)
  * [Technology Used](#technology-used)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Configurations](#configurations)
* [Execution](#execution)
  * [Configure Test Runner](#configure-test-runner)
  * [Run with Command Prompt](#run-with-command-prompt)
* [List Of Tags](#list-of-tags)
* [Test Reporting](#test-reporting)
* [Test Coverage](#test-coverage)
* [Upcoming Services](#upcoming-services)


    
<!-- ABOUT THE PROJECT -->
## About The Project
DIGIT Test Automation framework majorly deals with various API services validation. It enables to test and validate back end services across all active environments and as well as tenant ids. For more details on framework architecture please refer the [documentation](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1028521985/Automation+Framework+Knowledge+Base)
 
<!-- Technology Used -->
### Technology Used
 * [Java](https://www.java.com/en/)
 * [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
 * [Karate](https://github.com/intuit/karate)
 * [Cucumber](https://cucumber.io/docs/cucumber/api/)
 * [JUnit](https://junit.org/junit4/)
 
<!-- Getting Started --> 
## Getting Started
This framework required below prerequisites to be covered

<!-- Prerequisites --> 
### Prerequisites
To set up this framework two major software needs to be installed into the system. The step by step setup guideline provided below.
 ###### On Windows
 * [JDK 8](https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html)
 * [maven 3.6.3](https://maven.apache.org/download.cgi)
###### On Mac
 * First install [HomeBrew](https://brew.sh/)
 * To install OpenJDK 8 with brew, execute `$ brew cask install adoptopenjdk8` on terminal
 * To install maven into the system, execute `$ brew install maven` on terminal
 
Apart from JDK and maven `kubectl` configuration is required for `port forwarding`. Steps are mentioned below
 * [Install kubectl](https://gist.github.com/mrbobbytables/d9e5c7224dbba989cf0b8a30d7a231a4)
 * Configure kubectl for port forwarding

<!--Installation-->
### Installation
Upon installing the above-required software. Follow the below steps to configure and start execution
* Open [git bash](https://git-scm.com/downloads) or any other terminal and execute `git clone https://github.com/egovernments/test-automation.git` to clone the project repository in the system
* Open command prompt or terminal and run `mvn clean test`, this will start execution on `QA` by default

<!--Configurations-->
### Configurations
  ###### Application Level 
  * Create role action mapping as per the requirement 
  * Create a new user as per the mapped role
  ###### Project Level 
   Environment configuration files needs to be prepare in `local`, which is required for test execution. Please refer the points to setup below.
   * Create environment specific files with `.yaml` extension
   * It is recommended to provide environment specific names to the files (like: `qa.yaml`, `uat.yaml` etc.)
   * You can keep this file anywhere in the local system
   * Please refer the below details for initial setup and execution. Data can be change based upon the requirements.
   ###### For QA
   ```yaml
    host: https://qa.digit.org/
    stateCode: pb
    cityCode: amritsar
# Super User credentials for login(need to create user manually)
superUser:
    userName: EMPAUTO
    password: eGov@123
    type: EMPLOYEE
# Employee username and password to update an existing user's profile (need to create user manually)
employee:
    userName: EMP-107-000878
    password: Password@2
    type: EMPLOYEE
 ```
 ###### For UAT
   ```yaml
    host: https://uat.digit.org/
    stateCode: pg
    cityCode: citya
# Super User credentials for login(need to create user manually)
superUser:
  userName: EMP111
  password: eGov@123
  type: EMPLOYEE
# Employee username and password to update an existing user's profile (need to create user manually)
employee:
  userName: EMP-1013-000262
  password: eGov@uat123
  type: EMPLOYEE
 ```
  
  
## Execution
To start the test execution in `local` please refer the steps below. 
 * Open command prompt or terminal on project folder
 * Execute `mvn clean test "-DconfigPath= <path of the environment config. file>" "-Dkarate.options=--tags @<specify the test tag or tags> classpath:com/egov"`
 ###### For example 
 `mvn clean test "-DconfigPath= /User/apple/Documents/qa.yaml" "-Dkarate.options=--tags @searchMdms,@eGovUser classpath:com/egov"`  
 
## List Of Tags
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
