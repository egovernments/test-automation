# DIGIT Test Automation Framework Setup guide
##### Table of Contents
* [About the Project](#about-the-project)
  * [Technology Used](#technology-used)
  * [Dependencies Used](#dependencies-used)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Clone Project](#clone-project)
  * [Configurations](#configurations)
* [Execution](#execution)
* [List Of Tags](#list-of-tags)
* [Reporting](#reporting)
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

### Dependencies Used
In this section we have listed down some of the major libraries which is being used by the test automation framework as a `maven dependency`. These depencies can be found under `pom.xml`. 
* `karate-core` : This is responsible to provide core features of `karate`.
* `karate-junit4` : To facilate `JUnit` testing this dependency is required.
* `karate-gatling` : To perform API Performance test this dependency is used. For more details on performance test with karate checkout [here](https://intuit.github.io/karate/karate-gatling/)
* `karate-apache` : To make use of karate in `maven` project this dependency is required.
* `karate-netty` : It helps to `mock` API calls locally. For more details please checkout [here](https://intuit.github.io/karate/karate-netty/) 
* `cucumber-jvm-parallel-plugin` : To facilate `parallel execution` this dependency is required.
* `poi` and `poi-ooxml` : Used to work with the latest and older versions of `excel` file.
* `log4j-api` : Provide an interface which is required to implementers to create a logging implementation.
* `allure-junit4` : To facilate `Test Reports` along with `JUnit` runner this is required.
* `allure-cucumber4-jvm` : To facilate `Test Reports` along with `Cucumber JVM` this is required. This dependency helps to log `feature` file steps into the test report. 

<!-- Getting Started --> 
## Getting Started
This framework required below prerequisites to be covered

<!-- Prerequisites --> 
### Prerequisites
To set up this framework two major software needs to be installed into the system. The step by step setup guideline provided below.
 ###### On Windows
 * [Download JDK 8](https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html)
 * [Download maven 3.6.3](https://maven.apache.org/download.cgi)
 * [JDK Installation Guide](https://docs.oracle.com/en/java/javase/11/install/installation-jdk-microsoft-windows-platforms.html#GUID-DAF345BA-B3E7-4CF2-B87A-B6662D691840)
 * [maven Installation Guide](https://maven.apache.org/install.html)
###### On Mac
 * First install [HomeBrew](https://brew.sh/)
 * To install OpenJDK 8 with brew, execute `$ brew cask install adoptopenjdk8` on terminal
 * To install maven into the system, execute `$ brew install maven` on terminal
 
Apart from JDK and maven `kubectl` configuration is required for `port forwarding`. Steps are mentioned below
 * [Install kubectl on macOS](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)
 * [Install kubectl on windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
 * [Setup Guide](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1344798729/Kubectl+Installation+and+Setup+Guide)

<!--Clone Project-->
### Clone Project
To clone the framework in your local please follow the below step.
* Open [git bash](https://git-scm.com/downloads) or any other terminal and execute the below command to clone the project repository in the system
```
git clone https://github.com/egovernments/test-automation.git
```

<!--Configurations-->
### Configurations
  ###### Application Level 
  * Create role action mapping as per the requirement 
  * Create a new user as per the mapped role
  ###### Project Level 
   Environment configuration files needs to be prepare in `local`, which is required for test execution. Please refer the points to setup below.
   * Create environment specific files with `.yaml` extension
   * It is recommended to provide environment specific names to the files (like: `qa.yaml`, `uat.yaml`, `config.yaml` etc.) 
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
  
<!--Execution-->  
## Execution
To start the test execution in `local` please refer the steps below. 
 * Open command prompt or terminal on project folder
 * Execute `mvn clean test "-DconfigPath= <path of the environment config. file>" "-Dkarate.options=--tags @<specify the test tag or tags> classpath:com/egov"`
 ###### For example 
 `mvn clean test "-DconfigPath= /User/apple/Documents/config.yaml" "-Dkarate.options=--tags @searchMdms,@eGovUser classpath:com/egov"`  

<!--List Of Tags--> 
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

<!--Reporting-->
## Reporting
To determine the test results and analysis the test faliures test reporting is required. This framework can generate two type of test reports
 * Post execution framework will automatically generate `karate-summary.html` file which can be found under `./target/surefire-reports/`
 <img width="1272" alt="Screenshot 2021-03-16 at 1 24 00 PM" src="https://user-images.githubusercontent.com/68421244/111274649-42745c00-865b-11eb-8e7c-219687a2bb58.png">

 * A folder will automatically create under `./target/` folder along with timestamp which will contain `cucumber-html-reports` 
 <img width="1139" alt="Screenshot 2021-03-16 at 1 25 31 PM" src="https://user-images.githubusercontent.com/68421244/111275411-1f967780-865c-11eb-989b-abcf83d3e0df.png">
 

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
