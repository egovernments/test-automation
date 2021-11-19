Feature: EDCR-Service pretests
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def scrutinyDetailsRequest = read('../../municipal-services/requestPayload/dcr-services/scrutinydetails.json')
        * def occomparisonRequest = read('../../municipal-services/requestPayload/dcr-services/occomparison.json')
        * configure ssl = false

    @scrunity
    Scenario: Scrunity Successful
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
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = 'multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ'
        And multipart file planFile = {read: '#(testData)' , filename: 'scrunity.dxf', contentType: 'application/dxf'}
        And param edcrRequest = edcrRequest
        When method post
        Then status 200
        And def scrunityResponseBody = response
        # * print scrunityResponseBody
        * def edcrNumber = scrunityResponseBody.edcrDetail[0].edcrNumber


    @scrunityError
    Scenario: Scrunity Error
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
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = 'multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ'
        And multipart file planFile = {read: '#(testData)' , filename: 'scrunity.dxf', contentType: 'application/dxf'}
        And param edcrRequest = edcrRequest
        When method post
        Then status 400
        And def scrunityResponseBody = response

    @scrunityNoFileError
    Scenario: Scrunity NoFileError
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
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = 'multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ'
        And multipart file planFile = {read: '' , filename: '', contentType: 'application/dxf'}
        And param edcrRequest = edcrRequest
        When method post
        Then status 500
        And def scrunityResponseBody = response


    @scrunityErrorFile
    Scenario: Scrunity ErrorFile
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
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = 'multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ'
        And multipart file planFile = {read: '../../common-services/testData/testData4.png' , filename: 'testData4.png', contentType: 'application/png'}
        And param edcrRequest = edcrRequest
        When method post
        Then status 400
        And def scrunityResponseBody = response

    @scrunityMultiFile
    Scenario: Scrunity MultipleFile
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
        Given url createEdcrScrutinize + "?tenantId=" + tenantId
        And header auth-token = authToken
        And header Content-Type = 'multipart/form-data; boundary=----WebKitFormBoundaryac7WcrRamAPfptBJ'
        And multipart file planFile = {read: '#(testData)' , filename: 'scrunity.dxf', contentType: 'application/dxf'}
        And multipart file planFile = {read: '#(testData)' , filename: 'scrunity.dxf', contentType: 'application/dxf'}
        And param edcrRequest = edcrRequest
        When method post
        Then status 200
        And def scrunityResponseBody = response

    @searchScrutinySuccessfully
    Scenario: Search Successful
        Given url scrutinydetailsUrl
        And params searchScrutinyParams
        And request scrutinyDetailsRequest
        When method post
        Then status 200
        And def scrunityResponseHeaders = responseHeaders
        And def scrunityResponseBody = response

    @searchScrutinyError
    Scenario: Search Error
        Given url scrutinydetailsUrl
        And params searchScrutinyParams
        And request scrutinyDetailsRequest
        When method post
        Then status 400
        And def scrunityResponseHeaders = responseHeaders
        And def scrunityResponseBody = response

    @searchComparisonSuccessfully
    Scenario: Comparison Successful
        Given url occomparisonUrl
        And params comparisonParams
        And request occomparisonRequest
        When method post
        Then status 200
        And def comparisonResponseHeaders = responseHeaders
        And def comparisonResponseBody = response
        # * print response

    @searchComparisonError
    Scenario: Comparison Error
        Given url occomparisonUrl
        And params comparisonParams
        And request occomparisonRequest
        When method post
        Then status 400
        And def comparisonResponseHeaders = responseHeaders
        And def comparisonResponseBody = response


