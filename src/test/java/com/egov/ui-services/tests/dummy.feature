Feature: Dummy Feature

Background:
    * def scenarioStatus = 
    """
        {
            "status": "passed",
            "reason": ""
        }
    """
    * configure driver = deviceConfigs[0];
    * configure afterScenario = 
    """
        function(){
            if(browserstack == "yes" && karate.info.errorMessage){
                scenarioStatus.status = 'failed';
                scenarioStatus.reason = karate.info.errorMessage;
                driver.screenshot();
            }
            karate.call('../../ui-services/utils/browserstack.feature@updateScenarioStatus', scenarioStatus);
        }
    """

@dummyMobileBrowser
Scenario Outline: Dummy Scenario
    * def browserTestName = karate.info.scenarioName
    * print 'Scenario Name: ' + karate.info.scenarioName
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    # * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')

Examples:
| deviceConfigs |