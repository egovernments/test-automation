### DIGIT Test Automation Framework and Setup guidelines
#### Preface:
DIGIT, a REST API platform based out of microservices architecture.
#### Role of Test Automation:
1. Robust test framework, functions as platform independent test suite
2. Framework handles multi tenant by tuning only environment properties file changes
3. Dynamic test data creations on instant API calls
4. Reusability of code, features with data driven tests
5. Test suites catagirisation to utilise automation suite based on platform test requirements - In-progress
6. Ensure environment specific test data cleanup post test suite complete - In-progress

##### Table of Contents
###### * [Project Brief](#project-brief)
###### * [Tools and Technologies Used](#tools-and-technologies-used)
###### * [Automation Framework Kick Off](#automation-framework-kick-off)
- [Pre-requisites](#pre-requisites)
- [DIGIT automation code setup](#DIGITautomationcodesetup)
###### * [Check List to start automation test Runs](#CheckListtostartautomationtestRuns)
###### * [List of all service tags automated in the framework](#list-of-all-services-tags)
###### * [Automation Test Reporting](#test-reporting)
###### * [Test coverage](#test-coverage)

#### Project Brief
DIGIT Test automation framework plays a significant role in automating DIGIT workflows of Core, Business and Municipal services.
Automation test suite solves the problem of validating workflows and functionalities of DIGIT at any given point of code changes.

DIGIT Test Automation suite with one click brings quick turnaround of quality validations of DIGIT services and workflows without any manual quality engineering test efforts.

DIGIT Test Automation suite also majorly deals with various API services validation. 
it enables to test and validate back end services accross all active environments and as well as tenant ids. 

DIGIT Test Automation suite covers most key role in testing eGov configuration "KAFKA" architecture by validating producing and consuming real time event TOPICS to and from KAFKA Server.

For more details on KARATE framework architecture
please refer the [KARATE FRAMEWORK Knowldge Base](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1028521985/Automation+Framework+Knowledge+Base)

#### Technologies Used
-  [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
-  [Karate](https://github.com/intuit/karate/tree/v0.9.6) : version 0.9.6
-  [Gherkin](https://cucumber.io/docs/gherkin/reference/)
-  [Cucumber](https://cucumber.io/docs/cucumber/api/)
-  [Java](https://www.java.com/en/)

#### Automation Framework Kick-off
##### Pre-requisites
-  Two main software utilities required are : Jdk and Maven

 Step by step setup guidelines are provided below based on operating system.

-  [JDK](https://www.java.com/en/):     JDK version : 1.8
> Java and Maven Environment Path Setup : Windows
https://mkyong.com/maven/how-to-install-maven-in-windows/

 > Java and Maven Environment Path Setup : Mac
https://mkyong.com/java/how-to-set-java_home-environment-variable-on-mac-os-x/

- Maven 3.6.3 download and installation
> https://maven.apache.org/download.cgi
   https://maven.apache.org/install.html

#### DIGIT automation code setup
* [Supported IDEs for Code/Test Runs](https://github.com/intuit/karate/wiki/IDE-Support)
* [Visual Studio Setup](https://visualstudio.microsoft.com/downloads/)

 Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications.

* [Git Download](https://git-scm.com/downloads)
Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency

* [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (Install GIT in your local operating system)

 - Create a Local Repository Path Working Directory:
 Windows Example:  <Local Working Directory path>\test-automation

 - Open Visual studio: Ctl+~ (to open terminal)

    change path to  <Local Working Directory path>\test-automation

 - Perform source code clone to local repository path working directory using git clone

  - Clone the DIGIT automation project repository in the system

  `git clone https://github.com/egovernments/test-automation.git
  `
Navigate to test automation folder

   `cd test-automation`

 Check out your local branch, which created in GITHUB
  `git checkout <Your Branch>
  `

 Pull latest code from karate-master branch
  `git pull origin karate-master
  `
> **Note :** **karate-master** is main branch for DIGIT automation suite

#### Automation test execution from visual studio IDE terminal

1. DIGIT Test Automation Framework is covered with all Core, Business and Municipal services feature, pretest, tests, constant, yaml Files.
2. Create environment configuration yaml files at any given path of your local system, as per test environment of testing.

 Environment configuartion file contains parameters such as host, cityCode, stateCode, user credentials etc.

 Examples of environment files:
 1. <Local Working Directory path>karate/qa.yaml
 2. <Local Working Directory path>karate/uat.yaml

 * Create the configuration file for parameters (like: host, cityCode, stateCode, user credentials etc.) as per the environments in any path of your local system as .yaml file.

  For ex:`/Users/admin/Desktop/config.yaml`
  * Create the environment config file in below format
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
  * Create multiple config files if execution is required for multiple environments and pass the respective file path while executing the run command

3. Test suite runs, tags and DIGIT services

> **NOTE**: Test cases are grouped by TAG names based on DIGIT Services

Ex: AccessControl service feature file is composed set number of test cases and are tagged as `@accessControl`

 Refer below `List Of all services tags` for all available services

1. **Running indiviual service level feature test cases:**
  Below is the command format for running individual service specific test run.
```javascript
>mvn clean test "-DconfigPath=<Local Working Directory path>karate/qa.yaml" "-Dkarate.options=--tags <@tagname> classpath:com/egov"
```
Example: 
> mvn clean test "-DconfigPath=karate/qa.yaml" "-Dkarate.options=--tags @egfInstrument classpath:com/egov"

2. **Running multiple service level feature test cases at one shot:**
 Multiple Services categories are `@businessServices` (for running complete set of business-services test cases), `@coreServices` (for running complete set of core-services test cases)
Example:
> mvn clean test "-DconfigPath=karate/qa.yaml" "-Dkarate.options=--tags @egfInstrument,@localization classpath:com/egov"

3. **Running test category level feature test cases:**

 `@regression` (for running full set of test cases which are marked as regression) or `@smoke` (for running the set of test cases which are marked as smoke)

 Example:
  >mvn clean test "-DconfigPath=karate/qa.yaml" "-Dkarate.options=--tags @regression com/egov"
 or
>mvn clean test "-DconfigPath=karate/qa.yaml" "-Dkarate.options=--tags @smoke com/egov"

4. **Running kakfa consumer test cases through kakfa rest api proxy**

Kafka workflow:
https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1027407906/Consumer+and+Producer+Approach+Document

  * Configure kafka rest api proxy as part of other eGov services in the required environment
  * To run kafka consumer related test cases u can use `@kafkaServices` alone or along with other tags for execution

 **Note**:
  * Currently all the testcases are marked as `@regression`. So, this tag can be used alone for executing all the testcases

  * Test cases are yet to be tagged as `@smoke` (will be marked soon)

  * One or more tags associated with the above mentioned levels can be used separated by a comma in below format

   Example:
   >mvn clean test "-DconfigPath=karate/qa.yaml" "-Dkarate.options=--tags @kafkaServices com/egov"

#### List of all service tags automated in the framework
https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1284702657/Automation+Test+Tags
#### Automation Test Reporting
https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/1290371315/Automation+Test+Reporting

#### Test coverage

DIGIT Test Automation Framework cover validations of below services.
* Test Coverage details
   * Core-services
   * Business-services
   * Municipal-services

[Refer Details Product Requirements on Services](https://digit-discuss.atlassian.net/wiki/spaces/EPE/pages/2098331/Product+requirements)
