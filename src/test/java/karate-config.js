function() {
    var env = karate.env; // get system property 'karate.env'
    var locale = karate.properties['locale']; // get system property 'karate.locale'
    var tenantId = karate.properties['tenantId']; // get system property 'karate.tenantId'

    if (!env) {
        env = 'qa'; //intelligent default
    }
    
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

    if(!tenantId){
         var stateCode = 'pb';
         var cityCode = 'amritsar';
         tenantId = stateCode + '.' + cityCode;
    }

  try{

   var config = {
         env : env,
         stateCode : envProps.stateCode,
         cityCode : envProps.cityCode,
         tenantId : tenantId,
         locale : locale,
         retryCount : 30,
         retryInterval : 10000 //ms
   };
        
        config.envHost = envProps.host

        //username & password for authtoken
        config.stateCode = envProps.stateCode;
        
         //username & password for Existing User Profile
         config.employeeUserName = envProps.employee.userName;
         config.employeePassword = envProps.employee.password;
         //config.existingUserTenantId = envProps.existingUser.tenantId
         config.employeeType = envProps.employee.type;

         // username & password for global super user
         config.authUsername = envProps.superUser.userName;
         config.authPassword = envProps.superUser.password;
         config.authUserType = envProps.superUser.type;

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
        config.createpropertyUrl =  envProps.host + path.endPoints.propertyService.create
        config.updatePropertyUrl =  envProps.host + path.endPoints.propertyService.update
        config.searchPropertyUrl =  envProps.host + path.endPoints.propertyService.search
        //apportion
        config.apportionUrl = envProps.host + path.endPoints.apportion.bill;
        //dashboard
        config.configHomeUrl = envProps.host + path.endPoints.dashboard.getDashboardConfig;
        config.getChartUrl = envProps.host + path.endPoints.dashboard.getChartV2;
        //encService
        config.encryptUrl = envProps.localhost + path.endPoints.encService.encrypt;
        config.decryptUrl = envProps.localhost + path.endPoints.encService.decrypt;
        config.rotateKeyUrl = envProps.localhost + path.endPoints.encService.rotateKey;
        config.verifyUrl = envProps.localhost + path.endPoints.encService.verify;
        config.signUrl = envProps.localhost + path.endPoints.encService.sign;

        //eGovWorkFlow Business
        config.businessSearch = envProps.host + path.endPoints.eGovWorkFlowBusiness.search

        //url shorten
        config.shortenUrl = envProps.host + path.endPoints.urlShorten.shorten

        //egfMaster chart of account
        config.chartOfAccountCreate = envProps.host + path.endPoints.egfMasterChartOfAccount.create
        config.charOfAccountSearch = envProps.host + path.endPoints.egfMasterChartOfAccount.search
        config.chartOfAccountUpdate = envProps.host + path.endPoints.egfMasterChartOfAccount.update

        // Calling pretest features which is consumed by almost all tests
        var fileUploadResponse = karate.callSingle('../../common-services/pretests/fileStoreUpload.feature', config);
        config.fileStoreId = fileUploadResponse.fileStoreId

        var authTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature', config);
        config.authToken = authTokenResponse.authToken;

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

    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);

    return config;
    }catch(e){
        karate.log(java.lang.String.format("Terminating execution due to %s in configuration", e))
        java.lang.System.exit(0);
    }
}