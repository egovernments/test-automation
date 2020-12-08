function() {
    var env = karate.env; // get system property 'karate.env'
    var locale = karate.properties['locale']; // get system property 'karate.locale'
    var tenantId = karate.properties['tenantId']; // get system property 'karate.tenantId'
    //var envProFile = karate.properties['envProFile']; // get system property 'karate.envProFile'
    //var host;

    if (!env) {
        env = 'qa'; //intelligent default
    }
    
    if(!locale){
    	locale = 'en_IN';
    }
    
    if(!tenantId){
    	tenantId = 'pb';
    }
    
    //if(!envProFile){
    //	envProFile = 'qa'
   // }

    var envProps = karate.read('classpath:envYaml/' + env + '/' + env +'.yaml');

    var path = karate.read('classpath:envYaml/common/common.yaml');

    var userData = karate.read('classpath:userDetails/' + env + '/' + 'userDetails.yaml');
    //var basePath = path.endPoints[env];
   	//var envProps = karate.read('classpath:envYaml/' + env + '/' + envProFile +'.yaml');
    
   	
   	//print("****************************" + envProps)
    
    var config = {
        env : env,
        tenantId : tenantId,
        //envProFile : envProFile,
		locale : locale,
        retryCount : 30,
        retryInterval : 10000 //ms
    };
        
        

        config.counterEmployeeUserName = userData.counterEmployee.userName;
        config.counterEmployeePassword = userData.counterEmployee.password;
        
        //config.docVerifierUserName = envProps.docVerifierUserName;
        //config.docVerifierPassword = envProps.docVerifierPassword;
        
        //config.fieldInspectorUserName = envProps.fieldInspectorUserName;
        //config.fieldInspectorPassword = envProps.fieldInspectorPassword;
        
        //config.approverUserName = envProps.approverUserName;
        //config.approverPassword = envProps.approverPassword;
        
        // set address and tenantReqId
        config.tenantIdReq = userData.tenantIdReq;
        
        //localizationURL
        config.localizationMessagesUrl = envProps.host + path.endPoints.localizationSearch;
        
        //authTokenUrl
        config.authTokenUrl = envProps.host + path.endPoints.authToken;
        
        //upsertUrl
        config.upsertUrl = envProps.host + path.endPoints.localizationUpsert;
        
        //UserOtp
        config.userOtpRegisterUrl= envProps.host + path.endPoints.userOtpSend;

        //print("****************************new url **************" + config.userOtpRegisterUrl);


    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    //karate.log('envProFile:', envProFile);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

