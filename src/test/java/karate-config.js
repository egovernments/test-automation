function() {
    var env = karate.env; // get system property 'karate.env'
    var locale = karate.properties['locale']; // get system property 'karate.locale'
    var tenantId = karate.properties['tenantId']; // get system property 'karate.tenantId'
    var envProFile = karate.properties['envProFile']; // get system property 'karate.envProFile'
    

    if (!env) {
        env = 'qa'; //intelligent default
    }
    
    if(!locale){
    	locale = 'en_IN';
    }
    
    if(!tenantId){
    	tenantId = 'pb';
    }
    
    if(!envProFile){
    	envProFile = 'qa-pb'
    }

    var baseurl = karate.read('classpath:envYaml/common/commonurl.yaml');
    var test = baseurl.urls[env];
   // var baseurl = karate.read('classpath:envYaml/'+common+ '/'+commonurl.yaml+ '/'+urls+ '/' +env+ '/');
   	var envProps = karate.read('classpath:envYaml/' + env + '/' + envProFile +'.yaml');
    
   	
   	print("****************************" + envProps)
    
    var config = {
        env : env,
        tenantId : tenantId,
        envProFile : envProFile,
		locale : locale,
        retryCount : 30,
        retryInterval : 10000 //ms
    };

        config.counterEmployeeUserName = envProps.counterEmployeeUserName;
        config.counterEmployeePassword = envProps.counterEmployeePassword;
        
        config.docVerifierUserName = envProps.docVerifierUserName;
        config.docVerifierPassword = envProps.docVerifierPassword;
        
        config.fieldInspectorUserName = envProps.fieldInspectorUserName;
        config.fieldInspectorPassword = envProps.fieldInspectorPassword;
        
        config.approverUserName = envProps.approverUserName;
        config.approverPassword = envProps.approverPassword;
        
        // set address and tenantReqId
        config.tenantIdReq = envProps.tenantIdReq;
        config.address = envProps.address
        
        //localizationURL
        config.localizationMessagesUrl = baseurl.urls.baseUrl_qa + envProps.urls.localization_SearchUrl;
        
        //authTokenUrl
        config.authTokenUrl = envProps.urls.authTokenUrl;
        config.authorityHeader = envProps.urls.authorityHeader;
        
        //propertyCreationUrl
        config.propertyCreationUrl = envProps.urls.propertyCreationUrl;
        
        //mdmsUrl
        config.mdmsUrl = envProps.urls.mdmsUrl;
        
        //authReferer
        config.authReferer = envProps.urls.authReferer;
        
        //upsertUrl
        config.upsertUrl = baseurl.urls.baseUrl_qa + envProps.urls.localization_UpserthUrl;
        
        
        //filestore
        config.getFileUrl = envProps.urls.getFileUrl;
        config.createFileUrl = envProps.urls.createFileUrl;

  		//application status
        config.applicationStatusUrl = envProps.urls.applicationStatusUrl;
        
        //UserOtp
        config.userOtpRegisterUrl= test + envProps.urls.userOtp_SendUrl;

        print("****************************new url **************" + config.userOtpRegisterUrl);


    karate.log('karate.env:', env);
    karate.log('locale:', locale);
    karate.log('tenantId:', tenantId);
    karate.log('envProFile:', envProFile);
    
    karate.configure('readTimeout', 120000);
    

    return config;
}

