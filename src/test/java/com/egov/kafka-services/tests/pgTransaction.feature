Feature: Kafka Payment Gateway Transaction Tests

Background:
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.topics.createPgTransaction
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')

@kafka_pg_create_01 @positive @kafkaPgTransaction @kafkaService
Scenario: Create a pg transaction and verifdy the response Transaction object with the data obtained from the consumer
    # Create pg transaction
    * call read('../../core-services/tests/pgServices.feature@PGCreate_01')
    # Expected response
    * def createPgTransactionResponse = pgServicesCreateResponseBody.transaction
    # Setting the condition to filter consumer records
    * def recordsFilterCondition = "$[?(@.value.Transaction.billId=='" + billId + "' && @.value.Transaction.consumerCode=='" + consumerCode + "')].value.Transaction"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    # Check whether we got the records in consumer records or not
    * assert recordsResponse != null
    # Extract the kafka pg transaction consumer response messages for created billId and consumerCode
    * def pgTransactionMessages = recordsResponse
    # Extract the latest one and Actual Response
    * def latestPgTransactionMessage = pgTransactionMessages[pgTransactionMessages.length-1]
    * match createPgTransactionResponse == latestPgTransactionMessage




