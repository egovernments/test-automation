Feature: Driver Related Feature

Background:
    * def javaUtils = Java.type('com.egov.utils.JavaUtils');
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def getDriverConfig = 
    """
        function(){
            if(browserstack == "yes"){
                var configResult = karate.call('../../ui-services/utils/driver.feature@createBrowserStackConfig');
                var browserstackConfig = configResult.browserstackConfig;
                return browserstackConfig;
            }else{
                var localConfig = deviceConfigs[__num];
                delete localConfig.run;
                return localConfig;
            }
        }
    """
    * def clickElement =
    """
        function(element){
            try{
            driver.waitFor(element)
            driver.click(element)
            }catch(err){
                throw new Error("Exception occured while clicking element "+element+"-->"+err)
            }
        }
    """

    * def sendKeys = 
    """
        function(element,keysToSend){
            try{
            driver.waitFor(element)
            driver.input(element,keysToSend)
             }catch(err){
                karate.log("Exception occured sending text to element "+str(element)+"-->"+err)
                throw new Error("Exception occured sending text to element "+str(element)+"-->"+err)
            }
        }
    """


    * def waitForPageToLoad =
    """
        function(){
            try{
                driver.waitUntil("document.readyState == 'complete'")
            }catch(err){
                throw new Error("Exception occurred while waiting for page to load -->"+err)

            }
        }
    """

    * def hoverMouseToElement =
    """
        function(element){
        try{
            driver.mouse().move(element)
    }catch(err){
            throw new Error("Exception occurred while hovering the mouse to element -->"+err)

        }
    }      
    """

    * def hoverMouseAndClickElement =
    """
        function(element){
        try{
            driver.mouse().move(element)
            driver.click(element)
    }catch(err){
            throw new Error("Exception occurred while hovering the mouse to element -->"+err)

        }
    }      
    """

    * def getAttribute =
    """
        function(element,attributeName){
            try{
                return driver.attribute(element,attributeName)
            }catch(err){
            throw new Error("Exception occurred while getting attribute "+str(attributeName)+"of element"+str(element)+"-->"+err)

        }
        }
    """

     * def softRefreshPage =
    """
        function(){
            try{
                return driver.refresh()
            }catch(err){
            throw new Error("Exception occurred while soft refreshing the page -->"+err)

        }
        }
    """  
    
     * def hardRefreshPage =
    """
        function(){
            try{
                return driver.reload()
            }catch(err){
            throw new Error("Exception occurred while hard refreshing the page -->"+err)

        }
        }
    """  
    * def digitCustomSelectFromDropdownContainingLocalization =
    """
        function(element,valueToSelect){
            try{
                driver.waitFor(element)
                driver.click(element)
                ele = "//span[@class='menu-class']//div[text()='"+valueToSelect+"']"
             // driver.waitFor(ele)
                driver.click(ele)
            }catch(err){
            throw new Error("Exception occurred while selecting value from dropdown -->"+err)
        }
        }
    """

     * def digitCustomSelectFromDropdown =
    """
        function(element,valueToSelect){
            try{
                driver.waitFor(element)
                driver.input(element,valueToSelect)
                ele = "//div[contains(@class,'autocomplete-dropdown')]//*[text()='"+valueToSelect+"']"
                driver.waitFor(ele)
                driver.click(ele)
                // driver.click("{div[class~='automcomplete-dropdown']} "+valueToSelect)
            }catch(err){
            throw new Error("Exception occurred while selecting value from dropdown -->"+err)
        }
        }
    """

     * def digitCustomSelectFromDropdownWithHover =
    """
        function(element,valueToSelect){
            try{
                try{
                driver.input(element,valueToSelect)
                karate.log("VALUE INPUTED")
                }catch(err){
                    throw new Error("Exception occurred while sending input to dropdown -->"+err)
                }
                try{
                ele = "//div[contains(@class,'autocomplete-dropdown')]//*[text()='"+valueToSelect+"']"
                driver.waitFor(ele)
                driver.click(ele)
                }catch(err){
                    throw new Error("Selecting value from the dropdown menu -->"+err)

                }
            }catch(err){
            throw new Error("Exception occurred while selecting value from dropdown -->"+err)
        }
        }
    """

    * def digitClickValueInSearchResults = 
    """
        function(valueToClick){
            try{
                ele = "//tr[contains(@Id,'MUIDataTableBodyRow')]//a[text()='"+valueToClick+"']"
                driver.click(ele)
            }catch(err){
                throw new Error("Exception occurred while clicking value in search results -->"+err)
            }

        }

    """
    * def digitCustomInputFile = 
    """
        function(element,fileToInput){
            try{
                karate.log("BEFORE FILE INPUTTTT")
               // driver.inputFile("#contained-button-file","file:src/test/java/com/screenshot.png")
               driver.inputFile(element,fileToInput)
                karate.log("AFTER FILE INPUTTTT")

            }catch(err){
                karate.log("EXCEPTION OCCURED IN FILE FILE INPUTTTT")
                throw new Error("Exception occurred while input file -->"+err)
            }

        }
        // function(element) {
        //     driver.waitFor(element).click()
            
        // }
    """
    * configure afterScenario = 
    """
        function() { if(karate.info.errorMessage) {driver.screenshot();}
            
        }
    """

   * def getElementText = 
    """
        function(element){
            try{
                driver.waitFor(element)
                return driver.text(element)
            }catch(err){
                throw new Error("Exception occurred while getting element text -->"+err)
            }

        }
    """

    * def sendTextToAllElements =
    """
        function(locater){
                elements = driver.locateAll("//input[@type='text']")
                karate.log("ELEMENTS ARE")
                karate.log(elements)
                for(e in elements){
                    karate.log("KEYSSS AREE")
                    karate.log(e)
                    karate.log("KEYSSS AREE")
                    karate.log(driver.text(e))
                    karate.log("TRYING TO INPUT NOW")
                    driver.input(e,"HELLO")
                } 
            
        }
    """

@initializeDriver
Scenario: Initialize Driver
    * def driverConfig = getDriverConfig()
    * remove driverConfig.run
	* configure driver = driverConfig
    * print 'Driver Config: ', driverConfig
    * driver envHost
    * def sessionId = driver.sessionId
    * driver.emulateDevice(375, 812, 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36')
    * if(browserstack == 'yes') javaUtils.writeToFile(fileName, sessionId)
    * driver.fullscreen()


@takeScreenshot
Scenario: Take screenshot
    * driver.screenshot()

@createBrowserStackConfig
Scenario: Create Browserstack Config
    * def deviceCapabilities = deviceConfigs[__num]
    * eval karate.remove('deviceCapabilities', '$.run')
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