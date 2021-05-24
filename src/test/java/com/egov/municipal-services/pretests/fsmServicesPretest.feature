Feature: FIRE-NOC-Service pretests
    Background:
        * def jsUtils = read('classpath:jsUtils.js')
        * def createFsmRequest = read('../../municipal-services/requestPayload/fsmService/create.json')
        # * def createSantiFsmRequest = read('../../municipal-services/requestPayload/fsmService/create_Santi.json')
        # * def searchFsmRequest = read('../../municipal-services/requestPayload/fsmService/search.json')
        # * def updateFsmRequest = read('../../municipal-services/requestPayload/fsmService/update.json')
        # * def auditFsmRequest = read('../../municipal-services/requestPayload/fsmService/audit.json')
        # * def vendorCreateFsmRequest = read('../../municipal-services/requestPayload/fsmService/vendorCreate.json')
        # * def vendorSearchFsmRequest = read('../../municipal-services/requestPayload/fsmService/vendorSearch.json')
        # * def vehicalSearchFsmRequest = read('../../municipal-services/requestPayload/fsmService/vehicalSearch.json')
        # * def vehicalTripSearchFsmRequest = read('../../municipal-services/requestPayload/fsmService/vehicalTripSearch.json')

    @createFsmSuccessfully
    Scenario: Create FSM successfully
        Given url createFsmEvent
        And request createFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response
        And def fsmBody = fsmResponseBody.fsm[0]
        And def fsmId = fsmResponseBody.fsm[0].id
        And def applicationNo = fsmResponseBody.fsm[0].applicationNo
        And def tenantId = fsmResponseBody.fsm[0].tenantId

    @createFsmError
    Scenario: Create FSM Error
        Given url createFsmEvent
        And request createSantiFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @updateFsmSuccessfully
    Scenario: update FSM successfully
        Given url updateFsmEvent
        And request updateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @updateFsmError
    Scenario: update FSM Error
        Given url updateFsmEvent
        And request updateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @SearchFsmSuccessfully
    Scenario: search FSM successfully
        Given url searchFsmEvent
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @searchFsmError
    Scenario: search FSM Error
        Given url searchFsmEvent
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @searchFsmError1
    Scenario: search FSM Error
        Given url searchFsmEvent
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @auditFsmSuccessfully
    Scenario: Audit FSM successfully
        Given url auditFsmEvent
        And params getFsmAuditParam
        And request auditFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @auditFsmError
    Scenario: Audit FSM Error
        Given url auditFsmEvent
        And params getFsmAuditParam
        And request auditFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @auditFsmError1
    Scenario: Audit FSM Error
        Given url auditFsmEvent
        And params getFsmAuditParam
        And request auditFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vendorCreateFsmSuccessfully
    Scenario: Vendor Create FSM successfully
        Given url vendorCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vendorCreateFsmError
    Scenario: Vendor Create FSM error
        Given url vendorCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vendorSearchFsmSuccessfully
    Scenario: Vendor Search FSM successfully
        Given url vendorSearchFsmEvent
        And params getFsmVendorSearchParam
        And request vendorSearchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vendorSearchFsmError
    Scenario: Vendor Search FSM Error
        Given url vendorSearchFsmEvent
        And params getFsmVendorSearchParam
        And request vendorSearchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalCreateFsmSuccessfully
    Scenario: Vehical Create FSM successfully
        Given url vehicalCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalCreateFsmError
    Scenario: Vehical Create FSM Error
        Given url vehicalCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response
    
    @vehicalSearchFsmSuccessfully
    Scenario: Vehical Search FSM successfully
        Given url vehicalSearchFsmEvent
        And params getFsmVehicalSearchParam
        And request vehicalSearchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalSearchFsmError
    Scenario: Vehical Search FSM Error
        Given url vehicalSearchFsmEvent
        And params getFsmVehicalSearchParam
        And request vehicalSearchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalSearchFsmError1
    Scenario: Vehical Search FSM Error
        Given url vehicalSearchFsmEvent
        And params getFsmVehicalSearchParam
        And request vehicalSearchFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vehicalTripCreateFsmSuccessfully
    Scenario: Vehical Trip Create FSM successfully
        Given url vehicalTripCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalTripSearchFsmSuccessfully
    Scenario: Vehical Trip Search FSM successfully
        Given url vehicalTripSearchFsmEvent
        And params getFsmTripSearchParam
        And request vehicalTripSearchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalTripUpdateFsmSuccessfully
    Scenario: Vehical Trip Update FSM successfully
        Given url vehicalTripUpdateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response