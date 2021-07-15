Feature: Kafka Collection Services Tests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')

@Property_Collect_Payment_Kafka @positive @kafkaCollectionServices @kafkaServices
Scenario: Create a payment and verify the response Transaction object with the data obtained from the consumer
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.createPayment.topics
    * def consumer_group_id = kafkaConstants.createPayment.consumerGroupId
    # Get lag details before making an api call
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    * def dataBeforeApiCall = lagData
    # * print dataBeforeApiCall
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')
    # Create Payment
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    # Expected response
    # * print collectionServicesResponseBody
    * def createPaymentResponse = collectionServicesResponseBody.Payments[0]
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Setting the condition to filter consumer records
    # * print 'Payment Id: ' + paymentId + '
    * def recordsFilterCondition = "$[?(@.value.Payment.id=='" + paymentId + "')].value.Payment"
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
    * def createPaymentMessage = recordsResponse
    # Extract the latest one and Actual Response
    * def latestCreatePaymentMessage = createPaymentMessage[createPaymentMessage.length-1]
    * match createPaymentResponse == latestCreatePaymentMessage


