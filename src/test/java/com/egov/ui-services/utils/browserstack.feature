Feature: Browserstack Fetaure

@updateScenarioStatus
Scenario: Update Scenario Status to Browserstack
    * def browserstackUpdateStatusRequest = 
    """
        {
            "status": "#(scenarioStatus.status)",
            "reason": "#(scenarioStatus.reason)"
        }
    """
    Given url 'https://api.browserstack.com/automate/sessions/' + scenarioStatus.browserstackSessionId + '.json'
    And header Authorization = call read('../../ui-services/utils/basic-auth.js') { username: '#(browserstackUsername)', password: '#(browserstackKey)' }
    And header Content-Type = 'application/json'
    And request browserstackUpdateStatusRequest
    When method put
    Then status 200