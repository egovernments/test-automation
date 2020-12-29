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

    //var envProps = karate.read('Classpath:envYaml/' + env + '/' + env +'.yaml');
    //var envProps = karate.read('envYaml/' + env + '/' + env +'.yaml');

    //var path = karate.read('Classpath:envYaml/common/common.yaml');
    //var path = karate.read('envYaml/common/common.yaml');

    //var userData = karate.read('../userDetails/' + env + '/' + 'userDetails.yaml');

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
        config.counterEmployeeUserName = userData.counterEmployee.userName;
        config.counterEmployeePassword = userData.counterEmployee.password;

        //tenantId
        config.tenantId = envProps.tenantId;

        
        //localizationURL
        config.localizationMessagesUrl = envProps.host + path.endPoints.localizationSearch;
        //localizationSearchV2URL
        config.localizationSearchV2Url = envProps.host + path.endPoints.localizationV2Search;
        //localizationUpdateURL
        config.localizationUpdateMessagesUrl = envProps.host + path.endPoints.localizationUpdate;
        //localizationDeleteURL
        config.localizationDeleteMessagesUrl = envProps.host + path.endPoints.localizationDelete;
        //localizationCreateURL
        config.localizationCreateMessagesUrl = envProps.host + path.endPoints.localizationCreate;
        
        //authTokenUrl
        config.authTokenUrl = envProps.host + path.endPoints.authToken;
        
        //upsertUrl
        config.upsertUrl = envProps.host + path.endPoints.localizationUpsert;

        //create user
        config.createUser = envProps.host + path.endPoints.createUser;

        //search user
        config.searchUser = envProps.host + path.endPoints.searchUser;
        
        //UserOtp
        config.userOtpRegisterUrl = envProps.host + path.endPoints.userOtpSend;

        //File store crete
        config.fileStoreCreate = envProps.host + path.endPoints.fileStoreCreate

        //Get file id
        config.fileStoreGet = envProps.host + path.endPoints.fileStoreGet

        //Search location
        config.searchloc = envProps.host + path.endPoints.searchLocation

        //idGenerate
        config.idGenerateUrl = envProps.host + path.endPoints.idGeneate;

        //searchmdms service
        config.searchMdmsUrl = envProps.host + path.endPoints.searchMdms;



    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

