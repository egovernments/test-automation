Feature: Pretest scenarios of property-calculator service end points

Background: 
    * configure headers = read('classpath:websCommonHeaders.js')


@createBillingSlabMutation
Scenario: To create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
        * print mutationCreateResponse
    And def id = mutationCreateResponse.MutationBillingSlab[0].id
    And  assert responseStatus == 201

@errorInCreateBillingSlabMutation
Scenario: Not to create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
        * print createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
    And  assert responseStatus >= 400 && responseStatus <= 403

@updateBillingSlabMutation
Scenario: To update billing slab mutation
    Given url mutationBillingSlabUpdate
        * print mutationBillingSlabUpdate
    And request updateBillingSlabMutationPayload
        * print updateBillingSlabMutationPayload
    When method post
    Then def mutationUpdateResponse = response
        * print mutationUpdateResponse
    And  assert responseStatus == 201

@errorInUpdateBillingSlabMutation
Scenario: Negative pretest to update billing slab mutation
    Given url mutationBillingSlabUpdate
    And request updateBillingSlabMutationPayload
        * print updateBillingSlabMutationPayload
    When method post
    Then def mutationUpdateResponse = response
        * print mutationUpdateResponse
   And  assert responseStatus >= 400 && responseStatus <= 403

@searchBillingSlabMutation
Scenario: To search a billing slab mutation
    Given url mutationBillingSlabSearch
        * print mutationBillingSlabSearch
    And params searchParams
        * print searchParams
    And request searchBillingSlabMutationPayload
    When method post
    Then def mutationSearchResponse = response
    And  assert responseStatus == 200

@errorInSearchBillingSlabMutation
Scenario: Negative pretest to search a billing slab mutation
    Given url mutationBillingSlabSearch
        * print mutationBillingSlabSearch
    And params searchParams
        * print searchParams
    And request searchBillingSlabMutationPayload
    When method post
    Then def mutationSearchResponse = response
    And  assert responseStatus >= 400 && responseStatus <= 403


# Billing Slab

@createBillingSlab
Scenario: To create billing slab 
    Given url billingSlabCreate
    And request billingSlabCreatePayload
    * print billingSlabCreatePayload
    When method post
    Then def billingSlabCreateResponse = response
    And def id = billingSlabCreateResponse.billingSlab[0].id
    And  assert responseStatus == 201

@errorInCreateBillingSlab
Scenario: Ngative pretest To create billing slab 
    Given url billingSlabCreate
    And request billingSlabCreatePayload
    * print billingSlabCreatePayload
    When method post
    Then def errorResponse = response
    And  assert responseStatus >= 400 && responseStatus <= 403