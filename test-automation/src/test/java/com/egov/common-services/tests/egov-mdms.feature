Feature: MDMS Services Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    # Calling access token
    * def tenantId = tenantId
    * def authUsername = employeeUserName
    * def authPassword = employeePassword
    * def authUserType = employeeType
    * call read('../pretests/authenticationToken.feature')
    
@searchMdmsGlobal
Scenario: Test to Create Demand with valid field values
    * call read('../pretests/egovMdmsPretest.feature@successSearchState')
    * print mdmsServiceResponseBody