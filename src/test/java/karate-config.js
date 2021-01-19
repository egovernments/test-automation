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

        //username & password for authtoken of Super User
        config.superUserUserName = userData.superUser.userName;
        config.superUserPassword = userData.superUser.password;
        config.superUserTenantId = userData.superUser.tenantId;
        config.superUserAuthUserType = userData.superUser.authUserType;

        // username & password for Employee type user
        config.employeeUserName = userData.employee.userName;
        config.employeePassword = userData.employee.password;
        config.employeeType = userData.employee.type;

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
        config.createUser = envProps.host + path.endPoints.citizen.createUser;

        //Create Citizen
        config.createCitizen = envProps.host + path.endPoints.citizen.createCitizen;

        //search user
        config.searchUser = envProps.host + path.endPoints.citizen.searchUser;
        
        //UserOtp
        config.userOtpRegisterUrl = envProps.host + path.endPoints.userOtp.sendOtpUser;

        //File store crete
        config.fileStoreCreate = envProps.host + path.endPoints.fileStore.createFileStore;

        //Get file id
        config.fileStoreGet = envProps.host + path.endPoints.fileStore.getFileStore;

        //Search location
        config.searchloc = envProps.host + path.endPoints.location.searchLocation;

        //idGenerate
        config.idGenerateUrl = envProps.host + path.endPoints.idGenerate.idGeneate;

        //searchmdms service
        config.searchMdmsUrl = envProps.host + path.endPoints.mdmsService.searchMdms;

        //Searcher
        config.searcherUrl = envProps.host + path.endPoints.searcher.searcher;

        config.searcherWSUrl = envProps.host + path.endPoints.searcher.searcherWS;

        config.searcherSWUrl = envProps.host + path.endPoints.searcher.searcherSW;

        //Report
        config.metadataGetReport = envProps.host + path.endPoints.reports.metadataGetReport;

        //Get Report
        config.getReport = envProps.host + path.endPoints.reports.getReport;

        //hrmsCreate
        config.hrmsCreateUrl = envProps.host + path.endPoints.hrms.create;

        //hrmsSearch
        config.hrmsSearchUrl = envProps.host + path.endPoints.hrms.search;

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

        // Create Assessment
        config.createAssessment =  envProps.host + path.endPoints.collectionServices.assessmentCreate
       // Fetch Bill
        config.fetchBill =  envProps.host + path.endPoints.collectionServices.fetchBill
      // Create Payment
        config.payment =  envProps.host + path.endPoints.collectionServices.createPayment
        config.collectionServiceWorkflowUrl = envProps.host + path.endPoints.collectionServices.workflow


    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

