Feature: Business services - billing service demand calls

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def billingServiceDemandConstants = read('../../business-services/constants/billing-service-demand.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def createDemandRequest = read('../../business-services/requestPayload/billing-service-demand/create.json')
  * def searchDemandRequest = read('../../business-services/requestPayload/billing-service-demand/search.json')
  * def updateDemandRequest = read('../../business-services/requestPayload/billing-service-demand/update.json')
  
  * configure headers = read('classpath:websCommonHeaders.js')

@createEmployeeHrms
Scenario: Create Demand success Call
  * print createDemandRequest
  Given url createDemandUrl
  And request createDemandRequest
  When method post
  Then status 201
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response
  And def Demands = billingServiceDemandResponseBody.Demands
  And def demandId = Demands[0].id
  And def consumerCode = Demands[0].consumerCode

@errorInCreateEmployee
Scenario: Create Demand error Call
  * print createDemandRequest
  Given url createDemandUrl
  And request createDemandRequest
  When method post
  Then assert responseStatus == 400 || responseStatus == 403
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response

@errorCreateRemoveField
Scenario: reate Demand error Call by removing field
  * eval karate.remove('createDemandRequest', removeFieldPath)
  * print createDemandRequest
  Given url createDemandUrl 
  And request createDemandRequest
  When method post
  Then status 400
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response

@searchDemand
Scenario: Search Demand  Call
  * print searchDemandRequest
  * def searchDemandParams = 
  """
  {
    tenantId: '#(tenantId)',
    businessService: '#(businessService)',
    consumerCode: '#(consumerCode)',
    demandId: '#(demandId)'
  }
  """
  Given url searchDemandUrl
  And params searchDemandParams
  And request searchDemandRequest
  When method post
  And def searchDemandResponseStatus = responseStatus
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response

@searchDemandGenericParam
Scenario: Search Demand error Call
  * print searchDemandRequest
  Given url searchDemandUrl
  And params searchDemandParams
  And request searchDemandRequest
  When method post
  And def searchDemandResponseStatus = responseStatus
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response

@updateEmployeeHrms
Scenario: Update Demand success Call
  * eval updateDemandRequest.Demands = Demands
  * print updateDemandRequest
  Given url updateDemandUrl
  And request updateDemandRequest
  When method post
  Then status 201
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response
  And def Demands = billingServiceDemandResponseBody.Demands

@errorInUpdateEmployee
Scenario: Update Demand success Call
  * eval updateDemandRequest.Demands = Demands
  * print updateDemandRequest
  Given url updateDemandUrl
  And request updateDemandRequest
  When method post
  Then assert responseStatus == 400 || responseStatus == 403
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response
  And def Demands = billingServiceDemandResponseBody.Demands