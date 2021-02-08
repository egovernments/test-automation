# eGov Test Automation Framework
##### Table of Contents
* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Run Command Details](#run-command-details)
* [Configure Test Runner](#configure-test-runner)
* [Test Reporting](#test-reporting)
* [Test Coverage](#test-coverage)
* [Roadmap](#roadmap)


    
<!-- ABOUT THE PROJECT -->
## About The Project
eGov test automation framework majorly deals with various API services validation. It enables to test and validate back end services accross all active environments and as well as tenant ids.  
 
<!-- Built With -->
### Built With
 * [Java](https://www.java.com/en/)
 * [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
 * [Karate](https://github.com/intuit/karate)
 * [Cucumber](https://cucumber.io/docs/cucumber/api/)
 * [JUnit](https://junit.org/junit4/)
 
<!-- Getting Started --> 
## Getting Started
To start with this framework, some prerequisites has to be made, which are described below

<!-- Prerequisites --> 
### Prerequisites
To setup this framework two major softwares needs to installed into the system. The step by step setup guidline provided below 
 ###### On Windows
 * [JDK 8](https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html)
 * [maven 3.6.3](https://maven.apache.org/download.cgi)
###### On Mac
 * First install [HomeBrew](https://brew.sh/)
 * To install OpenJDK 8 with brew, execute `$ brew cask install adoptopenjdk8` on terminal
 * To install maven into the system, execute `$ brew install maven` on terminal

<!--Installation-->
### Installation
Upon installing the above-required software. Follow the below steps to confiure and start execution
* Open [git bash](https://git-scm.com/downloads) or any other terminal and execute `git clone https://github.com/egovernments/test-automation.git` to clone the project repository in the system
* Open command prompt or terminal and run `mvn clean test`, this will start execution on `QA` by default

## Run Command Details
 ###### On DEV
 *  `mvn clean test "-Dkarate.env=dev"`
 ###### On QA
 *  `mvn clean test "-Dkarate.env=qa"`
 ###### On UAT
 *  `mvn clean test "-Dkarate.env=uat"`

## Configure Test Runner
By default framework will execute all of the test features, to control this or to specify any particular test feature file follow the below steps
 * Open `EGovTest.java` from `src/test/java/com/egov/base` 
 * Specify the test case tag or service tag followed by `@` under `tags{}`. For example `@collectionServices`
 * Execute the run commands as mentioned
  
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
   * mdms-services

<!-- Roadmap -->
### Roadmap
Here are the next milestones.
* egf-services
