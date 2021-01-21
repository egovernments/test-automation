Feature: Generated pdf successfully

Background:
* def pdfCreatePayload = read('../requestPayload/pdfService/pdfCreate.json')
* def pdfCreatePayloadFirst = pdfCreatePayload.TL
* def pdfCreatePayloadSecond = pdfCreatePayload.PT
* def pdfCreatePayloadThird = pdfCreatePayload.Fire-Noc
* def pdfCreatePayloadFourth = pdfCreatePayload.WS

@pdfcreatesuccess
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createPdf 
     * print createPdf 
     And params pdfCreateParam
     And request pdfCreatePayloadFirst
     * print pdfCreatePayloadFirst
     When method post
     Then status 201
     And def pdfCreateResponseHeader = responseHeaders
     And def pdfCreateResponseBody = response
     * print pdfCreateResponseBody

@pdfcreateforptsuccess
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createPdf 
     * print createPdf 
     And params pdfCreateParam
     And request pdfCreatePayloadSecond
     * print pdfCreatePayloadSecond
     When method post
     Then status 201
     And def pdfCreateResponseHeader = responseHeaders
     And def pdfCreateResponseBody = response
     * print pdfCreateResponseBody

@pdfcreateforfirenocsuccess
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createPdf 
     * print createPdf 
     And params pdfCreateParam
     And request pdfCreatePayloadThird
     * print pdfCreatePayloadThird
     When method post
     Then status 201
     And def pdfCreateResponseHeader = responseHeaders
     And def pdfCreateResponseBody = response
     * print pdfCreateResponseBody

@pdfcreateforwssuccess
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createPdf 
     * print createPdf 
     And params pdfCreateParam
     And request pdfCreatePayloadFourth
     * print pdfCreatePayloadFourth
     When method post
     Then status 201
     And def pdfCreateResponseHeader = responseHeaders
     And def pdfCreateResponseBody = response
     * print pdfCreateResponseBody
    
@pdfcreatewithouttenantid
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateParam = 
    """
    {
     key: '#(key)'
    }

    """ 
     Given url createPdf 
     * print createPdf 
     And params pdfCreateParam
     And request pdfCreatePayloadFirst
     * print pdfCreatePayloadFirst
     When method post
     Then status 400
     And def pdfCreateResponseHeader = responseHeaders
     And def pdfCreateResponseBody = response
     * print pdfCreateResponseBody

@pdfcreatefail
Scenario: Verify a pdf is generated successfully
  * configure headers = read('classpath:websCommonHeaders.js') 
  * def pdfCreateParam = 
    """
    {
     key: '#(key)',
     tenantId: '#(tenantId)'
    }

    """ 
     Given url createPdf 
     * print createPdf 
     And params pdfCreateParam
     And request pdfCreatePayloadFirst
     * print pdfCreatePayloadFirst
     When method post
     Then status 400
     And def pdfCreateResponseHeader = responseHeaders
     And def pdfCreateResponseBody = response
     * print pdfCreateResponseBody