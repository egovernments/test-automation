Feature: Pretest scenarios of inbox search end points

Background: 
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def inboxPTSearchRequest = read('../../municipal-services/requestPayload/property-services/inboxSearch.json')
   * def inboxTLSearchRequest = read('../../municipal-services/requestPayload/trade-license/inboxSearch.json')
@searchPTInbox
Scenario: To fetch the count of PT application
    Given url inboxSearchUrl
         * print inboxSearchUrl
    And request inboxPTSearchRequest
    When method post
    Then def inboxPTSearchResponse = response
       # * print inboxPTSearchResponse
    And def pttotalcount = inboxPTSearchResponse.totalCount
         * print pttotalcount
    And def ptcreatecount1 = inboxPTSearchResponse.statusMap[0].count
         * print ptcreatecount1
    And def ptcreatebs1 = inboxPTSearchResponse.statusMap[0].businessservice
        * print ptcreatebs1
    And def ptAppStatus1 = inboxPTSearchResponse.statusMap[0].applicationstatus
         * print ptAppStatus1
    And def ptcreatecount2 = inboxPTSearchResponse.statusMap[1].count
         * print ptcreatecount2
    And def ptcreatebs2 = inboxPTSearchResponse.statusMap[1].businessservice
         * print ptcreatebs2 
    And def ptAppStatus2 = inboxPTSearchResponse.statusMap[1].applicationstatus
         * print ptAppStatus2
    And  assert responseStatus == 200

@searchTLInbox
Scenario: To fetch the count of TL application
    Given url inboxSearchUrl
    And request inboxTLSearchRequest
    When method post
    Then def inboxTLSearchResponse = response
       # * print inboxTLSearchResponse
    And def tltotalcount = inboxTLSearchResponse.totalCount
         * print tltotalcount
    And def tlcreatecount1 = inboxTLSearchResponse.statusMap[0].count
         * print tlcreatecount1
    And def tlcreatebs1 = inboxTLSearchResponse.statusMap[0].businessservice
        * print tlcreatebs1
    And  assert responseStatus == 200