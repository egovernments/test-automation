Feature: Pretest scenarios of property-calculator service end points

Background: 
    * configure headers = read('classpath:websCommonHeaders.js')


@createBillingSlabMutation
Scenario: To create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
        * print createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
    And  assert responseStatus == 201

@errorInCreateBillingSlabMutation
Scenario: Not to create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
        * print createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
    And  assert responseStatus == 403 || responseStatus == 400

@updateBillingSlabMutation
Scenario: To update billing slab mutation
    Given url mutationBillingSlabUpdate
    And request updateBillingSlabMutationPayload
        * print updateBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
    And  assert responseStatus == 201 || responseStatus == 403 || responseStatus == 400