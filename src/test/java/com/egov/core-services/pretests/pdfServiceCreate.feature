Feature: Generated pdf successfully

        Background:
* call read('../../business-services/tests/collectionServicesCreate.feature@Create_PaymentWithValidBillID_01')
* def Payments = Payments
* def pdfCreatePayload = read('../../core-services/requestPayload/pdfService/pdfCreate.json')
# initializing pdf create payload objects
* def pdfCreatePayloadFirst = pdfCreatePayload.TL
* def pdfCreatePayloadSecond = pdfCreatePayload.PT
* def pdfCreatePayloadThird = pdfCreatePayload.FireNoc
* def pdfCreatePayloadFourth = pdfCreatePayload.WS
* configure headers = read('classpath:websCommonHeaders.js') 

        @createPdfSuccessfully
        Scenario: Create PDF Successfully
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createPdf
              And params pdfCreateParam
              And request pdfCreatePayloadFirst
             When method post
             Then status 201
              And def pdfCreateResponseHeader = responseHeaders
              And def pdfCreateResponseBody = response

        @createPdfForPtSuccessfully
        Scenario: Create PDF for PT Successfully
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createPdf
              And params pdfCreateParam
     * eval pdfCreatePayloadSecond.Payments = Payments
              And request pdfCreatePayloadSecond
             When method post
             Then status 201
              And def pdfCreateResponseHeader = responseHeaders
              And def pdfCreateResponseBody = response

        @createPdfForFireNocSuccessfully
        Scenario: Create PDF for Fire NOC Successfully
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createPdf
              And params pdfCreateParam
              And request pdfCreatePayloadThird
             When method post
             Then status 201
              And def pdfCreateResponseHeader = responseHeaders
              And def pdfCreateResponseBody = response

        @createPdfForWSSuccessfully
        Scenario: Create PDF for WS Successfully
        * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createPdf
              And params pdfCreateParam
              
              And request pdfCreatePayloadFourth
              
             When method post
             Then status 201
              And def pdfCreateResponseHeader = responseHeaders
              And def pdfCreateResponseBody = response
    
        @createPdfWithoutTenantIdError
        Scenario: Create PDF without tenantId error
  * def pdfCreateParam = 
    """
    {
     key: '#(key)'
    }

    """ 
            Given url createPdf
     
              And params pdfCreateParam
              And request pdfCreatePayloadFirst
             When method post
             Then status 400
              And def pdfCreateResponseHeader = responseHeaders
              And def pdfCreateResponseBody = response

        @createPdfError
        Scenario: Create PDF error
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createPdf
              And params pdfCreateParam
              
              And request pdfCreatePayloadFirst
              
             When method post
             Then status 400
              And def pdfCreateResponseHeader = responseHeaders
              And def pdfCreateResponseBody = response