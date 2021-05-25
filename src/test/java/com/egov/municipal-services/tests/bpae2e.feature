Feature: BPA Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def transactionNumber = randomString(20)
    * def transactionNumber2 = randomString(20)

    * def applicantName = 'AUTO_NAME_' + ranInteger(10)
    * def appliactionType = mdmsStateBPA.ApplicationType[0].code
    * print appliactionType
    * def applicationSubType = mdmsStateBPA.ServiceType[0].code
    * print applicationSubType
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@scrunity')

    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@scrunityHighEnd')
    # * def appliactionType = "BUILDING_OC_PLAN_SCRUTINY"
    # * print appliactionType
    # * def applicationSubType = "NEW_CONSTRUCTION"
    # * print applicationSubType
    # * call read('../../municipal-services/pretests/bpaServicesPretest.feature@scrunityOCDR')    

    * def index = randomNumber(mdmsStateBPA.CalculationType.length)
    * print mdmsStateBPA.CalculationType
    * def feeType = mdmsStateBPA.CalculationType[index].feeType
    * def bpaConstants = read('../../municipal-services/constants/bpaServices.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def hierarchyTypeCode = commonConstants.parameters.hierarchyTypeCode
    * def boundaryType = commonConstants.parameters.boundaryType
    * call read('../../core-services/pretests/location.feature@searchLocationSuccessfully')
    * def localityCode = searchLocationResponseBody.TenantBoundary[0].boundary[0].code
    * def pincode = '5' + randomMobileNumGen(5)
    * def mobileNumber = '8073460929'
#* def mobileNumber = '77' + randomMobileNumGen(8)
    * def fatherOrHusbandName = randomString(10)
    * def name = 'AUTO_' + randomString(10)
    * def relationship = commonConstants.parameters.relationship[randomNumber(commonConstants.parameters.relationship.length)]
    * def gender = commonConstants.parameters.gender[randomNumber(commonConstants.parameters.gender.length)]
  #  * def dob = getPastEpochDate(5000)
    * def dob = "676578599000"
    * def correspondenceAddress = randomString(50)
    * def ownershipCategory = mdmsStatePropertyTax.OwnerShipCategory[0].code +"."+mdmsStatePropertyTax.SubOwnerShipCategory[0].code
    * def floorNo = bpaConstants.parameters.florNo
    * def unitType = bpaConstants.parameters.unitType
    * def riskType = mdmsStateBPA.RiskTypeComputation[2].riskType
    * def occupancyType = mdmsStateBPA.OccupancyType[0].code
    * def action = bpaConstants.actions.initiate
    * def status = bpaConstants.status.initiate
    * def action2 = bpaConstants.actions.sendToCitizen
    * def documentType1 = bpaConstants.documentType.type1
    * def documentType2 = bpaConstants.documentType.type2
    * def documentType3 = bpaConstants.documentType.type3
    * def documentType4 = bpaConstants.documentType.type4
    * def documentType5 = bpaConstants.documentType.type5
   # * def transactionNumber = randomString(20)
  #  * def applicantName = 'AUTO_NAME_' + ranInteger(10)
    * def emailId = randomString(10) + '@' + randomString(5) + '.com'
    * def subOwnerShipCategory = "INDIVIDUAL"
    * def tradeType = "ARCHITECT.CLASSA"
    * def counsilForArchNo = "12345"
    * def landmark = randomString(10)
    * def licenseType = "PERMENANT"
    * def businessService = "BPAREG"
    * def testData = '../../common-services/testData/scrunity.dxf'
    * def dcrConstants = read('../../municipal-services/constants/dcrServices.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    # TODO : taking hardCode value of ocdcrNumber as pf now, once end to end BPA is done will remove this ocdcrNumber hardCoded value
    * def ocdcrNumber = 'OCDCR42021JH3YL'
    * def city = tenantId.split(".")[0]
   # * def otpReference = 123456



# @bpaStakeholder
# Scenario: Register Architect
#     * def authToken = citizenAuthToken

#     * def mobileNumber = '77' + randomMobileNumGen(8)
#     * def createdUser = mobileNumber
#     * print mobileNumber
#     * call read('../../core-services/pretests/userCreationPretest.feature@usercreationForBPA')
#     * print ("USER CREATION BPA DONE")
#     * def mobileNumber = createdUser
#     * print mobileNumber
#     * call read('../../core-services/pretests/userCreationPretest.feature@registerUserSuccessfullyForBPA')
#     * print ("USER SUCCESSFULLY RUN")
#     * def dob = "676578599000"
#     * def action = "NOWORKFLOW"
#     * def mobileNumber = createdUser
#     * def citizenUsername3 = mobileNumber
#     * def citizenPassword3 = 123456
#     * print mobileNumber
#     # * def citizenAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenCitizen', config);
#     #     config.citizenAuthToken = citizenAuthTokenResponse.authToken;
#     * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizenForBPAStakeholder');
#     * def citizenAuthToken3 = authToken3;
#     * def authToken = citizenAuthToken3
#     * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAStakeholderSuccessfully')
# @bpaStakeholder
# Scenario: Register Architect
#     * def authToken = citizenAuthToken

#     * def mobileNumber = '77' + randomMobileNumGen(8)
#     * def createdUser = mobileNumber
#     * print mobileNumber
#     * call read('../../core-services/pretests/userCreationPretest.feature@createCitizen')
#     * print ("USER CREATION BPA DONE")
#     * def mobileNumber = createdUser
#     * print mobileNumber
#    # * call read('../../core-services/pretests/userCreationPretest.feature@registerUserSuccessfullyForBPA')
#     * print ("USER SUCCESSFULLY RUN")
#     * def dob = "676578599000"
#     * def action = "NOWORKFLOW"
#     * def mobileNumber = createdUser
#     * def citizenUsername3 = mobileNumber
#     * def citizenPassword3 = 123456
#     * print mobileNumber
#     # * def citizenAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenCitizen', config);
#     #     config.citizenAuthToken = citizenAuthTokenResponse.authToken;
#     * call read('../../common-services/pretests/authenticationToken.feature@authTokenCitizenForBPAStakeholder');
#     * def citizenAuthToken3 = authToken3;
#     * def authToken = citizenAuthToken3
#     * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPAStakeholderSuccessfully')




@bpae2e1 @positive @regression @bpae2eservice
Scenario: Verify BPA e2e scenarios
    #Scrutinize the building plan -- Done above
    * print "RUNNING SCNEARIOS"
        * def authToken = citizenArchitectAuthToken
    #Create New BPA Application (Architect)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    #Land_Create_17
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    #Send_to_citizen_18
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen')
    #Citizen_Login_19
    * def authToken = citizenAuthToken
    #Payment_20

    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@approveFromCitizen')
    * def authToken = superUserAuthToken
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * print getBPASearchParam
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * set BPA.workflow.action = 'APPLY'
    * set BPA.status = 'INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPASuccessfully')

    * def fetchBillParams = 
    """
    {
       consumerCode: '#(applicationNo)',
       businessService: 'BPA.LOW_RISK_PERMIT_FEE',
       tenantId: '#(tenantId)'
    }
    """
    * print fetchBillParams
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * def totalAmountPaid = txnAmount
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')

    * set BPA.workflow.action = 'FORWARD'
    * set BPA.status = 'DOC_VERIFICATION_INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')

    * def searchNOCParams = {offset:0,limit:-1 ,tenantId: '#(tenantId)', sourceRefId: '#(applicationNo)', nocType: 'FIRE_NOC'}
    * call read('../../municipal-services/pretests/nocPretest.feature@searchNOCWithValidDataForBPA')
    * set nocDetail.applicationStatus = "INPROGRESS"
    * set nocDetail.workflow.action = "APPROVE"
    * set nocDetail.documents = []
    * set nocDetail.documents[0].documentType = bpaConstants.documentType.type11
    * set nocDetail.documents[0].fileStoreId = fileStoreId3
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithValidData')
    * set BPA.workflow.action = 'FORWARD'
    * set BPA.status = 'FIELDINSPECTION_INPROGRESS'    
    * def documentType1 = bpaConstants.documentType.type6
    * def documentType2 = bpaConstants.documentType.type7
    * def documentType3 = bpaConstants.documentType.type8
    * def documentType4 = bpaConstants.documentType.type9
    * def documentType5 = bpaConstants.documentType.type10
    * set BPA.additionalDetails.fieldinspection_pending = []
    * set BPA.additionalDetails.fieldinspection_pending[0].date = getCurrentDate1()
    * set BPA.additionalDetails.fieldinspection_pending[0].time = getCurrentTime()
    * set BPA.additionalDetails.fieldinspection_pending[0].questions = []
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[0] = {"question":"RIVER_EXISTS_ON_SITE","value":"NO"}
    * print BPA
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[1] = {"question":"TREE_EXISTS_ON_SITE","value":"NO"}
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[2] = {"question":"PLAN_AS_PER_THE_SITE","value":"NO"}
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[3] = {"question":"ROADWIDTH_AS_PER_THE_PLAN","value":"NO"}
    * print ("FIELD INSPECTOR UPDATE")
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfullyForFieldInsecptor')
    * set BPA.workflow.action = 'APPROVE'
    * set BPA.status = 'APPROVAL_INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')

    # * match BPA.edcrNumber == "#present"
    # * match BPA.landId == "#present"
    # * match BPA.landInfo == "#present"
    # * match BPA.approvalNo == "#present"
    # * match BPA.approvalDate == "#present"
    # * match BPA.accountId == "#present"
    # * match BPA.applicationNo == "#present"
    # * def comparisonParams = { edcrNumber: '#(edcrNumber)', ocdcrNumber: '#(ocdcrNumber)',tenantId: '#(tenantId)'}
    # * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonSuccessfully')


@bpae2e2 @positive @regression @bpae2eservice
Scenario: Verify BPA e2e scenarios - Highend
    * print "RUNNING SCNEARIOS"
    * def riskType = mdmsStateBPA.RiskTypeComputation[0].riskType
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfullyForHighEnd')
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen')
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@approveFromCitizen')
    * def authToken = superUserAuthToken
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * print getBPASearchParam
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * set BPA.workflow.action = 'APPLY'
    * set BPA.status = 'INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPASuccessfully')
    * def fetchBillParams = 
    """
    {
       consumerCode: '#(applicationNo)',
       businessService: 'BPA.NC_APP_FEE',
       tenantId: '#(tenantId)'
    }
    """
    * print fetchBillParams
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * def totalAmountPaid = txnAmount
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * set BPA.workflow.action = 'FORWARD'
    * set BPA.status = 'DOC_VERIFICATION_INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * def searchNOCParams = {offset:0,limit:-1 ,tenantId: '#(tenantId)', sourceRefId: '#(applicationNo)', nocType: 'FIRE_NOC'}
    * call read('../../municipal-services/pretests/nocPretest.feature@searchNOCWithValidDataForBPA')
    * set nocDetail.applicationStatus = "INPROGRESS"
    * set nocDetail.workflow.action = "APPROVE"
    * set nocDetail.documents = []
    * set nocDetail.documents[0].documentType = bpaConstants.documentType.type11
    * set nocDetail.documents[0].fileStoreId = fileStoreId3
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithValidData')
    * set BPA.workflow.action = 'FORWARD'
    * set BPA.status = 'FIELDINSPECTION_INPROGRESS'    
    * def documentType1 = bpaConstants.documentType.type6
    * def documentType2 = bpaConstants.documentType.type7
    * def documentType3 = bpaConstants.documentType.type8
    * def documentType4 = bpaConstants.documentType.type9
    * def documentType5 = bpaConstants.documentType.type10
    * set BPA.additionalDetails.fieldinspection_pending = []
    * set BPA.additionalDetails.fieldinspection_pending[0].date = getCurrentDate1()
    * set BPA.additionalDetails.fieldinspection_pending[0].time = getCurrentTime()
    * set BPA.additionalDetails.fieldinspection_pending[0].questions = []
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[0] = {"question":"RIVER_EXISTS_ON_SITE","value":"NA"}
    * print BPA
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[1] = {"question":"TREE_EXISTS_ON_SITE","value":"NA"}
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[2] = {"question":"PLAN_AS_PER_THE_SITE","value":"NA"}
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[3] = {"question":"ROADWIDTH_AS_PER_THE_PLAN","value":"NA"}
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfullyForFieldInsecptor')
    * set BPA.workflow.action = 'APPROVE'
    * set BPA.status = 'APPROVAL_INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * match BPA.edcrNumber == "#present"
    * match BPA.landId == "#present"
    * match BPA.landInfo == "#present"
    * match BPA.approvalNo == "#present"
    * match BPA.approvalDate == "#present"
    * match BPA.accountId == "#present"
    * match BPA.applicationNo == "#present"




    # * def comparisonParams = { edcrNumber: '#(edcrNumber)', ocdcrNumber: '#(ocdcrNumber)',tenantId: '#(tenantId)'}
    # * call read('../../municipal-services/pretests/dcrServicesPretest.feature@searchComparisonSuccessfully')
    # * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfullyForHighEnd')

@bpae2e3 @positive @regression @bpae2eservice
Scenario: Verify BPA e2e scenarios - Revocate From Doc Verifer
    #Scrutinize the building plan -- Done above
    * print "RUNNING SCNEARIOS"
        * def authToken = citizenArchitectAuthToken
    #Create New BPA Application (Architect)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    #Land_Create_17
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    #Send_to_citizen_18
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen')
    #Citizen_Login_19
    * def authToken = citizenAuthToken
    #Payment_20

    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@approveFromCitizen')
    * def authToken = superUserAuthToken
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * print getBPASearchParam
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * set BPA.workflow.action = 'APPLY'
    * set BPA.status = 'INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPASuccessfully')
    * def fetchBillParams = 
    """
    {
       consumerCode: '#(applicationNo)',
       businessService: 'BPA.LOW_RISK_PERMIT_FEE',
       tenantId: '#(tenantId)'
    }
    """
    * print fetchBillParams
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * def totalAmountPaid = txnAmount
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * set BPA.workflow.action = 'REVOCATE'
    * set BPA.workflow.comments = randomString(20)
    * set BPA.status = 'DOC_VERIFICATION_INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * match BPA.edcrNumber == "#present"
    * match BPA.landId == "#present"
    * match BPA.landInfo == "#present"
    * match BPA.approvalNo == "#present"
    * match BPA.approvalDate == "#present"
    * match BPA.accountId == "#present"
    * match BPA.applicationNo == "#present"

@bpae2e4 @positive @regression @bpae2eservice
Scenario: Verify BPA e2e scenarios - Revocate as field Inspector
    #Scrutinize the building plan -- Done above
    * print "RUNNING SCNEARIOS"
  #  * def authToken = citizenArchitectAuthToken
    #Create New BPA Application (Architect)
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@createBPASuccessfully')
    #Land_Create_17
    * call read('../../municipal-services/pretests/landServicesPretest.feature@createLandSuccessfully')
    #Send_to_citizen_18
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@sendToCitizen')
    #Citizen_Login_19
    * def authToken = citizenAuthToken
    #Payment_20
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@approveFromCitizen')
    * def authToken = superUserAuthToken
    * def getBPASearchParam = {"tenantId": '#(tenantId)',"applicationNo": '#(applicationNo)'}
    * print getBPASearchParam
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * set BPA.workflow.action = 'APPLY'
    * set BPA.status = 'INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaCalculatorPretest.feature@calcuateBPASuccessfully')

    * def fetchBillParams = 
    """
    {
       consumerCode: '#(applicationNo)',
       businessService: 'BPA.LOW_RISK_PERMIT_FEE',
       tenantId: '#(tenantId)'
    }
    """
    * print fetchBillParams
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBillWithCustomizedParameters')
    * def totalAmountPaid = txnAmount
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')

    * set BPA.workflow.action = 'FORWARD'
    * set BPA.status = 'DOC_VERIFICATION_INPROGRESS'
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfully')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * def searchNOCParams = {offset:0,limit:-1 ,tenantId: '#(tenantId)', sourceRefId: '#(applicationNo)', nocType: 'AIRPORT_AUTHORITY'}
    * call read('../../municipal-services/pretests/nocPretest.feature@searchNOCWithValidData')
    * print "UPDATING AIRPORT NOC:::"
    * set nocDetail.applicationStatus = "INPROGRESS"
    * set nocDetail.workflow = null
    * set nocDetail.documents = null
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithValidData')
    * def searchNOCParams = {offset:0,limit:-1 ,tenantId: '#(tenantId)', sourceRefId: '#(applicationNo)', nocType: 'FIRE_NOC'}
    * call read('../../municipal-services/pretests/nocPretest.feature@searchNOCWithValidData')
    * set nocDetail.applicationStatus = "INPROGRESS"
    * set nocDetail.workflow = null
    * set nocDetail.documents = null
    * call read('../../municipal-services/pretests/NOCPretest.feature@updateNOCWithValidData')
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@searchBPASuccessfully')
    * set BPA.workflow.action = 'REVOCATE'
    * set BPA.workflow.comments = randomString(20)
    * set BPA.status = 'FIELDINSPECTION_INPROGRESS'    
    * def documentType1 = bpaConstants.documentType.type6
    * def documentType2 = bpaConstants.documentType.type7
    * def documentType3 = bpaConstants.documentType.type8
    * def documentType4 = bpaConstants.documentType.type9
    * def documentType5 = bpaConstants.documentType.type10
    * set BPA.additionalDetails.fieldinspection_pending = []
    * set BPA.additionalDetails.fieldinspection_pending[0].date = getCurrentDate1()
    * set BPA.additionalDetails.fieldinspection_pending[0].time = getCurrentTime()
    * set BPA.additionalDetails.fieldinspection_pending[0].questions = []
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[0] = {"question":"RIVER_EXISTS_ON_SITE","value":"NO"}
    * print BPA
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[1] = {"question":"TREE_EXISTS_ON_SITE","value":"NO"}
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[2] = {"question":"PLAN_AS_PER_THE_SITE","value":"NO"}
    * set BPA.additionalDetails.fieldinspection_pending[0].questions[3] = {"question":"ROADWIDTH_AS_PER_THE_PLAN","value":"NO"}
    * print ("FIELD INSPECTOR UPDATE")
    * call read('../../municipal-services/pretests/bpaServicesPretest.feature@updateBPASuccessfullyForFieldInsecptor')
    * match BPA.edcrNumber == "#present"
    * match BPA.landId == "#present"
    * match BPA.landInfo == "#present"
    * match BPA.approvalNo == "#present"
    * match BPA.approvalDate == "#present"
    * match BPA.accountId == "#present"
    * match BPA.applicationNo == "#present"
