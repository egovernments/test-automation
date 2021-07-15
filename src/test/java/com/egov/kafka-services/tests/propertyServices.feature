Feature: Kafka Property Services Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')

@Property_Create_ReadKafkaPeristerCheck_17 @positive @kafkaPropertyServices @kafkaServices
Scenario: Create a property and verify the response Transaction object with the data obtained from the consumer
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.createProperty.topics
    * def consumer_group_id = kafkaConstants.createProperty.consumerGroupId
    # Get lag details before making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataBeforeApiCall = lagData
    # * print dataBeforeApiCall
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create property
    * call read('../../municipal-services/tests/PropertyService.feature@createProperty')
    # Expected response
    * def createPropertyResponse = propertyServiceResponseBody.Properties[0]
    # Setting the condition to filter consumer records
    # * print 'Property Id: ' + propertyId + '
    * def recordsFilterCondition = "$[?(@.value.Property.propertyId=='" + propertyId + "')].value.Property"
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
    # Extract the kafka pg transaction consumer response messages for created billId and consumerCode
    * def createPropertyMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestCreatePropertyMessage = createPropertyMessages[createPropertyMessages.length-1]
    * match createPropertyResponse == latestCreatePropertyMessage

@Property_Update_ReadKafkaPeristerCheck_11 @positive @kafkaPropertyServices @kafkaServices
Scenario: Update a property and verify the response Transaction object with the data obtained from the consumer
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.updateProperty.topics
    * def consumer_group_id = kafkaConstants.updateProperty.consumerGroupId
    # Get lag details before making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataBeforeApiCall = lagData
    # * print dataBeforeApiCall
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Update property
    * call read('../../municipal-services/tests/PropertyService.feature@Property_Update_01')
    # Expected response
    * def upatePropertyResponse = propertyServiceResponseBody.Properties[0]
    * def propertyId = upatePropertyResponse.propertyId
    # Setting the condition to filter consumer records
    # * print 'Property Id: ' + propertyId + '
    * def recordsFilterCondition = "$[?(@.value.Property.propertyId=='" + propertyId + "')].value.Property"
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
    # Extract the kafka pg transaction consumer response messages for created billId and consumerCode
    * def upatePropertyMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestUpatePropertyMessage = upatePropertyMessages[upatePropertyMessages.length-1]
    * match upatePropertyResponse == latestUpatePropertyMessage




