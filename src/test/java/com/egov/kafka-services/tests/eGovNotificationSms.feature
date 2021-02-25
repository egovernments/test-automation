Feature: Kafka Notification SMS Tests

Background:
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.topics.smsNotification
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # JS function definition to loop the GET consumer records call for a maximum of 10 times
    * def waitUntilRecordsAreRead = 
    """
    function() {
      var i=0;
      while (i<10) {
        var result = karate.call('../../kafka-services/pretests/kafkaPretest.feature@readConsumerRecords');
        var records = result.response;
        if (records.size() > 0) {
          karate.log('Records fetched, exiting loop');
          karate.log('Kafka Otp Response: ', records);
          return records;
        }
        i++;
        karate.log('waiting to fetch records');
      }
    }
    """
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

@sms_01 @positive @kafkaEgovNotificationSms
Scenario: Create an Employee user, forgot password, read otp from kafka and update password
    # Create an Employee via hrms create employee api
    * call read('../../business-services/tests/egovHrms.feature@HRMS_create_emp01')
    * def resetMobileNumber =  hrmsResponseBody.Employees[0].user.mobileNumber
    * def userName =  hrmsResponseBody.Employees[0].code
    * print 'UserName/EmployeeCode: ' + userName + ' and Mobile Number: ' + resetMobileNumber
    # Generate OTP to reset password for user with above mobile number
    * call read('../../core-services/pretests/userOtpPretest.feature@generateOtpSuccessfully')
    # Call JS function to read the records from kafka consumer
    * def kafkaOtpResponse = call waitUntilRecordsAreRead
    # Extract the kafka OTP consumer response messages for above mobile number and notification sms topic
    * def otpMessages = karate.jsonPath(kafkaOtpResponse, "$[?(@.value.mobileNumber=='" + resetMobileNumber + "' && @.topic=='" + kafkaTopics + "')].value.message")
    # Extract the latest one if tried to reset multiple times recently
    * def latestMessage = otpMessages[otpMessages.length-1]
    # Call JS function to extract OTP from the message
    * def otpReference = extractOtp(latestMessage)
    * print 'Otp: ' + otpReference
    * def newPassword = notificationSmsConstants.parameters.newPassword
    * def type = notificationSmsConstants.parameters.employeeType
    # Update the password for the above created userName with the generated OTP and New Password
    * call read('../../core-services/pretests/egovUserUpdatePretest.feature@updatePasswordNoLogin')
    * print 'Update Password Response: ' + updatedPasswordWithOutLogin




