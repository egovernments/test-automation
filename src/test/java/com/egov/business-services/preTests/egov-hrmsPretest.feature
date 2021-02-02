Feature: HRMS API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def createEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/create.json')
  * def searchEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/search.json')
  * def updateEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/update.json')
  * def updateDeactivatemployeeRequest = read('../../business-services/requestPayload/egov-hrms/deactivate.json')
  * configure headers = read('classpath:websCommonHeaders.js')



@successCreate
Scenario: hrms create success call

  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response
  And def Employees = hrmsResponseBody.Employees


@errorCreate
Scenario: hrms create success call

  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorAuthCreate
Scenario: hrms create success call

  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@successSearch
Scenario: hrms search success call

  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param codes = '#(code)'
  And request searchEmployeeRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@successSearchWithoutEmployeeCodes
Scenario: hrms search success call

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


@successMultiSearch
Scenario: hrms search success call

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



@errorSearch
Scenario: hrms search error call
  
  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param names = '#(name)'
  And request searchEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@errorAuthSearch
Scenario: hrms search error call
  
  * print searchEmployeeRequest
  Given url hrmsSearchUrl
  And param tenantId = '#(tenantId)' 
  And request searchEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@successUpdate
Scenario: hrms update success call

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorUpdate
Scenario: hrms update error call

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errornAuthUpdate
Scenario: hrms update error auth call

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@successUpdateDeactivate
Scenario: hrms update success deactivate call

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