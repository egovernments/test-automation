Feature: HRMS API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def createEmployeeRequest = read('../requestPayload/hrms/create.json')
  * def searchEmployeeRequest = read('../requestPayload/hrms/search.json')
  * def updateEmployeeRequest = read('../requestPayload/hrms/update.json')
  * def updateDeactivatemployeeRequest = read('../requestPayload/hrms/deactivate.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def expectedMessage1 = read('../constants/hrms.yaml')
  * def invalidTenantId = 'notenant'


@success_Create
Scenario: hrms_Create success call

  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@error_Create
Scenario: hrms_Create success call

  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@errorAuth_Create
Scenario: hrms_Create success call

  * print createEmployeeRequest
  Given url hrmsCreateUrl 
  And request createEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@success_Search
Scenario: hrms_Search success call

  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param codes = '#(code)'
  And request searchEmployeeRequest
  When method post
  Then status 200
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@success_MultiSearch
Scenario: hrms_Search success call

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



@error_Search
Scenario: hrms_Search error call
  
  * print searchEmployeeRequest
  Given url hrmsSearchUrl 
  And param names = '#(name)'
  And request searchEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response


@errorAuth_Search
Scenario: hrms_Search error call
  
  * print searchEmployeeRequest
  Given url hrmsSearchUrl
  And param tenantId = '#(tenantId)' 
  And request searchEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@success_Update
Scenario: hrms_update success call

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 202
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@error_Update
Scenario: hrms_update error call

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 400
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@error_UnAuth_Update
Scenario: hrms_update error call

  * eval updateEmployeeRequest.Employees = Employees
  * print updateEmployeeRequest
  Given url hrmsUpdateUrl 
  And request updateEmployeeRequest
  When method post
  Then status 403
  And def hrmsResponseHeader = responseHeaders
  And def hrmsResponseBody = response

@success_Update_Deactivate
Scenario: hrms_update success deactivate call

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