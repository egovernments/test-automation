Feature: Dummy feature

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Thread = Java.type('java.lang.Thread')
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def cluster_id = kafkaConstants.parameters.clusterId
    * def consumer_group_id = kafkaConstants.parameters.consumerGroupId
    # * configure abortedStepsShouldPass = false

@kafka_getLags_sms_01
Scenario: Create a user and compare the offset simulation without changing offsets to make the test fail
    # Get lag details before making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataBeforeApiCall = lagData
    * print dataBeforeApiCall
    # Call create employee api to generate otp
    * call read('../../business-services/tests/egovHrms.feature@HRMS_create_emp01')
    # wait for random delay
    * def randomDelayTime = ranInteger(1)
    * print 'Waiting for delay time of ' + randomDelayTime + ' seconds...'
    * Thread.sleep(randomDelayTime)
    # Get lag details after making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataAfterApiCall = lagData
    * print dataAfterApiCall
    # Compare the offset
    * def isOffsetMoved = compareOffsetMovement(dataBeforeApiCall, dataAfterApiCall)
    # Fail the test if there is no offset change
    * eval if(!isOffsetMoved) karate.fail("No Movement in offset!!!")

@kafka_getLags_sms_02
Scenario: Create a user and compare the offset simulation by changing the offsets to make the test pass
    # Get lag details before making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataBeforeApiCall = lagData
    * print dataBeforeApiCall
    # Call create employee api to generate otp
    * call read('../../business-services/tests/egovHrms.feature@HRMS_create_emp01')
    # wait for random delay
    * def randomDelayTime = ranInteger(1)
    * print 'Waiting for delay time of ' + randomDelayTime + ' seconds...'
    * Thread.sleep(randomDelayTime)
    # Get lag details after making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataAfterApiCall = lagData
    # Simulating offset Change by updating the offset values manually
    * eval dataAfterApiCall[0].log_end_offset = (parseInt(~~(dataAfterApiCall[0].log_end_offset + 10)))
    * eval dataAfterApiCall[0].current_offset = (parseInt(~~(dataAfterApiCall[0].current_offset + 10)))
    * print dataAfterApiCall
    # Compare the offset
    * def isOffsetMoved = compareOffsetMovement(dataBeforeApiCall, dataAfterApiCall)
    # Fail the test if there is no offset change
    * eval if(!isOffsetMoved) karate.fail("No Movement in offset!!!")
