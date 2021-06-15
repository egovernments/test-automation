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

@kafka_workflow_transition_01 @positive @kafkaWorkflowTransition @kafkaServices
Scenario: Create a pg transaction and verifdy the response Transaction object with the data obtained from the consumer
    # Create workflow process transition
    * call read('../../core-services/tests/eGovWorkFlowTransition.feature@Process_Transition_01')
    # Expected response
    * def createProcessInstanceResponse = processTransitionResponseBody.ProcessInstances
    # * print 'Business Id: ' + businessId
    # Setting the condition to filter consumer records
    * def recordsFilterCondition = "$[?(@.value.ProcessInstances.businessId=='" + businessId + "')].value.ProcessInstances"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    * def kafkawokflowTransitionResponse = recordsResponse
    # Extract the latest one and Actual Response
    * def latestworkflowTransitionMessage = kafkawokflowTransitionResponse[kafkawokflowTransitionResponse.length-1]
    * match createProcessInstanceResponse == latestworkflowTransitionMessage




