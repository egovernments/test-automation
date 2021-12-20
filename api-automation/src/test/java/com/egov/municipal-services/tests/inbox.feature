Feature: Inbox API Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    * def tenantId = mdmsStatetenant.tenants[3].code
    * def tenantName = mdmsStatetenant.tenants[3].name
    * def propertyServicesConstants = read('../../municipal-services/constants/propertyServices.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def mobileNumber = '77' + randomMobileNumGen(8)
    * def name = 'AUTO_' + randomString(10)

    @pt_inboxSearch_01 @positive @regression @municipalServices @ptInboxSearch
    Scenario: Verify inbox searching for a pt service
    * call read('../../municipal-services/pretests/inboxPretest.feature@searchPTInbox')
    * match pttotalcount == '#present'
    * match pttotalcount == '#notnull'
    * match ptcreatecount1 == '#present'
    * match ptcreatecount2 == '#present'
    
    @tl_inboxSearch_01 @positive @regression @municipalServices @tlInboxSearch
    Scenario: Verify inbox searching for a tl service
    * call read('../../municipal-services/pretests/inboxPretest.feature@searchTLInbox')
    * match tltotalcount == '#present'
    * print tltotalcount
    * match tltotalcount == '#notnull'
    * match tlcreatecount1 == '#present'

    @bpa_inboxArchitectSearch_01 @positive @municipalServices @bpaInboxSearch @r2dot6
    Scenario: Verify inbox searching for a bpa service
    * call read('../../municipal-services/pretests/inboxPretest.feature@searchBPAArchitectInbox')
    #* match bpatotalcount == '#present'
   # * print bpatotalcount
    #* match bpatotalcount == '#notnull'
    #* match bpacreatecount1 == '#present'

    @bpa_inboxCitizenSearch_01 @positive @municipalServices @bpaInboxSearch @r2dot6
    Scenario: Verify citizen inbox searching for a bpa service
    * call read('../../municipal-services/pretests/inboxPretest.feature@searchBPACitizenInbox')
    * match bpatotalcount == '#present'
    * print bpatotalcount
    #* match bpatotalcount == '#notnull'
    #* match bpacreatecount1 == '#present'

    @bpa_inboxEmployeeSearch_01 @positive @municipalServices @bpaInboxSearch @r2dot6
    Scenario: Verify citizen inbox searching for a bpa service
    * call read('../../municipal-services/pretests/inboxPretest.feature@searchBPAEmployeeInbox')
    * match bpatotalcount == '#present'
    * print bpatotalcount
    #* match bpatotalcount == '#notnull'
    #* match bpacreatecount1 == '#present'