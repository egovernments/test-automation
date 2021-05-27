Feature: Driver Related Feature

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def getDriverConfig = 
    """
        function(){
            if(browserstack == "yes"){
                var configResult = karate.call('../../ui-services/utils/driver.feature@createBrowserStackConfig');
                var browserstackConfig = configResult.browserstackConfig;
                return browserstackConfig;
            }else{
                return deviceConfig;
            }
        }
    """
    * def clickElement = 
    """
        function(element) {
            driver.waitFor(element).click()
            
        }
    """

@initializeDriver
Scenario: Initialize Driver
    * def driverConfig = getDriverConfig()
	* configure driver = driverConfig
    * print 'Driver Config: ', driverConfig
    * driver envHost
	* def browserstackSessionId = driver.sessionId
    * driver.fullscreen()

@takeScreenshot
Scenario: Take screenshot
    * driver.screenshot()

@createBrowserStackConfig
Scenario: Create Browserstack Config
    * def deviceCapabilities = deviceConfig
	* def driverUrl = 'https://' + browserstackUsername + ':' + browserstackKey + '@' + browserstackUrl + '/wd/hub'
    * eval commonCapabilities.build = (karate.match(typeof browserstackBuildName, 'undefined').pass) ? commonCapabilities.build + currentEpochTime : browserstackBuildName
    * def desiredCapabilities = karate.merge(deviceCapabilities, commonCapabilities)
	* def driverType = (karate.match(desiredCapabilities.browserName, "#notnull").pass) ? desiredCapabilities.browserName : desiredCapabilities.browser + 'driver'
    * eval driverType = (karate.match(driverType, 'firefoxdriver').pass) ?  'geckodriver' : driverType
    * eval desiredCapabilities.name = (karate.match(desiredCapabilities.browserName, "#notnull").pass) ? desiredCapabilities.browserName : desiredCapabilities.browser
    * eval desiredCapabilities.name = browserTestName + ' ' + desiredCapabilities.name
    * def capabilities = karate.merge(deviceCapabilities, commonCapabilities)
    * eval capabilities.name = (karate.match(capabilities.browserName, "#notnull").pass) ? capabilities.browserName : capabilities.browser
    * eval capabilities.name = browserTestName + ' ' + capabilities.name
    * def browserSession = { desiredCapabilities: '#(desiredCapabilities)', capabilities: '#(capabilities)' }
	* def browserstackConfig = { type: '#(driverType)', webDriverSession: '#(browserSession)', start: false, webDriverUrl: '#(driverUrl)' }

@getCurrentEpochTime
Scenario: Get Current EPOCH Time
    * def currentEpochTime = getCurrentEpochTime()