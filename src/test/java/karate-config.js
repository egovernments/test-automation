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
    
    var envProps = karate.read('file:envYaml/' + env + '/' + env +'.yaml');
    var path = karate.read('file:envYaml/common/common.yaml');
    var userData = karate.read('../../common-services/userDetails/' + env + '/' + 'userDetails.yaml');
    
    if(!tenantId){
        var stateCode = 'pb';
        var cityCode = 'amritsar';
    	tenantId = stateCode + '.' + cityCode;
    }

    var config = {
        env : env,
        stateCode : envProps.stateCode,
        cityCode : envProps.cityCode,
        tenantId : tenantId,
		locale : locale,
        retryCount : 30,
        retryInterval : 10000 //ms
    };
        
        //username & password for authtoken
        config.stateCode = envProps.stateCode;
        config.counterEmployeeUserName = userData.superUserCounterEmployee.userName;
        config.counterEmployeePassword = userData.superUserCounterEmployee.password;

        //username & password for authtoken of Super User
        config.superUserUserName = userData.superUser.userName;
        config.superUserPassword = userData.superUser.password;
        config.superUserTenantId = userData.superUser.stateCode + '.' + userData.superUser.cityCode;
        config.superUserAuthUserType = userData.superUser.authUserType;

        // username & password for Employee type user
        config.employeeUserName = userData.employee.userName;
        config.employeePassword = userData.employee.password;
        config.employeeType = userData.employee.type;

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

    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

