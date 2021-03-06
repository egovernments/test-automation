Feature: Pretest scenarios of egf-master account details types service end points
Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * configure headers = read('classpath:websCommonHeaders.js')
  * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml') 
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
    Then status 201
    And def accountDetailTypesCreateResponseHeader = responseHeaders
    And def accountDetailTypesCreateResponseBody = response

    @negativeTestCase
  Scenario: Negative case Creating Unique account detail type through API call
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
    Then status 400
    And def accountDetailTypesCreateResponseHeader = responseHeaders
    And def accountDetailTypesCreateResponseBody = response