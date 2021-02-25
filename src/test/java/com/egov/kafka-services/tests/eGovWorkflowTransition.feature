Feature: Kafka Service Tests

Background:
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.topics.createWorkflowTransition
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # JS function definition to loop the GET consumer records call for a maximum of 10 times
    * def waitUntilRecordsAreRead = 
    """
    function() {
      var i=0;
      while (i<20) {
        var result = karate.call('../../kafka-services/pretests/kafkaPretest.feature@readConsumerRecords');
        var records = result.response;
        records = karate.jsonPath(records, "$[?(@.value.ProcessInstances.businessId=='" + businessId + "')].value.ProcessInstances")
        if (records.size() > 0) {
          karate.log('Records fetched, exiting loop');
          karate.log('Records: ',records);
          return records;
        }
        i++;
        karate.log('waiting to fetch records');
      }
      karate.log('failed to fetch records!!!')
    }
    """

@kafka_workflow_transition_01 @positive @kafkaEgovNotificationSms @kafkaService
Scenario: Create a pg transaction and verifdy the response Transaction object with the data obtained from the consumer
    # Create workflow process transition
    * call read('../../core-services/tests/eGovWorkFlowTransition.feature@Process_Transition_01')
    # Expected response
    * def createProcessInstanceResponse = processTransitionResponseBody.ProcessInstances
    # Call JS function to read the records from kafka consumer
    * def kafkawokflowTransitionResponse = call waitUntilRecordsAreRead
    * print 'Business Id: ' + businessId
    # Extract the latest one and Actual Response
    * def latestworkflowTransitionMessage = kafkawokflowTransitionResponse[kafkawokflowTransitionResponse.length-1]
    * match createProcessInstanceResponse == latestworkflowTransitionMessage




