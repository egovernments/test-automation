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
 * [kafka REST Proxy - Coming soon](https://github.com/confluentinc/kafka-rest)

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

* [Jenkins Setup](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1620934657/Jenkins+Setup+Tutorial+for+Automation)
 
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
  * Disabled the resource creation rate limit for the environment where the automation scripts will be executed
  * Configure and deploy Kafka REST Proxy tool in the environment with other services. Kafka Cluster can be accessed through proxy API created by kafka REST Proxy.
  * Currently kafka related testcases will not run as we are waiting for the latest version of the tool to be releases officially.
   
  ### Project Level 
   Environment configuration files needs to be created in `local` by following below steps.
   * Create environment specific files with `.yaml` extension anywhere in the local directory 
   * It is recommended to provide environment specific names to the files (like: `qa.yaml`, `uat.yaml`, `config.yaml` etc.) 
   * Please keep the environment specific data in the config file as per below format.  
   #### For example
   ```yaml
    host: <Host URL goes here>
    # This parameter is used in authorization header
    basicAuthorization: <Basic Authorization Encoded String goes here>
    # This parameter will be removed once kafka rest proxy is accessible
    localhost: http://localhost:8082/
    # This parameter is used to mock kafka test cases until the kafka rest proxy 6.2 is released
    mockHost: https://e5a23525-a2d2-42d3-b518-2761de88655c.mock.pstmn.io/
    # This parameter is used to check the kafka offset movement threshold percentage
    kafkaOffsetThresholdPercentage: 75
    stateCode: pb
    cityCode: amritsar
    # Super User credentials for login(need to create user manually)
    superUser:
      userName: <username goes here>
      password: <password goes here>
      type: EMPLOYEE
    # Employee username and password to update an existing user's profile (need to create user manually)
    employee:
      userName: <username goes here>
      password: <password goes here>
      type: EMPLOYEE
    # Citizen's username and password needed for Property End to End flow (need to create user manually)
    citizen:
      userName: <username goes here>
      password: <password goes here>
      type: CITIZEN
    # Alternate Citizen's username and password needed for Transfer Ownership of Property (need to create user manually)
    alternateCitizen:
      userName: <username goes here>
      password: <password goes here>
      type: CITIZEN
    # Counter Employee's username and password, required for multiple use (need to create user manually)
    counterEmployeeUser:
      userName: <username goes here>
      password: EMPLOYEE
      type: <user type goes here>
    citizenArchitect:
      userName: <username goes here>
      password: <username goes here>
      type: CITIZEN
   ```
 
<!--List Of Tags--> 
## List Of Tags
Please use the appropriate tags to execute tests based on the requirement.

### Core services tags
| Tags          		              | Description   			             |        
| ------------- 		              |:-------------:			             | 
| @reports      		              | Reports tests 			             | 
| @url_Shorterning_Invalid      | Url Shortening                |
| @Searcher     		              | Searcher tests                |
| @location     		              | Location tests			             |
| @localization 		              | Loacalization tests		         |
| @userotp      		              | User OTP tests			             |
| @eGovUser				                 | User profile update tests     |
| @accessControl		              | Access control tests 		       |
| @mdmsService         		       | MDMS tests				                |
| @userAccountAfterLock 	       | User Account After Lock tests	|
| @zuul                         | Zuul tests		                  |
| @eGovPdf                      | PDF Service tests			          |
| @idGenerate			                | ID generation tests		         |
| @egovWorkflowBusniessService  | eGov Workflow tests			        |
| @fileStore			                 | File store tests			           |
| @pgservices			                | PG Service tests			           |
| @encService                   | Enc Service tests             |

### Business services tags
| Tags          		      | Description   			         |        
| ------------- 		      |:-------------:			         | 
| @apportionService     | Apportion tests 			       | 
| @dashboardAnalytics   | Dashboard Analytics tests	|
| @egfMaster 		         | EGF Master tests		        |
| @egfInstrument      		| EGF Instrument tests			   |
| @dashboardIngest				  | Dashboard Ingest tests    |
| @hrms         		      | HRMS tests				            |
| @collectionServices 	 | Collecetion Service tests	|
| @billingServiceDemand | Billing Demand tests		    |
| @billingServiceBill   | Billing Service tests|

### Municipal services tags
| Tags          		       | Description   			             |        
| ------------- 		       |:-------------:			             | 
| @propertyServices      | Property Tax tests 			        | 
| @bpaCalculator   		    | BPA Calculator tests          | 
| @bpaService     		     | BPA tests                     |
| @dcrService     		     | DCR tests			                  |
| @eGovUserEvent 		      | eGov User Event tests		       |
| @fireNOCBillingFeature | FireNOC Calculator tests			   |
| @fireNocService				    | FireNOC tests                 |
| @landService		         | Land Service tests 		         |
| @NOCService         		 | NOC Service tests				         |
| @PGRService 	          | PGR Service tests	            |
| @propertyCalculator    | Property Tax Calculator tests |
| @fsmService            | FSM Service tests			          |
| @fsmBillingSlab        | FSM Calculator tests          |

### Service Category Tags
| Tags          		     | Description   			                           |        
| ------------- 		     |:-------------:			                           |
| @coreServices        | Runs all services under core services       |
| @businessServices    | Runs all services under business services   |
| @municipalServices   | Runs all services under municipal services  |
| @e2eServices         | Runs all e2e service tests                  |

### Test Category Tags
| Tags          		      | Description   			                                     |        
| ------------- 		      |:-------------:			                                     |
| @regression           | Runs all regression tests across all services         |
| @smoke                | Runs all smoke tests across all services (coming soon)|

### E2E service tags
| Tags          		      | Description   			               |        
| ------------- 		      |:-------------:			               | 
| @propertyTaxEndToEnd  | Property Tax and mCollect tests | 
| @tradeLicenseEndToEnd | Trade License mdms tests        | 
| @wsEndToEnd     		    | Water and Sewerage tests        |
| @fsmEndToEnd     		   | FSM tests			                    |
| @pgrEndToEndFlow 		   | PGR tests		                     |
| @firenocEndToEnd      | FireNOC tests			                |
| @bpae2eservice				    | BPA tests                       |

### Kafka Service tags
| Tags                  | Description                                   |
| -------------         |:--------------:                               |
| @kafkaServices        | Runs all kafka releated services(coming soon) |


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
 

## RUN API TEST CASES
mvn clean install "-DconfigPath=/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/qa.yaml" "-Dtags=@coreServices"


## RUN UI TEST CASES

cd /Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/.vscode
mvn clean install "-DconfigPath=/Users/macbookair/moolya_egovernments/test-automation-egovernmetns/test-automation/qa.yaml" "-Dtags=@dummyMobileBrowser"
