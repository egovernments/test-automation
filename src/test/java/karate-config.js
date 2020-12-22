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

    var envProps = karate.read('Classpath:envYaml/' + env + '/' + env +'.yaml');
    //var envProps = karate.read('envYaml/' + env + '/' + env +'.yaml');

    var path = karate.read('Classpath:envYaml/common/common.yaml');
    //var path = karate.read('envYaml/common/common.yaml');

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



    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

