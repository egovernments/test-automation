Feature: HCM Product API

      Background:
            * def tenantId = tenantId
            * def createProductRequest = read('../../health-services/requestPayload/product-service/create.json')
            * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

      @createProductSuccess
      Scenario: Create a product for a HCM campaign
            Given url createProductURL
            And request createProductRequest
            When method post
            Then status 202
            And def createProductResponseHeader = responseHeaders
            And def createProductResponseBody = response
            And def Product = createProductResponseBody.Product

      @createProductError
      Scenario: Create a product for a HCM campaign but with statuscode of 400
            Given url createProductURL
            And request createProductRequest
            When method post
            Then status 400
            And def createProductResponseHeader = responseHeaders
            And def createProductResponseBody = response

      @createProductAuthorizationError
      Scenario: Unauthorised user trying to create a product for the HCM campaign
            Given url createProductURL
            And request createProductRequest
            When method post
            Then status 403
            And def createProductResponseHeader = responseHeaders
            And def createProductResponseBody = response