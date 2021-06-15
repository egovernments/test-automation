Feature: eGov pdf pretest

  Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def ptmutationcertificateRequest = read('../../core-services/requestPayload/egov-pdf/ptmutationcertificate.json')
    * def consolidatedReceiptRequest = read('../../core-services/requestPayload/egov-pdf/consolidatedreceipt.json')
    * def tlrenewalcertificateRequest = read('../../core-services/requestPayload/egov-pdf/tlrenewalcertificate.json')
    * def tlreceiptRequest = read('../../core-services/requestPayload/egov-pdf/tlreceipt.json')
    * def ptreceiptRequest = read('../../core-services/requestPayload/egov-pdf/ptreceipt.json')
    * def ptbillRequest = read('../../core-services/requestPayload/egov-pdf/ptbill.json')

@ptMutationCertificateSuccessfully
Scenario:  pt Mutation Certificate Successfully
    Given url ptmutationcertificateEgovPDF
    And params ptmutationcertificateSearchParam
    And request ptmutationcertificateRequest
    When method post
    Then status 200
    And  def ptmutationcertificateResponseBody = response

@ptMutationCertificateError
Scenario:  pt Mutation Certificate Error
    Given url ptmutationcertificateEgovPDF
    And params ptmutationcertificateSearchParam
    And request ptmutationcertificateRequest
    When method post
    Then status 403
    And  def ptmutationcertificateResponseBody = response

@ptMutationCertificateError1
Scenario:  pt Mutation Certificate Error
    Given url ptmutationcertificateEgovPDF
    And params ptmutationcertificateSearchParam
    And request ptmutationcertificateRequest
    When method post
    Then status 404
    And  def ptmutationcertificateResponseBody = response

@ptMutationCertificateError2
Scenario:  pt Mutation Certificate Error
    Given url ptmutationcertificateEgovPDF
    And params ptmutationcertificateSearchParam
    And request ptmutationcertificateRequest
    When method post
    Then status 400
    And  def ptmutationcertificateResponseBody = response

@consolidatedreceiptSuccessfully
Scenario:  consolidated receipt Successfully
    Given url consolidatedreceiptEgovPDF
    And params consolidatedReceiptSearchParam
    And request consolidatedReceiptRequest
    When method post
    Then status 200
    And  def consolidatedReceiptResponseBody = response

@consolidatedreceiptError
Scenario:  consolidated receipt Error
    Given url consolidatedreceiptEgovPDF
    And params consolidatedReceiptSearchParam
    And request consolidatedReceiptRequest
    When method post
    Then status 404
    And  def consolidatedReceiptResponseBody = response

@consolidatedreceiptError1
Scenario:  consolidated receipt Error
    Given url consolidatedreceiptEgovPDF
    And params consolidatedReceiptSearchParam
    And request consolidatedReceiptRequest
    When method post
    Then status 403
    And  def consolidatedReceiptResponseBody = response

@consolidatedreceiptError2
Scenario:  consolidated receipt Error
    Given url consolidatedreceiptEgovPDF
    And params consolidatedReceiptSearchParam
    And request consolidatedReceiptRequest
    When method post
    Then status 400
    And  def consolidatedReceiptResponseBody = response

@tlrenewalcertificateSuccessfully
Scenario: tl Renewal Certificaite Successfully
    Given url tlrenewalcertificateEgovPDF
    And params tlrenewalcertificateSearchParam
    And request tlrenewalcertificateRequest
    When method post
    Then status 200
    And  def tlrenewalcertificateResponseBody = response

@tlrenewalcertificateError
Scenario: tl Renewal Certificaite Error
    Given url tlrenewalcertificateEgovPDF
    And params tlrenewalcertificateSearchParam
    And request tlrenewalcertificateRequest
    When method post
    Then status 400
    And  def tlrenewalcertificateResponseBody = response

@tlrenewalcertificateError1
Scenario: tl Renewal Certificaite Error
    Given url tlrenewalcertificateEgovPDF
    And params tlrenewalcertificateSearchParam
    And request tlrenewalcertificateRequest
    When method post
    Then status 404
    And  def tlrenewalcertificateResponseBody = response

@tlrenewalcertificateError2
Scenario: tl Renewal Certificaite Error
    Given url tlrenewalcertificateEgovPDF
    And params tlrenewalcertificateSearchParam
    And request tlrenewalcertificateRequest
    When method post
    Then status 403
    And  def tlrenewalcertificateResponseBody = response

@tlreceiptSuccessfully
Scenario: tl Receipt Successfully
    Given url tlreceiptEgovPDF
    # * print url tlreceiptEgovPDF
    And params tlreceiptSearchParam
    And request tlreceiptRequest
    When method post
    Then status 200
    And  def tlreceiptResponseBody = response

@tlreceiptError
Scenario: tl Receipt Error
    Given url tlreceiptEgovPDF
    And params tlreceiptSearchParam
    And request tlreceiptRequest
    When method post
    Then status 400
    And  def tlreceiptResponseBody = response

@ptreceiptSuccessfully
Scenario: pt Receipt Successfully
    Given url ptreceiptEgovPDF
    And params ptreceiptSearchParam
    And request ptreceiptRequest
    When method post
    Then status 200
    And  def ptreceiptResponseBody = response

@ptreceiptError
Scenario: pt Receipt Error
    Given url ptreceiptEgovPDF
    And params ptreceiptSearchParam
    And request ptreceiptRequest
    When method post
    Then status 400
    And  def ptreceiptResponseBody = response

@ptreceiptError1
Scenario: pt Receipt Error
    Given url ptreceiptEgovPDF
    And params ptreceiptSearchParam
    And request ptreceiptRequest
    When method post
    Then status 403
    And  def ptreceiptResponseBody = response

@ptreceiptError2
Scenario: pt Receipt Error
    Given url ptreceiptEgovPDF
    And params ptreceiptSearchParam
    And request ptreceiptRequest
    When method post
    Then status 404
    And  def ptreceiptResponseBody = response

@ptBillSuccessfully
Scenario: pt Bill Successfully
    Given url ptbillEgovPDF
    And params ptbillSearchParam
    And request ptbillRequest
    When method post
    Then status 200
    And  def ptBillResponseBody = response

@ptBillError
Scenario: ptbill Error
    Given url ptbillEgovPDF
    And params ptbillSearchParam
    And request ptbillRequest
    When method post
    Then status 400
    And  def ptBillResponseBody = response

@ptBillError1
Scenario: ptbill Error
    Given url ptbillEgovPDF
    And params ptbillSearchParam
    And request ptbillRequest
    When method post
    Then status 403
    And  def ptBillResponseBody = response