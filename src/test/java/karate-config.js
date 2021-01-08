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
    	tenantId = 'pb';
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
        config.invalidSearch = envProps.host + path.endPoints.localization.invalidSearch;
        //localizationSearchV2URL
        config.localizationSearchV2Url = envProps.host + path.endPoints.localization.v2SearchLocalization;
        config.invalidV2Search = envProps.host + path.endPoints.localization.invalidV2Search;
        //localizationUpdateURL
        config.localizationUpdateMessagesUrl = envProps.host + path.endPoints.localization.updateLocalization;
        config.invalidUpdate = envProps.host + path.endPoints.localization.invalidUpdate;
        //localizationDeleteURL
        config.localizationDeleteMessagesUrl = envProps.host + path.endPoints.localization.deleteLocalization;
        //localizationCreateURL
        config.localizationCreateMessagesUrl = envProps.host + path.endPoints.localization.createLocalization;
        
        //authTokenUrl
        config.authTokenUrl = envProps.host + path.endPoints.authenticationToken.authToken;
        
        //upsertUrl
        config.upsertUrl = envProps.host + path.endPoints.localization.upsertLocalization;
        config.invalidUpsert = envProps.host + path.endPoints.localization.invalidUpsert;

        //create user
        config.createUser = envProps.host + path.endPoints.citizen.createUser;

        //search user
        config.searchUser = envProps.host + path.endPoints.citizen.searchUser;
        
        //UserOtp
        config.userOtpRegisterUrl = envProps.host + path.endPoints.citizenRegisterAndLogin.sendOtpUser;
        config.invalidSendOpUser = envProps.host + path.endPoints.citizenRegisterAndLogin.invalidSendOpUser;

        //File store crete
        config.fileStoreCreate = envProps.host + path.endPoints.fileStore.createFileStore

        //Get file id
        config.fileStoreGet = envProps.host + path.endPoints.fileStore.getFileStore

        //Search location
        config.searchloc = envProps.host + path.endPoints.location.searchLocation
        config.invalidLocationService = envProps.host + path.endPoints.location.invalidLocationService

        //idGenerate
        config.idGenerateUrl = envProps.host + path.endPoints.idGenerate.idGeneate;

        //searchmdms service
        config.searchMdmsUrl = envProps.host + path.endPoints.mdmsService.searchMdms;

        //invalid search mdms service
        config.invalidSearchMdms = envProps.host + path.endPoints.mdmsService.invalidSearchMdms;

        //Searcher
        config.searcherUrl = envProps.host + path.endPoints.searcher.searcher;

        config.searcherWSUrl = envProps.host + path.endPoints.searcher.searcherWS;

        config.searcherSWUrl = envProps.host + path.endPoints.searcher.searcherSW;
        config.invalidSearcher = envProps.host + path.endPoints.searcher.invalidSearcher

        //Report
        config.metadataGetReport = envProps.host + path.endPoints.reports.metadataGetReport

        //Get Report
        config.getReport = envProps.host + path.endPoints.reports.getReport
        config.invalidReportService = envProps.host + path.endPoints.reports.invalidReportService

        //hrmsCreate
        config.hrmsCreateUrl = envProps.host + path.endPoints.hrms.hrmsCreate;

        //hrmsSearch
        config.hrmsSearchUrl = envProps.host + path.endPoints.hrms.hrmsSearch;
        config.invalidHrms = envProps.host + path.endPoints.hrms.invalidHrms;




    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

