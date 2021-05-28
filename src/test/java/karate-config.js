function() {
    var env = karate.env; // get system property 'karate.env'
    var locale = karate.properties['locale']; // get system property 'karate.locale'
    var tenantId = karate.properties['tenantId']; // get system property 'karate.tenantId'

    if(!locale){
    	locale = 'en_IN';
    }

    if(!karate.properties['configPath']){
        karate.log(java.lang.String.format("Terminating execution due to %s config file path",
        karate.properties['configPath']))
        java.lang.System.exit(0);
    }

    var envProps = karate.read('file:' + karate.properties['configPath']);

    var path = karate.read('file:envYaml/common/common.yaml');

  try{

   var config = {
         env : env,
         basicAuthorization: envProps.basicAuthorization,
         stateCode : envProps.stateCode,
         cityCode : envProps.cityCode,
         locale : locale,
         retryCount : 30,
         retryInterval : 10000 //ms
   };

   if(karate.properties['useKafkaSimulation']){
       if(karate.properties['useKafkaSimulation'] == 'yes'){
        config.kafkaHost = envProps.mockHost
       }
   }else{
    config.kafkaHost = envProps.host
   }
        
        config.envHost = envProps.host
        config.envLocalhost = envProps.localhost
        config.envMockHost = envProps.mockhost
        config.kafkaOffsetThresholdPercentage = envProps.kafkaOffsetThresholdPercentage

        //username & password for authtoken
        config.stateCode = envProps.stateCode;
        
         //username & password for Existing User Profile
         config.employeeUserName = envProps.employee.userName;
         config.employeePassword = envProps.employee.password;
         config.employeeType = envProps.employee.type;

         // username & password for global super user
         config.authUsername = envProps.superUser.userName;
         config.authPassword = envProps.superUser.password;
         config.authUserType = envProps.superUser.type;

         // username & password for Citizen user
         config.citizenUsername = envProps.citizen.userName;
         config.citizenPassword = envProps.citizen.password;
         config.citizenType = envProps.citizen.type;
        
         // username & password for alternate Citizen user
         config.altCitizenUsername = envProps.alternateCitizen.userName;
         config.altCitizenPassword = envProps.alternateCitizen.password;
         config.altCitizenType = envProps.alternateCitizen.type;

         // username & password for Approver user
         config.approverUsername = envProps.superUser.userName;
         config.approverPassword = envProps.superUser.password;
         config.approverType = envProps.superUser.type;

         // username & password for Counter Employee user
         config.counterEmployeeUsername = envProps.counterEmployeeUser.userName;
         config.counterEmployeePassword = envProps.counterEmployeeUser.password;
         config.counterEmployeeType = envProps.counterEmployeeUser.type;
        
         // username & password for Architect Employee user
         config.citizenArchitectUsername = envProps.citizenArchitect.userName;
         config.citizenArchitectPassword = envProps.citizenArchitect.password;
         config.citizenType = envProps.citizen.type;

       //  username & password for Architect Employee user
         config.citizenArchitectUsername = envProps.citizenArchitect.userName;
         config.citizenArchitectPassword = envProps.citizenArchitect.password;
         config.citizenType = envProps.citizen.type;
        //tenantId
        config.tenantId = envProps.stateCode + '.' + envProps.cityCode;

        
        //localizationURL
        config.localizationMessagesUrl = envProps.host + path.endPoints.localization.searchLocalization;

        //localizationSearchV2URL
        config.localizationSearchV2Url = envProps.host + path.endPoints.localization.v2SearchLocalization;

        //localizationUpdateURL
        config.localizationUpdateMessagesUrl = envProps.host + path.endPoints.localization.updateLocalization;

        //localizationDeleteURL
        config.localizationDeleteMessagesUrl = envProps.host + path.endPoints.localization.deleteLocalization;
        //localizationCreateURL
        config.localizationCreateMessagesUrl = envProps.host + path.endPoints.localization.createLocalization;
        
        //authTokenUrl
        config.authTokenUrl = envProps.host + path.endPoints.authenticationToken.authToken;
        
        //upsertUrl
        config.upsertUrl = envProps.host + path.endPoints.localization.upsertLocalization;

        //create user
        config.createUser = envProps.host + path.endPoints.citizen.create;

        //Create Citizen
        config.createCitizen = envProps.host + path.endPoints.citizen.createCitizen;

        //search user
        config.searchUser = envProps.host + path.endPoints.citizen.search;
        
        //UserOtp
        config.userOtpRegisterUrl = envProps.host + path.endPoints.userOtp.sendOtp;

        //File store crete
        config.fileStoreCreate = envProps.host + path.endPoints.fileStore.create;

        //Get file id
        config.fileStoreGet = envProps.host + path.endPoints.fileStore.getFileId;

        //Search location
        config.searchloc = envProps.host + path.endPoints.location.search;

        //idGenerate
        config.idGenerateUrl = envProps.host + path.endPoints.idGenerate.idGeneate;

        //searchmdms service
        config.searchMdmsUrl = envProps.host + path.endPoints.mdmsService.search;
        //get mdms service
        config.getMdmsUrl = envProps.host + path.endPoints.mdmsService.get;

        //Searcher
        config.searcherUrl = envProps.host + path.endPoints.searcher.searcher;

        config.searcherWSUrl = envProps.host + path.endPoints.searcher.searcherWS;

        config.searcherSWUrl = envProps.host + path.endPoints.searcher.searcherSW;

        //Report
        config.metadataGetReport = envProps.host + path.endPoints.reports.metadataGet;

        //Get Report
        config.getReport = envProps.host + path.endPoints.reports.get;

        //hrmsCreate
        config.hrmsCreateUrl = envProps.host + path.endPoints.hrms.create;

        //hrmsSearch
        config.hrmsSearchUrl = envProps.host + path.endPoints.hrms.search;

        

        //pgServices
        config.pgServices = envProps.host + path.endPoints.pgServices.create
        config.pgServicesUpdate = envProps.host + path.endPoints.pgServices.update
        config.pgServicesSearch = envProps.host + path.endPoints.pgServices.search
        //hrmsUpdate
        config.hrmsUpdateUrl = envProps.host + path.endPoints.hrms.update

        //accessControlSearch
        config.accessControlSearchUrl = envProps.host + path.endPoints.accessControl.search;

        //Update user profile
        config.updateUser = envProps.host + path.endPoints.user.updateProfile;

        //Update user password
        config.updatePassword = envProps.host + path.endPoints.user.updatePassword;

        //Update user password without login - OTP
        config.updatePasswordNoLogin = envProps.host + path.endPoints.user.updateForgetPassword;

        // Fetch Bill
        config.fetchBill =  envProps.host + path.endPoints.collectionServices.fetchBill
        // Create Payment
        config.payment =  envProps.host + path.endPoints.collectionServices.createPayment
        // Workflow
        config.collectionServiceWorkflowUrl = envProps.host + path.endPoints.collectionServices.workflow
        // Search Payment
        config.searchPayment = envProps.host + path.endPoints.collectionServices.searchPayment
        // billing-service-demand
        config.createDemandUrl = envProps.host + path.endPoints.billingServiceDemand.create
        config.searchDemandUrl = envProps.host + path.endPoints.billingServiceDemand.search
        config.updateDemandUrl = envProps.host + path.endPoints.billingServiceDemand.update
        //eGov workflow
        config.workFlowProcess = envProps.host + path.endPoints.eGovWorkFlowV2Process.search
        config.workFlowProcessCount = envProps.host + path.endPoints.eGovWorkFlowV2Process.count
        config.workflowTransition = envProps.host + path.endPoints.eGovWorkFlowV2Process.transition
	      config.workFlowCreateURL = envProps.host + path.endPoints.eGovWorkFlowV2Process.businessServiceCreate
    	  config.workFlowSearchURL = envProps.host + path.endPoints.eGovWorkFlowV2Process.businessServiceSearch
    	  config.workFlowUpdateURL = envProps.host + path.endPoints.eGovWorkFlowV2Process.businessServiceUpdate
        //billing service
        config.fetchBill = envProps.host + path.endPoints.billingService.fetchBill
        config.searchBill = envProps.host + path.endPoints.billingService.search
        //pdf service
        config.createPdf = envProps.host + path.endPoints.pdfService.create
        config.createNoSavePdf = envProps.host + path.endPoints.pdfService.createNoSave
        // Property Service
        config.createAssessment =  envProps.host + path.endPoints.propertyService.assessmentCreate
        config.updateAssessment =  envProps.host + path.endPoints.propertyService.assessmentUpdate
        config.searchAssessment =  envProps.host + path.endPoints.propertyService.assessmentSearch
        config.createpropertyUrl =  envProps.host + path.endPoints.propertyService.create
        config.updatePropertyUrl =  envProps.host + path.endPoints.propertyService.update
        config.searchPropertyUrl =  envProps.host + path.endPoints.propertyService.search
        //apportion
        config.apportionUrl = envProps.host + path.endPoints.apportion.bill;
        //dashboard
        config.configHomeUrl = envProps.host + path.endPoints.dashboard.getDashboardConfig;
        config.getChartUrl = envProps.host + path.endPoints.dashboard.getChartV2;
        //encService
        config.encryptUrl = envProps.host + path.endPoints.encService.encrypt;
        config.decryptUrl = envProps.host + path.endPoints.encService.decrypt;
        config.rotateKeyUrl = envProps.host + path.endPoints.encService.rotateKey;
        config.verifyUrl = envProps.host + path.endPoints.encService.verify;
        config.signUrl = envProps.host + path.endPoints.encService.sign;
        //eGovWorkFlow Business
        config.businessSearch = envProps.host + path.endPoints.eGovWorkFlowBusiness.search
        //url shorten
        config.shortenUrl = envProps.host + path.endPoints.urlShorten.shorten
        //egfMaster chart of account
        config.chartOfAccountCreate = envProps.host + path.endPoints.egfMasterChartOfAccount.create
        config.charOfAccountSearch = envProps.host + path.endPoints.egfMasterChartOfAccount.search
        config.chartOfAccountUpdate = envProps.host + path.endPoints.egfMasterChartOfAccount.update
        // egfMaster-ChartOfAccountDetails - Create account details type
        config.accountDetailsType = envProps.host + path.endPoints.egfMasterChartOfAccountDetails.accountDetailsType
        // egfMaster-ChartOfAccountDetails - Create chart of account details
        config.createAccountDetails = envProps.host + path.endPoints.egfMasterChartOfAccountDetails.create
        // egfMaster-ChartOfAccountDetails - Update chart of account details
        config.updateAccountDetails = envProps.host + path.endPoints.egfMasterChartOfAccountDetails.update
        // egfMaster-ChartOfAccountDetails - Update chart of account details
        config.searchAccountDetails = envProps.host + path.endPoints.egfMasterChartOfAccountDetails.search
        // egfMaster-Bank - Create
        config.bankCreate = envProps.host + path.endPoints.egfMasterBank.create
        // egfMaster-Bank - Update
        config.bankUpdate = envProps.host + path.endPoints.egfMasterBank.update
        // egfMaster-Bank - Search
        config.bankSearch = envProps.host + path.endPoints.egfMasterBank.search
		    //egfMaster chart of account
        config.chartOfAccountCreate = envProps.host + path.endPoints.egfMasterChartOfAccount.create
        config.charOfAccountSearch = envProps.host + path.endPoints.egfMasterChartOfAccount.search
        config.chartOfAccountUpdate = envProps.host + path.endPoints.egfMasterChartOfAccount.update
		    //egfMaster bank of account
        config.backAccountCreate = envProps.host + path.endPoints.egfMasterBankAccount.create
        config.backAccountUpdate = envProps.host + path.endPoints.egfMasterBankAccount.update
        config.backAccountSearch = envProps.host + path.endPoints.egfMasterBankAccount.search
        // egfMaster - Bank Branches endpoints
        config.bankBranchCreate = envProps.host + path.endPoints.egfMasterBankBranches.create
        config.bankBranchUpdate = envProps.host + path.endPoints.egfMasterBankBranches.update
        config.bankBranchSearch = envProps.host + path.endPoints.egfMasterBankBranches.search
        // egfMaster - AccountDetailTypes endpoints
        config.accountDetailTypesCreate = envProps.host + path.endPoints.egfMasterAccountDetailTypes.create
        config.accountDetailTypesUpdate = envProps.host + path.endPoints.egfMasterAccountDetailTypes.update
        config.accountDetailTypesSearch = envProps.host + path.endPoints.egfMasterAccountDetailTypes.search
        // dashboard ingest endpoints
        config.dashboardIngestSave = envProps.host + path.endPoints.dashboardIngest.save
        config.dashboardIngestUpload = envProps.host + path.endPoints.dashboardIngest.upload
        config.dashboardIngestMigrate = envProps.host + path.endPoints.dashboardIngest.migrate
        // kafka rest proxy endpoints
        config.createKafkaConsumer = envProps.localhost + path.endPoints.kafkaService.create
        config.subscribeKafkaConsumer = envProps.localhost + path.endPoints.kafkaService.subscribe
        config.readKafkaConsumer = envProps.localhost + path.endPoints.kafkaService.read
        config.deleteKafkaConsumer = envProps.localhost + path.endPoints.kafkaService.delete

        // egfInstrument - Instrument types endpoints
        config.createInstrumentTypes = envProps.host + path.endPoints.egfInstrumentTypes.create
        config.searchInstrumentTypes = envProps.host + path.endPoints.egfInstrumentTypes.search
        config.updateInstrumentTypes = envProps.host + path.endPoints.egfInstrumentTypes.update

        // Property Calculator - Mutation service endpoints
        config.mutationBillingSlabCreate = envProps.host + path.endPoints.propertyCalculatorMutation.create
        config.mutationBillingSlabUpdate = envProps.host + path.endPoints.propertyCalculatorMutation.update
        config.mutationBillingSlabSearch = envProps.host + path.endPoints.propertyCalculatorMutation.search

        // egfInstrument - Instrument Account Code endpoints
        config.instrumentAccountCodeCreate = envProps.host + path.endPoints.egfInstrumentAccountCode.create
        config.instrumentAccountCodeSearch = envProps.host + path.endPoints.egfInstrumentAccountCode.search
        config.instrumentAccountCodeUpdate = envProps.host + path.endPoints.egfInstrumentAccountCode.update

        // egfInsturment - Surrender Reasons endpoint
        config.createSurrenderReasons = envProps.host + path.endPoints.egfInstrumentSurrenderReasons.create
        config.updateSurrenderReasons = envProps.host + path.endPoints.egfInstrumentSurrenderReasons.update
        config.searchSurrenderReasons = envProps.host + path.endPoints.egfInstrumentSurrenderReasons.search

        // egfInstrument - Instrument endpoints
        config.instrumentCreate = envProps.host + path.endPoints.egfInstrument.create
        config.instrumentUpdate = envProps.host + path.endPoints.egfInstrument.update
        config.instrumentSearch = envProps.host + path.endPoints.egfInstrument.search

        // Property Calculator - Billings Slab service endpoints
        config.billingSlabCreate = envProps.host + path.endPoints.propertyCalculatorBillingSlab.create
        config.billingSlabUpdate = envProps.host + path.endPoints.propertyCalculatorBillingSlab.update
        config.billingSlabSearch = envProps.host + path.endPoints.propertyCalculatorBillingSlab.search

        // Property Calculator - Property Tax Mutation Calculate Service endpoint
        config.mutationCalculate = envProps.host + path.endPoints.propertyCalculatorPropertyTax.calculate

        // PGR endpoints
        config.createPGRUrl = envProps.host + path.endPoints.pgr.create
        config.updatePGRUrl = envProps.host + path.endPoints.pgr.update
        config.searchPGRUrl = envProps.host + path.endPoints.pgr.search
        config.countPGRUrl = envProps.host + path.endPoints.pgr.count

        // NOC endpoints
        config.createNOCUrl = envProps.host + path.endPoints.noc.create
        config.updateNOCUrl = envProps.host + path.endPoints.noc.update
        config.searchNOCUrl = envProps.host + path.endPoints.noc.search

        //BillingSlabNOC
        config.createFireNOCBillingSlabUrl = envProps.host + path.endPoints.fireNOCBillingSlab.create
        config.searchFireNOCBillingSlabUrl = envProps.host + path.endPoints.fireNOCBillingSlab.search
        config.calculateFireNOCBillingSlabUrl = envProps.host + path.endPoints.fireNOCBillingSlab.calculate
        // ws-servcies : water connection
        config.createWaterConnection = envProps.host + path.endPoints.waterConnection.create
        config.updateWaterConnection = envProps.host + path.endPoints.waterConnection.update
        config.searchWaterConnection = envProps.host + path.endPoints.waterConnection.search

        // ws-calculator
        config.wsCalculatorEstimate = envProps.host + path.endPoints.wsCalculator.estimate
        config.wsCalculatorCalculate = envProps.host + path.endPoints.wsCalculator.calculate
        config.wsCalculatorCreateMeterConnection = envProps.host + path.endPoints.wsCalculator.meterConnectionCreate
        config.wsCalculatorSearchMeterConnection = envProps.host + path.endPoints.wsCalculator.meterConnectionSearch
        config.wsCalculatorApplyAdhocTax = envProps.host + path.endPoints.wsCalculator.applyAdhocTax
        // Property Calculator - Property Tax Service endpoint
        config.propertyTaxEstimate = envProps.host + path.endPoints.propertyCalculator.estimate
        config.propertyTaxCalculate = envProps.host + path.endPoints.propertyCalculator.calculator

        // TL-servcies : Trade License
        config.createTradeLicense = envProps.host + path.endPoints.tradeLicense.create
        config.updateTradeLicense = envProps.host + path.endPoints.tradeLicense.update
        config.searchTradeLicense = envProps.host + path.endPoints.tradeLicense.search

        // tl-calculator
        config.tlCalculatorGetBill = envProps.host + path.endPoints.tlCalculator.getBill
        config.tlCalculatorCreateBillingSlab = envProps.host + path.endPoints.tlCalculator.billingSlabCreate
        config.tlCalculatorUpdateBillingSlab = envProps.host + path.endPoints.tlCalculator.billingSlabUpdate
        config.tlCalculatorSearchBillingSlab = envProps.host + path.endPoints.tlCalculator.billingSlabSearch
        config.tlCalculatorCalculate = envProps.host + path.endPoints.tlCalculator.calculate

        // sw-servcies : sewerage connection
        config.createSewerageConnection = envProps.host + path.endPoints.sewerageConnection.create
        config.updateSewerageConnection = envProps.host + path.endPoints.sewerageConnection.update
        config.searchSewerageConnection = envProps.host + path.endPoints.sewerageConnection.search

        // BPA-Services
        config.createEdcrScrutinize = envProps.host + path.endPoints.bpaService.edcrScrutinize
        config.createBPA = envProps.host + path.endPoints.bpaService.create
        config.searchBPA = envProps.host + path.endPoints.bpaService.search
        config.updateBPA = envProps.host + path.endPoints.bpaService.update
        config.createBPAStakeHolder = envProps.host + path.endPoints.bpaService.createStakeHolder
        // BPA- Calculator
        config.calculateBPA = envProps.host + path.endPoints.bpaCalculator.calculate

        // Land Services
        config.createLand = envProps.host + path.endPoints.landService.create
        config.searchLand = envProps.host + path.endPoints.landService.search
        config.updateLand = envProps.host + path.endPoints.landService.update    
        
        //DCR-Services
        config.scrutinizeUrl = envProps.host + path.endPoints.dcrServices.scrutinize
        config.scrutinydetailsUrl = envProps.host + path.endPoints.dcrServices.scrutinydetails
        config.occomparisonUrl = envProps.host + path.endPoints.dcrServices.occomparison

        // Fire-Noc-Service
        config.createFireNocService = envProps.host + path.endPoints.firenocService.create
        config.searchFireNocService = envProps.host + path.endPoints.firenocService.search
        config.updateFireNocService = envProps.host + path.endPoints.firenocService.update

        // egov user event
        config.notificationEgovUserEvent = envProps.host + path.endPoints.eGovUserEvent.notificationCount
        config.createEgovUserEvent = envProps.host + path.endPoints.eGovUserEvent.create
        config.updateEgovUserEvent = envProps.host + path.endPoints.eGovUserEvent.update
        config.searchEgovUserEvent = envProps.host + path.endPoints.eGovUserEvent.search
        config.latUpdateEgovUserEvent = envProps.host + path.endPoints.eGovUserEvent.latUpdate

        // egov PDF 
        config.ptmutationcertificateEgovPDF = envProps.host + path.endPoints.eGovPdf.ptmutationcertificate
        config.consolidatedreceiptEgovPDF = envProps.host + path.endPoints.eGovPdf.consolidatedreceipt
        config.tlrenewalcertificateEgovPDF = envProps.host + path.endPoints.eGovPdf.tlrenewalcertificate
        config.tlreceiptEgovPDF = envProps.host + path.endPoints.eGovPdf.tlreceipt
        config.ptreceiptEgovPDF = envProps.host + path.endPoints.eGovPdf.ptreceipt
        config.ptbillEgovPDF = envProps.host + path.endPoints.eGovPdf.ptbill

        // fsm Service
        config.createFsmEvent = envProps.host + path.endPoints.fsmService.create
        config.updateFsmEvent = envProps.host + path.endPoints.fsmService.update
        config.searchFsmEvent = envProps.host + path.endPoints.fsmService.search
        config.auditFsmEvent = envProps.host + path.endPoints.fsmService.audit
        config.vendorCreateFsmEvent = envProps.host + path.endPoints.fsmService.vendorCreate
        config.vendorSearchFsmEvent = envProps.host + path.endPoints.fsmService.vendorSearch
        config.vehicalCreateFsmEvent = envProps.host + path.endPoints.fsmService.vehicalCreate
        config.vehicalSearchFsmEvent = envProps.host + path.endPoints.fsmService.vehicalSearch
        config.vehicalTripCreateFsmEvent = envProps.host + path.endPoints.fsmService.vehicalTripCreate
        config.vehicalTripSearchFsmEvent = envProps.host + path.endPoints.fsmService.vehicalTripSearch
        config.vehicalTripUpdateFsmEvent = envProps.host + path.endPoints.fsmService.vehicalTripUpdate
        //FSM Billing Slab
        config.createFSMBillingSlab = envProps.host + path.endPoints.fsmBillingSlab.create
        config.updateFSMBillingSlab = envProps.host + path.endPoints.fsmBillingSlab.update
        config.searchFSMBillingSlab = envProps.host + path.endPoints.fsmBillingSlab.search
        config.calculateFSMBillingSlab = envProps.host + path.endPoints.fsmBillingSlab.calculate
        config.estimateFSMBillingSlab = envProps.host + path.endPoints.fsmBillingSlab.estimate
        config.createFsmEvent = envProps.host + path.endPoints.fsm.create

        // Calling pretest features which is consumed by almost all tests
        var fileUploadResponse = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore', config);
        config.fileStoreId = fileUploadResponse.fileStoreId

        var citizenAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenCitizen', config);
        config.citizenAuthToken = citizenAuthTokenResponse.authToken;

        var AltitizenAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenOfAltCitizen', config);
        config.altCitizenAuthToken = AltitizenAuthTokenResponse.authToken;

        var citizenArchitectAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenCitizenArchitect', config);
        config.citizenArchitectAuthToken = citizenArchitectAuthTokenResponse.authToken;

        var fileUploadResponse1 = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore1', config);
        config.fileStoreId1 = fileUploadResponse1.fileStoreId

        var fileUploadResponse2 = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore2', config);
        config.fileStoreId2 = fileUploadResponse2.fileStoreId

        var fileUploadResponse3 = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore3', config);
        config.fileStoreId3 = fileUploadResponse3.fileStoreId

        var fileUploadResponse4 = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore4', config);
        config.fileStoreId4 = fileUploadResponse4.fileStoreId

        var fileUploadResponse5 = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature@uploadFileToFilestore5', config);
        config.fileStoreId5 = fileUploadResponse5.fileStoreId

        var citizenAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenCitizen', config);
        config.citizenAuthToken = citizenAuthTokenResponse.authToken;

        var approverAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenApprover', config);
        config.approverAuthToken = approverAuthTokenResponse.authToken;

        var authTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenSuperuser', config);
        config.superUserAuthToken = authTokenResponse.authToken;
        config.authToken = authTokenResponse.authToken;
        config.uuid = authTokenResponse.id;

        var citizenArchitectAuthTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature@authTokenCitizenArchitect', config);
        config.citizenArchitectAuthToken = citizenArchitectAuthTokenResponse.authToken;


        var MdmsCityResponse = karate.callSingle('../../common-services/pretests/egovMdmsPretest.feature@searchMdmsSuccessfullyByCity', config);
        var MdmsCityRes = MdmsCityResponse.MdmsCityRes
        config.mdmsCityEgovLocation = MdmsCityRes['egov-location']
        config.mdmsCityTenant = MdmsCityRes.tenant

        
        var MdmsStateResponse = karate.callSingle('../../common-services/pretests/egovMdmsPretest.feature@searchMdmsSuccessfullyByState', config);
        var MdmsStateRes = MdmsStateResponse.MdmsStateRes
        config.mdmsStatePropertyTax = MdmsStateRes.PropertyTax
        config.mdmsStatetenant = MdmsStateRes.tenant
        config.mdmsStateBillingService = MdmsStateRes.BillingService
        config.mdmsStatecommonMasters = MdmsStateRes['common-masters']
        config.mdmsStateAccessControlRoles = MdmsStateRes['ACCESSCONTROL-ROLES']
        config.mdmsStateEgovHrms = MdmsStateRes['egov-hrms']
        config.mdmsStateDashboard = MdmsStateRes['dss-dashboard']
        config.mdmsStateDashboardConfig = config.mdmsStateDashboard['dashboard-config']
        config.msmsCityPgrServiceCodes = MdmsCityRes['RAINMAKER-PGR'].ServiceDefs 
        config.mdmsStateTradeLicense = MdmsStateRes['TradeLicense']
        config.mdmsStateBPA = MdmsStateRes['BPA']
        config.mdmsStateFireNocService = MdmsStateRes['firenoc']
        config.mdmsStateEgfMasterService = MdmsStateRes['egf-master']
        config.mdmsStateFsmService = MdmsStateRes['FSM']
        config.mdmsStatebpaChecklist = MdmsStateRes.BPA.CheckList;


        var driverConfig = { type: 'chrome', headless: false, addOptions: [ '--disable-geolocation', '--start-maximized', '--disable-notifications'], prefs : { 'profile.default_content_setting_values.geolocation': 2} };
        karate.configure('driver', driverConfig);
        config.driverConfig = driverConfig;

    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', config.tenantId);
    
    karate.configure('readTimeout', 120000);

    return config;
    }catch(e){
        karate.log(java.lang.String.format("Terminating execution due to %s in configuration", e))
        java.lang.System.exit(0);
    }
}