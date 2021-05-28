Feature: PGR Service for End to End Flow

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def Collections = Java.type('java.util.Collections')
    * def Thread = Java.type('java.lang.Thread')
    * Thread.sleep(5000)

@createPgrComplaintEndTotEndFlow @pgrEndToEndFlow @e2eServices
Scenario: Login as a citizen and files a Complaint
    # Steps to validate error messages of login attempt with invalid mobile number
    * call read('../../core-services/pretests/userOtpPretest.feature@errorInvalidMobileNo')
    * assert userOtpSendResponseBody.error.fields[0].code == userOtpConstant.errorMessages.msgForMobileNoLength
    * assert userOtpSendResponseBody.error.fields[0].message == userOtpConstant.errorMessages.msgForValidMobNo
    # Steps to login as Citizen and files Complaint
    * def authToken = citizenAuthToken
    * call read('../../municipal-services/tests/pgr.feature@PGRCreate1')
    * def serviceRequestId = pgrResponseBody.ServiceWrappers[0].service.id
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Assign
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "Pending at LME"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Reject
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    * def status = pgrResponseBody
    # Steps to Update Complaint
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Re-Assign
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    * def status = pgrResponseBody
    # Steps to Update Complaint
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Reslove
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "Resloved"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login as citizen for Rate
    * def authToken = citizenAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "RATE"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login as citizen for reopen
    * def authToken = citizenAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint for REJECTED
    * def status = "REJECTED"
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)',applicationStatus:'#(status)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "REOPEN"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')


@createPgrComplaintForCSREndTotEndFlow @pgrEndToEndFlow @e2eServices
Scenario: Login as a citizen and files a Complaint
    # Steps to login as Citizen and files Complaint
    * def authToken = superUserAuthToken
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    * call read('../../municipal-services/tests/pgr.feature@PGRCreate1')
    * def serviceRequestId = pgrResponseBody.ServiceWrappers[0].service.id
    * def authToken = citizenAuthToken
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Login GRO for Assign
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint for action as Pending at LME
    * def action = "Pending at LME"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login GRO for Reslove
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)', serviceRequestId: '#(serviceRequestId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "Resloved"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login as 
    * def authToken = superUserAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "RATE"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')
    # Steps to Login as citizen for reopen
    * def authToken = citizenAuthToken
    # Steps to verify PGR count
    * def countPGRParams = { tenantId: '#(tenantId)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRCount1')
    # Steps to Search Complaint for REJECTED
    * def status = "REJECTED"
    * def searchPGRParams = { tenantId: '#(tenantId)', mobileNumber: '#(mobileNumber)',applicationStatus:'#(status)'}
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRSearch1')
    # Steps to Update Complaint
    * def action = "REOPEN"
    * call read('../../municipal-services/pretests/pgrPretest.feature@PGRUpdate1')