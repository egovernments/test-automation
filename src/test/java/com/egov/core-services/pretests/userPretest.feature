Feature: User Search
        Background:
  * configure headers = read('classpath:websCommonHeaders.js')
  * def jsUtils = read('classpath:jsUtils.js')
  # initializing user payload objects
  * def multipleTenantId = mdmsCityTenant.tenants[1].code + ',' + mdmsCityTenant.tenants[3].code
  * call read('../../core-services/pretests/userCreation.feature@usercreation')
  * def existingUser = createdUser
  * def mobileNumberGen = randomMobileNumGen(10)
  * def unRegisteredNumber = new java.math.BigDecimal(mobileNumberGen)
  * def withoutUserName = ''
  * def emptyStringInTenantId = ''
  * def userConstant = read('../../core-services/constants/user.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def findUser = read('../../core-services/requestPayload/userCreation/searchUser.json')
  
        @finduser
        Scenario: Search user with valid details
     * def payload = findUser.validPayload
            Given url searchUser
     
              And request payload
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @finduserwithmultipletenantid
        Scenario: Search user with multiple tenantIds
     * def payload = findUser.validPayload
     * set findUser.validPayload.tenantId = multipleTenantId
            Given url searchUser
     
              And request payload
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response
  
        @finduserwithinvalidusername
        Scenario: Search user with invalid username
     * def payload = findUser.validPayload
     * set findUser.validPayload.userName = unRegisteredNumber
            Given url searchUser
     
              And request payload
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @finduserwithinvalidtenantid
        Scenario: Search user with invalid tenantId
     * def payLoad = findUser.validPayload  
     * set findUser.validPayload.tenantId = invalidTenantId
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @finduserwithoutusername
        Scenario: Search user without username
     * def payLoad = findUser.validPayload 
     * set findUser.validPayload.userName = withoutUserName
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 400
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @finduserwithouttenantid
        Scenario: Search user without tenantId
     * def payLoad = findUser.invalidPayload
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 400
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @finduseremptytenantid
        Scenario: Search user with empty tenantId
     * def payLoad = findUser.validPayload
     * set findUser.validPayload.tenantId = emptyStringInTenantId
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 400
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response