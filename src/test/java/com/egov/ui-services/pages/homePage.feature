Feature: Home Page Feature

Background:
    * def homePage = read('../../ui-services/page-objects/homePage.yaml')
    * def hPO = homePage.objects
	# * def geoLocationScript = "window.navigator.geolocation.getCurrentPosition = function(success){ var position = {'coords' : {  'latitude': '18.975080',   'longitude': '72.825838' }  };  success(position);}"
    * def homePageData = homePage.data
   
	@navigateToPropertyTaxMobile
Scenario: Navigate To Property Tax - Mobile
    * clickElement(pTPO.leftHamburger)
	* clickElement(pTPO.propertyTaxFromLeftNav)
	
  @navigateToPropertyTaxDesktop
Scenario: Navigate To Property Tax - Desktop
    * clickElement(pTPO.leftHamburger)
	* clickElement(pTPO.propertyTaxFromLeftNav)

@clickComplaints
Scenario: Click Complaints link
	* clickElement(hPO.complaintsLink)