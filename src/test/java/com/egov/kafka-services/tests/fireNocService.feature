Feature: Kafka Firenoc Service Tests

@fire_NOC_Create_Kafka @positive @kafkaCreateFireNoc @kafkaServices
Scenario: Create FireNoc using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.createFireNoc.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.createFireNoc.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create fireNoc 
    * call read('../../municipal-services/tests/fireNocService.feature@fireNoc_Create_01')
    # Expected response
    * def fireNocBody = fireNocResponseBody.FireNOCs[0]
    * def id = fireNocResponseBody.FireNOCs[0].id
    # Setting the condition to filter FireNocs
    * print 'fire noc Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.FireNOCs)]"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    # Check whether we got the records in FireNocs or not
    * assert recordsResponse != null
    # Extract the kafka pg transaction consumer response messages for created FireNoc
    * def createFireNocMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestCreateFireNocMessage = createFireNocMessages[createFireNocMessages.length-1]
    * match createFireNocMessages == latestCreateFireNocMessage

@fire_NOC_update_Kafka @positive @kafkaUpdateFireNoc @kafkaServices
Scenario: Update FireNoc using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.updateFireNoc.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.updateFireNoc.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create fireNoc 
    * call read('../../municipal-services/tests/fireNocService.feature@updateNoc_01')
    # Expected response
    * def fireNocBody = fireNocResponseBody.FireNOCs[0]
    * def id = fireNocResponseBody.FireNOCs[0].id
    # Setting the condition to filter Firenoc ID
    * print 'Fire Noc ID: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.FireNOCs)]"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    # Check whether we got the records in FireNoc or not
    * assert recordsResponse != null
    # Extract the kafka Firenoc Id response messages for created FireNoc ID
    * def updateFireNocMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestUpdateFireNocMessages = updateFireNocMessages[updateFireNocMessages.length-1]
    * match updateFireNocMessages == latestUpdateFireNocMessages