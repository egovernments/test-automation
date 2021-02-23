Feature: Business Services: dashboard-ingest tests

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def fileContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    * def validTestDataFile1Name = 'DashboardIngestTestData.xlsx'
    * def validTestDataFile2Name = 'DashboardIngestTestData2.xlsx'
    * def wrongTestDataFileFormat = 'DashboardIngestWrongFileType.pdf'
    * def wrongTestDataFileTemplate = 'DashboardIngestInvalidTemplate.xlsx'
    * def testDataFolderPath = '../../common-services/testData/'
    * def validTestDataFile1Path = testDataFolderPath+'/'+validTestDataFile1Name
    * def validTestDataFile2Path = testDataFolderPath+'/'+validTestDataFile2Name
    * def wrongTestDataFileFormatPath = testDataFolderPath+'/'+wrongTestDataFileFormat
    * def wrongTestDataFileTemplatePath = testDataFolderPath+'/'+wrongTestDataFileTemplate
    * def dashboardIngestConstants = read('../../business-services/constants/dashboardIngest.yaml')
@Save_01 @positive @regression @dashboardIngest
Scenario: Save dashboard ingest with valid request payload
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@saveDashboardIngest')

@Migrate_01 @positive @regression @dashboardIngest
Scenario: Migrate dashboard ingest successfully
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@migrateDashboardIngest')

@Upload_ValidFileFormatAndTemplate_01 @positive @regression @dashboardIngest
Scenario: Upload file to dashboard ingest successfully
    * def fileParam = {read: '#(validTestDataFile1Path)' , filename: '#(validTestDataFile1Name)', contentType: '#(fileContentType)'}
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@uploadToDashboardIngest')

# need to discuss the scenario
@Upload_ValidFileFormatAndInvalidTemplate_02 @negative @regression @dashboardIngest
Scenario: Upload file to dashboard ingest with invalid template
    * def fileParam = {read: '#(wrongTestDataFileTemplatePath)' , filename: '#(wrongTestDataFileTemplate)', contentType: '#(fileContentType)'}
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@errorInUploadToDashboardIngest')

@Upload_InvalidFileFormat_03 @Upload_ValidTemplateAndInvalidFormat_04 @negative @regression @dashboardIngest
Scenario: Upload file to dashboard ingest with invalid file format
    * def fileParam = {read: '#(wrongTestDataFileFormatPath)' , filename: '#(wrongTestDataFileFormat)', contentType: '#(fileContentType)'}
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@errorInUploadToDashboardIngest')
    * match uploadResponse.message == dashboardIngestConstants.errorMessages.shouldBeXlsx

@Upload_NoFile_05 @negative @regression @dashboardIngest
Scenario: Upload file to dashboard ingest with no file
    * def fileParam = {read: '' , filename: '', contentType: '#(fileContentType)'}
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@errorInUploadToDashboardIngest')
    * match uploadResponse.Errors[0].message == dashboardIngestConstants.errorMessages.noFile

@Upload_MultipleFile_06 @Upload_ValidFileWithDifferentName_08 @positive @regression @dashboardIngest
Scenario: Upload multiple files to dashboard ingest successfully
    * def file1 = {read: '#(validTestDataFile1Path)' , filename: '#(validTestDataFile1Name)', contentType: '#(fileContentType)'}
    * def file2 = {read: '#(validTestDataFile2Path)' , filename: '#(validTestDataFile2Name)', contentType: '#(fileContentType)'}
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@uploadMutlipleFilesToDashboardIngest')

@Upload_DifferentFiles_07 @negative @regression @dashboardIngest
Scenario: Upload multiple files with different file formats to dashboard ingest
    * def file1 = {read: '#(wrongTestDataFileFormatPath)' , filename: '#(wrongTestDataFileFormat)', contentType: '#(fileContentType)'}
    * def file2 = {read: '#(validTestDataFile2Path)' , filename: '#(validTestDataFile2Name)', contentType: '#(fileContentType)'}
    * call read('../../business-services/pretest/dashboardIngestPretest.feature@errorInUploadMutlipleFilesToDashboardIngest')
    * match uploadResponse.message == dashboardIngestConstants.errorMessages.shouldBeXlsx