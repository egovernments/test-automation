Feature: Property Tax Assessment

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * def propertyTaxAssessmentConstants = read('../constants/propertyTaxAssessment.yaml')
  * def propertyId = propertyTaxAssessmentConstants.parameters.propertyId
  * def financialYear = propertyTaxAssessmentConstants.parameters.financialYear
  * def assessmentDate = getTodayUtcDate()
  * def source = propertyTaxAssessmentConstants.parameters.source
  * def channel = propertyTaxAssessmentConstants.parameters.channel
  * def assessmentRequest = read('../requestPayload/collection-services/assessment.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@assessment
Scenario: Create assessment
  * def assessmentParams = 
    """
    {
       tenantId: '#(tenantId)'
    }
    """
  * print assessmentRequest
  Given url createAssessment
  And params assessmentParams
  And request assessmentRequest
  When method post
  Then status 201
  * print response
  # And match response.ResponseInfo.status == 'successful'