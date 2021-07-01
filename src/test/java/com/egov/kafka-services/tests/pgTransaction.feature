Feature: Kafka Payment Gateway Transaction Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.createPgTransaction.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    * def consumer_group_id = kafkaConstants.createProperty.consumerGroupId
    # Get lag details before making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataBeforeApiCall = lagData
    # * print dataBeforeApiCall
    
@kafka_pg_create_01 @positive @kafkaPgTransaction @kafkaServices
Scenario: Create a pg transaction and verify the response Transaction object with the data obtained from the consumer
    # Create pg transaction
    * call read('../../core-services/tests/pgServices.feature@PGCreate_01')
    # * print pgServicesCreateResponseBody
    # Expected response
    * def createPgTransactionResponse = pgServicesCreateResponseBody.transaction
    # Setting the condition to filter consumer records
    # * print 'Bill Id: ' + billId + ', Consumer Code: ' + consumerCode
    * def recordsFilterCondition = "$[?(@.value.Transaction.billId=='" + billId + "' && @.value.Transaction.consumerCode=='" + consumerCode + "')].value.Transaction"
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
    # * eval if(!isThreshHold) karate.fail("No Movement in offset!!!")
    # Extract the kafka pg transaction consumer response messages for created billId and consumerCode
    * def pgTransactionMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestPgTransactionMessage = pgTransactionMessages[pgTransactionMessages.length-1]
    * match createPgTransactionResponse == latestPgTransactionMessage




