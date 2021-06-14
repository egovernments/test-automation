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
Scenario Outline: Create Property and reject property Verification
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    #* call read('../../ui-services/pages/propertyTaxPage.feature@approveProperty')
   * call read('../../ui-services/pages/propertyTaxPage.feature@rejectPropertyVerification')
  
Examples:
| deviceConfigs |

@dummyMobileBrowser2
Scenario Outline: Create  Property as SuperUser
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser2 - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    #* call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    #* call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    #* call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
   # * call read('../../ui-services/pages/propertyTaxPage.feature@createPropertyAsSuperUser')
    * def appNumber = "PB-AC-2021-06-14-017173"
    #* call read('../../ui-services/pages/propertyTaxPage.feature@approveProperty')
   * call read('../../ui-services/pages/propertyTaxPage.feature@payPropertyTax')

Examples:
| deviceConfigs |

@dummyMobileBrowser3
Scenario Outline: Create property and reject property approval
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser3 - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@rejectPropertyApproval')
  
Examples:
| deviceConfigs |


