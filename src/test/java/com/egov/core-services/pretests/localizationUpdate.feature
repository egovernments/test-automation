Feature: Localization Update Messages API call 

Background:
	
  * def jsUtils = read('classpath:jsUtils.js')
  	# calling localization Json
  * def localizationUpdateRequest = read('../requestPayload/localization/update.json')
  * def localizationCreateRequest = read('../requestPayload/localization/create.json')
  * def localizationMultiMessageCreateRequest = read('../requestPayload/localization/multiMessageCreate.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print tenantId
  * set localizationUpdateRequest.tenantId = tenantId
  * set localizationCreateRequest.tenantId = tenantId
  * set localizationMultiMessageCreateRequest.tenantId = tenantId
  * print localizationUpdateRequest
  * print localizationMultiMessageCreateRequest


@Success_Update
Scenario: Update with Success call

  Given url localizationUpdateMessagesUrl
  And request localizationUpdateRequest
  When method post
  Then status 200
  And def updateResponseHeader = responseHeaders
  And def updateResponseBody = response


@Error_Update
Scenario: Update with Error call

  Given url localizationUpdateMessagesUrl
  And request localizationUpdateRequest
  When method post
  Then status 400
  And def updateResponseHeader = responseHeaders
  And def updateResponseBody = response


@Error_accessingResource_update
Scenario: Update with Error call
  
  Given url localizationUpdateMessagesUrl
  And request localizationUpdateRequest
  When method post
  Then status 403
  And def updateResponseHeader = responseHeaders
  And def updateResponseBody = response

@Errorupdate_invalid
Scenario: Update with Error call
  
  Given url invalidUpdate
  And request localizationUpdateRequest
  When method post
  Then status 403
  And def updateResponseHeader = responseHeaders
  And def updateResponseBody = response


#need to update this scenario  
@Delete
Scenario: Localization Delete call

  * def deleteRequest = read('../requestPayload/localization/upsert.json')
  * configure headers = read('classpath:websCommonHeaders.js')
  * print deleteRequest
  
  Given url localizationDeleteMessagesUrl
  And request deleteRequest
  When method post
  Then status 403
  And def deleteResponseHeader = responseHeaders
  And def deleteResponseBody = response



@Create_Success
Scenario: Localization Create Success Call

  Given url localizationCreateMessagesUrl
  And request localizationCreateRequest
  When method post
  Then status 200
  And def createResponseHeader = responseHeaders
  And def createResponseBody = response


@Create_MultiMessages_Success
Scenario: Localization Multi Message Create Success Call

  Given url localizationCreateMessagesUrl
  And request localizationMultiMessageCreateRequest
  When method post
  Then status 200
  And def createResponseHeader = responseHeaders
  And def createResponseBody = response
  
  



  




