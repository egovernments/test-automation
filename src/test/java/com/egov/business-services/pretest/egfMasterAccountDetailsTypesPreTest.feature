Feature: Pretest scenarios of egf-master account details types service end points
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml') 
  # * def branchName = randomString(10)
  # * def tableName = egfMasterConstants.chartOfAccountDeatails.params.tableName
  # * def fullyQualifiedName = randomString(3)+"/"+tableName
  * def description = 'TEST_'+randomString(5)
  #* def active = egfMasterConstants.chartOfAccountDeatails.params.active
  * def accountDetailTypesCreatePayload = read('../../business-services/requestPayload/egfMaster/accountDetailTypes/create.json')
  * def accountDetailTypesUpdatePayload = read('../../business-services/requestPayload/egfMaster/accountDetailTypes/update.json')
  * def accountDetailTypesSearchPayload = read('../../business-services/requestPayload/egfMaster/accountDetailTypes/search.json')
  
 @createAccountSuccessfully
  Scenario: Creating Unique account detail type through API call
    * def accountCreateParam = 
    """
    {
     tenantId: '#(tenantId)'
    }
    """ 
    Given url accountDetailTypesCreate 
    And params accountCreateParam
    And request accountDetailTypesCreatePayload
    When method post
    # Then status 201
    Then assert responseStatus == 201 || responseStatus == 400
    And def accountDetailTypesCreateResponseHeader = responseHeaders
    And def accountDetailTypesCreateResponseBody = response
   # * print accountDetailTypesCreate
   # * print accountCreateParam
   # * print accountDetailTypesCreatePayload
   # * print accountDetailTypesCreateResponseBody