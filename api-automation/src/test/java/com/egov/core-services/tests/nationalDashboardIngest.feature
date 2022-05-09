Feature: National Dashboard Ingest

    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def Thread = Java.type('java.lang.Thread')
        * Thread.sleep(10000)
        * def ingestConstants = read('../../core-services/constants/nationalDashboardIngest.yaml')
        * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
        * def UsageCategory1 = mdmsStatePropertyTax.UsageCategory[0].code
        * def UsageCategory2 = mdmsStatePropertyTax.UsageCategory[1].code
        * def UsageCategory3 = mdmsStatePropertyTax.UsageCategory[2].code
        # * def FY19 = commonConstants.parameters.dssFY[1]
        # * def FY20 = commonConstants.parameters.dssFY[2]
        # * def FY21 = commonConstants.parameters.dssFY[3]
        * def financialYear = commonConstants.parameters.dssFY[randomNumber(commonConstants.parameters.dssFY.length)]
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * def state = ingestConstants.parameters.state
        * def region = ingestConstants.parameters.region
        * def pt = ingestConstants.parameters.module[0]
        * def tl = ingestConstants.parameters.module[1]
        * def ws = ingestConstants.parameters.module[2]
        * def obps = ingestConstants.parameters.module[3]
        * def pgr = ingestConstants.parameters.module[4]
        * def mcollect = ingestConstants.parameters.module[5]
        * def firenoc = ingestConstants.parameters.module[6]
        * def common = ingestConstants.parameters.module[7]
        * def department1 = mdmsStatecommonMasters.Department[0].code
        * def department2 = mdmsStatecommonMasters.Department[1].code
        * def usageTypeFN = mdmsStateFireNocService.BuildingType[randomNumber(mdmsStateFireNocService.BuildingType.length)]
        * def provisional = mdmsStateFireNocService.ApplicationType[0].code
        * def new = mdmsStateFireNocService.ApplicationType[1].code
        * def paymentMode = ingestConstants.parameters.paymentMode[randomNumber(ingestConstants.parameters.paymentMode.length)]
        * def category = ingestConstants.parameters.category[randomNumber(ingestConstants.parameters.category.length)]
        * def receiptStatus = ingestConstants.parameters.receiptStatus[randomNumber(ingestConstants.parameters.receiptStatus.length)]
        * def challanStatus = ingestConstants.parameters.challanStatus[randomNumber(ingestConstants.parameters.challanStatus.length)]
        * def channelType = ingestConstants.parameters.channelType[randomNumber(ingestConstants.parameters.channelType.length)]
        * def connectionType = ingestConstants.parameters.connectionType[randomNumber(ingestConstants.parameters.connectionType.length)]
        * def usageTypeWS = ingestConstants.parameters.usageTypeWS[randomNumber(ingestConstants.parameters.usageTypeWS.length)]
        * def taxHeads = ingestConstants.parameters.taxHeads[randomNumber(ingestConstants.parameters.taxHeads.length)]
        * def wsduration = ingestConstants.parameters.wsduration[randomNumber(ingestConstants.parameters.wsduration.length)]
        * def meterType = ingestConstants.parameters.meterType[randomNumber(ingestConstants.parameters.meterType.length)]
        * def paymentChannelType = ingestConstants.parameters.paymentChannelType[randomNumber(ingestConstants.parameters.paymentChannelType.length)]
        * def serviceCode = msmsCityPgrServiceCodes[5].name
        * def channelPGR = ingestConstants.parameters.channelPGR[randomNumber(ingestConstants.parameters.channelPGR.length)]
        * def statusPGR = ingestConstants.parameters.statusPGR[randomNumber(ingestConstants.parameters.statusPGR.length)]
        * def statusTL = ingestConstants.parameters.statusTL[randomNumber(ingestConstants.parameters.statusTL.length)]
        * def tradetype = ingestConstants.parameters.tradetype[randomNumber(ingestConstants.parameters.tradetype.length)]
        * def riskType = ingestConstants.parameters.riskType[randomNumber(ingestConstants.parameters.riskType.length)]
        * def occupancyType = ingestConstants.parameters.occupancyType[randomNumber(ingestConstants.parameters.occupancyType.length)]
        * def subOccupancyType = ingestConstants.parameters.subOccupancyType[randomNumber(ingestConstants.parameters.subOccupancyType.length)]
        * def statusLive = ingestConstants.parameters.statusLive
        * def statusOnBoarded = ingestConstants.parameters.statusOnBoarded



    @ingestPTValidRecord  @coreServices @regression @positive  @nationalDashboardIngest @ingestPT @digit_2_7
    Scenario: Ingest National dashboard data for PT
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPTSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestPTDuplicateRecord  @coreServices @regression  @nationalDashboardIngest @ingestPT @digit_2_7
    Scenario: Ingest duplicate data for PT
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPTSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPTError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestPTFutureDate  @coreServices @regression  @nationalDashboardIngest @ingestPT @digit_2_7
    Scenario: Ingest future Date data for PT
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPTError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestPTInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestPT @digit_2_7
    Scenario: Ingest invalid date data for PT
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPTError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestFirenocValidRecord  @coreServices @regression @positive @nationalDashboardIngest @ingestFirenoc @digit_2_7
    Scenario: Ingest National dashboard data for Firenoc
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestFirenocSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestFirenocDuplicateRecord  @coreServices @regression @nationalDashboardIngest @ingestFirenoc @digit_2_7
    Scenario: Ingest duplicate data for Firenoc
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestFirenocSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestFirenocError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestFirenocFutureDate  @coreServices @regression @nationalDashboardIngest @ingestFirenoc @digit_2_7
    Scenario: Ingest Firenoc data for future date
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestFirenocError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestFirenocInvalidDate  @coreServices @regression @nationalDashboardIngest @ingestFirenoc @digit_2_7
    Scenario: Ingest Firenoc data for invalid date
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestFirenocError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestmCollectValidRecord  @coreServices @regression @positive @nationalDashboardIngest @ingestmCollect @digit_2_7
    Scenario: Ingest National dashboard data for mCollect
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestmCollectSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestmCollectDuplicateRecord  @coreServices @regression @nationalDashboardIngest @ingestmCollect @digit_2_7
    Scenario: Ingest duplicate data for mCollect
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestmCollectSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestmCollectError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestmCollectFutureDate  @coreServices @regression @nationalDashboardIngest @ingestmCollect @digit_2_7
    Scenario: Ingest mCollect data for future date
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestmCollectError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestmCollectInvalidDate  @coreServices @regression @nationalDashboardIngest @ingestmCollect @digit_2_7
    Scenario: Ingest mCollect data for invalid date
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestmCollectError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestWSValidRecord  @coreServices @regression @positive  @nationalDashboardIngest @ingestWS @digit_2_7
    Scenario: Ingest National dashboard data for WS
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestWSSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestWSDuplicateRecord  @coreServices @regression  @nationalDashboardIngest @ingestWS @digit_2_7
    Scenario: Ingest duplicate data for WS
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestWSSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestWSError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestWSFutureDate  @coreServices @regression  @nationalDashboardIngest @ingestWS @digit_2_7
    Scenario: Ingest WS data for future date
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestWSError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestWSInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestWS @digit_2_7
    Scenario: Ingest WS data for invalid date
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestWSError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestPGRValidRecord  @coreServices @regression @positive  @nationalDashboardIngest @ingestPGR @digit_2_7
    Scenario: Ingest National dashboard data for PGR
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPGRSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestPGRDuplicateRecord  @coreServices @regression  @nationalDashboardIngest @ingestPGR @digit_2_7
    Scenario: Ingest duplicate data for PGR
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPGRSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPGRError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestPGRFutureDate  @coreServices @regression  @nationalDashboardIngest @ingestPGR @digit_2_7
    Scenario: Ingest PGR data for future date
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPGRError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestPGRInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestPGR @digit_2_7
    Scenario: Ingest PGR data for invalid date
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestPGRError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestTLValidRecord  @coreServices @regression @positive @nationalDashboardIngest @ingestTL @digit_2_7
    Scenario: Ingest National dashboard data for TL
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestTLSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestTLDuplicateRecord  @coreServices @regression @nationalDashboardIngest @ingestTL @digit_2_7
    Scenario: Ingest duplicate data for TL
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestTLSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestTLError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestTLFutureDate  @coreServices @regression @nationalDashboardIngest @ingestTL @digit_2_7
    Scenario: Ingest duplicate data for TL
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestTLError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestTLInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestTL @digit_2_7
    Scenario: Ingest invalid date data for TL
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestTLError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestOBPSValidRecord  @coreServices @regression @positive  @nationalDashboardIngest @ingestOBPS @digit_2_7
    Scenario: Ingest National dashboard data for OBPS
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestOBPSSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestOBPSDuplicateRecord  @coreServices @regression  @nationalDashboardIngest @ingestOBPS @digit_2_7
    Scenario: Ingest duplicate data for OBPS
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestOBPSSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestOBPSError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestOBPSFutureDate  @coreServices @regression  @nationalDashboardIngest @ingestOBPS @digit_2_7
    Scenario: Ingest future date data for OBPS
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestOBPSError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestOBPSInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestOBPS @digit_2_7
    Scenario: Ingest invalid date data for OBPS
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestOBPSError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate


    @ingestLiveCommonValidRecord  @coreServices @regression @positive @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest National dashboard Common Live data
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def statusCommon = statusLive
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestOnBoardedCommonValidRecord  @coreServices @regression @positive @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest National dashboard Common OnBoarded data
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def statusCommon = statusOnBoarded
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonSuccessfully')
        * match ingestResponseBody == '#present'

    @ingestLiveCommonDuplicateRecord  @coreServices @regression @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest duplicate Live data
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def statusCommon = statusLive
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist

    @ingestOnBoardedCommonDuplicateRecord  @coreServices @regression @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest duplicate OnBoarded data
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-20' + (randomNumber(10)+12)
        * def statusCommon = statusOnBoarded
        * def ward = ingestConstants.parameters.ward[randomNumber(ingestConstants.parameters.ward.length)]
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonSuccessfully')
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.recordAlreadyExist


    @ingestLiveCommonFutureDate  @coreServices @regression @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest Live data for future date
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * def statusCommon = statusLive
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestOnBoardedCommonFutureDate  @coreServices @regression @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest OnBoarded data for future date
        # calling ingest pretest
        * def date = (randomNumber(18)+10) +'-0' + randomNumber(9)+'-210' + randomNumber(9)
        * def statusCommon = statusOnBoarded
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.futureDate

    @ingestLiveCommonInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest Live data for invalid date
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * def statusCommon = statusLive
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate

    @ingestOnBoardedCommonInvalidDate  @coreServices @regression  @nationalDashboardIngest @ingestCommon @digit_2_7
    Scenario: Ingest OnBoarded data for invalid date
        # calling ingest pretest
        * def date = randomNumber(10)+'-' + randomNumber(10)+'-21' + randomNumber(10)
        * def statusCommon = statusOnBoarded
        * call read('../../core-services/pretests/nationalDashboardIngestPretest.feature@ingestCommonError')
        * match ingestResponseBody == '#present'
        * match ingestResponseBody.Errors[0].message == ingestConstants.errorMessages.invalidDate