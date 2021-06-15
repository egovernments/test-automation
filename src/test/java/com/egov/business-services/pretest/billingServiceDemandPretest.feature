Feature: Business services - billing service demand calls

        Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def billingServiceDemandConstants = read('../../business-services/constants/billing-service-demand.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def createDemandRequest = read('../../business-services/requestPayload/billing-service-demand/create.json')
  * def searchDemandRequest = read('../../business-services/requestPayload/billing-service-demand/search.json')
  * def updateDemandRequest = read('../../business-services/requestPayload/billing-service-demand/update.json')
  
  * configure headers = read('classpath:websCommonHeaders.js')

        @createBillDemand
        Scenario: Create Demand success Call
            Given url createDemandUrl
            # * print createDemandRequest
              And request createDemandRequest
             When method post
             Then status 201
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response
              And def Demands = billingServiceDemandResponseBody.Demands
              And def demandId = Demands[0].id
              And def consumerCode = Demands[0].consumerCode

        @errorCreateBillDemand
        Scenario: Create Demand error Call
  
            Given url createDemandUrl
              And request createDemandRequest
             When method post
             Then status 400
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response

      @errorCreateBillDemandUnAuthorized
        Scenario: Create Demand error Call
  
            Given url createDemandUrl
              And request createDemandRequest
             When method post
             Then status 403
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response

        @errorCreateRemoveField
        Scenario: reate Demand error Call by removing field
  * eval karate.remove('createDemandRequest', removeFieldPath)
  
            Given url createDemandUrl
              And request createDemandRequest
             When method post
             Then status 400
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response

        @searchDemand
        Scenario: Search Demand  Call
  
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
  
            Given url searchDemandUrl
              And params searchDemandParams
              And request searchDemandRequest
             When method post
              And def searchDemandResponseStatus = responseStatus
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response
              And def demandId = billingServiceDemandResponseBody.Demands[0].id

        @updateDemand
        Scenario: Update Demand success Call
  * eval updateDemandRequest.Demands = Demands
  
            Given url updateDemandUrl
              And request updateDemandRequest
             When method post
             Then status 201
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response
              And def Demands = billingServiceDemandResponseBody.Demands

        @errorInUpdateDemand
        Scenario: Update Demand success Call
  * eval updateDemandRequest.Demands = Demands
  
            Given url updateDemandUrl
              And request updateDemandRequest
             When method post
             Then status 400
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response
              And def Demands = billingServiceDemandResponseBody.Demands

      @errorInUpdateDemandUnAuthorized
        Scenario: Update Demand success Call
  * eval updateDemandRequest.Demands = Demands
  
            Given url updateDemandUrl
              And request updateDemandRequest
             When method post
             Then status 403
              And def billingServiceDemandResponseHeader = responseHeaders
              And def billingServiceDemandResponseBody = response
              And def Demands = billingServiceDemandResponseBody.Demands