Feature: Dummy Feature

Background:
    * def afterScenarioDriver = null
    * def scenarioStatus = 
    """
        {
            "status": "passed",
            "reason": ""
        }
    """
    * configure driver = deviceConfigs[0];
    * configure afterFeature = 
    """
        function(){
            karate.log('Scenario Name After Feature: ' + karate.info.scenarioName)
            if(browserstack == "yes" && karate.info.errorMessage){
                scenarioStatus.status = 'failed';
                scenarioStatus.reason = karate.info.errorMessage;
                afterScenarioDriver.screenshot();
            }
            karate.call('../../ui-services/utils/browserstack.feature@updateScenarioStatus', scenarioStatus);
        }
    """

@dummyMobileBrowser
Scenario Outline: Dummy Scenario
    * def deviceConfig = __row
    * def browserTestName = karate.info.scenarioName
    * print 'Scenario Name: ' + karate.info.scenarioName
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * eval afterScenarioDriver = karate.get('driver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')

Examples:
| deviceConfigs |