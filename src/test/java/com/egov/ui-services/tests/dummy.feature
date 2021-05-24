Feature: Dummy Feature

@dummyMobileBrowser
Scenario Outline: Dummy Scenario
    * def browserTestName = 'Dummy Scenario - @dummyMobileBrowser'
    * call read('../pages/driver.feature@initializeDriver')
    * call read('../pages/loginPage.feature@loginAsCitizen')
    * call read('../pages/loginPage.feature@naviagteToHomePage')

Examples:
| deviceConfigs |