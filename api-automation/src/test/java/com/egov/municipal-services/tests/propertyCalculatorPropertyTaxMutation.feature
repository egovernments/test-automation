Feature: To test property-calculator-PropertyTax-mutation service 'Calculate' endpoints

Background: 
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def propertyCalculatorConstants = read('../../municipal-services/constants/propertyCalculator.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../municipal-services/tests/PropertyService.feature@createActiveProperty')
    * def caseDetails = ""
    * def marketValue = 2000
    * def documentDate = getCurrentEpochTime()
    * def documentValue = ranInteger(3)
    * def documentNumber = randomString(5)
    * def isMutationInCourt = "NO"
    * def reasonForTransfer = mdmsStatePropertyTax.ReasonForTransfer[mdmsStatePropertyTax.ReasonForTransfer.size()-2].code
    * def previousPropertyUuid = generateUUID()
    * def govtAcquisitionDetails = ""
    * def isPropertyUnderGovtPossession = "NO"
    * def propertyTaxMutationPayload = read('../../municipal-services/requestPayload/property-calculator/propertyTaxMutation/calculate.json')
    * def searchBillingSlabMutationPayload = read('../../municipal-services/requestPayload/property-calculator/mutationBillingSlab/search.json')
    * set propertyTaxMutationPayload['Property'] = Property
    * set propertyTaxMutationPayload['Property'].additionalDetails.caseDetails = caseDetails
    * set propertyTaxMutationPayload['Property'].additionalDetails.marketValue = marketValue
    * set propertyTaxMutationPayload['Property'].additionalDetails.documentDate = documentDate
    * set propertyTaxMutationPayload['Property'].additionalDetails.documentValue = documentValue
    * set propertyTaxMutationPayload['Property'].additionalDetails.documentNumber = documentNumber
    * set propertyTaxMutationPayload['Property'].additionalDetails.isMutationInCourt = isMutationInCourt
    * set propertyTaxMutationPayload['Property'].additionalDetails.reasonForTransfer = reasonForTransfer
    * set propertyTaxMutationPayload['Property'].additionalDetails.previousPropertyUuid = previousPropertyUuid
    * set propertyTaxMutationPayload['Property'].additionalDetails.govtAcquisitionDetails = govtAcquisitionDetails
    * set propertyTaxMutationPayload['Property'].additionalDetails.isPropertyUnderGovtPossession = isPropertyUnderGovtPossession


@Propertytax_mutation_calculate_01 @positive @propertyTaxMutation @propertyCalculator @regression
Scenario: Verify creating a mutation billing slab for property tax through API call
    # Steps to process Property Tax Mutation Calculate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxMutation')
    # Assigning billing slab id from API response
    * def bilingSlabId = propertyTaxMutationResponse[acknowldgementNumber].billingSlabIds[0] 
    # Preparing Search parameter 
    * def searchParams = {tenantId: '#(tenantId)', id:'#(bilingSlabId)'}
    # Step to search Billing Mutation along with Search Parameter
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@searchBillingSlabMutation')
    # Validate the result
    * match mutationSearchResponse.MutationBillingSlab[0].usageCategoryMajor == 'RESIDENTIAL'
    
@Propertytax_mutation_calculate_values_02 @positive @propertyTaxMutation @propertyCalculator @regression
Scenario: Verify the mutation property tax calculation thorugh API call for a given property id by providing different values for lanareas, floors, etc and check if the total and tax ammount changes, estimates
    # Steps to process Property Tax Mutation Calculate
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxMutation')   
    # Assigning fisrt total amount  
    * def totalAmountFirst =  propertyTaxMutationResponse[acknowldgementNumber].totalAmount
    # Assigning fisrt tax amount 
    * def taxAmountFirst =  propertyTaxMutationResponse[acknowldgementNumber].taxAmount
    # Assigning landArea, noOfFloors and builtUpArea
    * set propertyTaxMutationPayload['Property'].landArea = 1000
    * set propertyTaxMutationPayload['Property'].noOfFloors = 3
    * set propertyTaxMutationPayload['Property'].builtUpArea = 2500
    * set propertyTaxMutationPayload['Property'].additionalDetails.marketValue = 1000
    # Steps to Calculate Property Tax mutation with new values
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@calculatePropertyTaxMutation') 
    # Validate the details
    * assert propertyTaxMutationResponse[acknowldgementNumber].totalAmount == totalAmountFirst
    * assert propertyTaxMutationResponse[acknowldgementNumber].taxAmount == taxAmountFirst

@Propertytax_mutation_calculate_InvalidBuiltUpArea_03 @negative @propertyTaxMutation @propertyCalculator @regression
Scenario: Verify the mutation property tax calculation thorugh API call for a given property id by passing invalid  values for built up area and check for errors
    # Set builtUpArea with invalid out of bound value
    * set propertyTaxMutationPayload['Property'].units[0].constructionDetail.builtUpArea = 132343458990
    # Steps to Calculate Property Tax mutation with invalid builtUpArea
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTaxMutation') 
    # Validate the details
    * match propertyTaxMutationResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.outOfBoundBuiltUpAreaCode
    * match propertyTaxMutationResponse.Errors[0].message == propertyCalculatorConstants.errorMessage.outOfBoundBuiltUpAreaMessage

@Propertytax_mutation_calculate_InvalidMarketValue_04 @negative @propertyTaxMutation @propertyCalculator @regression
Scenario: Verify the mutation property tax calculation thorugh API call for a given property id by passing a null value for market value and check for errors
    # Set marketValue with null
    * set propertyTaxMutationPayload['Property'].additionalDetails.marketValue = null
    # Steps to Calculate Property Tax mutation with null marketValue
    * call read('../../municipal-services/pretests/propertyCalculatorServicesPretest.feature@errorInCalculatePropertyTaxMutation') 
    # Validate the details
    * match propertyTaxMutationResponse.Errors[0].code == propertyCalculatorConstants.errorMessage.invalidMarketValueCode
    * match propertyTaxMutationResponse.Errors[0].message.trim() == propertyCalculatorConstants.errorMessage.invalidMarketValueMessage
    