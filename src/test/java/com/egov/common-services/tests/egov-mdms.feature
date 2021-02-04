Feature: MDMS Services Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def tenantId = tenantId
    * def authUsername = authUsername
    * def authPassword = authPassword
    * def authUserType = authUserType
    * call read('../pretests/authenticationToken.feature')
    
@searchMdmsGlobal
Scenario: Test to Create Demand with valid field values
    * call read('../pretests/egovMdmsPretest.feature@successSearchState')