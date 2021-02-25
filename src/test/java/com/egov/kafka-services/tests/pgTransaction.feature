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
          return records;
        }
        i++;
        karate.log('waiting to fetch records');
      }
    }
    """

@kafka_pg_create_01 @positive @kafkaEgovNotificationSms
Scenario: Create a pg transaction and verifdy the response Transaction object with the data obtained from the consumer
    # Create pg transaction
    * call read('../../core-services/tests/pgServices.feature@PGCreate_01')
    # Expected response
    * def createPgTransactionResponse = pgServicesCreateResponseBody.Transaction
    # Call JS function to read the records from kafka consumer
    * def kafkaPgTransactionResponse = call waitUntilRecordsAreRead
    # Extract the kafka pg transaction consumer response messages for created billId and consumerCode
    * def pgTransactionMessages = karate.jsonPath(kafkaPgTransactionResponse, "$[?(@.value.Transaction.billId=='" + billId + "' && @.value.Transaction.consumerCode=='" + consumerCode + "')].value.Transaction")
    # Extract the latest one and Actual Response
    * def latestPgTransactionMessage = pgTransactionMessages[pgTransactionMessages.length-1]
    * match createPgTransactionResponse == latestPgTransactionMessage




