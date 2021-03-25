Feature: Property Service 

Background: 
  * def createPropertyRequest = read('../../municipal-services/requestPayload/property-services/create.json')
  * def updatePropertyRequest = read('../../municipal-services/requestPayload/property-services/update.json')
  * def createAssessmentRequest = read('../../municipal-services/requestPayload/property-services/createAssessment.json')
  * def updateAssessmentRequest = read('../../municipal-services/requestPayload/property-services/updateAssessment.json')
  * def searchAssessmentRequest = read('../../municipal-services/requestPayload/property-services/searchAssessment.json')
  * def searchPropertyRequest = read('../../common-services/requestPayload/common/search.json')
  * def transferOwnershipRequest = read('../../municipal-services/requestPayload/property-services/ownership.json')
@createPropertySuccessfully 
Scenario: Create a property successfully 
	Given url createpropertyUrl 
	And request createPropertyRequest
	When method post 
	Then status 201 
	And def propertyServiceResponseHeaders = responseHeaders 
	And def propertyServiceResponseBody = response 
	And def Property = propertyServiceResponseBody.Properties[0] 
	And def propertyId = Property.propertyId 
	And def consumerCode = propertyId 
	And def acknowldgementNumber = Property.acknowldgementNumber 
	And def businessId = acknowldgementNumber 

@errorInCreateProperty 
Scenario: Create a property error 
	Given url createpropertyUrl 
	And request createPropertyRequest 
	When method post 
	Then assert responseStatus >=400 && responseStatus <=403 
	And def propertyServiceResponseHeaders = responseHeaders 
	And def propertyServiceResponseBody = response 
	
@errorInCreatePropertyRemoveField 
Scenario: Create a property error 
	Given url createpropertyUrl 
	* eval karate.remove('createPropertyRequest', removeFieldPath) 
	And  request createPropertyRequest 
	When  method post 
	Then  assert responseStatus >=400 && responseStatus <=403 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response 
	
	
@searchPropertySuccessfully 
Scenario: Search a property 
	Given  url searchPropertyUrl 
	And  params searchPropertyParams 
	And  request searchPropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response
  And def Property = propertyServiceResponseBody.Properties[0]
  And def propertyId = Property.propertyId 
	And def consumerCode = propertyId 
	And def acknowldgementNumber = Property.acknowldgementNumber 
	And def businessId = acknowldgementNumber 

@searchPropertyForEmptyResult 
Scenario: Search a property for empty result
	Given  url searchPropertyUrl 
	And  params searchPropertyParams 
	And  request searchPropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response

@errorInSearchProperty 
Scenario: Search a property error 
	Given  url searchPropertyUrl 
	And  params searchPropertyParams 
	And  request searchPropertyRequest 
	When  method post 
	Then  status 400 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response 
	
@updatePropertySuccessfully 
Scenario: Update a property 
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval Property = karate.merge(Property, {'0': {'comment': '', 'assignee':[]}}) 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	* eval updatePropertyRequest.Property.workflow.action = 'VERIFY'
  Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId 

@errorInUpdateProperty
Scenario: Update a property error
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval Property = karate.merge(Property, {'0': {'comment': '', 'assignee':[]}}) 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	* eval updatePropertyRequest.Property.workflow.action = 'VERIFY'
  Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post
	Then  assert responseStatus >=400 && responseStatus <=403 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response

@errorInUpdatePropertyRemoveField
Scenario: Update a property error
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval Property = karate.merge(Property, {'0': {'comment': '', 'assignee':[]}}) 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	* eval updatePropertyRequest.Property.workflow.action = 'VERIFY'
  * eval karate.remove('updatePropertyRequest', removeFieldPath) 
  Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post
	Then  assert responseStatus >=400 && responseStatus <=403 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response
	
@verifyPropertySuccessfully 
Scenario: Verify a property 
	* def workflow = updatePropertyRequest.Property.workflow 
	# * eval Property = karate.merge(Property, {'0': {'comment': '', 'assignee':[]}}) 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	# Since the action is specifically 'verify', it is hardcoded
	* eval updatePropertyRequest.Property.workflow.action = 'VERIFY' 
	Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId 
	
@forwardPropertySuccessfully 
Scenario: Forward a property 
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	* eval updatePropertyRequest.Property.workflow.action = 'FORWARD' 
	Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId 
	
@approvePropertySuccessfully 
Scenario: Approve a property 
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	* eval updatePropertyRequest.Property.workflow.action = 'APPROVE' 
	Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def propertyServiceResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId 

@sendBackToCitizen 
Scenario: Application send back to citizen
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	# Since the action is specifically 'verify', it is hardcoded
	* eval updatePropertyRequest.Property.workflow.action = 'SENDBACKTOCITIZEN' 
	Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def sendBackResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId 

@reopenApplication 
Scenario: Reopen the application
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	# Since the action is specifically 'verify', it is hardcoded
	* eval updatePropertyRequest.Property.workflow.action = 'REOPEN' 
	Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def reopenResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId

@rejectApplication 
Scenario: Reject the application
	* def workflow = updatePropertyRequest.Property.workflow 
	* eval updatePropertyRequest.Property = Property 
	* eval updatePropertyRequest.Property.workflow = workflow 
	# Since the action is specifically 'verify', it is hardcoded
	* eval updatePropertyRequest.Property.workflow.action = 'REJECT' 
	Given  url updatePropertyUrl 
	And  request updatePropertyRequest 
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def rejectResponseBody = response 
	And  def Property = propertyServiceResponseBody.Properties[0] 
	And  def propertyId = Property.propertyId 
	And  def consumerCode = propertyId
	
@createAssessmentSuccessfully 
Scenario: Create assessment successfully
	* def assessmentParams = 
	"""
    {
       tenantId: '#(tenantId)'
    }
    """
	Given  url createAssessment 
	And  params assessmentParams 
	And  request createAssessmentRequest
	When  method post 
	Then  status 201
	And  def propertyServiceResponseHeaders = responseHeaders
	And  def propertyServiceResponseBody = response
	And def Assessment = propertyServiceResponseBody.Assessments[0]

@errorInCreateAssessment
Scenario: Create assessment error
	* def assessmentParams =
	"""
    {
       tenantId: '#(tenantId)'
    }
    """
	Given  url createAssessment
	And  params assessmentParams
	And  request createAssessmentRequest
	When  method post
	Then  assert responseStatus >=400 && responseStatus <=403
	And  def propertyServiceResponseHeaders = responseHeaders
	And  def propertyServiceResponseBody = response

@searchAssessmentSuccessfully
Scenario: Search assessment successfully
	Given  url searchAssessment
	And  params assessmentParams
	And  request searchAssessmentRequest
	When  method post
	Then  status 200
	And  def propertyServiceResponseHeaders = responseHeaders
	And  def propertyServiceResponseBody = response

@errorInSearchAssessment
Scenario: Create assessment error
	Given  url searchAssessment
	And  params assessmentParams
	And  request searchAssessmentRequest
	When  method post
	Then  assert responseStatus >=400 && responseStatus <=403
	And  def propertyServiceResponseHeaders = responseHeaders
	And  def propertyServiceResponseBody = response

@updateAssessmentSuccessfully
Scenario: Update assessment successfully
	* def assessmentParams =
	"""
    {
       tenantId: '#(tenantId)'
    }
    """
	* set updatePropertyRequest.Assessment = Assessment
	* print updateAssessmentRequest
	Given  url updateAssessment
	And  params assessmentParams
	And  request updateAssessmentRequest
	When  method post
	Then  status 200
	And  def propertyServiceResponseHeaders = responseHeaders
	And  def propertyServiceResponseBody = response
	And def Assessment = propertyServiceResponseBody.Assessments[0]

@errorInUpdateAssessment
Scenario: Update assessment error
	* def assessmentParams =
	"""
    {
       tenantId: '#(tenantId)'
    }
    """
	* eval updatePropertyRequest.Assessment = Assessment
	Given  url updateAssessment
	And  params assessmentParams
	And  request updateAssessmentRequest
	When  method post
	Then  assert responseStatus >=400 && responseStatus <=403
	And  def propertyServiceResponseHeaders = responseHeaders
	And  def propertyServiceResponseBody = response
	And def Assessment = propertyServiceResponseBody.Assessments[0]

@transferOwnership 
Scenario: Application send back to citizen 
	* def institution = transferOwnershipRequest.Property.institution
	* def ownersTemp = transferOwnershipRequest.Property.ownersTemp
	* def additionalDetails = transferOwnershipRequest.Property.additionalDetails
	* def ownershipCategory = transferOwnershipRequest.Property.ownershipCategory
	* def altContactNumber = transferOwnershipRequest.Property.owners[0].altContactNumber
	* eval transferOwnershipRequest.Property = Property 
	* eval transferOwnershipRequest.Property.institution = institution
	* eval transferOwnershipRequest.Property.ownersTemp = ownersTemp
	* eval transferOwnershipRequest.Property.additionalDetails = additionalDetails
	* eval transferOwnershipRequest.Property.creationReason = 'MUTATION'
	* eval transferOwnershipRequest.Property.ownershipCategory = ownershipCategory
	* eval transferOwnershipRequest.Property.owners[0].altContactNumber = altContactNumber
	Given  url updatePropertyUrl
	And params transferParameters 
	And  request transferOwnershipRequest 
	* print transferOwnershipRequest
	When  method post 
	Then  status 200 
	And  def propertyServiceResponseHeaders = responseHeaders 
	And  def transferResponseBody = response 

@createPropertyNegativeCE
Scenario: Create a property with new counter employee
	Given url createpropertyUrl
	And request createPropertyRequest
	When method post
	Then status 403
	And def propertyServiceResponseHeaders = responseHeaders
	And def propertyServiceResponseBody = response
* print createPropertyRequest
@UImakePayment
Scenario: Search property tax by unique id and make payment
	Given driver envHost
	And delay(5000)
	* input('body', Key.ESC)
	And delay(10000)
