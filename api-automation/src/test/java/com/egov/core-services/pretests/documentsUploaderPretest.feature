Feature: Document Uploader API call
        Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  # initializing the headers, form-data and other variables required for file upload
  * def docname = 'TEST_'+randomString(5)
  * def name = 'TEST_'+randomString(5)
  * def description = 'TEST_'+randomString(5)
  * def userName = 'AUTOEMPLOYEE' + randomString(6)
  * def mobileNumber = '78' + randomMobileNumGen(8)
  * def id = randomString(5)
  * def email = randomString(10) + '@' + randomString(5) + '.com'
  * def createDocumentsRequest = read('../../core-services/requestPayload/documentsUpload/create.json')
  * def updateDocumentsRequest = read('../../core-services/requestPayload/documentsUpload/update.json')
  * def deleteDocumentsRequest = read('../../core-services/requestPayload/documentsUpload/delete.json')
  * def searchDocumentsRequest = read('../../core-services/requestPayload/documentsUpload/search.json')
        
      
      @createDocuments
        Scenario: create document successfully
            Given url createDocumentsURL
            And request createDocumentsRequest
            * print createDocumentsRequest
            When method post
             Then status 200
              And def documentsUploaderResponseHeader = responseHeaders
              And def documentsUploaderResponseBody = response
              And def documentsUploaderDocuments = response.Documents[0]
              And def documentsUploaderDocUUID = documentsUploaderDocuments.uuid
              And def documentsUploaderDocName = documentsUploaderDocuments.name
              And def documentsUploaderDocCategory = documentsUploaderDocuments.category
              And def documentsUploaderDocActive = documentsUploaderDocuments.active
              * print documentsUploaderDocActive

      @updateDocuments
        Scenario: update document successfully
            Given url updateDocumentsURL
            And request updateDocumentsRequest
            * print updateDocumentsRequest
            When method post
             Then status 200
              And def documentsUploaderResponseHeader = responseHeaders
              And def documentsUploaderResponseBody = response
              And def documentsUploaderDocuments = response.Documents[0]
              And def documentsUploaderDocUUID = documentsUploaderDocuments.uuid
              And def documentsUploaderDocName = documentsUploaderDocuments.name
              And def documentsUploaderDocCategory = documentsUploaderDocuments.category
              And def documentsUploaderDocActive = documentsUploaderDocuments.active
      
      @deleteDocuments
        Scenario: delete document successfully
            Given url deleteDocumentsURL
            And request deleteDocumentsRequest
            * print deleteDocumentsRequest
            When method post
             Then status 200
              And def documentsUploaderResponseHeader = responseHeaders
              And def documentsUploaderResponseBody = response


      @searchDocuments
        Scenario: search document successfully
            * def documentssearchParams = 
      	"""
            {
                  tenantIds: '#(tenantId)',
                  postedBy: '#(documentToSearchPostedBy)',
                  category: 'CATEGORY_CITIZEN_CHARTER'
             }
            """
            Given url searchDocumentsURL
            And params documentssearchParams
            And request searchDocumentsRequest
            * print searchDocumentsRequest
            * print documentssearchParams
            When method post
             Then status 200
              And def documentsUploaderResponseHeader = responseHeaders
              And def documentsUploaderSearchResponseBody = response
              * print documentsUploaderSearchResponseBody
              And def documentsUploadertotalCount = documentsUploaderSearchResponseBody.totalCount
              #And def documentsUploaderSC = documentsUploaderSearchResponseBody.statusCount[]
              And def documentsUploadercount = response.statusCount[0].count
              And def documentsUploaderSCCategory = response.statusCount[0].category
              And def documentsUploaderDocuments = response.Documents[0]
              And def documentsUploaderDocCategory = documentsUploaderDocuments.category
              And def documentsUploaderDocUUID = documentsUploaderDocuments.uuid
              And def documentsUploaderDocName = documentsUploaderDocuments.name
              And def documentsUploaderpostedBy = documentsUploaderDocuments.postedBy
              And def documentsUploaderDocActive = documentsUploaderDocuments.active





