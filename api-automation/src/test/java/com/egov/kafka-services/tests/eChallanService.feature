Feature: Kafka eChallan Service Tests

Background:
    * def Thread = Java.type('java.lang.Thread')
@eChallan_kafka_create @positive @kafkaCreateEChallan @kafkaServices
Scenario: Create eChallan using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.createChallan.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.createChallan.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create eChallan service 
    * call read('../../municipal-services/tests/eChallanService.feature@eChallan_create_01')
    # Expected response
    * def echallanBody = challanResponseBody.challans[0]
    * def id = challanResponseBody.challans[0].id
    # Setting the condition to filter echallan
    * print 'Echallan Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.challans)]"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * Thread.sleep(3000)
    # Check whether we got the records in echallan or not
    * assert recordsResponse != null
    # Extract the kafka pg transaction consumer response messages for created echallan
    * def createEchallanMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestCreateEChallanMessage = createEchallanMessages[createEchallanMessages.length-1]
    * match createEchallanMessages == latestCreateEChallanMessage

@eChallan_kafka_update @positive @kafkaUpdateEChallan @kafkaServices
Scenario: Update echallan using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.updateChallan.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.updateChallan.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # update Echallan service 
    * call read('../../municipal-services/tests/eChallanService.feature@eChallan_update_01')
    # Expected response
    * def echallanBody = challanResponseBody.challans[0]
    * def id = challanResponseBody.challans[0].id
    # Setting the condition to filter echallan
    * print 'Echallan Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.challans)]"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * Thread.sleep(3000)
    # Check whether we got the records in echallan or not
    * assert recordsResponse != null
    # Extract the kafka pg transaction consumer response messages for created echallan
    * def updateEchallanMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestUpdateEChallanMessage = updateEchallanMessages[updateEchallanMessages.length-1]
    * match updateEchallanMessages == latestUpdateEChallanMessage