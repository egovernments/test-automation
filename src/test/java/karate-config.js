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
    
    if(!tenantId){
    	tenantId = 'pb.amritsar';
    }

    
    var envProps = karate.read('file:envYaml/' + env + '/' + env +'.yaml');
    var path = karate.read('file:envYaml/common/common.yaml');
    var userData = karate.read('../userDetails/' + env + '/' + 'userDetails.yaml');
    
    
    var config = {
        env : env,
        tenantId : tenantId,
		locale : locale,
        retryCount : 30,
        retryInterval : 10000 //ms
    };
        
        //username & password for authtoken
        config.counterEmployeeUserName = userData.superUserCounterEmployee.userName;
        config.counterEmployeePassword = userData.superUserCounterEmployee.password;

        //tenantId
        config.tenantId = envProps.tenantId;

        
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
<<<<<<< HEAD
        config.createUser = envProps.host + path.endPoints.citizen.create;
=======
        config.createUser = envProps.host + path.endPoints.citizen.createUser;
>>>>>>> f484628170878a5972a6530fbda854ac146c12e5

        //Create Citizen
        config.createCitizen = envProps.host + path.endPoints.citizen.createCitizen;

        //search user
<<<<<<< HEAD
        config.searchUser = envProps.host + path.endPoints.citizen.search;
        
        //UserOtp
        config.userOtpRegisterUrl = envProps.host + path.endPoints.userOtp.sendOtp;

        //File store crete
        config.fileStoreCreate = envProps.host + path.endPoints.fileStore.create;

        //Get file id
        config.fileStoreGet = envProps.host + path.endPoints.fileStore.getFileId;

        //Search location
        config.searchloc = envProps.host + path.endPoints.location.search;
=======
        config.searchUser = envProps.host + path.endPoints.citizen.searchUser;
        
        //UserOtp
        config.userOtpRegisterUrl = envProps.host + path.endPoints.userOtp.sendOtpUser;

        //File store crete
        config.fileStoreCreate = envProps.host + path.endPoints.fileStore.createFileStore;

        //Get file id
        config.fileStoreGet = envProps.host + path.endPoints.fileStore.getFileStore;

        //Search location
        config.searchloc = envProps.host + path.endPoints.location.searchLocation;
>>>>>>> f484628170878a5972a6530fbda854ac146c12e5

        //idGenerate
        config.idGenerateUrl = envProps.host + path.endPoints.idGenerate.idGeneate;

        //searchmdms service
<<<<<<< HEAD
        config.searchMdmsUrl = envProps.host + path.endPoints.mdmsService.search;
=======
        config.searchMdmsUrl = envProps.host + path.endPoints.mdmsService.searchMdms;
>>>>>>> f484628170878a5972a6530fbda854ac146c12e5

        //Searcher
        config.searcherUrl = envProps.host + path.endPoints.searcher.searcher;

        config.searcherWSUrl = envProps.host + path.endPoints.searcher.searcherWS;

        config.searcherSWUrl = envProps.host + path.endPoints.searcher.searcherSW;

        //Report
<<<<<<< HEAD
        config.metadataGetReport = envProps.host + path.endPoints.reports.metadataGet;

        //Get Report
        config.getReport = envProps.host + path.endPoints.reports.get;
=======
        config.metadataGetReport = envProps.host + path.endPoints.reports.metadataGetReport;

        //Get Report
        config.getReport = envProps.host + path.endPoints.reports.getReport;
>>>>>>> f484628170878a5972a6530fbda854ac146c12e5

        //hrmsCreate
        config.hrmsCreateUrl = envProps.host + path.endPoints.hrms.hrmsCreate;

        //hrmsSearch
        config.hrmsSearchUrl = envProps.host + path.endPoints.hrms.hrmsSearch;
        
        //hrmsUpdate
<<<<<<< HEAD
        config.hrmsUpdateUrl = envProps.host + path.endPoints.hrms.hrmsUpdate;

        //pgServices
        config.pgServices = envProps.host + path.endPoints.pgServices.create
        config.pgServicesUpdate = envProps.host + path.endPoints.pgServices.update
        config.pgServicesSearch = envProps.host + path.endPoints.pgServices.search

=======
        config.hrmsUpdateUrl = envProps.host + path.endPoints.hrms.hrmsUpdate
>>>>>>> f484628170878a5972a6530fbda854ac146c12e5

        //accessControlSearch
        config.accessControlSearchUrl = envProps.host + path.endPoints.accessControl.search;

        config.accessControlInvalidSearchMethodUrl = envProps.host + path.endPoints.accessControl.invalidSearchMethod;

<<<<<<< HEAD
        //pg services
        config.workFlowProcess = envProps.host + path.endPoints.eGovWorkFlowV2Process.search

        //billing service
        config.fetchBill = envProps.host + path.endPoints.billingService.fetchBill

=======
>>>>>>> f484628170878a5972a6530fbda854ac146c12e5

    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

