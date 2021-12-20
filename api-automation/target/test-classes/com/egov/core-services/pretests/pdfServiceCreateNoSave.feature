Feature: PDF config is generated successfully

        Background:
        * call read('../../business-services/tests/collectionServicesCreate.feature@create_PaymentWithValidBillID_01')
#* def Payments = Payments
* def Bill = Payments[0].paymentDetails[0].bill
* def pdfCreateNoSavePayload = read('../../core-services/requestPayload/pdf-service/pdfCreateNoSave.json')
* def pdfCreateNoSavePayloadFirst = pdfCreateNoSavePayload.WS

        @createPdfNosaveSuccessfully
        Scenario: Create PDF NoSave successfully
  * def pdfCreateNoSaveParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createNoSavePdf
              And params pdfCreateNoSaveParam
              And request pdfCreateNoSavePayload
             When method post
             Then status 201
              And def pdfCreateNoSaveResponseHeader = responseHeaders
              And def pdfCreateNoSaveResponseBody = response

        @createPdfNosaveForWsSuccessfully
        Scenario: Create PDF NoSave for WS successfully
  * def pdfCreateNoSaveParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createNoSavePdf
              And params pdfCreateNoSaveParam
              And request pdfCreateNoSavePayloadFirst
             When method post
             Then status 201
              And def pdfCreateNoSaveResponseHeader = responseHeaders
              And def pdfCreateNoSaveResponseBody = response
              * print pdfCreateNoSaveResponseBody

        @createPdfNosaveWithoutParamsError
        Scenario: Create PDF NoSave without params error
            Given url createNoSavePdf
              And request pdfCreateNoSavePayload
             When method post
             Then status 400
              And def pdfCreateNoSaveResponseHeader = responseHeaders
              And def pdfCreateNoSaveResponseBody = response

        @createPdfNosaveError
        Scenario: Create PDF NoSave error
  * def pdfCreateNoSaveParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
            Given url createNoSavePdf
              And params pdfCreateNoSaveParam
              And request pdfCreateNoSavePayload
             When method post
             Then status 400
              And def pdfCreateNoSaveResponseHeader = responseHeaders
              And def pdfCreateNoSaveResponseBody = response