Feature: MDMS data fetching

Background: 
	* def jsUtils = read('classpath:jsUtils.js')
		
Scenario: MDMS data fetching

	 * eval if(karate.get('tenantId') == 'pb') karate.set('mdmsRequestBody', karate.read('classpath:requestJson/mdmsRequestPB.json'))
	 * eval if(karate.get('tenantId') == 'uk') karate.set('mdmsRequestBody', karate.read('classpath:requestJson/mdmsRequestUK.json'))
	
	 * print mdmsRequestBody
	 * call read('classpath:com/egov/demo/pretests/mdmsDataPretest.feature')
	 * print '**************** MDMS response ******************************'
	 * print mdmsResponseBody
	 
	 * eval
		  """
		  if (karate.get('tenantId') == 'uk'){
			 karate.set('usageCategoryMajor', karate.jsonPath(mdmsResponseBody,"$..UsageCategoryMajor[?(@.name=='Mixed')].code")[0])
			 karate.set('occupancyType', karate.jsonPath(mdmsResponseBody,"$..OccupancyType[?(@.name=='Rented/ Leased')].code")[0])
			 karate.set('usageCategorySubMinor', karate.jsonPath(mdmsResponseBody,"$..UsageCategorySubMinor[2].code")[0])
			 karate.set('propertySubType', karate.jsonPath(mdmsResponseBody,"$..PropertySubType[?(@.name=='Flat / Part of the building')].code")[0])
			 karate.set('propertyType', karate.jsonPath(mdmsResponseBody,"$..PropertySubType[?(@.name=='Flat / Part of the building')].propertyType")[0])
			 karate.set('ownershipCategory', karate.jsonPath(mdmsResponseBody,"$..OwnerShipCategory[?(@.code=='INDIVIDUAL')].code")[0])
			 karate.set('subOwnershipCategory', karate.jsonPath(mdmsResponseBody,"$..SubOwnerShipCategory[?(@.name=='Single Owner')].code")[0])
			 
		  }
		  
		  else if (karate.get('tenantId') == 'pb'){
			 karate.set('usageCategoryMinor', karate.jsonPath(mdmsResponseBody,"$..UsageCategory[?(@.name=='Residential')].code")[0])
			 karate.set('usageCategoryMajor', karate.jsonPath(mdmsResponseBody,"$..UsageCategory[?(@.name=='NonResidential')].code")[0])
			 karate.set('occupancyType', karate.jsonPath(mdmsResponseBody,"$..OccupancyType[?(@.name=='Rented')].code")[0])
			 karate.set('usageCategory', karate.jsonPath(mdmsResponseBody,"$..UsageCategory[?(@.name=='AC Restaurant')].code")[0])
			 karate.set('propertyType', karate.jsonPath(mdmsResponseBody,"$..PropertyType[?(@.name=='Flat/Part of the building')].code")[0])
		  }
		  
		  """
	 * def ownershipCategory = karate.jsonPath(mdmsResponseBody,"$..OwnerShipCategory[?(@.name=='Single Owner')].code")[0]
	 