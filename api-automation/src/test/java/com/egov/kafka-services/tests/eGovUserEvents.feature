Feature: Kafka Egov User Events Tests

Background:
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * def Thread = Java.type('java.lang.Thread')

@create_User_events_Kafka @positive @kafkaCreateUserEvents @kafkaServices
Scenario: Create Egov User Events using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.createUserEvent.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.createUserEvent.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create Egov User Events
    * call read('../../municipal-services/tests/eGovUserEvent.feature@events_create_PT_01')
    # Expected response
    * def egovUserEventsBody = eGovUserEventResponseBody.events[0]
    * def id = eGovUserEventResponseBody.events[0].id
    # Setting the condition to filter Egov User Events
    # * print 'Egov User Events Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.events.id=='" + id + "')].value.events"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    # Check whether we got the records in Egov User Events or not
    * assert recordsResponse != null
    # Extract the kafka User events response messages for created Egov User Events
    * def createEgovUserEventsMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestCreateEgovUserEventsMessage = createEgovUserEventsMessages[createEgovUserEventsMessages.length-1]
    * match createEgovUserEventsMessages == latestCreateEgovUserEventsMessage

@update_User_events_Kafka @positive @kafkaCreateUserEvents @kafkaServices
Scenario: update Egov User Events using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.updateUserEvent.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.updateUserEvent.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create Egov User Events
    * call read('../../municipal-services/tests/eGovUserEvent.feature@events_update_01')
    # Expected response
    * def egovUserEventsBody = eGovUserEventResponseBody.events[0]
    * def id = eGovUserEventResponseBody.events[0].id
    # Setting the condition to filter Egov User Events
    # * print 'Egov User Events Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.events.id=='" + id + "')].value.events"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * Thread.sleep(3000)
    # Check whether we got the records in Egov User Events or not
    * assert recordsResponse != null
    # Extract the kafka User events response messages for created Egov User Events
    * def updateEgovUserEventsMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestUpdateEgovUserEventsMessage = updateEgovUserEventsMessages[updateEgovUserEventsMessages.length-1]
    * match updateEgovUserEventsMessages == latestUpdateEgovUserEventsMessage

@lat_Update_User_events_Kafka @positive @kafkaCreateUserEvents @kafkaServices
Scenario: lat update Egov User Events using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.latUserEvent.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.latUserEvent.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create Egov User Events
    * call read('../../municipal-services/tests/eGovUserEvent.feature@lat_update_01')
    * match eGovUserEventResponseBody.status == commonConstants.expectedStatus.success

@create_User_events_Kafka_Persister @positive @kafkaCreateUserEvents @kafkaServices
Scenario: Create Egov User Events using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.asyncUserEvent.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.asyncUserEvent.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create Egov User Events
    * call read('../../municipal-services/tests/eGovUserEvent.feature@events_create_PT_01')
    # Expected response
    * def egovUserEventsBody = eGovUserEventResponseBody.events[0]
    * def id = eGovUserEventResponseBody.events[0].id
    # Setting the condition to filter Egov User Events
    # * print 'Egov User Events Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.events.id=='" + id + "')].value.events"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    # Check whether we got the records in Egov User Events or not
    * assert recordsResponse != null
    # Extract the kafka User events response messages for created Egov User Events
    * def createEgovUserEventsMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestCreateEgovUserEventsMessage = createEgovUserEventsMessages[createEgovUserEventsMessages.length-1]
    * match createEgovUserEventsMessages == latestCreateEgovUserEventsMessage

@update_User_events_Kafka_Persister @positive @kafkaCreateUserEvents @kafkaServices
Scenario: update Egov User Events using kafka service
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def consumer_group_id = kafkaConstants.updateAsyncUserEvent.consumerGroupId
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def notificationSmsConstants = read('../../kafka-services/constants/notificationSms.yaml')
    * def kafkaTopics = kafkaConstants.updateAsyncUserEvent.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create Egov User Events
    * call read('../../municipal-services/tests/eGovUserEvent.feature@events_update_01')
    # Expected response
    * def egovUserEventsBody = eGovUserEventResponseBody.events[0]
    * def id = eGovUserEventResponseBody.events[0].id
    # Setting the condition to filter Egov User Events
    # * print 'Egov User Events Id: ' + id + '
    * def recordsFilterCondition = "$[?(@.value.events.id=='" + id + "')].value.events"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(3000)
    # Check whether we got the records in Egov User Events or not
    * assert recordsResponse != null
    # Extract the kafka User events response messages for created Egov User Events
    * def updateEgovUserEventsMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestUpdateEgovUserEventsMessage = updateEgovUserEventsMessages[updateEgovUserEventsMessages.length-1]
    * match updateEgovUserEventsMessages == latestUpdateEgovUserEventsMessage