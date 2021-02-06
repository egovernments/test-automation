Feature: HRMS API call 

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def createEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/create.json')
  * def searchEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/search.json')
  * def updateEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/update.json')
  * def updateDeactivatemployeeRequest = read('../../business-services/requestPayload/egov-hrms/deactivate.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@createEmployeeHrms
Scenario: Create employee with valid details
  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response
  And def Employees = hrmsResponseBody.Employees

@errorInCreateEmployee
Scenario: Error in create employee for invalid details
  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorInTenantId
Scenario: Error in create employee for invalid tenantId
  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@searchEmployeeHrms
Scenario: Search employee with valid code
  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param codes = '#(code)'
  And request searchEmployeeRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@successSearchWithoutEmployeeCodes
Scenario: Search employee without code
  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param tenantId = tenantId
  And request searchEmployeeRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response
  * def employeeCode1 = hrmsResponseBody.Employees[0].code
  * def employeeCode2 = hrmsResponseBody.Employees[1].code

@searchEmployeeWithMultipleParams
Scenario: Search employee with multiple parameters

  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     codes: '#(code)'
    }
    """
  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And params parameters
  And request searchEmployeeRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorInSearchEmployee
Scenario: Error in search employee
  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param names = '#(name)'
  And request searchEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@searchWithInvalidTenantId
Scenario: Search employee with Invalid tenant id
  * print searchEmployeeRequest
  Given url hrmsSearchUrl
  And param tenantId = '#(tenantId)' 
  And request searchEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@updateEmployeeHrms
Scenario: Update employee
  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorInUpdateEmployee
Scenario: Error in update employee
  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@updateEmployeeWithInvalidTenantId
Scenario: Error in update employee for invalid tenant Id

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@deactiveEmployee
Scenario: Update an active employee to deactive
  * eval updateEmployeeRequest.Employees = Employees
  * eval updateEmployeeRequest.Employees[0].deactivationDetails = updateDeactivatemployeeRequest.deactivationDetails
  * eval updateEmployeeRequest.Employees[0].isActive = false
  * eval updateEmployeeRequest.Employees[0].reActivateEmployee = false
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response