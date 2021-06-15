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
        
@approvePropertyUIFlow
Scenario Outline: Create Property and approve property Verification
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser - '
# Scenario Outline: Login Scenario
#     * def browserTestName = karate.info.scenarioName + ' - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * def appNumber = ""
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@approveProperty')
    Examples:
    | deviceConfigs      |
    | deviceConfigs[0]  |
    | deviceConfigs[1]  |
    | deviceConfigs[2]  |
    | deviceConfigs[3]  |
    | deviceConfigs[4]  |
    | deviceConfigs[5]  |
    | deviceConfigs[6]  |

@rejectPropertyFromDocVerifierUIFlow
Scenario Outline: Create Property and reject property Verification From Doc Verifer
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser - '
# Scenario Outline: Login Scenario
#     * def browserTestName = karate.info.scenarioName + ' - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * def appNumber = ""
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@rejectPropertyDocVerification')
    Examples:
    | deviceConfigs      |
    # | deviceConfigs[0]  |
    # | deviceConfigs[1]  |
    # | deviceConfigs[2]  |
    # | deviceConfigs[3]  |
    # | deviceConfigs[4]  |
    # | deviceConfigs[5]  |
    # | deviceConfigs[6]  |

@rejectPropertyFromApproverUIFlow
Scenario Outline: Create Property and reject property Verification From Doc Verifer
    * def browserTestName = karate.info.scenarioName + ' - @rejectPropertyFromApproverUIFlow - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * def appNumber = ""
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@approvePropertyFromDocVerifier')
    * call read('../../ui-services/pages/propertyTaxPage.feature@approvePropertyFromFieldInspector')
    * call read('../../ui-services/pages/propertyTaxPage.feature@rejectPropertyFromApprover')
    Examples:
    | deviceConfigs      |
    # | deviceConfigs[0]  |
    # | deviceConfigs[1]  |
    # | deviceConfigs[2]  |
    # | deviceConfigs[3]  |
    # | deviceConfigs[4]  |
    # | deviceConfigs[5]  |
    # | deviceConfigs[6]  |

@sendBackToCitizenFromDocVerifierUIFlow
Scenario Outline: Create Property and reject property Verification From Doc Verifer
    * def browserTestName = karate.info.scenarioName + ' - @sendBackToCitizenFromDocVerifierUIFlow - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen') 
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@sendBackToCitizenFromDocVerifier')
    Examples:
    | deviceConfigs      |

    














@dummyMobileBrowser
Scenario Outline: Create Property and reject property from Field Insecptor
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser - '
# Scenario Outline: Login Scenario
#     * def browserTestName = karate.info.scenarioName + ' - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/propertyTaxPage.feature@createProperty')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@approveProperty')
 #  * call read('../../ui-services/pages/propertyTaxPage.feature@rejectPropertyVerification')
  
Examples:
| deviceConfig      |
| deviceConfigs[0]  |
| deviceConfigs[1]  |
| deviceConfigs[2]  |
| deviceConfigs[3]  |
| deviceConfigs[4]  |
| deviceConfigs[5]  |
| deviceConfigs[6]  |

@dummyMobileBrowser2
Scenario Outline: Create  Property as SuperUser
    * def browserTestName = karate.info.scenarioName + ' - @dummyMobileBrowser2 - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    #* call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    #* call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/loginPage.feature@loginAsSuperUser')
    * call read('../../ui-services/pages/propertyTaxPage.feature@createPropertyAsSuperUser')
    #* call read('../../ui-services/pages/propertyTaxPage.feature@approveProperty')
    #* call read('../../ui-services/pages/propertyTaxPage.feature@payPropertyTax')
Examples:
| deviceConfigs     |
# | deviceConfigs[0]  |
# | deviceConfigs[1]  |
# | deviceConfigs[2]  |
# | deviceConfigs[3]  |
# | deviceConfigs[4]  |
# | deviceConfigs[5]  |
# | deviceConfigs[6]  |

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
| deviceConfigs      |
# | deviceConfigs[0]  |
# | deviceConfigs[1]  |
# | deviceConfigs[2]  |
# | deviceConfigs[3]  |
# | deviceConfigs[4]  |
# | deviceConfigs[5]  |
# | deviceConfigs[6]  |


