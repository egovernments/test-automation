Feature: Dummy Feature

@dummyMobileBrowser
Scenario Outline: Dummy Scenario
    * def browserTestName = 'Dummy Scenario - @dummyMobileBrowser - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')

Examples:
| deviceConfigs |