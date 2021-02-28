Feature: Kafka Service Pretest

Background:
    * def createConsumerPayload = read('../../kafka-services/requestPayload/create.json')
    * def subscribeConsumerPayload = read('../../kafka-services/requestPayload/subscribe.json')

@createConsumerInstance
Scenario: Create consumer instance
    * configure headers = {Content-Type: 'application/vnd.kafka.v2+json', Accept: 'application/vnd.kafka.v2+json', Accept-Encoding: 'gzip,deflate,br'}
    Given url createKafkaConsumer
    And request createConsumerPayload
    When method post
    Then status 200
    * def createConsumerResponseBody = response

@subscribeConsumerToTopic
Scenario: Subcribe Consumer to a Topic
    * configure headers = {Content-Type: 'application/vnd.kafka.v2+json'}
    Given url subscribeKafkaConsumer
    And request subscribeConsumerPayload
    When method post
    Then status 204
    * def subscribeConsumerResponseBody = response

@readConsumerRecords
Scenario: Read Records from the Consumer
    * configure headers = { Accept: 'application/vnd.kafka.json.v2+json', Accept-Encoding: 'gzip,deflate,br'}
    Given url readKafkaConsumer
    When method get
    Then status 200
    * def readConsumerResponseBody = response

@waitUntilRecordsAreConsumed
Scenario: Wait until records are consumed
    * def waitUntilRecordsAreRead = 
    """
    function() {
      var i=0;
      while (i<10) {
        var result = karate.call('../../kafka-services/pretests/kafkaPretest.feature@readConsumerRecords');
        var records = result.response;
        karate.log('Kafka Response: ', records);
        records = karate.jsonPath(records, recordsFilterCondition);
        if (records.size() > 0) {
          karate.log('Records fetched, exiting loop');
          karate.log('Kafka Response: ', records);
          return records;
        }
        i++;
        karate.log('waiting to fetch records');
      }
      return null;
    }
    """
    * def recordsResponse = call waitUntilRecordsAreRead

@deleteConsumerInstance
Scenario: Delete Consumer Instance
    * configure headers = { Accept: 'application/vnd.kafka.v2+json'}
    Given url deleteKafkaConsumer
    When method delete
    Then assert responseStatus == 204 || responseStatus == 404