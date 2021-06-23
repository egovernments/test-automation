Feature: Dummy Feature

Background:
    * def fileName = 'sessionId.txt'
    * def javaUtils = Java.type('com.egov.utils.JavaUtils')
    * def deleteFile = javaUtils.deleteFile(fileName)
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
            if(karate.info.errorMessage){
                scenarioStatus.status = 'failed';
                scenarioStatus.reason = karate.info.errorMessage;
            }else{
                scenarioStatus.status = 'passed';
                scenarioStatus.reason = '';
            }
            if(browserstack == 'yes'){
                var browserstackSessionId = javaUtils.readFromFile(fileName);
                scenarioStatus.browserstackSessionId = browserstackSessionId;
                if(browserstackSessionId != ''){
                    var deleteFile = javaUtils.deleteFile(fileName);
                    karate.call('../../ui-services/utils/browserstack.feature@updateScenarioStatus', scenarioStatus);
                }
            }
        }
    """

@dummyMobileBrowser
Scenario Outline: Login Scenario
    * def browserTestName = karate.info.scenarioName + ' - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')

Examples:
| deviceConfigs |