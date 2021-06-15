Feature: Kafka Payment Gateway Transaction Tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
    * def pdfCreateConstant = read('../../core-services/constants/pdfService.yaml')
    * def key = pdfCreateConstant.parameters.valid.keyForPt
    # Try to delete the kafka consumer instance if it is not already deleted
    * call read('../../kafka-services/pretests/kafkaPretest.feature@deleteConsumerInstance')
    # Read Constant Parameters
    * def kafkaConstants = read('../../kafka-services/constants/kafka.yaml')
    * def kafkaTopics = kafkaConstants.createPdf.topics
    #Create Consumer instance before triggering producer messages via api
    * call read('../../kafka-services/pretests/kafkaPretest.feature@createConsumerInstance')
    #Subscribe Consumer instance to topic
    * call read('../../kafka-services/pretests/kafkaPretest.feature@subscribeConsumerToTopic')

@Property-Services_PDF_Create_Kafka @positive @kafkaPdfServices @kafkaServices
Scenario: Create a pdf and verify the response Transaction object with the data obtained from the consumer
    # Create PDF
    * call read('../../core-services/pretests/pdfServiceCreate.feature@createPdfForPtSuccessfully')
    # Expected response
    # * print pdfCreateResponseBody
    * def pdfCreateResponse = pdfCreateResponseBody
    * def jobId = pdfCreateResponse.jobid
    * def createdJobId = jobId
    # Setting the condition to filter consumer records
    # * print 'Job Id: ' + jobId + '
    * def recordsFilterCondition = "$[?(@.value.jobId=='" + jobId + "')].value.jobId"
    # Call to wait until records are read by kafka consumer
    * call read('../../kafka-services/pretests/kafkaPretest.feature@waitUntilRecordsAreConsumed')
    # Extract the kafka pg transaction consumer response messages for created billId and consumerCode
    * def createPdfMessage = recordsResponse
    # Extract the latest one and Actual Response
    * def latestcreatePdfMessage = createPdfMessage[createPdfMessage.length-1]
    * match createdJobId == latestcreatePdfMessage


