Feature: BPA-Service pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def createBPARequest = read('../../municipal-services/requestPayload/bpa-services/create.json')
        * def createBPARequestHighEnd = read('../../municipal-services/requestPayload/bpa-services/create2.json')
        * def searchBPARequest = read('../../municipal-services/requestPayload/bpa-services/search.json')
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        * def bpaDocument = read('../../municipal-services/requestPayload/bpa-services/documents.json')
        * def testData = '../../common-services/testData/scrunity.dxf'
        * def testData2 = '../../common-services/testData/High_Accepted_STAIR_NEW_system_scrutinized.dxf'
        * def createBPAStakeholderRequest = read('../../municipal-services/requestPayload/bpa-services/createBPAStakeholder.json')
        * configure ssl = false

    @createBPASuccessfully
    Scenario: Create BPA successfully
        * print mobileNumber
        Given url createBPA
        And request createBPARequest
        * print "BPA REQUEST IS"
        * print createBPARequest
        When method post
        Then status 200
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response
        And def applicationNo = bpaResponseBody.BPA[0].applicationNo
        And def edcrNumber = bpaResponseBody.BPA[0].edcrNumber
        And def BPA = bpaResponseBody.BPA[0]
        And def businessService = bpaResponseBody.BPA[0].businessService
        And def id = bpaResponseBody.BPA[0].id
        And def riskType = bpaResponseBody.BPA[0].riskType
        And def ownershipCategory = bpaResponseBody.BPA[0].landInfo.ownershipCategory
        And def mobileNumber = bpaResponseBody.BPA[0].landInfo.owners[0].mobileNumber
        And def gender = bpaResponseBody.BPA[0].landInfo.owners[0].gender
        
   @createBPASuccessfullyForHighEnd
    Scenario: Create BPA successfully
        * print mobileNumber
        Given url createBPA
        And request createBPARequestHighEnd
        When method post
        Then status 200
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response
        And def applicationNo = bpaResponseBody.BPA[0].applicationNo
        And def edcrNumber = bpaResponseBody.BPA[0].edcrNumber
        And def BPA = bpaResponseBody.BPA[0]
        And def businessService = bpaResponseBody.BPA[0].businessService
        And def id = bpaResponseBody.BPA[0].id
        And def riskType = bpaResponseBody.BPA[0].riskType
        And def ownershipCategory = bpaResponseBody.BPA[0].landInfo.ownershipCategory
        And def mobileNumber = bpaResponseBody.BPA[0].landInfo.owners[0].mobileNumber
        And def gender = bpaResponseBody.BPA[0].landInfo.owners[0].gender
    @createBPAError
    Scenario: Create BPA Error
        Given url createBPA
        And request createBPARequest
        When method post
        Then assert responseStatus >= 400 && responseStatus <= 403
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response

    @createBPAError2
    Scenario: Create BPA Error
        Given url createBPA
        And request createBPARequest
        When method post
        Then status 400
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response
        * print bpaResponseBody

    @scrunity
    Scenario: Scrunity
        * def edcrRequest =
            """
            {
            transactionNumber: "#(transactionNumber)",
            tenantId: "#(tenantId)",
            RequestInfo: {
            userInfo: {
            id: "#(id)",
            tenantId: "#(tenantId)"
            }
            },
            applicantName: "#(applicantName)",
            appliactionType: "#(appliactionType)",
            applicationSubType :"#(applicationSubType)"
            }
            """
        * print "ECDR REQUST"
        * print edcrRequest
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        * print createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = "multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ"
        And multipart file planFile = {read: '#(testData)' , filename: 'scrunity.dxf', contentType: 'application/dxf'}
        * print testData
        And param edcrRequest = edcrRequest
        When method post
        Then status 200
        And def scrunityResponseBody = response
        * def edcrNumber = scrunityResponseBody.edcrDetail[0].edcrNumber
        * print "EDCR NUMBER"
        * print edcrNumber

    @scrunityHighEnd
    Scenario: Scrunity
        * def edcrRequest =
            """
            {
            transactionNumber: "#(transactionNumber2)",
            tenantId: "#(tenantId)",
            RequestInfo: {
            userInfo: {
            id: "#(id)",
            tenantId: "#(tenantId)"
            }
            },
            applicantName: "#(applicantName)",
            appliactionType: "#(appliactionType)",
            applicationSubType :"#(applicationSubType)"
            }
            """
        * print edcrRequest
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = "multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ"
        And multipart file planFile = {read: '#(testData2)' , filename: 'High_Accepted_STAIR_NEW_system_scrutinized.dxf', contentType: 'application/dxf'}
        * print testData
        And param edcrRequest = edcrRequest
        When method post
        Then status 200
        And def scrunityResponseBody2 = response
        * def edcrNumber2 = scrunityResponseBody2.edcrDetail[0].edcrNumber

    @scrunityOCDR
    Scenario: Scrunity for Occupany Certificate
        * def edcrRequest =
            """
            {
            transactionNumber: "#(transactionNumber)",
            tenantId: "#(tenantId)",
            RequestInfo: {
            userInfo: {
            id: "#(id)",
            tenantId: "#(tenantId)"
            }
            },
            applicantName: "#(applicantName)",
            appliactionType: "#(appliactionType)",
            applicationSubType :"#(applicationSubType)"
            }
            """
        * print edcrRequest
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = "multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ"
        And multipart file planFile = {read: '#(testData)' , filename: 'scrunity.dxf', contentType: 'application/dxf'}
        * print testData
        And param edcrRequest = edcrRequest
        When method post
        Then status 200
        * print "SCRUTIY OCDR"
        * print response
        And def scrunityResponseBody = response
        * def ocdcrNumber = scrunityResponseBody.edcrDetail[0].edcrNumber


    @searchBPASuccessfully
    Scenario: Search BPA Successfully

        Given url searchBPA
        And params getBPASearchParam
        And request searchBPARequest
        When method post
        Then status 200
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response
        * print bpaResponseBody

    @searchBPAError
    Scenario: Search BPA Error

        Given url searchBPA + "?tenantId=" + tenantId + "&fromDate=null"
        And request searchBPARequest
        When method post
        Then status 400
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response

    @searchBPAUnauthorizedError
    Scenario: Search BPA Error
        Given url searchBPA
        And params getBPASearchParam
        And request searchBPARequest
        When method post
        Then status 403
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response


    @sendToCitizen
    Scenario: Send to CITIZEN

        * set BPA.workflow.action = 'SEND_TO_CITIZEN'
        * set BPA.status = 'INITIATED'
        * set BPA.documents = bpaDocument.bpaDocuments
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        Given  url updateBPA
        And  request updateBPARequest
        When  method post
        Then  status 200
        And  def bpaResponseHeaders = responseHeaders
        And  def bpaResponseBody = response
        And  def BPA = bpaResponseBody.BPA[0]
        And  def applicationNo = bpaResponseBody.BPA[0].applicationNo

    @sendToCitizen_Invalid
    Scenario: Send to CITIZEN Invalid

        * set BPA.workflow.action = action
        * set BPA.status = status
        * set BPA.tenantId = tenantId
        * set BPA.applicationNo = applicationNo
        * set BPA.businessService = businessService
        * set BPA.edcrNumber = edcrNumber
        * set BPA.id = id
        * set BPA.riskType = riskType
        * set BPA.landInfo.ownershipCategory = ownershipCategory
        * set BPA.landInfo.owners[0].mobileNumber = mobileNumber
        * set BPA.landInfo.owners[0].gender = gender
        * set BPA.documents = bpaDocument.bpaDocuments
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        Given  url updateBPA
        And  request updateBPARequest
        When  method post
        Then  status 400
        And  def bpaResponseHeaders = responseHeaders
        And  def bpaResponseBody = response

   @approveFromCitizen
    Scenario: Send to CITIZEN

        * set BPA.workflow.action = 'APPROVE'
        * set BPA.status = 'CITIZEN_APPROVAL_INPROCESS'
    #    * set BPA.documents = bpaDocument.bpaDocuments
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        Given  url updateBPA
        And  request updateBPARequest
        When  method post
        Then  status 200
        And  def bpaResponseHeaders = responseHeaders
        And  def bpaResponseBody = response
        And  def BPA = bpaResponseBody.BPA[0]
        And  def applicationNo = bpaResponseBody.BPA[0].applicationNo
        * print ("APPROVE FROM CITIZEN RESPONSE")
        * print response


    @updateBPASuccessfully
    Scenario: Update BPA

        # * set BPA.workflow.action = 'APPROVE'
        # * set BPA.status = 'CITIZEN_APPROVAL_INPROCESS'
        # * set BPA.documents = bpaDocument.bpaDocuments
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        * print updateBPARequest
        Given  url updateBPA
        And  request updateBPARequest
        When  method post
        Then  status 200
        And  def bpaResponseHeaders = responseHeaders
        And  def bpaResponseBody = response
        * print bpaResponseBody
        And  def BPA = bpaResponseBody.BPA[0]
        And  def applicationNo = bpaResponseBody.BPA[0].applicationNo


    @updateBPASuccessfullyForFieldInsecptor
    Scenario: Update BPA
        * set BPA.additionalDetails.fieldinspection_pending[0].docs = bpaDocument.bpaDocuments
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        * print updateBPARequest
        Given  url updateBPA
        And  request updateBPARequest
        When  method post
        Then  status 200
        And  def bpaResponseHeaders = responseHeaders
        And  def bpaResponseBody = response
        * print bpaResponseBody
        And  def BPA = bpaResponseBody.BPA[0]

    @updateBPASuccessfullyForFieldInsecptor
    Scenario: Update BPA
        * set BPA.additionalDetails.fieldinspection_pending[0].docs = bpaDocument.bpaDocuments
        * def updateBPARequest = read('../../municipal-services/requestPayload/bpa-services/update.json')
        * print updateBPARequest
        Given  url updateBPA
        And  request updateBPARequest
        When  method post
        Then  status 200
        And  def bpaResponseHeaders = responseHeaders
        And  def bpaResponseBody = response
        * print bpaResponseBody
        And  def BPA = bpaResponseBody.BPA[0]
    @createBPAStakeholderSuccessfully
    Scenario: Create BPA Stakeholder successfully
        * print dob
        Given url createBPAStakeHolder
        * print createBPAStakeHolder
        And request createBPAStakeholderRequest
        * print createBPAStakeholderRequest
        When method post
        Then status 200
        And def bpaResponseHeaders = responseHeaders
        And def bpaResponseBody = response
        # And def applicationNo = bpaResponseBody.BPA[0].applicationNo
        # And def edcrNumber = bpaResponseBody.BPA[0].edcrNumber
        # And def BPA = bpaResponseBody.BPA[0]
        # And def businessService = bpaResponseBody.BPA[0].businessService
        # And def id = bpaResponseBody.BPA[0].id
        # And def riskType = bpaResponseBody.BPA[0].riskType
        # And def ownershipCategory = bpaResponseBody.BPA[0].landInfo.ownershipCategory
        # And def mobileNumber = bpaResponseBody.BPA[0].landInfo.owners[0].mobileNumber
        # And def gender = bpaResponseBody.BPA[0].landInfo.owners[0].gender