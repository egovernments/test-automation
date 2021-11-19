Feature: Access Control Pretest Feature

        Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  * def accessControlConstants = read('../../core-services/constants/accessControl.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def searchAccessControlRequest = read('../../core-services/requestPayload/access-control/search.json')
  
        @searchAccessControlSuccessfully
        Scenario: Search Access Control successfully
            Given url accessControlSearchUrl
              And request searchAccessControlRequest
             When method post
             Then status 200
              And def accessControlResponseHeader = responseHeaders
              And def accessControlResponseBody = response

        @searchAccessControlError
        Scenario: Search Access Control for error
            Given url accessControlSearchUrl
              And request searchAccessControlRequest
             When method post
             Then status 400
              And def accessControlResponseHeader = responseHeaders
              And def accessControlResponseBody = response

        @searchAccessControlWithInvalidTenant
        Scenario: Search Access Control with invalid tenantId
  * eval searchAccessControlRequest.tenantId = 'INVALID-' + ranString(10)
            Given url accessControlSearchUrl
              And request searchAccessControlRequest
             When method post
             Then status 400
              And def accessControlResponseHeader = responseHeaders
              And def accessControlResponseBody = response