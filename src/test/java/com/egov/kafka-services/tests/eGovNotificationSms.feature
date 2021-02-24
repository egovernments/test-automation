Feature: Kafka Service Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.topics.smsNotification
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    * def waitUntilRecordsAreRead = 
    """
    function() {
      while (true) {
        var result = karate.call('../../kafka-services/pretests/kafkaPretest.feature@readConsumerRecords');
        var records = result.response;
        if (records.size() > 0) {
          karate.log('Records fetched, exiting loop');
          return records;
        }
        karate.log('waiting to fetch records');
      }
    }
    """
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
Scenario: Create an Employee user, reset password and read otp from kafka and update password
    * call read('../../business-services/tests/egovHrms.feature@HRMS_create_emp01')
    * def resetMobileNumber =  hrmsResponseBody.Employees[0].user.mobileNumber
    * def userName =  hrmsResponseBody.Employees[0].code
    * call read('../../core-services/pretests/userOtpPretest.feature@generateOtpSuccessfully')
    * def kafkaOtpResponse = call waitUntilRecordsAreRead
    * def otpMessages = karate.jsonPath(kafkaOtpResponse, "$[?(@.value.mobileNumber=='" + resetMobileNumber + "')].value.message")
    * def latestMessage = otpMessages[otpMessages.length-1]
    * def otpReference = extractOtp(latestMessage)
    * def newPassword = notificationSmsConstants.parameters.newPassword
    * def type = notificationSmsConstants.parameters.employeeType
    * call read('../../core-services/pretests/egovUserUpdatePretest.feature@updatePasswordNoLogin')




