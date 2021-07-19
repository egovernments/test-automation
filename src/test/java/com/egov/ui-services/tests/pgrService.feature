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
        
@pgrServiceUIFlowForCitizen
Scenario Outline: Create Pgr Verification
    * def browserTestName = karate.info.scenarioName + ' - @pgrServiceUIFlow - '
    * call read('../../ui-services/utils/driver.feature@initializeDriver')
    * call read('../../ui-services/pages/loginPage.feature@loginAsCitizen')
    * call read('../../ui-services/pages/loginPage.feature@naviagteToHomePage')
    * call read('../../ui-services/pages/homePage.feature@clickComplaints')
    # Select Complaint Type
    * call read('../../ui-services/pages/homePage.feature@selectComplaintType')
    # Choose Complaints sub type
    * call read('../../ui-services/pages/homePage.feature@selectComplaintType')
    # Search Pincode
    * call read('../../ui-services/pages/homePage.feature@searchLocationPincode')
    # Search Pincode
    * call read('../../ui-services/pages/homePage.feature@searchLocationPincode')
    # Upload Complaint Photo
    #* call read('../../ui-services/pages/homePage.feature@updalodComplaintPhoto')
    # Providing additional information
    * call read('../../ui-services/pages/homePage.feature@additionalDetails')