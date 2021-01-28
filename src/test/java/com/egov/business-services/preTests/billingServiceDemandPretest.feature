Feature: Business services - billing service demand calls

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def billingServiceDemandConstants = read('../constants/billing-service-demand.yaml')
  * def commonConstants = read('../constants/commonConstants.yaml')
  * def createDemandRequest = read('../requestPayload/billing-service-demand/create.json')
  # commenting as this will be added later
  # * def updateDemandRequest = read('../requestPayload/billing-service-demand/update.json')
  # * def searchDemandRequest = read('../requestPayload/billing-service-demand/search.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@successCreate
Scenario: Create Demand success Call
  * print createDemandRequest
  Given url createDemandUrl
  And request createDemandRequest
  When method post
  Then status 201
  And def billingServiceDemandResponseHeader = responseHeaders
  And def billingServiceDemandResponseBody = response

@errorCreate
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