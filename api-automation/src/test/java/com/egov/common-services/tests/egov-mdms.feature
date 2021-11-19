Feature: MDMS Services Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def tenantId = tenantId
    
@searchMdmsSuccessfullyGlobal
Scenario: Test to Create Demand with valid field values
    * call read('../common-services/pretest/egovMdmsPretest.feature@successSearchState')