Feature: Dummy Feature

Background:
    * def scenarioStatus = 
    """
        {
            "status": "passed",
            "reason": ""
        }
    """
    * configure afterScenario = 
    """
        function(){
            if(browserstack == "yes" && karate.info.errorMessage){
                scenarioStatus.status = 'failed';
                scenarioStatus.reason = karate.info.errorMessage;
                driver.screenshot();
            }
            karate.call('../../ui-services/utils/browserstack.feature', scenarioStatus);
        }
    """
        
@dummyMobileBrowser
Scenario Outline: Dummy Scenario
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')


Examples:
| deviceConfigs |