Feature: Pretest scenarios of property-calculator service end points

Background: 
    * configure headers = read('classpath:websCommonHeaders.js')
   

@createBillingSlabMutation
Scenario: To create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
        # * print mutationCreateResponse
    And def id = mutationCreateResponse.MutationBillingSlab[0].id
    And  assert responseStatus == 201

@errorInCreateBillingSlabMutation
Scenario: Not to create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
        # * print createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
    And  status 400

@errorInCreateBillingSlabMutationUnAuthorized
Scenario: Not to create billing slab mutation
    Given url mutationBillingSlabCreate
    And request createBillingSlabMutationPayload
        # * print createBillingSlabMutationPayload
    When method post
    Then def mutationCreateResponse = response
    And  status 403

@updateBillingSlabMutation
Scenario: To update billing slab mutation
    Given url mutationBillingSlabUpdate
        # * print mutationBillingSlabUpdate
    And request updateBillingSlabMutationPayload
        # * print updateBillingSlabMutationPayload
    When method post
    Then def mutationUpdateResponse = response
    And  assert responseStatus == 201

@errorInUpdateBillingSlabMutation
Scenario: Negative pretest to update billing slab mutation
    Given url mutationBillingSlabUpdate
    And request updateBillingSlabMutationPayload
        # * print updateBillingSlabMutationPayload
    When method post
    Then def mutationUpdateResponse = response
   And  status 400

@errorInUpdateBillingSlabMutationUnAuthorized
Scenario: Negative pretest to update billing slab mutation
    Given url mutationBillingSlabUpdate
    And request updateBillingSlabMutationPayload
        # * print updateBillingSlabMutationPayload
    When method post
    Then def mutationUpdateResponse = response
   And  status 403

@searchBillingSlabMutation
Scenario: To search a billing slab mutation
    Given url mutationBillingSlabSearch
    And params searchParams
        # * print searchParams
    And request searchBillingSlabMutationPayload
    When method post
    Then def mutationSearchResponse = response
    And  assert responseStatus == 200

@errorInSearchBillingSlabMutation
Scenario: Negative pretest to search a billing slab mutation
    Given url mutationBillingSlabSearch
    And params searchParams
        # * print searchParams
    And request searchBillingSlabMutationPayload
    When method post
    Then def mutationSearchResponse = response
    And  status 400

@errorInSearchBillingSlabMutationUnAuthorized
Scenario: Negative pretest to search a billing slab mutation
    Given url mutationBillingSlabSearch
    And params searchParams
        # * print searchParams
    And request searchBillingSlabMutationPayload
    When method post
    Then def mutationSearchResponse = response
    And  status 403


# Billing Slab

@createBillingSlab
Scenario: To create billing slab 
    Given url billingSlabCreate
    And request billingSlabCreatePayload
    # * print billingSlabCreatePayload
    When method post
    Then def billingSlabCreateResponse = response
    And def id = billingSlabCreateResponse.billingSlab[0].id
    And  assert responseStatus == 201

@errorInCreateBillingSlab
Scenario: Ngative pretest To create billing slab 
    Given url billingSlabCreate
    And request billingSlabCreatePayload
    # * print billingSlabCreatePayload
    When method post
    Then def errorResponse = response
    And  status 400

@errorInCreateBillingSlabUnAuthorized
Scenario: Ngative pretest To create billing slab 
    Given url billingSlabCreate
    And request billingSlabCreatePayload
    # * print billingSlabCreatePayload
    When method post
    Then def errorResponse = response
    And  status 403

@searchBillingSlab
Scenario: To search a billing slab
    Given url billingSlabSearch
    And params searchParams
        # * print searchParams
    And request searchBillingSlabPayload
    When method post
    Then def billingSlabSearchResponse = response
    And  assert responseStatus == 200

@errorInSearchBillingSlab
Scenario: Negative pretest to search a billing slab
    Given url billingSlabSearch
    And params searchParams
        # * print searchParams
    And request searchBillingSlabPayload
    When method post
    Then def billingSlabSearchResponse = response
    # * print billingSlabSearchResponse
    And  status 400

@errorInSearchBillingSlabUnAuthorized
Scenario: Negative pretest to search a billing slab
    Given url billingSlabSearch
    And params searchParams
        # * print searchParams
    And request searchBillingSlabPayload
    When method post
    Then def billingSlabSearchResponse = response
    # * print billingSlabSearchResponse
    And  status 403

@updateBillingSlab
Scenario: To update billing slab
    Given url billingSlabUpdate
    And request updateBillingSlabPayload
        # * print updateBillingSlabPayload
    When method post
    Then def billingSlabUpdateResponse = response
    And  assert responseStatus == 201

@errorInUpdateBillingSlab
Scenario: Negative pretest to update billing slab
    Given url billingSlabUpdate
    And request updateBillingSlabPayload
        # * print updateBillingSlabPayload
    When method post
    Then def billingSlabUpdateResponse = response
    And  status 400

@errorInUpdateBillingSlabUnAuthorized
Scenario: Negative pretest to update billing slab
    Given url billingSlabUpdate
    And request updateBillingSlabPayload
        # * print updateBillingSlabPayload
    When method post
    Then def billingSlabUpdateResponse = response
    And  status 403


# Property Tax Mutation Calculate
@calculatePropertyTaxMutation
Scenario: To Calculate property tax
    Given url mutationCalculate
    And request propertyTaxMutationPayload
        # * print propertyTaxMutationPayload
    When method post
    Then def propertyTaxMutationResponse = response
    And  assert responseStatus == 200

@errorInCalculatePropertyTaxMutation
Scenario: Negative pretest to Calculate property tax
    Given url mutationCalculate
    And request propertyTaxMutationPayload
        # * print propertyTaxMutationPayload
    When method post
    Then def propertyTaxMutationResponse = response
     And  status 400

@calculatePropertyTaxEstimate
Scenario: To Calculate property tax estimate
    * def params =
    """
    {
        tenantId:'#(tenantId)'
    }
    """
    Given url propertyTaxEstimate
    And params params
    And request propertyTaxEstimatePayload
        # * print propertyTaxEstimatePayload
    When method post
    Then def propertyTaxEstimateResponse = response
    And  assert responseStatus == 200

@errorInCalculatePropertyTaxEstimate
Scenario: Negative pretest to Calculate property tax estimate
    * def params =
    """
    {
        tenantId:'#(tenantId)'
    }
    """
    Given url propertyTaxEstimate
    And params params
    And request propertyTaxEstimatePayload
    When method post
    Then def propertyTaxEstimateErrorResponse = response
    And  status 400

@errorInCalculatePropertyTaxEstimateUnAuthorized
Scenario: Negative pretest to Calculate property tax estimate
    * def params =
    """
    {
        tenantId:'#(tenantId)'
    }
    """
    Given url propertyTaxEstimate
    And params params
    And request propertyTaxEstimatePayload
    When method post
    Then def propertyTaxEstimateErrorResponse = response
    And  status 403

@calculatePropertyTax
Scenario: To Calculate property tax
  Given url propertyTaxCalculate
  And request propertyTaxPayload
  When method post
  Then def propertyTaxResponse = response
  And  assert responseStatus == 200

@errorInCalculatePropertyTax
Scenario: Negative pretest to Calculate property tax
    Given url propertyTaxCalculate
    And request propertyTaxPayload
    When method post
    Then def propertyTaxErrorResponse = response
     And  status 400