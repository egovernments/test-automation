Feature: File store
Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')

  @createdocuments_01  @coreServices @positive  @documents @r2point6
  Scenario: create a document
      # Calling create document pretest
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@createDocuments')
      * match documentsUploaderResponseBody == '#present'
      * match documentsUploaderDocUUID == '#present'
      * match documentsUploaderDocName == '#present'
      * match documentsUploaderDocCategory == '#present'
      * match documentsUploaderDocActive == '#present'
      * assert documentsUploaderDocActive == true

  @updatedocuments_01  @coreServices @positive  @documents @r2point6
  Scenario: update an existing document
      # Calling create document pretest
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@createDocuments')
      * def documentToUpdateUUID = documentsUploaderDocuments.uuid
      # Calling update document pretest
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@updateDocuments')
      * match documentsUploaderResponseBody == '#present'
      * match documentsUploaderDocUUID == '#present'
      * match documentsUploaderDocName == '#present'
      * match documentsUploaderDocCategory == '#present'
      * match documentsUploaderDocActive == '#present'
      * assert documentsUploaderDocActive == true

  @deletedocuments_01  @coreServices @positive  @documents @r2point6
  Scenario: delete an existing document
      # Calling create document pretest
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@createDocuments')
      * def documentToDeleteUUID = documentsUploaderDocuments.uuid
      # Calling delete document pretest
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@deleteDocuments')
      * match documentsUploaderResponseBody == '#present'

  @searchdocuments_01  @coreServices @positive  @documents @r2point6
  Scenario: search an existing document
      # Calling update document pretest
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@createDocuments')
      ### Not needed * def documentToSearchUUID = documentsUploaderDocuments.uuid
      * def documentToSearchPostedBy = documentsUploaderDocuments.postedBy
      ### Not needed * def documentToSearchCategory = documentsUploaderDocuments.category
      * call read('../../core-services/pretests/documentsUploaderPretest.feature@searchDocuments')
      * match documentsUploaderResponseBody == '#present'
      * match documentsUploaderDocUUID == '#present'
      * match documentsUploaderDocName == '#present'
      * match documentsUploaderSCCategory == '#present'
      * match documentsUploadertotalCount == '#present'
      * match documentsUploaderDocActive == '#present'
      * assert documentsUploaderDocActive == true
      * match documentsUploaderDocCategory == '#present'
      * match documentsUploadercount == '#present'
      * match documentsUploaderpostedBy == '#present'
      * assert documentsUploadertotalCount == documentsUploadercount




