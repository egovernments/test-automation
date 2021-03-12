Feature: Kafka Service Pretest

Background:
    * def createConsumerPayload = read('../../kafka-services/requestPayload/create.json')
    * def subscribeConsumerPayload = read('../../kafka-services/requestPayload/subscribe.json')
    * def api = read('file:envYaml/common/common.yaml');
    * def getClustersUrl = envLocalhost + api.endPoints.kafkaService.getClusters
    * def getConsumerGroupsUrl = envLocalhost + api.endPoints.kafkaService.getConsumerGroups
    * def getlagsUrl = envLocalhost + api.endPoints.kafkaService.getLags
    * def getlagSummaryUrl = envLocalhost + api.endPoints.kafkaService.getLagSummary

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
      while (i<15) {
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
      karate.log('failed to fetch records!!!');
      return null;
    }
    """
    * def recordsResponse = call waitUntilRecordsAreRead
    * assert recordsResponse != null

@deleteConsumerInstance
Scenario: Delete Consumer Instance
    * configure headers = { Accept: 'application/vnd.kafka.v2+json'}
    Given url deleteKafkaConsumer
    When method delete
    Then assert responseStatus == 204 || responseStatus == 404

@getClusters
Scenario: Get the list of clusters
  * print getClustersUrl
  Given url getClustersUrl
  When method get
  Then status 200
  And def clustersResponse = response
  And match clustersResponse.data.size() != 0
  And def clusters = clustersResponse.data

@getConsumerGroups
Scenario: Get the list of consumer groups
  * replace getConsumerGroupsUrl.cluster_id = cluster_id
  * print getConsumerGroupsUrl
  Given url getConsumerGroupsUrl
  When method get
  Then status 200
  And def consumerGroupsResponse = response
  And match consumerGroupsResponse.data.size() != 0
  And def consumerGroups = consumerGroupsResponse.data

@getConsumerGroupLags
Scenario: Get the lags for comsumer group id
  * replace getlagsUrl.cluster_id = cluster_id
  * replace getlagsUrl.consumer_group_id = consumer_group_id
  Given url getlagsUrl
  When method get
  Then status 200
  And def lagsResponse = response
  And match lagsResponse.data.size() != 0

@getConsumerGroupLagSummary
Scenario: Get the lag summary for comsumer group id
  * replace getlagSummaryUrl.cluster_id = cluster_id
  * replace getlagSummaryUrl.consumer_group_id = consumer_group_id
  Given url getlagSummaryUrl
  When method get
  Then status 200
  And def lagSummaryResponse = response
  And match lagSummaryResponse.size() != 0