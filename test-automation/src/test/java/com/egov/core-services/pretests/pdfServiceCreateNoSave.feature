Feature: PDF config is generated successfully

Background:
* def pdfCreateNoSavePayload = read('../requestPayload/pdfService/pdfCreateNoSave.json')
* def pdfCreateNoSavePayloadFirst = pdfCreateNoSavePayload.WS

@pdfcreatenosavesuccess
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateNoSaveParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createNoSavePdf 
     * print createNoSavePdf 
     And params pdfCreateNoSaveParam
     And request pdfCreateNoSavePayload
     * print pdfCreateNoSavePayload
     When method post
     Then status 201
     And def pdfCreateNoSaveResponseHeader = responseHeaders
     And def pdfCreateNoSaveResponseBody = response
     * print pdfCreateNoSaveResponseBody

@pdfcreatenosaveforwssuccess
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateNoSaveParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createNoSavePdf 
     * print createNoSavePdf 
     And params pdfCreateNoSaveParam
     And request pdfCreateNoSavePayloadFirst
     * print pdfCreateNoSavePayloadFirst
     When method post
     Then status 201
     And def pdfCreateNoSaveResponseHeader = responseHeaders
     And def pdfCreateNoSaveResponseBody = response
     * print pdfCreateNoSaveResponseBody

@pdfcreatenosavewithoutparam
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
     Given url createNoSavePdf 
     * print createNoSavePdf 
     And request pdfCreateNoSavePayload
     * print pdfCreateNoSavePayload
     When method post
     Then status 400
     And def pdfCreateNoSaveResponseHeader = responseHeaders
     And def pdfCreateNoSaveResponseBody = response
     * print pdfCreateNoSaveResponseBody

@pdfcreatenosavefail
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateNoSaveParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createNoSavePdf 
     * print createNoSavePdf 
     And params pdfCreateNoSaveParam
     And request pdfCreateNoSavePayload
     * print pdfCreateNoSavePayload
     When method post
     Then status 400
     And def pdfCreateNoSaveResponseHeader = responseHeaders
     And def pdfCreateNoSaveResponseBody = response
     * print pdfCreateNoSaveResponseBody