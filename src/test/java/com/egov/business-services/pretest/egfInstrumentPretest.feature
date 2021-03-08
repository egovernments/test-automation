Feature: Pretest scenarios of egf-instrument service end points

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
    #egfInstrumet-Instruments Requests
  * def instrumentCreateRequest = read('../../business-services/requestPayload/egfInstrument/instrument/create.json')
  * def instrumentUpdateRequest = read('../../business-services/requestPayload/egfInstrument/instrument/update.json')
  * def instrumentSearchRequest = read('../../business-services/requestPayload/egfInstrument/instrument/search.json')
  * def createSurrenderReasonRequest = read('../../business-services/requestPayload/egfInstrument/surrenderReasons/create.json')
  * def updateSurrenderReasonRequest = read('../../business-services/requestPayload/egfInstrument/surrenderReasons/update.json')
  * def searchSurrenderReasonRequest = read('../../business-services/requestPayload/egfInstrument/surrenderReasons/search.json')

  # Instrument Types prtests

  @createInstrumentTypes
    Scenario: To create instrument types
    Given url createInstrumentTypes
        * print createInstrumentTypes
    And request instrumentTypesPayload
        * print instrumentTypesPayload
    When method post
    Then assert responseStatus == 201
    And  def instrumentTypesResponse = response
  
  @errorInCreateInstrumentTypes
    Scenario: Negative pretest to create instrument types
    Given url createInstrumentTypes
        * print createInstrumentTypes
    And request instrumentTypesPayload
        * print instrumentTypesPayload
    When method post
    Then assert responseStatus >= 400 && responseStatus <= 403
    And  def instrumentTypesResponse = response

  @searchInstrumentTypes
    Scenario: To search instrument types
    Given url searchInstrumentTypes
    And params searchParams
      * print searchParams
    And request searchInstrumentTypesPayload
    When method post
    Then assert responseStatus == 200
    And def searchResponse = response
  
  @errorInSearchInstrumentTypes
    Scenario: Negative pretest to search instrument types
    Given url searchInstrumentTypes
    And params searchParams
      * print searchParams
    And request searchInstrumentTypesPayload
    When method post
    Then assert responseStatus == 403
    And def searchResponse = response

  @updateInstrumentTypes
    Scenario: To update instrument types
    Given url updateInstrumentTypes
        * print updateInstrumentTypes
    And request instrumentTypesPayload
        * print instrumentTypesPayload
    When method post
    Then assert responseStatus == 201
    And  def updateInstrumentTypesResponse = response

@errorInUpdateInstrumentTypes
    Scenario: Negative pretest to update instrument types
    Given url updateInstrumentTypes
        * print updateInstrumentTypes
    And request instrumentTypesPayload
        * print instrumentTypesPayload
    When method post
    Then assert responseStatus >= 400 && responseStatus <= 403
    And  def updateInstrumentTypesResponse = response

# Instruments pretests
@createInstrumentsSuccessfully
Scenario: Creating an Instruments through API call

    Given url instrumentCreate 
    And request instrumentCreateRequest
    When method post
    Then status 201
    And def instrumentCreateResponseHeader = responseHeaders
    And def instrumentCreateResponseBody = response
    And def id = instrumentCreateResponseBody.instruments[0].id

@errorInCreateInstruments
Scenario: Creating an instruments and check for error through API call

    Given url instrumentCreate 
    And request instrumentCreateRequest
    When method post
    Then status 400
    And def instrumentCreateResponseHeader = responseHeaders
    And def instrumentCreateResponseBody = response


@unauthorizedaccessError
Scenario: Creating an instruments and check for errors through API call

    Given url instrumentCreate 
    And request instrumentCreateRequest
    When method post
    Then status 403
    And def instrumentCreateResponseHeader = responseHeaders
    And def instrumentCreateResponseBody = response


@updateInstrumentsSuccessfully
Scenario: Update an Instruments through API call

    Given url instrumentUpdate
    And request instrumentUpdateRequest
    When method post
    Then status 201
    And def instrumentUpdateResponseHeader = responseHeaders
    And def instrumentUpdateResponseBody = response

@errorInUpdateInstruments
Scenario: Updating an instruments and check for error through API call

    Given url instrumentUpdate
    And request instrumentUpdateRequest
    When method post
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def instrumentUpdateResponseHeader = responseHeaders
    And def instrumentUpdateResponseBody = response

@unauthorizedaccessError_Update
Scenario: Updating an instruments and check for errors through API call

    Given url instrumentUpdate 
    And request instrumentUpdateRequest
    When method post
    Then status 403
    And def instrumentUpdateResponseHeader = responseHeaders
    And def instrumentUpdateResponseBody = response

@searchTransactionNumberSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     transactionNumber: '#(transactionNumber)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then status 200
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@searchInstrumentIdSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     id: '#(id)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then status 200
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@searchTransactionTypeSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     transactionType: '#(transactionType)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then assert responseStatus == 200
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@errorInsearchTransactionTypeSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     transactionType: '#(transactionType)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then assert responseStatus >= 400 && responseStatus <= 403
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@searchInstrumentTypesSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     instrumentTypes: '#(instrumentType)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then status 200
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@searchAllInstrumentsSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then assert responseStatus == 200
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@errorInsearchAllInstrumentsSuccessfully
Scenario: error in Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then assert responseStatus == 403
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@searchInstrumentTypesAndTransactionTypeSuccessfully
Scenario: Searching Instruments through API call
    * def instrumentsSearchParam = 
    """
    {
     tenantId: '#(tenantId)',
     instrumentTypes: '#(instrumentType)',
     transactionType: '#(transactionType)'
    }
    """ 
    Given url instrumentSearch
    And params instrumentsSearchParam
    And request instrumentSearchRequest
    When method post
    Then status 200
    And def instrumentSearchResponseHeader = responseHeaders
    And def instrumentSearchResponseBody = response

@createSurrenderReasonSuccessfully
Scenario: Create Surrender Reason Successfully
    Given url createSurrenderReasons
    And request createSurrenderReasonRequest
    When method post
    Then status 201
    And def surrenderReasonsResponseHeaders = responseHeaders
    And def surrenderReasonsResponseBody = response
    And def surrenderReasons = surrenderReasonsResponseBody.surrenderReasons

@errorInCreateSurrenderReason
Scenario: Create Surrender Reason Error
    Given url createSurrenderReasons
    And request createSurrenderReasonRequest
    When method post
    Then assert responseStatus >= 400
    And def surrenderReasonsResponseHeaders = responseHeaders
    And def surrenderReasonsResponseBody = response

@updateSurrenderReasonSuccessfully
Scenario: Update Surrender Reason Successfully
    * eval updateSurrenderReasonRequest.surrenderReasons = surrenderReasons
    Given url updateSurrenderReasons
    And request updateSurrenderReasonRequest
    When method post
    Then status 201
    And def surrenderReasonsResponseHeaders = responseHeaders
    And def surrenderReasonsResponseBody = response
    And def surrenderReasons = surrenderReasonsResponseBody.surrenderReasons
    
@errorInUpdateSurrenderReason
Scenario: Update Surrender Reason Error
    * eval updateSurrenderReasonRequest.surrenderReasons = surrenderReasons
    Given url updateSurrenderReasons
    And request updateSurrenderReasonRequest
    When method post
     * print surrenderReasonsResponseBody
    Then assert responseStatus >= 400
    And def surrenderReasonsResponseHeaders = responseHeaders
    And def surrenderReasonsResponseBody = response
    
@searchSurrenderReasonSuccessfully
Scenario: Search Surrender Reason Successfully
    Given url searchSurrenderReasons
    And params surrenderReasonsParams
    And request searchSurrenderReasonRequest
    When method post
    Then status 200
    And def surrenderReasonsResponseHeaders = responseHeaders
    And def surrenderReasonsResponseBody = response

@errorInSearchSurrenderReason
Scenario: Search Surrender Reason Error
    Given url searchSurrenderReasons
    And params surrenderReasonsParams
    And request searchSurrenderReasonRequest
    When method post
    Then assert responseStatus >= 400
    And def surrenderReasonsResponseHeaders = responseHeaders
    And def surrenderReasonsResponseBody = response