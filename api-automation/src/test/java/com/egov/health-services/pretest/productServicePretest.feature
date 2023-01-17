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
      Scenario: hrms create employee error
            Given url createProductURL
            And request createProductRequest
            When method post
            Then status 400
            And def createProductResponseHeader = responseHeaders
            And def createProductResponseBody = response

      @createProductAuthorizationError
      Scenario: hrms create employee error authorization
            Given url createProductURL
            And request createProductRequest
            When method post
            Then status 403
            And def createProductResponseHeader = responseHeaders
            And def createProductResponseBody = response

      @searchEmployeeSuccessfully
      Scenario: hrms search employee successfully
            Given url searchProductURL
            And param codes = '#(code)'
            And request searchEmployeeRequest
            When method post
            Then status 200
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @searchEmployeeSuccessfullyWithoutEmployeeCodes
      Scenario: hrms search employee successfully without passing employee codes
            Given url hrmsSearchUrl
            And param tenantId = tenantId
            And request searchEmployeeRequest
            When method post
            Then status 200
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response
            * def employeeCode1 = hrmsResponseBody.Employees[0].code
            * def employeeCode2 = hrmsResponseBody.Employees[1].code

      @searchEmployeeSuccessfullyWithMultipleEmployeeCodes
      Scenario: hrms search employee successfully by passing multiple employee codes
            * def parameters =
                  """
                  {
                  tenantId: '#(tenantId)',
                  codes: '#(code)'
                  }
                  """
            Given url hrmsSearchUrl
            And params parameters
            And request searchEmployeeRequest
            When method post
            Then status 200
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @searchEmployeeError
      Scenario: hrms search employee error
            Given url hrmsSearchUrl
            And param names = '#(name)'
            And request searchEmployeeRequest
            When method post
            Then status 400
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @searchWithInvalidTenantId
      Scenario: Search employee with Invalid tenant id
            Given url hrmsSearchUrl
            And param tenantId = '#(tenantId)'
            And request searchEmployeeRequest
            When method post
            Then status 403
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @updateEmployeeSuccessfully
      Scenario: hrms update employee successfully
            * eval updateEmployeeRequest.Employees = Employees
            Given url hrmsUpdateUrl
            And request updateEmployeeRequest
            When method post
            Then status 202
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @updateEmployeeError
      Scenario: hrms update employee error
            * eval updateEmployeeRequest.Employees = Employees
            Given url hrmsUpdateUrl
            And request updateEmployeeRequest
            When method post
            Then status 400
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @updateEmployeeWithInvalidTenantId
      Scenario: Error in update employee for invalid tenant Id
            * eval updateEmployeeRequest.Employees = Employees
            Given url hrmsUpdateUrl
            And request updateEmployeeRequest
            When method post
            Then status 403
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response

      @deactivateEmployeeSuccessfully
      Scenario: hrms deactivate successfully
            * eval updateEmployeeRequest.Employees = Employees
            * eval updateEmployeeRequest.Employees[0].deactivationDetails = updateDeactivatemployeeRequest.deactivationDetails
            * eval updateEmployeeRequest.Employees[0].isActive = false
            * eval updateEmployeeRequest.Employees[0].reActivateEmployee = false
            Given url hrmsUpdateUrl
            And request updateEmployeeRequest
            When method post
            Then status 202
            And def hrmsResponseHeader = responseHeaders
            And def hrmsResponseBody = response