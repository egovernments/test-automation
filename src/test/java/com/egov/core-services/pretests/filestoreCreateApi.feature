Feature: FileStore create API call 

Background:
	* def jsUtils = read('classpath:jsUtils.js')
  * def javaUtils = Java.type('com.egov.base.EGovTest')
  * configure headers = read('classpath:websCommonHeaders.js')
	

@FileStore_GenerateId_01
Scenario:Upload a document using POST request and verify a filestore ID is generated

   Given url createfilestore