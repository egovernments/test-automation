Feature: Dummy Feature

Background:
    * def scenarioStatus = 
    """
        {
            "sessionId": "",
            "status": "passed",
            "reason": ""
        }
    """
    * configure afterScenario = 
    """
        function(){
            karate.log('Scenario Name After Feature: ' + karate.info.scenarioName)
            if(browserstack == "yes" && karate.info.errorMessage){
                scenarioStatus[__num].status = 'failed';
                scenarioStatus[__num].reason = karate.info.errorMessage;
            }
            karate.log(scenarioStatus);
            // karate.call('../../ui-services/utils/browserstack.feature@updateScenarioStatus', scenarioStatus);
        }
    """

@dummyMobileBrowser
Scenario Outline: Dummy Scenario
    * def browserTestName = karate.info.scenarioName
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')

Examples:
| deviceConfig      |
| deviceConfigs[0]  |
| deviceConfigs[1]  |
| deviceConfigs[2]  |
| deviceConfigs[3]  |
| deviceConfigs[4]  |
| deviceConfigs[5]  |
| deviceConfigs[6]  |