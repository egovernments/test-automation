Feature: Trade License service pretests

Background:
    * def createTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/create.json')
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
    * def searchTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/search.json')
	* def tlDocuments = read('../../municipal-services/requestPayload/trade-license/documents.json')

@successCreateTradeLicense
Scenario: To create Trade License successfully
    Given url createTradeLicense
    And request createTradeLicenseRequest 
    When method post 
    Then status 200
    And def tradeLicenseResponseHeaders = responseHeaders 
    And def tradeLicenseResponseBody = response
    And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
    And def tradeLicenseId = tradeLicense.id
    And def tradeLicenseApplicationNumber = tradeLicense.applicationNumber
    And def tradeLicenseStatus = tradeLicense.status
    And def tradeLicenseFromDate = tradeLicense.validFrom
    And def tradeLicenseToDate = tradeLicense.validTo

@errorCreateTradeLicense
Scenario: Create Trade License with Error
    Given url createTradeLicense
    And request createTradeLicenseRequest
    When method post
	Then  status 400
    And def tradeLicenseResponseHeaders = responseHeaders
    And def tradeLicenseResponseBody = response

@errorCreateTradeLicenseUnAuthorized
Scenario: Create Trade License with Error
    Given url createTradeLicense
    And request createTradeLicenseRequest
    When method post
	Then  status 403
    And def tradeLicenseResponseHeaders = responseHeaders
    And def tradeLicenseResponseBody = response

@searchTradeLicenseSuccessfully
Scenario: Search a Trade License with Valid Parameters
	Given url searchTradeLicense
	And params searchTradeLicenseParams
	And request searchTradeLicenseRequest
	When method post
	Then status 200
	And def tradeLicenseResponseHeaders = responseHeaders
	And def tradeLicenseResponseBody = response
  And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
  And def tradeLicenseNumber = tradeLicense.connectionNo


@searchTradeLicenseError
Scenario: Search a Trade License with InValid Parameters
	Given url searchTradeLicense
	And params searchTradeLicenseParams
	And request searchTradeLicenseRequest
	When method post
	Then  status 400
	And def tradeLicenseResponseHeaders = responseHeaders
	And def tradeLicenseResponseBody = response

@searchTradeLicenseSuccessfullyWithInvalidData
Scenario: Search a Trade License with invalid data
	Given url searchTradeLicense
	And params searchTradeLicenseParams
	And request searchTradeLicenseRequest
	When method post
	Then status 200
	And def tradeLicenseResponseHeaders = responseHeaders
	And def tradeLicenseResponseBody = response


@updateTradeLicenseSuccessfully
Scenario: Update Trade License With Valid Data
	Given url updateTradeLicense
	And request updateTradeLicenseRequest
	When method post
	Then status 200
	And def tradeLicenseResponseHeaders = responseHeaders
	And def tradeLicenseResponseBody = response
  And def tradeLicense = tradeLicenseResponseBody.Licenses[0]
@updateTradeLicenseError
Scenario: Update Trade License With Invalid Data
	Given url updateTradeLicense
	And request updateTradeLicenseRequest
	When method post
	Then  status 400
	And def tradeLicenseResponseHeaders = responseHeaders
	And def tradeLicenseResponseBody = response

#citizen Login
@forwardTradeLicenseToDocumentVerifier
Scenario: Forward TL 

	* set tradeLicense.action = 'APPLY' 
    * set tradeLicense.status = 'INITIATED' 
    * set tradeLicense.wfDocuments = tlDocuments.wfDocuments
    * set tradeLicense.tradeLicenseDetail.applicationDocuments = tlDocuments.wfDocuments
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#DocVerifier Login
@forwardTradeLicenseToFieldInspector
Scenario: Forward TL 

	* set tradeLicense.action = 'FORWARD' 
    * set tradeLicense.status = 'APPLIED' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#FieldInspector Login
@forwardTradeLicenseToApprover
Scenario: Forward TL 

	* set tradeLicense.action = 'FORWARD' 
    * set tradeLicense.status = 'FIELDINSPECTION' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]


#Approver Login
@forwardTradeLicenseToPendingPayment
Scenario: Forward TL 

	* set tradeLicense.action = 'APPROVE' 
    * set tradeLicense.status = 'PENDINGAPPROVAL' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]
    And  def consumerCode = tradeLicenseResponseBody.Licenses[0].applicationNumber

#DocVerifier Login
@rejectDocVerifier
Scenario: Reject TL 

	* set tradeLicense.action = 'REJECT' 
    * set tradeLicense.status = 'APPLIED' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#FieldInspector Login
@rejectFieldInspector
Scenario: Reject TL 

	* set tradeLicense.action = 'REJECT' 
    * set tradeLicense.status = 'FIELDINSPECTION' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#Approver Login
@rejectApprover
Scenario: Reject TL 

	* set tradeLicense.action = 'REJECT' 
    * set tradeLicense.status = 'PENDINGAPPROVAL' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#FieldInspector Login
@sendBackToCitizen_FI
Scenario: Send Back to CITIZEN TL 

	* set tradeLicense.action = 'SENDBACKTOCITIZEN' 
    * set tradeLicense.status = 'FIELDINSPECTION' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#citizen Login
@citizenToDocumentVerifier
Scenario: Forward TL 

	* set tradeLicense.action = 'FORWARD' 
    * set tradeLicense.status = 'CITIZENACTIONREQUIRED' 
	* set tradeLicense.assignee = null
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#FieldInspector Login
@sendBackToDocVerifier_FI
Scenario: Send Back to DocVerifier from FI

	* set tradeLicense.action = 'SENDBACK' 
    * set tradeLicense.status = 'FIELDINSPECTION' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#Approver Login
@sendBackToFieldInspector_Approver
Scenario: Send Back to DocVerifier from FI

	* set tradeLicense.action = 'SENDBACK' 
    * set tradeLicense.status = 'PENDINGAPPROVAL' 
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]


#Approver Login
@cancel_Approver
Scenario: Cancel TL : Approver

	* set tradeLicense.action = 'CANCEL' 
    * set tradeLicense.status = 'APPROVED' 
	* set tradeLicense.wfDocuments = null
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#CounterEmployee Login
@submitForRenewal
Scenario: Submit for Renewal TL 

	* set tradeLicense.action = 'INITIATE' 
    * set tradeLicense.status = 'APPROVED' 
	* set tradeLicense.applicationType = 'RENEWAL' 
	* set tradeLicense.workflowCode = 'DIRECTRENEWAL' 
	* set tradeLicense.financialYear = '2020-21'
	* set tradeLicense.wfDocuments = null
	* set tradeLicense.calculation = null
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#CounterEmployee Login
@editForRenewal
Scenario: Edit for Renewal TL

	* set tradeLicense.action = 'INITIATE' 
    * set tradeLicense.status = 'APPROVED' 
	* set tradeLicense.applicationType = 'RENEWAL' 
	* set tradeLicense.workflowCode = 'EDITRENEWAL' 
	* set tradeLicense.financialYear = '2020-21'
	* set tradeLicense.wfDocuments = null
	* set tradeLicense.calculation = null
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]

#citizen Login
@forwardTradeLicenseToDocumentVerifierAfterEditing
Scenario: Forward TL 

	* set tradeLicense.action = 'APPLY' 
    * set tradeLicense.status = 'INITIATED' 
    * set tradeLicense.wfDocuments = null
    * def updateTradeLicenseRequest = read('../../municipal-services/requestPayload/trade-license/update.json')
	Given  url updateTradeLicense 
	And  request updateTradeLicenseRequest 
	When  method post 
	Then  status 200 
	And  def tradeLicenseResponseHeaders = responseHeaders 
	And  def tradeLicenseResponseBody = response 
    And  def tradeLicense = tradeLicenseResponseBody.Licenses[0]