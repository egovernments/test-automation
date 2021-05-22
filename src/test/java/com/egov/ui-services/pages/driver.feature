Feature: Driver Related Feature

Background:
    * def jsUtils = read('classpath:jsUtils.js')

@initializeDriver
Scenario: Initialize Driver
    * def deviceCapabilities = deviceConfigs[__num]
	* def driverUrl = 'https://' + browserstackUsername + ':' + browserstackKey + '@' + browserstackUrl + '/wd/hub'
	* eval commonCapabilities.build = commonCapabilities.build + currentEpochTime
	* eval desiredCapabilities = karate.merge(deviceCapabilities, commonCapabilities)
	* def driverType = (karate.match(desiredCapabilities.browserName, "#notnull").pass) ? desiredCapabilities.browserName : desiredCapabilities.browser + 'driver'
    * eval driverType = (karate.match(driverType, 'firefoxdriver').pass) ?  'geckodriver' : driverType
    * eval desiredCapabilities.name = (karate.match(desiredCapabilities.browserName, "#notnull").pass) ? desiredCapabilities.browserName : desiredCapabilities.browser
	* def driverSession = { desiredCapabilities: '#(desiredCapabilities)', capabilities: '#(desiredCapabilities)' }
	* def driverConfig = { type: '#(driverType)', webDriverSession: '#(driverSession)', start: false, webDriverUrl: '#(driverUrl)' }
	* configure driver = driverConfig
    * print 'Driver Config: ', driverConfig
    * driver.fullscreen()

@getCurrentEpochTime
Scenario: Get Current EPOCH Time
    * def currentEpochTime = getCurrentEpochTime()