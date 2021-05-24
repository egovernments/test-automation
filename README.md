# DIGIT Test Automation Framework Setup guide
## Table of Contents
* [About the Project](#about-the-project)
  * [Technology Used](#technology-used)
  * [Dependencies Used](#dependencies-used)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Clone Project](#clone-project)
  * [Configurations](#configurations)
* [List Of Tags](#list-of-tags)
* [Execution](#execution)
* [Reporting](#reporting)


<!-- ABOUT THE PROJECT -->
## About The Project
DIGIT Test Automation framework majorly deals with various API services validation. It enables to test and validate back end services across all active environments and as well as tenant ids. For more details on framework architecture please refer the [documentation](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1028521985/Automation+Framework+Knowledge+Base). For guide on Kafka Producer Consumer approach, please refer to [documentation](https://digit-discuss.atlassian.net/wiki/spaces/DD/pages/1540587710/Kafka+Consumer+Producer+Approach)
 
<!-- Technology Used -->
## Technology Used
 * [Java](https://www.java.com/en/)
 * [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
 * [Karate](https://github.com/intuit/karate)
 * [Cucumber](https://cucumber.io/docs/cucumber/api/)
 * [JUnit](https://junit.org/junit4/)

## Dependencies Used
In this section we have listed down some of the major libraries which is being used by the test automation framework as a `maven dependency` that is defined in `pom.xml`. 
* `karate-core` : To provide core features of `karate`.
* `karate-junit4` : To facilitate `JUnit` testing this dependency is required.
* `karate-gatling` : To perform API Performance test. For more details on performance test with karate, checkout [here](https://intuit.github.io/karate/karate-gatling/)
* `karate-apache` : To make use of karate in `maven` project.
* `karate-netty` : To `mock` API calls locally. For more details please checkout [here](https://intuit.github.io/karate/karate-netty/) 
* `cucumber-jvm-parallel-plugin` : To facilitate `parallel execution`.
* `poi` and `poi-ooxml` : To work with the latest and older versions of `excel` file.
* `log4j-api` : An interface that handles logs.
* `allure-junit4` : To facilitate `Test Reports` along with `JUnit` runner.
* `allure-cucumber4-jvm` : To facilitate `Test Reports` along with `Cucumber JVM` and helps to log `feature` file steps into the test report. 

<!-- Getting Started --> 
## Getting Started
This framework requires below prerequisites to be covered

<!-- Prerequisites --> 
## Prerequisites
To set up this framework, two mandatory softwares need to be installed into the system. Follow below step by step setup guidelines.
 ### On Windows
 * [Download JDK 8](https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html)
 * [Download maven 3.6.3](https://maven.apache.org/download.cgi)
 * [JDK Installation Guide](https://docs.oracle.com/en/java/javase/11/install/installation-jdk-microsoft-windows-platforms.html#GUID-DAF345BA-B3E7-4CF2-B87A-B6662D691840)
 * [maven Installation Guide](https://maven.apache.org/install.html)
 * [Install Visual Studio Code](https://code.visualstudio.com/docs/setup/windows)
### On Mac
 * First install [HomeBrew](https://brew.sh/)
 * To install OpenJDK 8 with brew, execute `$ brew cask install adoptopenjdk8` on terminal
 * To install maven into the system, execute `$ brew install maven` on terminal
 * [Install Visual Studio Code](https://code.visualstudio.com/docs/setup/mac)
 
<!--Clone Project-->
## Clone Project
To clone the framework to your local, please follow the below step.
* Open [git bash](https://git-scm.com/downloads) or any other terminal and execute the below command to clone the project repository in the system
```
git clone https://github.com/egovernments/test-automation.git
```

<!--Configurations-->
## Configurations
  ### Application Level 
  * Create role action mapping as per the requirement 
  * Create a new user as per the mapped role
  ### Project Level 
   Environment configuration files needs to be created in `local` by following below steps.
   * Create environment specific files with `.yaml` extension anywhere in the local directory 
   * It is recommended to provide environment specific names to the files (like: `qa.yaml`, `uat.yaml`, `config.yaml` etc.) 
   * Please keep the environment specific data in the config file as per below format.  
   #### For example
   ```yaml
    host: https://qa.xxx.xxx/
    stateCode: pb
    cityCode: amritsar
# Super User credentials for login(need to create user manually)
superUser:
     userName: <username goes here>
     password: <password goes here>
     type: <user type goes here>
# Employee username and password to update an existing user's profile (need to create user manually)
employee:
     userName: <username goes here>
     password: <password goes here>
     type: <user type goes here>
# Citizen's username and password needed for Property End to End flow (need to create user manually)
citizen:
     userName: <username goes here>
     password: <password goes here>
     type: <user type goes here>
# Alternate Citizen's username and password needed for Transfer Ownership of Property (need to create user manually)
alternateCitizen:
     userName: <username goes here>
     password: <password goes here>
     type: <user type goes here>
# Counter Employee's username and password, required for multiple use (need to create user manually)
counterEmployeeUser:
     userName: <username goes here>
     password: <password goes here>
     type: <user type goes here>
 ```
 
<!--List Of Tags--> 
## List Of Tags
Please use the appropriate tags to execute tests based on the requirement.

### Individual service tags
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
| @propertyCalculator   | Property Calculator tests |

### Service Category Tags
| Tags          		      | Description   			                           |        
| ------------- 		      |:-------------:			                           |
| @core-services        | Runs all services under core services       |
| @business-services    | Runs all services under business services   |
| @municipal-services   | Runs all services under municipal services  |

### Test Category Tags
| Tags          		      | Description   			                                     |        
| ------------- 		      |:-------------:			                                     |
| @regression           | Runs all regression tests across all services         |
| @smoke                | Runs all smoke tests across all services (coming soon)|


<!--Execution-->  
## Execution
To start the test execution in `local`,  
 * Open command prompt or terminal 
 * Navigate to project folder and execute,
 ```
 mvn clean test "-DconfigPath= <path of the environment config. file>" "-Dkarate.options=--tags @<tag1,tag2> classpath:com/egov"
 ```
 ### For example 
 `mvn clean test "-DconfigPath= /User/apple/Documents/config.yaml" "-Dkarate.options=--tags @searchMdms,@eGovUser classpath:com/egov"`  

<!--Reporting-->
## Reporting
Follow below step to find location of reports generated post test execution to analyze the results.
  
* A folder with `timestamp` will be created under `./target/`. 
* Navigate to `./target/<timestamp>/cucumber-html-reports`
* Open `overview-features.html`
### A snapshot is attached for reference.
 <img width="1139" alt="Screenshot 2021-03-16 at 1 25 31 PM" src="https://user-images.githubusercontent.com/68421244/111275411-1f967780-865c-11eb-989b-abcf83d3e0df.png">
 
