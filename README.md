# eGov Test Automation Framework
##### Table of Contents
* [About the Project](#about-the-project)
  * [Technology Used](#technology-used)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Configurations](#configurations)
* [Run with Command Prompt](#run-with-command-prompt)
* [List Of Tags](#list-of-tags)
* [Test Reporting](#test-reporting)
* [Test Coverage](#test-coverage)
* [Upcoming Services](#upcoming-services)


    
<!-- ABOUT THE PROJECT -->
## About The Project
eGov test automation framework majorly deals with various API services validation. It enables to test and validate back end services accross all active environments and as well as tenant ids. For more details on framework architecture please refer the [documentation](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1028521985/Automation+Framework+Knowledge+Base)
 
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
To setup this framework two major softwares needs to be installed into the system. The step by step setup guidline provided below
 ###### On Windows
 * [JDK 8](https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html)
 * [maven 3.6.3](https://maven.apache.org/download.cgi)
###### On Mac
 * First install [HomeBrew](https://brew.sh/)
 * To install OpenJDK 8 with brew, execute `$ brew cask install adoptopenjdk8` on terminal
 * To install maven into the system, execute `$ brew install maven` on terminal

<!--Installation-->
### Installation
Upon installing the above-required software. Follow the below steps to configure and start execution
* Open [git bash](https://git-scm.com/downloads) or any other terminal and execute `git clone https://github.com/egovernments/test-automation.git` to clone the project repository in the system

<!--Configurations-->
### Configurations
  ###### Application Level 
  * Create role action mapping as per the requirement 
  * Create a new user as per the mapped role
  * Create another user for updating profile of existing user scenario
  * Use the above credentials in environment config file
  ###### Project Level 
  * Create the configuration file for parameters (like: host, cityCode, stateCode, user credentials etc.) as per the environments in any path of your local system as `.yaml` file. For ex:`/Users/admin/Desktop/config.yaml`
  * Create the environment config file in below format
  ```yaml
  host: hostUrl
stateCode: pb
cityCode: amritsar
# Super User credentials for login(need to create user manually)
superUser:
  userName: userName
  password: password
  type: EMPLOYEE
# Employee username and password to update an existing user's profile (need to create user manually)
employee:
  userName: userName
  password: password
  type: EMPLOYEE
  ```
  * Create multiple config files if execution is required for multiple environments and pass the respective file path while executing the run command
  
 
## Run with Command Prompt
It is possible to specify certain test tags and environment details from command prompt or terminal itself. Steps mentioned below.
 * Open command prompt or terminal on project folder
 * Execute `mvn clean test "-DconfigPath=/path/to/config/file.yaml" "-Dkarate.options=--tags <tag1>,<tag2> classpath:com/egov"`
 ###### For example  
 `mvn clean test "-DconfigPath=/Users/admin/eGovAuto/config.yaml" "-Dkarate.options=--tags @searchMdms,@accessControl classpath:com/egov"`
 
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
