Feature: Dummy feature

Background:
    * def jsUtils = read('classpath:jsUtils.js')

@kafka_getLags
Scenario: Calling Kafka endpoints to get consumer group id lags for a cluster id
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getClusters')
    * def cluster_id = clusters[randomNumber(clusters.length)].cluster_id
    * print cluster_id
    * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroups')
    * def consumerGroupIds = karate.jsonPath(consumerGroups, "$.data[?(@.cluster_id=='" + cluster_id + "')].consumer_group_id")
    * def consumer_group_id = consumerGroupIds[randomNumber(consumerGroupIds.length)]
    * print consumer_group_id
    # * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLags')
    # * call read('../../kafka-services/pretests/kafkaPretest.feature@getConsumerGroupLagSummary')