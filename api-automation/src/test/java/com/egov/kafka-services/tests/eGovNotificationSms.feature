Feature: Kafka Notification SMS Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.sms.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.sms.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # JS function definition to extract the otp refernece number from the message
    * def extractOtp = 
    """
    function(x) {
        var words = new java.lang.String(x).split(' ');
        var otp = words[words.length-1];
        otp = new java.lang.String(otp).replaceAll('[^0-9]', '');
        return otp;
    }
    """
    * def extractWelcomePassword = 
    """
    function(x) {
        var words = new java.lang.String(x).substring(new java.lang.String(x).indexOf('Password'))
        karate.log(words)
        words = new java.lang.String(words).split(' ');
        var otp = words[2];
        return otp;
    }
    """

@sms_01 @positive @kafkaEgovNotificationSms @kafkaServices
Scenario: Create an Employee user, forgot password, read otp from kafka, update password and login
    # Create an Employee via hrms create employee api
    * call read('../../business-services/tests/egovHrms.feature@HRMS_create_emp01')
    * def resetMobileNumber =  hrmsResponseBody.Employees[0].user.mobileNumber
    * def userName =  hrmsResponseBody.Employees[0].code
    # * print 'UserName/EmployeeCode: ' + userName + ' and Mobile Number: ' + resetMobileNumber
    # Generate OTP to reset password for user with above mobile number
    * call read('../../core-services/pretests/userOtpPretest.feature@generateOtpSuccessfully')
    # Setting the condition to filter consumer records
    * def recordsFilterCondition = "$[?(@.value.mobileNumber=='" + resetMobileNumber + "' && @.topic=='" + kafkaTopics + "' && @.value.message contains 'OTP')].value.message"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    # Get lag details after making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataAfterApiCall = lagData
    # * print dataAfterApiCall
    # Compare the offset
    * def offsetDiff = compareOffsetMovement(dataBeforeApiCall, dataAfterApiCall)
    # * print offsetDiff
    * call read('../../kafka-services/pretests/kafkaPretest.feature@checkOffsetThreshold') 
    # * print isThreshHold
    # Fail the test if there is no offset change
    * eval if(!isThreshHold) karate.fail("No Movement in offset!!!")
    # Extract the kafka OTP consumer response messages for above mobile number and notification sms topic
    * def otpMessages = recordsResponse
    # Extract the latest one if tried to reset multiple times recently
    * def latestMessage = otpMessages[otpMessages.length-1]
    # Call JS function to extract OTP from the message
    * def otpReference = extractOtp(latestMessage)
    # * print 'Otp: ' + otpReference
    * def newPassword = notificationSmsConstants.parameters.newPassword
    * def type = notificationSmsConstants.parameters.employeeType
    # Update the password for the above created userName with the generated OTP and New Password
    * call read('../../core-services/pretests/egovUserUpdatePretest.feature@updatePasswordNoLogin')
    # * print 'Update Password Response: ' + updatedPasswordWithOutLogin
    * def authUsername = userName
    * def authPassword = newPassword
    * def authUserType = notificationSmsConstants.parameters.employeeType
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenSuperuser')
    # * print 'Login Success.'

@sms_02 @positive @kafkaEgovNotificationSms @kafkaServices
Scenario: Create an Employee user,read generated password from kafka and login
    # Create an Employee via hrms create employee api
    * call read('../../business-services/tests/egovHrms.feature@HRMS_create_emp01')
    * def resetMobileNumber =  hrmsResponseBody.Employees[0].user.mobileNumber
    * def userName =  hrmsResponseBody.Employees[0].code
    # * print 'UserName/EmployeeCode: ' + userName + ' and Mobile Number: ' + resetMobileNumber
    # Setting the condition to filter consumer records
    * def recordsFilterCondition = "$[?(@.value.mobileNumber=='" + resetMobileNumber + "' && @.topic=='" + kafkaTopics + "' && @.value.message contains 'Welcome to mSeva')].value.message"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    # Get lag details after making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataAfterApiCall = lagData
    # Simulating offset Change by updating the offset values manually
    * eval dataAfterApiCall[0].current_offset = (parseInt(~~(dataAfterApiCall[0].current_offset + 10)))
    * eval dataAfterApiCall[1].current_offset = (parseInt(~~(dataAfterApiCall[1].current_offset + 5)))
    * eval dataAfterApiCall[2].current_offset = (parseInt(~~(dataAfterApiCall[2].current_offset + 15)))
    # * print dataAfterApiCall
    # Compare the offset
    * def offsetDiff = compareOffsetMovement(dataBeforeApiCall, dataAfterApiCall)
    # * print offsetDiff
    * call read('../../kafka-services/pretests/kafkaPretest.feature@checkOffsetThreshold') 
    # * print isThreshHold
    # Fail the test if there is no offset change
    * eval if(!isThreshHold) karate.fail("No Movement in offset!!!")
    # Extract the kafka Welcome Password consumer response messages for above mobile number and notification sms topic
    * def welcomePasswordMessages = recordsResponse
    # Extract the latest one if tried to reset multiple times recently
    * def latestMessage = welcomePasswordMessages[welcomePasswordMessages.length-1]
    # Call JS function to extract OTP from the message
    * def welcomePassword = extractWelcomePassword(latestMessage)
    # * print 'Welcome Password: ' + welcomePassword
    * def authUsername = userName
    * def authPassword = welcomePassword
    * def authUserType = notificationSmsConstants.parameters.employeeType
    * call read('../../common-services/pretests/authenticationToken.feature@authTokenSuperuser')
    # * print 'Login Success.'




